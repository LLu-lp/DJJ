package com.jiayue.cinema.service.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.dto.CreateOrderDTO;
import com.jiayue.cinema.dto.OrderVO;
import com.jiayue.cinema.entity.Cinema;
import com.jiayue.cinema.entity.Hall;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.entity.OrderItem;
import com.jiayue.cinema.entity.OrderSnack;
import com.jiayue.cinema.entity.Schedule;
import com.jiayue.cinema.entity.ScheduleSeat;
import com.jiayue.cinema.entity.Seat;
import com.jiayue.cinema.entity.Snack;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.CinemaMapper;
import com.jiayue.cinema.mapper.HallMapper;
import com.jiayue.cinema.mapper.MovieMapper;
import com.jiayue.cinema.mapper.OrderItemMapper;
import com.jiayue.cinema.mapper.OrderMapper;
import com.jiayue.cinema.mapper.OrderSnackMapper;
import com.jiayue.cinema.mapper.ScheduleMapper;
import com.jiayue.cinema.mapper.ScheduleSeatMapper;
import com.jiayue.cinema.mapper.SeatMapper;
import com.jiayue.cinema.mapper.SnackMapper;
import com.jiayue.cinema.mapper.UserCouponMapper;
import com.jiayue.cinema.entity.UserCoupon;
import com.jiayue.cinema.service.OrderService;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.IdUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final OrderSnackMapper orderSnackMapper;
    private final ScheduleMapper scheduleMapper;
    private final ScheduleSeatMapper scheduleSeatMapper;
    private final SeatMapper seatMapper;
    private final MovieMapper movieMapper;
    private final CinemaMapper cinemaMapper;
    private final HallMapper hallMapper;
    private final SnackMapper snackMapper;
    private final UserCouponMapper userCouponMapper;
    private final com.jiayue.cinema.service.MemberService memberService;
    
    @Override
    @Transactional
    public Order createOrder(CreateOrderDTO dto, Long userId) {
        // 判断是否为纯小吃订单：有小吃但没有座位
        boolean isSnackOnly = CollUtil.isNotEmpty(dto.getSnacks()) && CollUtil.isEmpty(dto.getSeatIds());
        
        Schedule schedule = null;
        Movie movie = null;
        Cinema cinema = null;
        Hall hall = null;
        LocalDateTime showTime = null;
        
        // 如果有座位，需要验证场次和座位
        if (CollUtil.isNotEmpty(dto.getSeatIds())) {
            schedule = scheduleMapper.selectById(dto.getScheduleId());
            if (schedule == null) {
                throw new BusinessException(ResultCode.SCHEDULE_NOT_FOUND);
            }
            
            if (schedule.getStatus() != 1) {
                throw new BusinessException(ResultCode.SCHEDULE_CANCELLED);
            }
            
            movie = movieMapper.selectById(schedule.getMovieId());
            if (movie == null) {
                throw new BusinessException(ResultCode.NOT_FOUND, "电影不存在");
            }
            
            cinema = cinemaMapper.selectById(schedule.getCinemaId());
            hall = hallMapper.selectById(schedule.getHallId());
            showTime = LocalDateTime.of(schedule.getShowDate(), schedule.getStartTime());
        } else if (isSnackOnly) {
            // 纯小吃订单，验证是否有小吃
            if (CollUtil.isEmpty(dto.getSnacks())) {
                throw new BusinessException(ResultCode.PARAM_ERROR, "请选择商品");
            }
            
            // 如果有 scheduleId，获取影院信息
            if (dto.getScheduleId() != null && dto.getScheduleId() > 0) {
                schedule = scheduleMapper.selectById(dto.getScheduleId());
                if (schedule != null) {
                    cinema = cinemaMapper.selectById(schedule.getCinemaId());
                    hall = hallMapper.selectById(schedule.getHallId());
                    showTime = LocalDateTime.of(schedule.getShowDate(), schedule.getStartTime());
                }
            }
        } else {
            // 既没有座位也没有小吃
            throw new BusinessException(ResultCode.PARAM_ERROR, "请选择座位或小吃");
        }
        
        // 计算票价
        BigDecimal ticketAmount = BigDecimal.ZERO;
        List<ScheduleSeat> scheduleSeats = new ArrayList<>();
        
        if (!isSnackOnly && CollUtil.isNotEmpty(dto.getSeatIds())) {
            for (Long seatId : dto.getSeatIds()) {
                ScheduleSeat scheduleSeat = scheduleSeatMapper.selectOne(
                        new LambdaQueryWrapper<ScheduleSeat>()
                                .eq(ScheduleSeat::getScheduleId, dto.getScheduleId())
                                .eq(ScheduleSeat::getSeatId, seatId)
                );
                
                if (scheduleSeat == null || scheduleSeat.getStatus() != 0) {
                    throw new BusinessException(ResultCode.SEAT_NOT_AVAILABLE, "座位不可用");
                }
                
                scheduleSeats.add(scheduleSeat);
                Seat seat = seatMapper.selectById(seatId);
                BigDecimal seatPrice = seat.getSeatType() == 2 ? schedule.getVipPrice() : schedule.getPrice();
                if (seatPrice == null) {
                    seatPrice = schedule.getPrice();
                }
                ticketAmount = ticketAmount.add(seatPrice);
            }
        }
        
        // 计算小吃金额
        BigDecimal snackAmount = BigDecimal.ZERO;
        List<OrderSnack> orderSnacks = new ArrayList<>();
        if (CollUtil.isNotEmpty(dto.getSnacks())) {
            for (CreateOrderDTO.SnackItem item : dto.getSnacks()) {
                Snack snack = snackMapper.selectById(item.getSnackId());
                if (snack != null && snack.getStatus() == 1) {
                    BigDecimal subtotal = snack.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                    snackAmount = snackAmount.add(subtotal);
                    
                    OrderSnack orderSnack = new OrderSnack();
                    orderSnack.setSnackId(snack.getId());
                    orderSnack.setSnackName(snack.getName());
                    orderSnack.setPrice(snack.getPrice());
                    orderSnack.setQuantity(item.getQuantity());
                    orderSnacks.add(orderSnack);
                }
            }
        }
        
        // 创建订单
        Order order = new Order();
        order.setOrderNo(generateOrderNo());
        order.setUserId(userId);
        order.setScheduleId(dto.getScheduleId());
        
        if (!isSnackOnly) {
            order.setCinemaId(schedule.getCinemaId());
            order.setCinemaName(cinema != null ? cinema.getName() : "");
            order.setHallId(schedule.getHallId());
            order.setHallName(hall != null ? hall.getName() : "");
            order.setMovieTitle(movie.getTitle());
            order.setShowTime(showTime);
            order.setSeatCount(dto.getSeatIds().size());
        } else {
            // 小吃订单设置默认值
            order.setCinemaId(0L);
            order.setCinemaName("");
            order.setHallId(0L);
            order.setHallName("");
            order.setMovieTitle("小吃订单");
            order.setSeatCount(0);
        }
        
        order.setTicketAmount(ticketAmount);
        order.setSnackAmount(snackAmount);
        order.setDiscountAmount(BigDecimal.ZERO);
        order.setTotalAmount(ticketAmount.add(snackAmount));
        order.setPayAmount(ticketAmount.add(snackAmount));
        order.setCouponId(dto.getCouponId());
        order.setStatus(0);
        order.setTicketed(0);
        order.setExpireTime(LocalDateTime.now().plusMinutes(15));
        
        orderMapper.insert(order);
        
        // 保存座位订单项
        if (!isSnackOnly && CollUtil.isNotEmpty(dto.getSeatIds())) {
            for (int i = 0; i < dto.getSeatIds().size(); i++) {
                Long seatId = dto.getSeatIds().get(i);
                Seat seat = seatMapper.selectById(seatId);
                ScheduleSeat scheduleSeat = scheduleSeats.get(i);
                
                BigDecimal seatPrice = seat.getSeatType() == 2 ? schedule.getVipPrice() : schedule.getPrice();
                if (seatPrice == null) {
                    seatPrice = schedule.getPrice();
                }
                
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(order.getId());
                orderItem.setScheduleId(dto.getScheduleId());
                orderItem.setSeatId(seatId);
                orderItem.setSeatLabel(seat.getSeatLabel());
                orderItem.setPrice(seatPrice);
                orderItem.setStatus(0);
                orderItemMapper.insert(orderItem);
                
                scheduleSeat.setStatus(1);
                scheduleSeatMapper.updateById(scheduleSeat);
            }
        }
        
        // 保存小吃订单项
        for (OrderSnack orderSnack : orderSnacks) {
            orderSnack.setOrderId(order.getId());
            BigDecimal subtotal = orderSnack.getPrice().multiply(BigDecimal.valueOf(orderSnack.getQuantity()));
            orderSnack.setSubtotal(subtotal);
            orderSnackMapper.insert(orderSnack);
        }
        
        return order;
    }
    
    @Override
    @Transactional
    public void payOrder(Long orderId, String payType, Long userId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new BusinessException(ResultCode.ORDER_NOT_FOUND);
        }
        
        if (!order.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此订单");
        }
        
        if (order.getStatus() != 0) {
            throw new BusinessException(ResultCode.ORDER_PAID, "订单状态不正确");
        }
        
        order.setPayType(payType);
        order.setPayTime(LocalDateTime.now());
        order.setStatus(1);
        orderMapper.updateById(order);
        
        // 更新优惠券状态为已使用
        if (order.getCouponId() != null && order.getCouponId() > 0) {
            UserCoupon userCoupon = userCouponMapper.selectById(order.getCouponId());
            if (userCoupon != null) {
                userCoupon.setStatus(1); // 1 = 已使用
                userCoupon.setUseTime(LocalDateTime.now());
                userCoupon.setOrderId(orderId);
                userCouponMapper.updateById(userCoupon);
            }
        }
        
        // 更新会员消费金额和积分
        if (order.getTotalAmount() != null && order.getTotalAmount().compareTo(BigDecimal.ZERO) > 0) {
            // 增加积分：每消费1元获得1积分
            int earnedPoints = order.getTotalAmount().intValue();
            memberService.addPoints(userId, earnedPoints, 1, orderId, "购票消费获得积分");
            
            // 更新会员消费金额
            memberService.updateTotalSpent(userId, order.getTotalAmount());
        }
        
        // 更新电影购票人数
        Schedule schedule = scheduleMapper.selectById(order.getScheduleId());
        if (schedule != null) {
            Movie movie = movieMapper.selectById(schedule.getMovieId());
            if (movie != null) {
                // 增加购票人数（按座位数计算）
                Integer currentCount = movie.getTicketCount() != null ? movie.getTicketCount() : 0;
                movie.setTicketCount(currentCount + order.getSeatCount());
                movieMapper.updateById(movie);
            }
        }
    }
    
    @Override
    @Transactional
    public void cancelOrder(Long orderId, Long userId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new BusinessException(ResultCode.ORDER_NOT_FOUND);
        }
        
        if (!order.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此订单");
        }
        
        if (order.getStatus() != 0) {
            throw new BusinessException(ResultCode.ORDER_CANCELLED, "订单状态不正确");
        }
        
        Schedule schedule = scheduleMapper.selectById(order.getScheduleId());
        
        List<OrderItem> items = orderItemMapper.selectList(
                new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderId)
        );
        
        for (OrderItem item : items) {
            ScheduleSeat scheduleSeat = scheduleSeatMapper.selectOne(
                    new LambdaQueryWrapper<ScheduleSeat>()
                        .eq(ScheduleSeat::getScheduleId, order.getScheduleId())
                        .eq(ScheduleSeat::getSeatId, item.getSeatId())
            );
            
            if (scheduleSeat != null) {
                scheduleSeat.setStatus(0);
                scheduleSeatMapper.updateById(scheduleSeat);
            }
        }
        
        order.setStatus(3);
        orderMapper.updateById(order);
    }
    
    @Override
    public OrderVO getOrderById(Long orderId, Long userId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new BusinessException(ResultCode.ORDER_NOT_FOUND);
        }
        
        if (!order.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权查看此订单");
        }
        
        return convertToVO(order);
    }
    
    @Override
    public Page<OrderVO> getUserOrderPage(Integer page, Integer size, Long userId, Integer status) {
        Page<Order> orderPage = orderMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getUserId, userId)
                        .eq(status != null, Order::getStatus, status)
                        .orderByDesc(Order::getCreatedAt)
        );
        
        Page<OrderVO> voPage = new Page<>(orderPage.getCurrent(), orderPage.getSize(), orderPage.getTotal());
        voPage.setRecords(orderPage.getRecords().stream().map(this::convertToVO).toList());
        
        return voPage;
    }
    
    @Override
    @Transactional
    public void refundOrder(Long orderId, Long userId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new BusinessException(ResultCode.ORDER_NOT_FOUND);
        }
        
        if (!order.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此订单");
        }
        
        if (order.getStatus() != 1) {
            throw new BusinessException(ResultCode.ORDER_CANCELLED, "订单状态不正确");
        }
        
        Schedule schedule = scheduleMapper.selectById(order.getScheduleId());
        
        List<OrderItem> items = orderItemMapper.selectList(
                new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, orderId)
        );
        
        for (OrderItem item : items) {
            ScheduleSeat scheduleSeat = scheduleSeatMapper.selectOne(
                    new LambdaQueryWrapper<ScheduleSeat>()
                        .eq(ScheduleSeat::getScheduleId, order.getScheduleId())
                        .eq(ScheduleSeat::getSeatId, item.getSeatId())
            );
            
            if (scheduleSeat != null) {
                scheduleSeat.setStatus(0);
                scheduleSeatMapper.updateById(scheduleSeat);
            }
        }
        
        order.setStatus(2);
        orderMapper.updateById(order);
    }
    
    private String generateOrderNo() {
        String dateStr = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String randomStr = IdUtil.randomUUID().substring(0, 6).toUpperCase();
        return "JY" + dateStr + randomStr;
    }
    
    private OrderVO convertToVO(Order order) {
        OrderVO vo = new OrderVO();
        vo.setId(order.getId());
        vo.setOrderNo(order.getOrderNo());
        vo.setUserId(order.getUserId());
        vo.setScheduleId(order.getScheduleId());
        vo.setMovieTitle(order.getMovieTitle());
        vo.setTotalAmount(order.getTotalAmount());
        vo.setTicketAmount(order.getTicketAmount());
        vo.setSnackAmount(order.getSnackAmount());
        vo.setDiscountAmount(order.getDiscountAmount());
        vo.setPayAmount(order.getPayAmount());
        vo.setPayType(order.getPayType());
        vo.setPayTime(order.getPayTime());
        vo.setStatus(order.getStatus());
        vo.setCreatedAt(order.getCreatedAt());
        
        if (order.getShowTime() != null) {
            vo.setShowTime(order.getShowTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        }
        
        // 使用 Order 表中已保存的影院和影厅名称
        vo.setCinemaName(order.getCinemaName());
        vo.setHallName(order.getHallName());
        
        // 如果 Order 表中没有，再尝试从 Schedule 查询
        if ((vo.getCinemaName() == null || vo.getHallName() == null) && order.getScheduleId() != null) {
        Schedule schedule = scheduleMapper.selectById(order.getScheduleId());
        if (schedule != null) {
                if (vo.getCinemaName() == null) {
            Cinema cinema = cinemaMapper.selectById(schedule.getCinemaId());
            if (cinema != null) {
                vo.setCinemaName(cinema.getName());
                    }
            }
            
                if (vo.getHallName() == null) {
            Hall hall = hallMapper.selectById(schedule.getHallId());
            if (hall != null) {
                vo.setHallName(hall.getName());
                    }
                }
            }
        }
        
        List<OrderItem> items = orderItemMapper.selectList(
                new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, order.getId())
        );
        vo.setSeats(items.stream().map(item -> {
            OrderVO.OrderSeatVO seatVO = new OrderVO.OrderSeatVO();
            seatVO.setSeatLabel(item.getSeatLabel());
            seatVO.setPrice(item.getPrice());
            return seatVO;
        }).toList());
        
        List<OrderSnack> snacks = orderSnackMapper.selectList(
                new LambdaQueryWrapper<OrderSnack>().eq(OrderSnack::getOrderId, order.getId())
        );
        vo.setSnacks(snacks.stream().map(snack -> {
            OrderVO.OrderSnackVO snackVO = new OrderVO.OrderSnackVO();
            snackVO.setSnackName(snack.getSnackName());
            snackVO.setPrice(snack.getPrice());
            snackVO.setQuantity(snack.getQuantity());
            snackVO.setSubtotal(snack.getPrice().multiply(BigDecimal.valueOf(snack.getQuantity())));
            return snackVO;
        }).toList());
        
        return vo;
    }
}
