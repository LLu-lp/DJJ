package com.jiayue.cinema.entity;

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
@Table(name = "halls")
@TableName("halls")
public class Hall {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(name = "cinema_id", nullable = false)
    private Long cinemaId;
    
    @Column(nullable = false, length = 50)
    private String name;
    
    @Column(length = 30)
    private String type;
    
    @TableField("`rows`")
    @Column(name = "`rows`", nullable = false)
    private Integer rows;
    
    @Column(nullable = false)
    private Integer cols;
    
    @Column(name = "total_seats", nullable = false)
    private Integer totalSeats;
    
    @Column(length = 255)
    private String facilities;
    
    @Column(nullable = false)
    private Integer status;
    
    @TableField(fill = FieldFill.INSERT)
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @TableField(fill = FieldFill.INSERT, select = false)
    @Column(nullable = false)
    private Integer deleted;
}
