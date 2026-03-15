package com.jiayue.cinema.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.Coupon;
import com.jiayue.cinema.entity.UserCoupon;

import java.util.List;

/**
 * 优惠券 Service
 */
public interface CouponService {
    
    /**
     * 获取可领取的优惠券列表
     */
    List<Coupon> getAvailableCoupons();
    
    /**
     * 领取优惠券
     */
    void receiveCoupon(Long couponId, Long userId);
    
    /**
     * 获取用户的优惠券列表
     */
    List<UserCoupon> getUserCoupons(Long userId, Integer status);
    
    /**
     * 使用优惠券
     */
    void useCoupon(Long userCouponId, Long orderId);
    
    /**
     * 分页查询优惠券（管理员）
     */
    Page<Coupon> getCouponPage(Integer page, Integer size);
    
    /**
     * 创建优惠券（管理员）
     */
    void createCoupon(Coupon coupon);
    
    /**
     * 更新优惠券（管理员）
     */
    void updateCoupon(Coupon coupon);
    
    /**
     * 删除优惠券（管理员）
     */
    void deleteCoupon(Long id);
}

