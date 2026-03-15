package com.jiayue.cinema.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.dto.CreateOrderDTO;
import com.jiayue.cinema.dto.OrderVO;
import com.jiayue.cinema.entity.Order;

/**
 * 订单服务接口
 */
public interface OrderService {
    
    /**
     * 创建订单
     */
    Order createOrder(CreateOrderDTO dto, Long userId);
    
    /**
     * 支付订单
     */
    void payOrder(Long orderId, String payType, Long userId);
    
    /**
     * 取消订单
     */
    void cancelOrder(Long orderId, Long userId);
    
    /**
     * 获取订单详情
     */
    OrderVO getOrderById(Long orderId, Long userId);
    
    /**
     * 分页查询用户订单
     */
    Page<OrderVO> getUserOrderPage(Integer page, Integer size, Long userId, Integer status);
    
    /**
     * 申请退款
     */
    void refundOrder(Long orderId, Long userId);
}
