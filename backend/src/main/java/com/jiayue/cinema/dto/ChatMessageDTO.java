package com.jiayue.cinema.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 聊天消息 DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessageDTO {
    
    /**
     * 消息 ID
     */
    private Long id;
    
    /**
     * 发送者 ID
     */
    private Long senderId;
    
    /**
     * 发送者名称
     */
    private String senderName;
    
    /**
     * 发送者头像
     */
    private String senderAvatar;
    
    /**
     * 接收者 ID（0 表示客服）
     */
    private Long receiverId;
    
    /**
     * 消息内容
     */
    private String content;
    
    /**
     * 消息类型（text/image/file）
     */
    private String type;
    
    /**
     * 发送时间
     */
    private LocalDateTime sendTime;
    
    /**
     * 是否已读
     */
    private Boolean isRead;
    
    /**
     * 用户角色（user/staff/admin）
     */
    private String userRole;
}

