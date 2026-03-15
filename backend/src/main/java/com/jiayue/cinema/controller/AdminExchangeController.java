package com.jiayue.cinema.controller;

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
import com.jiayue.cinema.service.ExchangeService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "兑换商品管理", description = "管理员兑换商品管理接口")
@RestController
@RequestMapping("/admin/exchange-items")
@RequiredArgsConstructor
public class AdminExchangeController {
    
    private final ExchangeService exchangeService;
    
    @Operation(summary = "分页查询兑换商品")
    @GetMapping
    public Result<Page<ExchangeItem>> getItemPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(exchangeService.getItemPage(page, size));
    }
    
    @Operation(summary = "新增兑换商品")
    @PostMapping
    public Result<Void> addItem(@RequestBody ExchangeItem item) {
        exchangeService.addItem(item);
        return Result.success();
    }
    
    @Operation(summary = "更新兑换商品")
    @PutMapping("/{id}")
    public Result<Void> updateItem(@PathVariable Long id, @RequestBody ExchangeItem item) {
        item.setId(id);
        exchangeService.updateItem(item);
        return Result.success();
    }
    
    @Operation(summary = "删除兑换商品")
    @DeleteMapping("/{id}")
    public Result<Void> deleteItem(@PathVariable Long id) {
        exchangeService.deleteItem(id);
        return Result.success();
    }
}
