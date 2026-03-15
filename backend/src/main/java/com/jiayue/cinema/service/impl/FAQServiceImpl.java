package com.jiayue.cinema.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jiayue.cinema.entity.FAQ;
import com.jiayue.cinema.mapper.FAQMapper;
import com.jiayue.cinema.service.FAQService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * FAQ Service 实现类
 */
@Service
public class FAQServiceImpl extends ServiceImpl<FAQMapper, FAQ> implements FAQService {
    
    @Override
    public List<FAQ> getEnabledFAQs() {
        return list(new QueryWrapper<FAQ>()
                .eq("enabled", 1)
                .orderByAsc("sort"));
    }
    
    @Override
    public List<FAQ> getFAQsByCategory(String category) {
        return list(new QueryWrapper<FAQ>()
                .eq("category", category)
                .eq("enabled", 1)
                .orderByAsc("sort"));
    }
}

