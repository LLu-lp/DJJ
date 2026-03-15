package com.jiayue.cinema.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jiayue.cinema.entity.FAQ;

import java.util.List;

/**
 * FAQ Service 接口
 */
public interface FAQService extends IService<FAQ> {
    
    /**
     * 获取所有启用的 FAQ
     */
    List<FAQ> getEnabledFAQs();
    
    /**
     * 按分类获取 FAQ
     */
    List<FAQ> getFAQsByCategory(String category);
}

