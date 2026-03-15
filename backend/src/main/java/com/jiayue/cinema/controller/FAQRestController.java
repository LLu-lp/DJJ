package com.jiayue.cinema.controller;

import com.jiayue.cinema.entity.FAQ;
import com.jiayue.cinema.service.FAQService;
import com.jiayue.cinema.common.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * FAQ 控制器
 */
@Slf4j
@RestController
@RequestMapping("/faq")
public class FAQRestController {
    
    @Autowired
    private FAQService faqService;
    
    /**
     * 获取所有启用的 FAQ
     */
    @GetMapping("/list")
    public Result<List<FAQ>> getEnabledFAQs() {
        try {
            List<FAQ> faqs = faqService.getEnabledFAQs();
            return Result.success(faqs);
        } catch (Exception e) {
            log.error("获取 FAQ 列表失败", e);
            return Result.fail("获取 FAQ 列表失败");
        }
    }
    
    /**
     * 按分类获取 FAQ
     */
    @GetMapping("/category/{category}")
    public Result<List<FAQ>> getFAQsByCategory(@PathVariable String category) {
        try {
            List<FAQ> faqs = faqService.getFAQsByCategory(category);
            return Result.success(faqs);
        } catch (Exception e) {
            log.error("获取分类 FAQ 失败", e);
            return Result.fail("获取分类 FAQ 失败");
        }
    }
    
    /**
     * 获取单个 FAQ
     */
    @GetMapping("/{id}")
    public Result<FAQ> getFAQ(@PathVariable Long id) {
        try {
            FAQ faq = faqService.getById(id);
            if (faq == null) {
                return Result.fail("FAQ 不存在");
            }
            return Result.success(faq);
        } catch (Exception e) {
            log.error("获取 FAQ 失败", e);
            return Result.fail("获取 FAQ 失败");
        }
    }
}

