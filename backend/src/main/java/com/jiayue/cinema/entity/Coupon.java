package com.jiayue.cinema.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 优惠券实体
 */
@Data
@TableName("coupons")
public class Coupon {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String name;
    
    private Integer type;
    
    private Integer discountType;
    
    private BigDecimal discountValue;
    
    private BigDecimal minAmount;
    
    private Integer totalCount;
    
    private Integer receivedCount;
    
    private Integer usedCount;
    
    private Integer validDays;
    
    private LocalDateTime startTime;
    
    private LocalDateTime endTime;
    
    private Integer status;
    
    private String description;
    
    @TableField("created_at")
    private LocalDateTime createdAt;
    
    @TableField("updated_at")
    private LocalDateTime updatedAt;
}

