package com.jiayue.cinema.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
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
@Table(name = "member_levels")
@TableName("member_levels")
public class MemberLevel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(nullable = false)
    private Integer level;
    
    @Column(name = "level_name", nullable = false, length = 50)
    private String levelName;
    
    @Column(name = "level_code", nullable = false, length = 20)
    private String levelCode;
    
    @Column(name = "min_spent", nullable = false, precision = 10, scale = 2)
    private BigDecimal minSpent;
    
    @Column(name = "max_spent", precision = 10, scale = 2)
    private BigDecimal maxSpent;
    
    @Column(nullable = false, precision = 3, scale = 2)
    private BigDecimal discount;
    
    @Column(name = "points_rate", nullable = false, precision = 3, scale = 2)
    private BigDecimal pointsRate;
    
    @Column(length = 500)
    private String benefits;
    
    @Column(length = 255)
    private String icon;
    
    @Column(name = "sort_order")
    private Integer sortOrder;
    
    @TableField(fill = FieldFill.INSERT)
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @TableField(select = false)
    @Column(nullable = false)
    private Integer deleted;
}
