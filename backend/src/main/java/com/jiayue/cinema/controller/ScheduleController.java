package com.jiayue.cinema.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
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
import com.jiayue.cinema.dto.ScheduleVO;
import com.jiayue.cinema.dto.SeatStatusVO;
import com.jiayue.cinema.entity.Schedule;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.ScheduleService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

/**
 * 排片控制器
 */
@Tag(name = "排片管理", description = "排片场次相关接口")
@RestController
@RequestMapping("/schedules")
@RequiredArgsConstructor
public class ScheduleController {
    
    private final ScheduleService scheduleService;
    private final AuthService authService;
    
    @Operation(summary = "分页查询排片")
    @GetMapping("/page")
    public Result<Page<ScheduleVO>> getSchedulePage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Long cinemaId,
            @RequestParam(required = false) Long movieId,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate showDate) {
        return Result.success(scheduleService.getSchedulePage(page, size, cinemaId, movieId, showDate));
    }
    
    @Operation(summary = "获取排片详情")
    @GetMapping("/{id}")
    public Result<ScheduleVO> getScheduleById(@PathVariable Long id) {
        return Result.success(scheduleService.getScheduleById(id));
    }
    
    @Operation(summary = "获取某电影在某影院的排片")
    @GetMapping("/movie/{movieId}/cinema/{cinemaId}")
    public Result<List<ScheduleVO>> getSchedulesByMovieAndCinema(
            @PathVariable Long movieId,
            @PathVariable Long cinemaId,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate showDate) {
        return Result.success(scheduleService.getSchedulesByMovieAndCinema(movieId, cinemaId, showDate));
    }
    
    @Operation(summary = "获取场次座位状态")
    @GetMapping("/{scheduleId}/seats")
    public Result<List<SeatStatusVO>> getScheduleSeats(@PathVariable Long scheduleId) {
        return Result.success(scheduleService.getScheduleSeats(scheduleId));
    }
    
    @Operation(summary = "添加排片")
    @PostMapping
    public Result<Void> addSchedule(@RequestBody Schedule schedule) {
        scheduleService.addSchedule(schedule);
        return Result.success();
    }
    
    @Operation(summary = "更新排片")
    @PutMapping("/{id}")
    public Result<Void> updateSchedule(@PathVariable Long id, @RequestBody Schedule schedule) {
        schedule.setId(id);
        scheduleService.updateSchedule(schedule);
        return Result.success();
    }
    
    @Operation(summary = "删除排片")
    @DeleteMapping("/{id}")
    public Result<Void> deleteSchedule(@PathVariable Long id) {
        scheduleService.deleteSchedule(id);
        return Result.success();
    }
    
    @Operation(summary = "锁定座位")
    @PostMapping("/{scheduleId}/lock-seats")
    public Result<Void> lockSeats(
            @PathVariable Long scheduleId,
            @RequestBody List<Long> seatIds) {
        scheduleService.lockSeats(scheduleId, seatIds, authService.getCurrentUserId());
        return Result.success();
    }
    
    @Operation(summary = "解锁座位")
    @PostMapping("/{scheduleId}/unlock-seats")
    public Result<Void> unlockSeats(
            @PathVariable Long scheduleId,
            @RequestBody List<Long> seatIds) {
        scheduleService.unlockSeats(scheduleId, seatIds);
        return Result.success();
    }
}
