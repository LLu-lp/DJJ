package com.jiayue.cinema.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jiayue.cinema.dto.ChatUserDTO;
import com.jiayue.cinema.entity.ChatMessage;

import java.util.List;

/**
 * 聊天消息 Service 接口
 */
public interface ChatMessageService extends IService<ChatMessage> {
    
    /**
     * 保存消息
     */
    void saveMessage(ChatMessage message);
    
    /**
     * 获取用户的聊天记录
     */
    List<ChatMessage> getUserChatHistory(Long userId, int limit);
    
    /**
     * 获取有聊天记录的用户列表
     */
    List<ChatUserDTO> getChatUsers();
    
    /**
     * 标记消息为已读
     */
    void markAsRead(Long messageId);
    
    /**
     * 获取未读消息数
     */
    int getUnreadCount(Long userId);
}

