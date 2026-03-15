package com.jiayue.cinema.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Cinema;
import com.jiayue.cinema.entity.Hall;
import com.jiayue.cinema.service.CinemaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 影院控制器
 */
@Tag(name = "影院管理", description = "影院相关接口")
@RestController
@RequestMapping("/cinemas")
@RequiredArgsConstructor
public class CinemaController {
    
    private final CinemaService cinemaService;
    
    @Operation(summary = "分页查询影院")
    @GetMapping("/page")
    public Result<Page<Cinema>> getCinemaPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword) {
        return Result.success(cinemaService.getCinemaPage(page, size, keyword));
    }
    
    @Operation(summary = "获取影院详情")
    @GetMapping("/{id}")
    public Result<Cinema> getCinemaById(@PathVariable Long id) {
        return Result.success(cinemaService.getCinemaById(id));
    }
    
    @Operation(summary = "获取所有营业中的影院")
    @GetMapping("/list")
    public Result<List<Cinema>> getActiveCinemas() {
        return Result.success(cinemaService.getActiveCinemas());
    }
    
    @Operation(summary = "添加影院")
    @PostMapping
    public Result<Void> addCinema(@RequestBody Cinema cinema) {
        cinema.setDeleted(0);
        cinemaService.addCinema(cinema);
        return Result.success();
    }
    
    @Operation(summary = "更新影院")
    @PutMapping("/{id}")
    public Result<Void> updateCinema(@PathVariable Long id, @RequestBody Cinema cinema) {
        cinema.setId(id);
        cinemaService.updateCinema(cinema);
        return Result.success();
    }
    
    @Operation(summary = "删除影院")
    @DeleteMapping("/{id}")
    public Result<Void> deleteCinema(@PathVariable Long id) {
        cinemaService.deleteCinema(id);
        return Result.success();
    }
    
    @Operation(summary = "获取影院的影厅列表")
    @GetMapping("/{cinemaId}/halls")
    public Result<List<Hall>> getHallsByCinemaId(@PathVariable Long cinemaId) {
        return Result.success(cinemaService.getHallsByCinemaId(cinemaId));
    }
    
    @Operation(summary = "添加影厅")
    @PostMapping("/halls")
    public Result<Void> addHall(@RequestBody Hall hall) {
        hall.setDeleted(0);
        cinemaService.addHall(hall);
        return Result.success();
    }
    
    @Operation(summary = "更新影厅")
    @PutMapping("/halls/{id}")
    public Result<Void> updateHall(@PathVariable Long id, @RequestBody Hall hall) {
        hall.setId(id);
        cinemaService.updateHall(hall);
        return Result.success();
    }
    
    @Operation(summary = "删除影厅")
    @DeleteMapping("/halls/{id}")
    public Result<Void> deleteHall(@PathVariable Long id) {
        cinemaService.deleteHall(id);
        return Result.success();
    }
}
