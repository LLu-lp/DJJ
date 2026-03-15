package com.jiayue.cinema.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.dto.OrderVO;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.entity.OrderItem;
import com.jiayue.cinema.mapper.OrderItemMapper;
import com.jiayue.cinema.mapper.OrderMapper;
import com.jiayue.cinema.service.OrderService;

import cn.hutool.core.util.StrUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "管理员订单管理", description = "管理员订单管理接口")
@RestController
@RequestMapping("/admin/orders")
@RequiredArgsConstructor
public class AdminOrderController {
    
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final OrderService orderService;
    
    @Operation(summary = "分页查询所有订单")
    @GetMapping
    public Result<Page<OrderVO>> getOrderPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        
        Page<Order> orderPage = orderMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<Order>()
                        .and(StrUtil.isNotBlank(keyword), wrapper -> wrapper
                                .like(Order::getOrderNo, "%" + keyword + "%")
                                .or()
                                .like(Order::getUsername, "%" + keyword + "%"))
                        .eq(status != null, Order::getStatus, status)
                        .ge(StrUtil.isNotBlank(startDate), Order::getCreatedAt, startDate + " 00:00:00")
                        .le(StrUtil.isNotBlank(endDate), Order::getCreatedAt, endDate + " 23:59:59")
                        .orderByDesc(Order::getCreatedAt)
        );
        
        Page<OrderVO> voPage = new Page<>(page, size);
        voPage.setTotal(orderPage.getTotal());
        voPage.setRecords(orderPage.getRecords().stream().map(this::convertToVO).toList());
        
        return Result.success(voPage);
    }
    
    @Operation(summary = "导出订单")
    @GetMapping("/export")
    public Result<Void> exportOrders(
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) Integer status) {
        // 导出功能暂未实现
        return Result.success();
    }
    
    @Operation(summary = "获取订单详情")
    @GetMapping("/{id}")
    public Result<OrderVO> getOrderDetail(@PathVariable Long id) {
        Order order = orderMapper.selectById(id);
        if (order == null) {
            return Result.error(404, "订单不存在");
        }
        return Result.success(convertToVO(order));
    }
    
    @Operation(summary = "订单退款")
    @PostMapping("/{id}/refund")
    public Result<Void> refundOrder(@PathVariable Long id) {
        Order order = orderMapper.selectById(id);
        if (order == null) {
            return Result.error(404, "订单不存在");
        }
        if (order.getStatus() != 1) {
            return Result.error(400, "订单状态不允许退款");
        }
        order.setStatus(3);
        orderMapper.updateById(order);
        return Result.success();
    }
    
    private OrderVO convertToVO(Order order) {
        OrderVO vo = new OrderVO();
        vo.setId(order.getId());
        vo.setOrderNo(order.getOrderNo());
        vo.setUserId(order.getUserId());
        vo.setUsername(order.getUsername());
        vo.setScheduleId(order.getScheduleId());
        vo.setMovieTitle(order.getMovieTitle());
        vo.setCinemaName(order.getCinemaName());
        vo.setHallName(order.getHallName());
        vo.setShowTime(order.getShowTime() != null ? order.getShowTime().toString() : null);
        vo.setTotalAmount(order.getTotalAmount());
        vo.setTicketAmount(order.getTicketAmount());
        vo.setSnackAmount(order.getSnackAmount());
        vo.setDiscountAmount(order.getDiscountAmount());
        vo.setPayAmount(order.getPayAmount());
        vo.setPayType(order.getPayType());
        vo.setStatus(order.getStatus());
        vo.setCreatedAt(order.getCreatedAt());
        vo.setPayTime(order.getPayTime());
        
        // 查询座位信息
        try {
            if (order.getId() != null) {
                List<OrderItem> orderItems = orderItemMapper.selectList(
                        new LambdaQueryWrapper<OrderItem>()
                                .eq(OrderItem::getOrderId, order.getId())
                                .orderByAsc(OrderItem::getId)
                );
                
                if (orderItems != null && !orderItems.isEmpty()) {
                    vo.setSeats(orderItems.stream()
                            .map(item -> {
                                OrderVO.OrderSeatVO seat = new OrderVO.OrderSeatVO();
                                seat.setSeatNo(item.getSeatLabel());
                                seat.setPrice(item.getPrice());
                                return seat;
                            })
                            .toList());
                }
            }
        } catch (Exception e) {
            // 座位查询失败，不影响订单信息返回
            e.printStackTrace();
        }
        
        return vo;
    }
}
