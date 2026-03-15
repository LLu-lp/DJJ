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
@Table(name = "announcements")
@TableName("announcements")
public class Announcement {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(nullable = false, length = 200)
    private String title;
    
    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;
    
    @Column(nullable = false)
    private Integer type;
    
    @Column(name = "cover_image", length = 255)
    private String coverImage;
    
    @Column(name = "is_top", nullable = false)
    private Integer isTop;
    
    @Column(name = "view_count", nullable = false)
    private Integer viewCount;
    
    @Column(nullable = false)
    private Integer status;
    
    @Column(name = "publish_time")
    private LocalDateTime publishTime;
    
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
