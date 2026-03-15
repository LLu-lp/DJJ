package com.jiayue.cinema.controller;

import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.dto.ChatMessageDTO;
import com.jiayue.cinema.dto.ChatUserDTO;
import com.jiayue.cinema.entity.ChatMessage;
import com.jiayue.cinema.service.ChatMessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 聊天历史记录 REST 控制器
 */
@Slf4j
@RestController
@RequestMapping("/chat")
public class ChatHistoryController {
    
    @Autowired
    private ChatMessageService chatMessageService;
    
    /**
     * 获取聊天历史记录
     */
    @GetMapping("/history/{userId}")
    public Result<List<ChatMessageDTO>> getChatHistory(@PathVariable Long userId) {
        try {
            List<ChatMessage> messages = chatMessageService.getUserChatHistory(userId, 50);
            List<ChatMessageDTO> dtos = new ArrayList<>();
            for (ChatMessage msg : messages) {
                ChatMessageDTO dto = new ChatMessageDTO();
                dto.setId(msg.getId());
                dto.setSenderId(msg.getSenderId());
                dto.setSenderName(msg.getSenderName());
                dto.setSenderAvatar(msg.getSenderAvatar());
                dto.setReceiverId(msg.getReceiverId());
                dto.setContent(msg.getContent());
                dto.setType(msg.getType());
                dto.setSendTime(msg.getSendTime());
                dto.setIsRead(msg.getIsRead() == 1);
                dto.setUserRole(msg.getUserRole());
                dtos.add(dto);
            }
            return Result.success(dtos);
        } catch (Exception e) {
            log.error("获取聊天历史失败", e);
            return Result.fail("获取聊天历史失败");
        }
    }
    
    /**
     * 获取有聊天记录的用户列表（员工端使用）
     */
    @GetMapping("/users")
    public Result<List<ChatUserDTO>> getChatUsers() {
        try {
            List<ChatUserDTO> users = chatMessageService.getChatUsers();
            return Result.success(users);
        } catch (Exception e) {
            log.error("获取用户列表失败", e);
            return Result.fail("获取用户列表失败");
        }
    }
    
    /**
     * 获取未读消息数
     */
    @GetMapping("/unread/{userId}")
    public Result<Integer> getUnreadCount(@PathVariable Long userId) {
        try {
            int count = chatMessageService.getUnreadCount(userId);
            return Result.success(count);
        } catch (Exception e) {
            log.error("获取未读消息数失败", e);
            return Result.fail("获取未读消息数失败");
        }
    }
    
    /**
     * 标记消息为已读
     */
    @PutMapping("/read/{messageId}")
    public Result<Void> markAsRead(@PathVariable Long messageId) {
        try {
            chatMessageService.markAsRead(messageId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("标记消息已读失败", e);
            return Result.fail("标记消息已读失败");
        }
    }
}

