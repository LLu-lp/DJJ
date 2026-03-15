package com.jiayue.cinema.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 聊天用户 DTO
 */
@Data
public class ChatUserDTO {
    private Long userId;
    private String username;
    private String avatar;
    private String lastMessage;
    private LocalDateTime lastTime;
    private Integer unreadCount;
}

