package com.jiayue.cinema.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Cinema;
import com.jiayue.cinema.entity.MemberLevel;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.MovieReview;
import com.jiayue.cinema.entity.Order;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.mapper.CinemaMapper;
import com.jiayue.cinema.mapper.MemberLevelMapper;
import com.jiayue.cinema.mapper.MovieMapper;
import com.jiayue.cinema.mapper.MovieReviewMapper;
import com.jiayue.cinema.mapper.OrderMapper;
import com.jiayue.cinema.mapper.ScheduleMapper;
import com.jiayue.cinema.mapper.UserMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "管理员接口", description = "管理员专用接口")
@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
    
    private final UserMapper userMapper;
    private final MovieMapper movieMapper;
    private final CinemaMapper cinemaMapper;
    private final OrderMapper orderMapper;
    private final ScheduleMapper scheduleMapper;
    private final MemberLevelMapper memberLevelMapper;
    private final MovieReviewMapper movieReviewMapper;
    
    @Operation(summary = "获取统计数据")
    @GetMapping("/statistics")
    public Result<Map<String, Object>> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalUsers", userMapper.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getRole, 0)
        ));
        stats.put("totalStaff", userMapper.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getRole, 1)
        ));
        
        stats.put("totalMovies", movieMapper.selectCount(null));
        stats.put("showingMovies", movieMapper.selectCount(
                new LambdaQueryWrapper<Movie>().eq(Movie::getStatus, 2)
        ));
        
        stats.put("totalCinemas", cinemaMapper.selectCount(
                new LambdaQueryWrapper<Cinema>().eq(Cinema::getStatus, 1)
        ));
        
        stats.put("totalSchedules", scheduleMapper.selectCount(null));
        
        stats.put("totalOrders", orderMapper.selectCount(null));
        stats.put("paidOrders", orderMapper.selectCount(
                new LambdaQueryWrapper<Order>().eq(Order::getStatus, 1)
        ));
        
        LocalDateTime todayStart = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime todayEnd = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);
        
        java.math.BigDecimal todayRevenue = orderMapper.selectTodayRevenue(todayStart, todayEnd);
        stats.put("todayRevenue", todayRevenue != null ? todayRevenue.longValue() : 0);
        
        Long todayOrders = orderMapper.selectCount(
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getStatus, 1)
                        .between(Order::getPayTime, todayStart, todayEnd)
        );
        stats.put("todayOrders", todayOrders != null ? todayOrders : 0);
        
        List<Map<String, Object>> revenueChart = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        for (int i = 6; i >= 0; i--) {
            LocalDate date = LocalDate.now().minusDays(i);
            LocalDateTime dayStart = LocalDateTime.of(date, LocalTime.MIN);
            LocalDateTime dayEnd = LocalDateTime.of(date, LocalTime.MAX);
            java.math.BigDecimal dayRevenue = orderMapper.selectTodayRevenue(dayStart, dayEnd);
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("date", date.format(formatter));
            dayData.put("revenue", dayRevenue != null ? dayRevenue.longValue() : 0);
            revenueChart.add(dayData);
        }
        stats.put("revenueChart", revenueChart);
        
        // 电影类型分布统计
        List<Map<String, Object>> genreChart = movieMapper.selectGenreDistribution();
        stats.put("genreChart", genreChart);
        
        // 各类型票房统计（万元）
        List<Map<String, Object>> movieRankChart = orderMapper.selectRevenueByGenre();
        stats.put("movieRankChart", movieRankChart);
        
        return Result.success(stats);
    }
    
    @Operation(summary = "分页查询用户")
    @GetMapping("/users")
    public Result<Page<User>> getUserPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Integer role,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String keyword) {
        
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(keyword != null && !keyword.isBlank(), w -> w
                        .like(User::getUsername, keyword)
                        .or()
                        .like(User::getPhone, keyword))
                .eq(role != null, User::getRole, role)
                .eq(status != null, User::getStatus, status)
                .orderByDesc(User::getCreatedAt);
        
        return Result.success(userMapper.selectPage(new Page<>(page, size), wrapper));
    }
    
    @Operation(summary = "更新用户状态")
    @PutMapping("/users/{id}/status")
    public Result<Void> updateUserStatus(
            @PathVariable Long id,
            @RequestParam Integer status) {
        
        User user = new User();
        user.setStatus(status);
        userMapper.update(user,
                new LambdaQueryWrapper<User>().eq(User::getId, id)
        );
        
        return Result.success();
    }
    
    @Operation(summary = "添加员工")
    @PostMapping("/staff")
    public Result<Void> addStaff(@RequestBody User user) {
        user.setRole(1);
        user.setStatus(1);
        userMapper.insert(user);
        return Result.success();
    }
    
    @Operation(summary = "获取所有会员等级")
    @GetMapping("/member-levels")
    public Result<List<MemberLevel>> getMemberLevels() {
        return Result.success(memberLevelMapper.selectList(
                new LambdaQueryWrapper<MemberLevel>().orderByAsc(MemberLevel::getLevel)
        ));
    }
    
    @Operation(summary = "新增会员等级")
    @PostMapping("/member-levels")
    public Result<Void> addMemberLevel(@RequestBody MemberLevel memberLevel) {
        memberLevelMapper.insert(memberLevel);
        return Result.success();
    }
    
    @Operation(summary = "更新会员等级")
    @PutMapping("/member-levels/{level}")
    public Result<Void> updateMemberLevel(
            @PathVariable Integer level,
            @RequestBody MemberLevel memberLevel) {
        memberLevel.setLevel(level);
        memberLevelMapper.update(memberLevel,
                new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, level)
        );
        return Result.success();
    }
    
    @Operation(summary = "删除会员等级")
    @DeleteMapping("/member-levels/{level}")
    public Result<Void> deleteMemberLevel(@PathVariable Integer level) {
        memberLevelMapper.delete(
                new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, level)
        );
        return Result.success();
    }

    @Operation(summary = "分页查询评论")
    @GetMapping("/reviews")
    public Result<Page<MovieReview>> getReviewPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String keyword) {
        LambdaQueryWrapper<MovieReview> wrapper = new LambdaQueryWrapper<MovieReview>()
                .eq(status != null, MovieReview::getStatus, status)
                .orderByDesc(MovieReview::getCreatedAt);
        return Result.success(movieReviewMapper.selectPage(new Page<>(page, size), wrapper));
    }

    @Operation(summary = "审核通过评论")
    @PutMapping("/reviews/{id}/approve")
    public Result<Void> approveReview(@PathVariable Long id) {
        MovieReview review = new MovieReview();
        review.setId(id);
        review.setStatus(1);
        movieReviewMapper.updateById(review);
        return Result.success();
    }

    @Operation(summary = "拒绝评论")
    @PutMapping("/reviews/{id}/reject")
    public Result<Void> rejectReview(@PathVariable Long id) {
        MovieReview review = new MovieReview();
        review.setId(id);
        review.setStatus(2);
        movieReviewMapper.updateById(review);
        return Result.success();
    }

    @Operation(summary = "删除评论")
    @DeleteMapping("/reviews/{id}")
    public Result<Void> deleteReview(@PathVariable Long id) {
        movieReviewMapper.deleteById(id);
        return Result.success();
    }

    @Operation(summary = "获取订单统计数据")
    @GetMapping("/order-stats")
    public Result<Map<String, Object>> getOrderStats(
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        Map<String, Object> stats = new HashMap<>();
        LocalDateTime start = startDate != null
                ? LocalDateTime.of(LocalDate.parse(startDate), LocalTime.MIN)
                : LocalDateTime.of(LocalDate.now().minusDays(6), LocalTime.MIN);
        LocalDateTime end = endDate != null
                ? LocalDateTime.of(LocalDate.parse(endDate), LocalTime.MAX)
                : LocalDateTime.of(LocalDate.now(), LocalTime.MAX);

        long totalOrders = orderMapper.selectCount(
                new LambdaQueryWrapper<Order>().between(Order::getCreatedAt, start, end));
        java.math.BigDecimal totalRevenue = orderMapper.selectTodayRevenue(start, end);
        long totalTickets = orderMapper.selectCount(
                new LambdaQueryWrapper<Order>()
                        .eq(Order::getStatus, 1)
                        .between(Order::getPayTime, start, end));

        stats.put("totalOrders", totalOrders);
        stats.put("totalRevenue", totalRevenue != null ? totalRevenue : java.math.BigDecimal.ZERO);
        stats.put("totalTickets", totalTickets);

        List<Map<String, Object>> dailyData = new ArrayList<>();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("MM-dd");
        LocalDate s = start.toLocalDate();
        LocalDate e = end.toLocalDate();
        while (!s.isAfter(e)) {
            LocalDateTime dayStart = LocalDateTime.of(s, LocalTime.MIN);
            LocalDateTime dayEnd = LocalDateTime.of(s, LocalTime.MAX);
            java.math.BigDecimal dayRevenue = orderMapper.selectTodayRevenue(dayStart, dayEnd);
            long dayOrders = orderMapper.selectCount(
                    new LambdaQueryWrapper<Order>().between(Order::getCreatedAt, dayStart, dayEnd));
            Map<String, Object> day = new HashMap<>();
            day.put("date", s.format(fmt));
            day.put("revenue", dayRevenue != null ? dayRevenue.longValue() : 0);
            day.put("orderCount", dayOrders);
            dailyData.add(day);
            s = s.plusDays(1);
        }
        stats.put("dailyData", dailyData);
        stats.put("movieRankChart", orderMapper.selectRevenueByGenre());
        return Result.success(stats);
    }
}
