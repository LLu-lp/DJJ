package com.jiayue.cinema.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.dto.MemberInfoVO;
import com.jiayue.cinema.entity.MemberLevel;
import com.jiayue.cinema.entity.PointsLog;
import com.jiayue.cinema.entity.RechargeLog;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.MemberService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

/**
 * 会员控制器
 */
@Tag(name = "会员管理", description = "会员相关接口")
@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
    
    private final MemberService memberService;
    private final AuthService authService;
    
    @Operation(summary = "获取会员信息")
    @GetMapping("/info")
    public Result<MemberInfoVO> getMemberInfo() {
        return Result.success(memberService.getMemberInfo(authService.getCurrentUserId()));
    }
    
    @Operation(summary = "获取会员等级列表")
    @GetMapping("/levels")
    public Result<List<MemberLevel>> getMemberLevels() {
        return Result.success(memberService.getMemberLevels());
    }
    
    @Operation(summary = "充值")
    @PostMapping("/recharge")
    public Result<Void> recharge(
            @RequestParam BigDecimal amount,
            @RequestParam Integer payType) {
        memberService.recharge(authService.getCurrentUserId(), amount, payType);
        return Result.success();
    }
    
    @Operation(summary = "获取充值记录")
    @GetMapping("/recharge-logs")
    public Result<Page<RechargeLog>> getRechargeLogPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(memberService.getRechargeLogPage(page, size, authService.getCurrentUserId()));
    }
    
    @Operation(summary = "获取积分记录")
    @GetMapping("/points-logs")
    public Result<Page<PointsLog>> getPointsLogPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(memberService.getPointsLogPage(page, size, authService.getCurrentUserId()));
    }
}
