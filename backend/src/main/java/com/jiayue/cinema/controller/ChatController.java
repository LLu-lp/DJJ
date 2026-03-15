package com.jiayue.cinema.controller;

import com.jiayue.cinema.dto.ChatMessageDTO;
import com.jiayue.cinema.entity.ChatMessage;
import com.jiayue.cinema.service.ChatMessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

/**
 * WebSocket 聊天控制器
 */
@Slf4j
@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    
    @Autowired
    private ChatMessageService chatMessageService;

    /**
     * 处理用户发送的消息
     */
    @MessageMapping("/send")
    public void handleMessage(@Payload ChatMessageDTO message) {
        try {
            message.setSendTime(LocalDateTime.now());
            
            // 保存消息到数据库
            ChatMessage chatMessage = new ChatMessage();
            chatMessage.setSenderId(message.getSenderId());
            chatMessage.setSenderName(message.getSenderName());
            chatMessage.setSenderAvatar(message.getSenderAvatar());
            chatMessage.setReceiverId(message.getReceiverId());
            chatMessage.setContent(message.getContent());
            chatMessage.setType(message.getType());
            chatMessage.setSendTime(message.getSendTime());
            chatMessage.setIsRead(0);
            chatMessage.setUserRole(message.getUserRole());
            chatMessageService.saveMessage(chatMessage);
            
            // 如果是发送给客服的消息
            if (message.getReceiverId() == 0) {
                // 广播给所有客服
                messagingTemplate.convertAndSend("/topic/service", message);
            } else {
                // 发送给特定用户
                messagingTemplate.convertAndSendToUser(
                    message.getReceiverId().toString(),
                    "/queue/messages",
                    message
                );
            }
            
            log.info("消息已发送: 发送者={}, 内容={}", message.getSenderName(), message.getContent());
        } catch (Exception e) {
            log.error("处理消息失败", e);
        }
    }
}
