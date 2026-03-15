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
@Table(name = "system_logs")
@TableName("system_logs")
public class SystemLog {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(name = "user_id")
    private Long userId;
    
    @Column(length = 50)
    private String username;
    
    @Column(length = 50)
    private String module;
    
    @Column(length = 100)
    private String operation;
    
    @Column(length = 20)
    private String method;
    
    @Column(columnDefinition = "TEXT")
    private String params;
    
    @Column(length = 50)
    private String ip;
    
    @Column(name = "user_agent", length = 500)
    private String userAgent;
    
    @Column
    private Integer result;
    
    @Column(name = "error_msg", columnDefinition = "TEXT")
    private String errorMsg;
    
    @Column
    private Long duration;
    
    @TableField(fill = FieldFill.INSERT)
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}
