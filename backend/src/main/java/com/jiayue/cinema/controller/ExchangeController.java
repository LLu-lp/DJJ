package com.jiayue.cinema.controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.ExchangeItem;
import com.jiayue.cinema.entity.ExchangeRecord;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.ExchangeService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "积分兑换", description = "积分兑换商品相关接口")
@RestController
@RequestMapping("/exchange")
@RequiredArgsConstructor
public class ExchangeController {
    
    private final ExchangeService exchangeService;
    private final AuthService authService;
    
    @Operation(summary = "获取可兑换商品列表")
    @GetMapping("/items")
    public Result<List<ExchangeItem>> getAvailableItems() {
        return Result.success(exchangeService.getAvailableItems());
    }
    
    @Operation(summary = "兑换商品")
    @PostMapping("/items/{itemId}")
    public Result<Void> exchangeItem(@PathVariable Long itemId) {
        exchangeService.exchange(authService.getCurrentUserId(), itemId);
        return Result.success();
    }
    
    @Operation(summary = "获取用户兑换记录")
    @GetMapping("/records")
    public Result<Page<ExchangeRecord>> getUserExchangeRecords(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(exchangeService.getUserExchangeRecords(
                authService.getCurrentUserId(), page, size
        ));
    }
}
