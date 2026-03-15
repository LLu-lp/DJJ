package com.jiayue.cinema.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 用户优惠券实体
 */
@Data
@TableName("user_coupons")
public class UserCoupon {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long userId;
    
    private Long couponId;
    
    private String couponName;
    
    private Integer type;
    
    private Integer discountType;
    
    private BigDecimal discountValue;
    
    private BigDecimal minAmount;
    
    private Integer status;
    
    private LocalDateTime receiveTime;
    
    private LocalDateTime useTime;
    
    private LocalDateTime expireTime;
    
    private Long orderId;
    
    @TableField("created_at")
    private LocalDateTime createdAt;
    
    @TableField("updated_at")
    private LocalDateTime updatedAt;
}

