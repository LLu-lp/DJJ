package com.jiayue.cinema.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Coupon;
import com.jiayue.cinema.service.CouponService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 管理员优惠券管理控制器
 */
@Tag(name = "优惠券管理", description = "管理员优惠券管理接口")
@RestController
@RequestMapping("/admin/coupons")
@RequiredArgsConstructor
public class AdminCouponController {
    
    private final CouponService couponService;
    
    @Operation(summary = "分页查询优惠券")
    @GetMapping("/page")
    public Result<Page<Coupon>> getCouponPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(couponService.getCouponPage(page, size));
    }
    
    @Operation(summary = "创建优惠券")
    @PostMapping
    public Result<Void> createCoupon(@RequestBody Coupon coupon) {
        couponService.createCoupon(coupon);
        return Result.success();
    }
    
    @Operation(summary = "更新优惠券")
    @PutMapping("/{id}")
    public Result<Void> updateCoupon(@PathVariable Long id, @RequestBody Coupon coupon) {
        coupon.setId(id);
        couponService.updateCoupon(coupon);
        return Result.success();
    }
    
    @Operation(summary = "删除优惠券")
    @DeleteMapping("/{id}")
    public Result<Void> deleteCoupon(@PathVariable Long id) {
        couponService.deleteCoupon(id);
        return Result.success();
    }
}

