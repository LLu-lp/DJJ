package com.jiayue.cinema.controller;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.jiayue.cinema.common.Result;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;

@io.swagger.v3.oas.annotations.tags.Tag(name = "测试工具", description = "测试工具接口")
@RestController
@RequestMapping("/test")
@RequiredArgsConstructor
public class TestController {
    
    private final PasswordEncoder passwordEncoder;
    
    @Operation(summary = "生成BCrypt密码哈希")
    @GetMapping("/encode")
    public Result<String> encodePassword(@RequestParam String password) {
        String encoded = passwordEncoder.encode(password);
        return Result.success(encoded);
    }
}
