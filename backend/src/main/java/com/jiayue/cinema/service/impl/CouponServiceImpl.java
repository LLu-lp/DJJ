package com.jiayue.cinema.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.entity.Coupon;
import com.jiayue.cinema.entity.ExchangeItem;
import com.jiayue.cinema.entity.UserCoupon;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.CouponMapper;
import com.jiayue.cinema.mapper.ExchangeItemMapper;
import com.jiayue.cinema.mapper.UserCouponMapper;
import com.jiayue.cinema.service.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 优惠券 Service 实现
 */
@Service
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {
    
    private final CouponMapper couponMapper;
    private final UserCouponMapper userCouponMapper;
    private final ExchangeItemMapper exchangeItemMapper;
    
    @Override
    public List<Coupon> getAvailableCoupons() {
        LocalDateTime now = LocalDateTime.now();
        // 获取所有被兑换项关联的优惠券ID
        List<Long> exchangeCouponIds = exchangeItemMapper.selectList(
                new QueryWrapper<ExchangeItem>().select("coupon_id").isNotNull("coupon_id")
        ).stream().map(ExchangeItem::getCouponId).toList();
        
        QueryWrapper<Coupon> wrapper = new QueryWrapper<Coupon>()
                .eq("status", 1)
                .le("start_time", now)
                .ge("end_time", now)
                .apply("received_count < total_count")
                .orderByDesc("created_at");
        
        // 排除被兑换项关联的优惠券
        if (!exchangeCouponIds.isEmpty()) {
            wrapper.notIn("id", exchangeCouponIds);
        }
        
        return couponMapper.selectList(wrapper);
    }
    
    @Override
    @Transactional
    public void receiveCoupon(Long couponId, Long userId) {
        Coupon coupon = couponMapper.selectById(couponId);
        if (coupon == null || coupon.getStatus() != 1) {
            throw new BusinessException(ResultCode.NOT_FOUND, "优惠券不存在或已下架");
        }
        
        LocalDateTime now = LocalDateTime.now();
        if (coupon.getStartTime() != null && now.isBefore(coupon.getStartTime())) {
            throw new BusinessException(ResultCode.FAIL, "优惠券未开始");
        }
        
        if (coupon.getEndTime() != null && now.isAfter(coupon.getEndTime())) {
            throw new BusinessException(ResultCode.FAIL, "优惠券已过期");
        }
        
        if (coupon.getReceivedCount() >= coupon.getTotalCount()) {
            throw new BusinessException(ResultCode.FAIL, "优惠券已领完");
        }
        
        // 检查用户是否已领取
        Long count = userCouponMapper.selectCount(new QueryWrapper<UserCoupon>()
                .eq("user_id", userId)
                .eq("coupon_id", couponId));
        if (count > 0) {
            throw new BusinessException(ResultCode.FAIL, "您已领取过该优惠券");
        }
        
        // 创建用户优惠券
        UserCoupon userCoupon = new UserCoupon();
        userCoupon.setUserId(userId);
        userCoupon.setCouponId(couponId);
        userCoupon.setCouponName(coupon.getName());
        userCoupon.setType(coupon.getType());
        userCoupon.setDiscountType(coupon.getDiscountType());
        userCoupon.setDiscountValue(coupon.getDiscountValue());
        userCoupon.setMinAmount(coupon.getMinAmount());
        userCoupon.setStatus(0);
        userCoupon.setReceiveTime(now);
        userCoupon.setExpireTime(now.plusDays(coupon.getValidDays()));
        userCouponMapper.insert(userCoupon);
        
        // 更新优惠券领取数量
        coupon.setReceivedCount(coupon.getReceivedCount() + 1);
        couponMapper.updateById(coupon);
    }
    
    @Override
    public List<UserCoupon> getUserCoupons(Long userId, Integer status) {
        QueryWrapper<UserCoupon> wrapper = new QueryWrapper<UserCoupon>()
                .eq("user_id", userId);
        
        if (status != null) {
            wrapper.eq("status", status);
        }
        
        return userCouponMapper.selectList(wrapper.orderByDesc("receive_time"));
    }
    
    @Override
    @Transactional
    public void useCoupon(Long userCouponId, Long orderId) {
        UserCoupon userCoupon = userCouponMapper.selectById(userCouponId);
        if (userCoupon == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "优惠券不存在");
        }
        
        if (userCoupon.getStatus() != 0) {
            throw new BusinessException(ResultCode.FAIL, "优惠券不可用");
        }
        
        if (LocalDateTime.now().isAfter(userCoupon.getExpireTime())) {
            userCoupon.setStatus(2);
            userCouponMapper.updateById(userCoupon);
            throw new BusinessException(ResultCode.FAIL, "优惠券已过期");
        }
        
        userCoupon.setStatus(1);
        userCoupon.setUseTime(LocalDateTime.now());
        userCoupon.setOrderId(orderId);
        userCouponMapper.updateById(userCoupon);
    }
    
    @Override
    public Page<Coupon> getCouponPage(Integer page, Integer size) {
        return couponMapper.selectPage(
                new Page<>(page, size),
                new QueryWrapper<Coupon>().orderByDesc("created_at")
        );
    }
    
    @Override
    @Transactional
    public void createCoupon(Coupon coupon) {
        coupon.setStatus(1);
        coupon.setReceivedCount(0);
        coupon.setUsedCount(0);
        coupon.setCreatedAt(LocalDateTime.now());
        
        // 如果没有设置开始时间，默认为当前时间
        if (coupon.getStartTime() == null) {
            coupon.setStartTime(LocalDateTime.now());
        }
        
        // 如果没有设置结束时间，默认为开始时间 + validDays
        if (coupon.getEndTime() == null && coupon.getValidDays() != null) {
            coupon.setEndTime(coupon.getStartTime().plusDays(coupon.getValidDays()));
        }
        
        couponMapper.insert(coupon);
    }
    
    @Override
    @Transactional
    public void updateCoupon(Coupon coupon) {
        coupon.setUpdatedAt(LocalDateTime.now());
        couponMapper.updateById(coupon);
    }
    
    @Override
    @Transactional
    public void deleteCoupon(Long id) {
        couponMapper.deleteById(id);
    }
}

