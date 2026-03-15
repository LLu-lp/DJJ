package com.jiayue.cinema.controller;

import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Coupon;
import com.jiayue.cinema.entity.UserCoupon;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.CouponService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 优惠券控制器
 */
@Slf4j
@RestController
@RequestMapping("/coupons")
@RequiredArgsConstructor
public class CouponController {
    
    private final CouponService couponService;
    private final AuthService authService;
    
    /**
     * 获取可领取的优惠券列表
     */
    @GetMapping("/available")
    public Result<List<Coupon>> getAvailableCoupons() {
        try {
            List<Coupon> coupons = couponService.getAvailableCoupons();
            return Result.success(coupons);
        } catch (Exception e) {
            log.error("获取优惠券列表失败", e);
            return Result.fail("获取优惠券列表失败");
        }
    }
    
    /**
     * 领取优惠券
     */
    @PostMapping("/receive/{couponId}")
    public Result<Void> receiveCoupon(@PathVariable Long couponId) {
        try {
            Long userId = authService.getCurrentUserId();
            couponService.receiveCoupon(couponId, userId);
            return Result.success();
        } catch (Exception e) {
            log.error("领取优惠券失败", e);
            return Result.fail(e.getMessage());
        }
    }
    
    /**
     * 获取我的优惠券
     */
    @GetMapping("/my")
    public Result<List<UserCoupon>> getMyCoupons(@RequestParam(required = false) Integer status) {
        try {
            Long userId = authService.getCurrentUserId();
            List<UserCoupon> coupons = couponService.getUserCoupons(userId, status);
            return Result.success(coupons);
        } catch (Exception e) {
            log.error("获取我的优惠券失败", e);
            return Result.fail("获取我的优惠券失败");
        }
    }
}

