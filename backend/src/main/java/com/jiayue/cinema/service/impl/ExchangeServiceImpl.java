package com.jiayue.cinema.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.entity.Coupon;
import com.jiayue.cinema.entity.ExchangeItem;
import com.jiayue.cinema.entity.ExchangeRecord;
import com.jiayue.cinema.entity.MemberInfo;
import com.jiayue.cinema.entity.UserCoupon;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.CouponMapper;
import com.jiayue.cinema.mapper.ExchangeItemMapper;
import com.jiayue.cinema.mapper.ExchangeRecordMapper;
import com.jiayue.cinema.mapper.MemberInfoMapper;
import com.jiayue.cinema.mapper.UserCouponMapper;
import com.jiayue.cinema.service.ExchangeService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ExchangeServiceImpl implements ExchangeService {
    
    private final ExchangeItemMapper exchangeItemMapper;
    private final ExchangeRecordMapper exchangeRecordMapper;
    private final MemberInfoMapper memberInfoMapper;
    private final CouponMapper couponMapper;
    private final UserCouponMapper userCouponMapper;
    
    @Override
    public List<ExchangeItem> getAvailableItems() {
        return exchangeItemMapper.selectList(
                new LambdaQueryWrapper<ExchangeItem>()
                        .eq(ExchangeItem::getStatus, 1)
                        .gt(ExchangeItem::getStock, 0)
                        .orderByAsc(ExchangeItem::getSort)
        );
    }
    
    @Override
    public Page<ExchangeItem> getItemPage(Integer page, Integer size) {
        return exchangeItemMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<ExchangeItem>()
                        .orderByAsc(ExchangeItem::getSort)
        );
    }
    
    @Override
    public void addItem(ExchangeItem item) {
        item.setExchangedCount(0);
        item.setStatus(1);
        item.setDeleted(0);
        item.setCreatedAt(LocalDateTime.now());
        exchangeItemMapper.insert(item);
    }
    
    @Override
    public void updateItem(ExchangeItem item) {
        item.setUpdatedAt(LocalDateTime.now());
        exchangeItemMapper.updateById(item);
    }
    
    @Override
    public void deleteItem(Long id) {
        exchangeItemMapper.deleteById(id);
    }
    
    @Override
    @Transactional
    public void exchange(Long userId, Long itemId) {
        ExchangeItem item = exchangeItemMapper.selectById(itemId);
        if (item == null || item.getStatus() != 1) {
            throw new BusinessException(ResultCode.NOT_FOUND, "兑换商品不存在");
        }
        
        if (item.getStock() <= 0) {
            throw new BusinessException(ResultCode.FAIL, "商品库存不足");
        }
        
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null || memberInfo.getPoints() < item.getPoints()) {
            throw new BusinessException(ResultCode.FAIL, "积分不足");
        }
        
        memberInfo.setPoints(memberInfo.getPoints() - item.getPoints());
        memberInfoMapper.updateById(memberInfo);
        
        item.setStock(item.getStock() - 1);
        item.setExchangedCount(item.getExchangedCount() + 1);
        exchangeItemMapper.updateById(item);
        
        ExchangeRecord record = new ExchangeRecord();
        record.setUserId(userId);
        record.setItemId(itemId);
        record.setItemName(item.getName());
        record.setPoints(item.getPoints());
        record.setStatus(0);
        record.setExchangedAt(LocalDateTime.now());
        exchangeRecordMapper.insert(record);
        
        // 如果兑换项关联了优惠券，创建用户优惠券记录
        if (item.getCouponId() != null && item.getCouponId() > 0) {
            Coupon coupon = couponMapper.selectById(item.getCouponId());
            if (coupon != null) {
                UserCoupon userCoupon = new UserCoupon();
                userCoupon.setUserId(userId);
                userCoupon.setCouponId(coupon.getId());
                userCoupon.setCouponName(coupon.getName());
                userCoupon.setType(coupon.getType());
                userCoupon.setDiscountType(coupon.getDiscountType());
                userCoupon.setDiscountValue(coupon.getDiscountValue());
                userCoupon.setMinAmount(coupon.getMinAmount());
                userCoupon.setStatus(0); // 0 = 未使用
                userCoupon.setReceiveTime(LocalDateTime.now());
                userCoupon.setExpireTime(LocalDateTime.now().plusDays(coupon.getValidDays()));
                userCouponMapper.insert(userCoupon);
            }
        }
    }
    
    @Override
    public Page<ExchangeRecord> getUserExchangeRecords(Long userId, Integer page, Integer size) {
        return exchangeRecordMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<ExchangeRecord>()
                        .eq(ExchangeRecord::getUserId, userId)
                        .orderByDesc(ExchangeRecord::getExchangedAt)
        );
    }
}
