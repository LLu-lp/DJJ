package com.jiayue.cinema.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.SystemLog;
import com.jiayue.cinema.service.SystemService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "系统管理", description = "系统配置和日志管理接口")
@RestController
@RequestMapping("/admin/system")
@RequiredArgsConstructor
public class AdminSystemController {
    
    private final SystemService systemService;
    
    @Operation(summary = "获取系统配置")
    @GetMapping("/config")
    public Result<Map<String, String>> getConfig() {
        return Result.success(systemService.getConfigMap());
    }
    
    @Operation(summary = "更新系统配置")
    @PutMapping("/config")
    public Result<Void> updateConfig(@RequestBody Map<String, String> configs) {
        systemService.updateConfigs(configs);
        return Result.success();
    }
    
    @Operation(summary = "获取系统日志")
    @GetMapping("/logs")
    public Result<Page<SystemLog>> getLogPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String module,
            @RequestParam(required = false) String username) {
        return Result.success(systemService.getLogPage(page, size, module, username));
    }
}
