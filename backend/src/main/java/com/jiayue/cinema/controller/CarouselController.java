package com.jiayue.cinema.controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Carousel;
import com.jiayue.cinema.mapper.CarouselMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "轮播图管理", description = "轮播图相关接口")
@RestController
@RequestMapping("/carousels")
@RequiredArgsConstructor
public class CarouselController {

    private final CarouselMapper carouselMapper;

    @Operation(summary = "获取所有轮播图")
    @GetMapping("/list")
    public Result<List<Carousel>> list() {
        List<Carousel> list = carouselMapper.selectList(
                new LambdaQueryWrapper<Carousel>().orderByAsc(Carousel::getSort)
        );
        return Result.success(list);
    }

    @Operation(summary = "获取启用的轮播图")
    @GetMapping("/active")
    public Result<List<Carousel>> active() {
        List<Carousel> list = carouselMapper.selectList(
                new LambdaQueryWrapper<Carousel>()
                        .eq(Carousel::getStatus, 1)
                        .orderByAsc(Carousel::getSort)
        );
        return Result.success(list);
    }

    @Operation(summary = "新增轮播图")
    @PostMapping
    public Result<Void> create(@RequestBody Carousel carousel) {
        carouselMapper.insert(carousel);
        return Result.success();
    }

    @Operation(summary = "更新轮播图")
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody Carousel carousel) {
        carousel.setId(id);
        carouselMapper.updateById(carousel);
        return Result.success();
    }

    @Operation(summary = "删除轮播图")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        carouselMapper.deleteById(id);
        return Result.success();
    }
}

