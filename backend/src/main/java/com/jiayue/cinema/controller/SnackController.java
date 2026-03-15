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
import com.jiayue.cinema.entity.Snack;
import com.jiayue.cinema.service.SnackService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

/**
 * 小食商品控制器
 */
@Tag(name = "小食商品管理", description = "小食商品相关接口")
@RestController
@RequestMapping("/snacks")
@RequiredArgsConstructor
public class SnackController {
    
    private final SnackService snackService;
    
    @Operation(summary = "分页查询商品")
    @GetMapping("/page")
    public Result<Page<Snack>> getSnackPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String category) {
        return Result.success(snackService.getSnackPage(page, size, category));
    }
    
    @Operation(summary = "获取商品列表")
    @GetMapping("/list")
    public Result<List<Snack>> getSnackList(@RequestParam(required = false) String category) {
        return Result.success(snackService.getSnackList(category));
    }
    
    @Operation(summary = "获取商品详情")
    @GetMapping("/{id}")
    public Result<Snack> getSnackById(@PathVariable Long id) {
        return Result.success(snackService.getSnackById(id));
    }
    
    @Operation(summary = "添加商品")
    @PostMapping
    public Result<Void> addSnack(@RequestBody Snack snack) {
        snackService.addSnack(snack);
        return Result.success();
    }
    
    @Operation(summary = "更新商品")
    @PutMapping("/{id}")
    public Result<Void> updateSnack(@PathVariable Long id, @RequestBody Snack snack) {
        snack.setId(id);
        snackService.updateSnack(snack);
        return Result.success();
    }
    
    @Operation(summary = "删除商品")
    @DeleteMapping("/{id}")
    public Result<Void> deleteSnack(@PathVariable Long id) {
        snackService.deleteSnack(id);
        return Result.success();
    }
}
