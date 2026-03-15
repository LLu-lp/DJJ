package com.jiayue.cinema.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.entity.OrderItem;
import com.jiayue.cinema.entity.Schedule;
import com.jiayue.cinema.mapper.OrderItemMapper;
import com.jiayue.cinema.mapper.OrderMapper;
import com.jiayue.cinema.mapper.ScheduleMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "员工接口", description = "员工专用接口")
@RestController
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {
    
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final ScheduleMapper scheduleMapper;
    
    @Operation(summary = "获取今日场次列表")
    @GetMapping("/schedules/today")
    public Result<List<Schedule>> getTodaySchedules(@RequestParam Long cinemaId) {
        return Result.success(scheduleMapper.selectList(
                new LambdaQueryWrapper<Schedule>()
                        .eq(Schedule::getCinemaId, cinemaId)
                        .eq(Schedule::getShowDate, LocalDate.now())
                        .eq(Schedule::getStatus, 1)
                        .orderByAsc(Schedule::getStartTime)
        ));
    }
    
    @Operation(summary = "取票验证")
    @PostMapping("/orders/verify")
    public Result<Map<String, Object>> verifyTicket(@RequestBody Map<String, String> request) {
        String ticketCode = request.get("code");
        if (ticketCode == null || ticketCode.isBlank()) {
            return Result.fail("取票码不能为空");
        }
        
        Order order = orderMapper.selectOne(
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getStatus, 1)
                        .and(wrapper -> wrapper
                                .eq(Order::getQrCode, ticketCode)
                                .or()
                                .eq(Order::getOrderNo, ticketCode))
                        .last("LIMIT 1")
        );
        
        if (order == null) {
            return Result.fail("取票码无效或订单未支付");
        }
        
        if (order.getTicketed() != null && order.getTicketed() == 1) {
            return Result.fail("该订单已核销");
        }
        
        order.setTicketed(1);
        order.setTicketTime(java.time.LocalDateTime.now());
        orderMapper.updateById(order);
        
        return Result.success(Map.of(
                "orderId", order.getId(),
                "orderNo", order.getOrderNo(),
                "movieTitle", order.getMovieTitle() != null ? order.getMovieTitle() : "",
                "message", "验票成功"
        ));
    }
    
    @Operation(summary = "分页查询订单")
    @GetMapping("/orders")
    public Result<Page<Map<String, Object>>> getOrderPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Long cinemaId,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) Integer ticketed,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {

        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(cinemaId != null, Order::getCinemaId, cinemaId)
                .eq(status != null, Order::getStatus, status)
                .eq(ticketed != null, Order::getTicketed, ticketed)
                .and(keyword != null && !keyword.isBlank(), w -> w
                        .like(Order::getOrderNo, keyword)
                        .or()
                        .like(Order::getUsername, keyword));

        // 单日过滤
        if (date != null) {
            wrapper.between(Order::getTicketTime,
                    LocalDateTime.of(date, LocalTime.MIN),
                    LocalDateTime.of(date, LocalTime.MAX));
        }
        // 日期范围过滤（今日核销用 startDate=endDate=today）
        if (startDate != null && endDate != null) {
            wrapper.between(Order::getTicketTime,
                    LocalDateTime.of(startDate, LocalTime.MIN),
                    LocalDateTime.of(endDate, LocalTime.MAX));
        }

        wrapper.orderByDesc(Order::getTicketTime);

        Page<Order> orderPage = orderMapper.selectPage(new Page<>(page, size), wrapper);

        // 查询每个订单的座位信息
        List<Long> orderIds = orderPage.getRecords().stream()
                .map(Order::getId).collect(Collectors.toList());

        Map<Long, List<OrderItem>> seatMap = orderIds.isEmpty() ? Map.of() :
                orderItemMapper.selectList(
                        new LambdaQueryWrapper<OrderItem>().in(OrderItem::getOrderId, orderIds)
                ).stream().collect(Collectors.groupingBy(OrderItem::getOrderId));

        // 构建带座位的返回数据
        List<Map<String, Object>> records = orderPage.getRecords().stream().map(o -> {
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("id", o.getId());
            row.put("orderNo", o.getOrderNo());
            row.put("userId", o.getUserId());
            row.put("username", o.getUsername());
            row.put("movieTitle", o.getMovieTitle());
            row.put("showTime", o.getShowTime());
            row.put("payTime", o.getPayTime());
            row.put("ticketTime", o.getTicketTime());
            row.put("status", o.getStatus());
            row.put("ticketed", o.getTicketed());
            row.put("payAmount", o.getPayAmount());
            List<OrderItem> items = seatMap.getOrDefault(o.getId(), List.of());
            row.put("seats", items.stream()
                    .map(i -> Map.of("seatLabel", i.getSeatLabel(), "price", i.getPrice()))
                    .collect(Collectors.toList()));
            return row;
        }).collect(Collectors.toList());

        Page<Map<String, Object>> resultPage = new Page<>(orderPage.getCurrent(), orderPage.getSize(), orderPage.getTotal());
        resultPage.setRecords(records);
        return Result.success(resultPage);
    }
    
    @Operation(summary = "获取场次订单统计")
    @GetMapping("/schedules/{scheduleId}/stats")
    public Result<Object> getScheduleStats(@PathVariable Long scheduleId) {
        long totalOrders = orderMapper.selectCount(
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getScheduleId, scheduleId)
                        .in(Order::getStatus, List.of(1, 0))
        );
        
        return Result.success(Map.of("totalOrders", totalOrders));
    }
}
