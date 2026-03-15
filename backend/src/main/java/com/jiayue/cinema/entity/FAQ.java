package com.jiayue.cinema.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * FAQ 实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("faq")
public class FAQ {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String question;
    
    private String answer;
    
    private String category;
    
    private Integer sort;
    
    /**
     * 是否启用: 0-禁用 1-启用，使用Integer避免Boolean映射问题
     */
    private Integer enabled;
    
    @TableField("create_time")
    private LocalDateTime createTime;
    
    @TableField("update_time")
    private LocalDateTime updateTime;
}
