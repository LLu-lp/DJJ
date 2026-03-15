package com.jiayue.cinema.entity;

import com.baomidou.mybatisplus.annotation.*;
import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "movies")
@TableName("movies")
public class Movie {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @Column(nullable = false, length = 100)
    private String title;
    
    @Column(length = 255)
    private String poster;
    
    @Column(length = 100)
    private String director;
    
    @Column(length = 500)
    private String actors;
    
    @Column(length = 100)
    private String genre;
    
    @Column(nullable = false)
    private Integer duration;
    
    @Column(length = 50)
    private String language;
    
    @Column(length = 50)
    private String region;
    
    @Column(name = "release_date")
    private LocalDate releaseDate;
    
    @Column(name = "end_date")
    private LocalDate endDate;
    
    @Column(precision = 2, scale = 1)
    private BigDecimal rating;
    
    @Column(name = "rating_count")
    private Integer ratingCount;
    
    @Column(name = "ticket_count")
    private Integer ticketCount;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(nullable = false)
    private Integer status;
    
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
