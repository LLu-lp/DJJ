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
@Table(name = "orders")
@TableName("orders")
public class Order {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(name = "order_no", nullable = false, unique = true, length = 50)
    private String orderNo;
    
    @Column(name = "user_id", nullable = false)
    private Long userId;
    
    @Column(length = 50)
    private String username;
    
    @Column(name = "schedule_id")
    private Long scheduleId;
    
    @Column(name = "cinema_id")
    private Long cinemaId;
    
    @Column(name = "cinema_name", length = 100)
    private String cinemaName;
    
    @Column(name = "hall_id")
    private Long hallId;
    
    @Column(name = "hall_name", length = 50)
    private String hallName;
    
    @Column(name = "movie_title", length = 100)
    private String movieTitle;
    
    @Column(name = "show_time")
    private LocalDateTime showTime;
    
    @Column(name = "seat_count", nullable = false)
    private Integer seatCount;
    
    @Column(name = "total_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Column(name = "ticket_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal ticketAmount;
    
    @Column(name = "snack_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal snackAmount;
    
    @Column(name = "discount_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal discountAmount;
    
    @Column(name = "pay_amount", precision = 10, scale = 2)
    private BigDecimal payAmount;
    
    @Column(name = "pay_type", length = 20)
    private String payType;
    
    @Column(name = "pay_time")
    private LocalDateTime payTime;
    
    @Column(nullable = false)
    private Integer status;
    
    @Column(nullable = false)
    private Integer ticketed;
    
    @Column(name = "ticket_time")
    private LocalDateTime ticketTime;
    
    @Column(name = "qr_code", length = 255)
    private String qrCode;
    
    @Column(name = "expire_time")
    private LocalDateTime expireTime;
    
    @Column(name = "coupon_id")
    private Long couponId;
    
    @Column(length = 500)
    private String remark;
    
    @TableField(fill = FieldFill.INSERT)
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @TableField(select = false)
    @Column(nullable = false)
    private Integer deleted = 0;
}
