package com.jiayue.cinema.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jiayue.cinema.dto.ChatUserDTO;
import com.jiayue.cinema.entity.ChatMessage;
import com.jiayue.cinema.mapper.ChatMessageMapper;
import com.jiayue.cinema.service.ChatMessageService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 聊天消息 Service 实现类
 */
@Service
public class ChatMessageServiceImpl extends ServiceImpl<ChatMessageMapper, ChatMessage> implements ChatMessageService {
    
    @Override
    public void saveMessage(ChatMessage message) {
        if (message.getSendTime() == null) {
            message.setSendTime(LocalDateTime.now());
        }
        if (message.getIsRead() == null) {
            message.setIsRead(0);
        }
        save(message);
    }
    
    @Override
    public List<ChatMessage> getUserChatHistory(Long userId, int limit) {
        // 返回：用户发给客服的消息(senderId=userId, receiverId=0) 或 客服回复该用户的消息(receiverId=userId)
        return list(new QueryWrapper<ChatMessage>()
                .and(wrapper -> wrapper
                        .eq("sender_id", userId)
                        .or()
                        .eq("receiver_id", userId))
                .orderByAsc("send_time")
                .last("LIMIT " + limit));
    }
    
    @Override
    public List<ChatUserDTO> getChatUsers() {
        // 只查询发送给客服的消息（receiver_id=0），天然排除员工回复消息
        List<ChatMessage> allMessages = list(new QueryWrapper<ChatMessage>()
                .eq("receiver_id", 0)
                .orderByDesc("send_time"));

        Map<Long, ChatUserDTO> userMap = new HashMap<>();

        for (ChatMessage msg : allMessages) {
            Long userId = msg.getSenderId();
            if (userId == null || userId == 0) continue;

            if (!userMap.containsKey(userId)) {
                ChatUserDTO user = new ChatUserDTO();
                user.setUserId(userId);
                user.setUsername(msg.getSenderName());
                user.setAvatar(msg.getSenderAvatar());
                user.setLastMessage(msg.getContent());
                user.setLastTime(msg.getSendTime());
                
                // 计算未读消息数（发送给客服的未读消息）
                Long unreadCount = count(new QueryWrapper<ChatMessage>()
                        .eq("sender_id", userId)
                        .eq("receiver_id", 0)
                        .eq("is_read", 0));
                user.setUnreadCount(unreadCount != null ? unreadCount.intValue() : 0);
                
                userMap.put(userId, user);
            }
        }
        
        return new ArrayList<>(userMap.values());
    }
    
    @Override
    public void markAsRead(Long messageId) {
        ChatMessage message = new ChatMessage();
        message.setId(messageId);
        message.setIsRead(1);
        updateById(message);
    }
    
    @Override
    public int getUnreadCount(Long userId) {
        Long count = count(new QueryWrapper<ChatMessage>()
                .eq("receiver_id", userId)
                .eq("is_read", 0));
        return count != null ? count.intValue() : 0;
    }
}

