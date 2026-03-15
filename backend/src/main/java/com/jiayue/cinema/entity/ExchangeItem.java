package com.jiayue.cinema.entity;

import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "exchange_items")
@TableName("exchange_items")
public class ExchangeItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(nullable = false, length = 100)
    private String name;
    
    @Column(length = 255)
    private String icon;
    
    @Column(length = 255)
    private String description;
    
    @Column(nullable = false)
    private Integer points;
    
    @Column(nullable = false)
    private Integer stock;
    
    @Column(name = "exchanged_count", nullable = false)
    private Integer exchangedCount;
    
    @Column(nullable = false)
    private Integer status;
    
    @Column
    private Integer sort;
    
    @Column(name = "coupon_id")
    private Long couponId;
    
    @TableLogic
    @TableField(select = false)
    @Column(nullable = false)
    private Integer deleted;
    
    @TableField(fill = FieldFill.INSERT)
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
