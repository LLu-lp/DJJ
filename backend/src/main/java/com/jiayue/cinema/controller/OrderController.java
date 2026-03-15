package com.jiayue.cinema.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.dto.CreateOrderDTO;
import com.jiayue.cinema.dto.OrderVO;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.OrderService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

/**
 * 订单控制器
 */
@Tag(name = "订单管理", description = "订单相关接口")
@RestController
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrderController {
    
    private final OrderService orderService;
    private final AuthService authService;
    
    @Operation(summary = "创建订单")
    @PostMapping
    public Result<Order> createOrder(@RequestBody CreateOrderDTO dto) {
        return Result.success(orderService.createOrder(dto, authService.getCurrentUserId()));
    }
    
    @Operation(summary = "支付订单")
    @PostMapping("/{orderId}/pay")
    public Result<Void> payOrder(
            @PathVariable Long orderId,
            @RequestParam String payType) {
        orderService.payOrder(orderId, payType, authService.getCurrentUserId());
        return Result.success();
    }
    
    @Operation(summary = "取消订单")
    @PostMapping("/{orderId}/cancel")
    public Result<Void> cancelOrder(@PathVariable Long orderId) {
        orderService.cancelOrder(orderId, authService.getCurrentUserId());
        return Result.success();
    }
    
    @Operation(summary = "获取订单详情")
    @GetMapping("/{orderId}")
    public Result<OrderVO> getOrderById(@PathVariable Long orderId) {
        return Result.success(orderService.getOrderById(orderId, authService.getCurrentUserId()));
    }
    
    @Operation(summary = "分页查询用户订单")
    @GetMapping("/page")
    public Result<Page<OrderVO>> getUserOrderPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Integer status) {
        return Result.success(orderService.getUserOrderPage(page, size, authService.getCurrentUserId(), status));
    }
    
    @Operation(summary = "申请退款")
    @PostMapping("/{orderId}/refund")
    public Result<Void> refundOrder(@PathVariable Long orderId) {
        orderService.refundOrder(orderId, authService.getCurrentUserId());
        return Result.success();
    }
}
