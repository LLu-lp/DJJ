package com.jiayue.cinema.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

/**
 * 聊天消息 Mapper
 */
@Mapper
public interface ChatMessageMapper extends BaseMapper<ChatMessage> {
}

