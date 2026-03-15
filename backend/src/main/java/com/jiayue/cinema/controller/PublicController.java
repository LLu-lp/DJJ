package com.jiayue.cinema.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.MemberLevel;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.mapper.MemberLevelMapper;
import com.jiayue.cinema.mapper.MovieMapper;
import com.jiayue.cinema.mapper.OrderMapper;
import com.jiayue.cinema.mapper.UserMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "公开接口", description = "无需登录即可访问的公开接口")
@RestController
@RequestMapping("/public")
@RequiredArgsConstructor
public class PublicController {
    
    private final UserMapper userMapper;
    private final MovieMapper movieMapper;
    private final OrderMapper orderMapper;
    private final MemberLevelMapper memberLevelMapper;
    
    @Operation(summary = "获取首页统计数据")
    @GetMapping("/statistics")
    public Result<Map<String, Object>> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        LocalDateTime todayStart = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime todayEnd = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);
        
        Long todayRevenue = orderMapper.selectTodayRevenue(todayStart, todayEnd) != null
                ? orderMapper.selectTodayRevenue(todayStart, todayEnd).longValue()
                : 0L;
        stats.put("todayRevenue", todayRevenue / 10000.0);
        
        Long todayOrders = orderMapper.selectCount(
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getStatus, 1)
                        .between(Order::getPayTime, todayStart, todayEnd)
        );
        stats.put("todayOrders", todayOrders != null ? todayOrders : 0);
        
        stats.put("totalUsers", userMapper.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getRole, 0)
        ));
        
        stats.put("totalMovies", movieMapper.selectCount(null));
        
        return Result.success(stats);
    }
    
    @Operation(summary = "获取所有会员等级（公开）")
    @GetMapping("/member-levels")
    public Result<List<MemberLevel>> getMemberLevels() {
        return Result.success(memberLevelMapper.selectList(
                new LambdaQueryWrapper<MemberLevel>().orderByAsc(MemberLevel::getLevel)
        ));
    }
}
