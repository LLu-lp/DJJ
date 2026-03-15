package com.jiayue.cinema.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Announcement;
import com.jiayue.cinema.mapper.AnnouncementMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Tag(name = "公告管理", description = "公告相关接口")
@RestController
@RequestMapping("/announcements")
@RequiredArgsConstructor
public class AnnouncementController {
    
    private final AnnouncementMapper announcementMapper;
    
    @Operation(summary = "分页查询公告")
    @GetMapping("/page")
    public Result<Page<Announcement>> getAnnouncementPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) Integer type) {
        
        LambdaQueryWrapper<Announcement> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(type != null, Announcement::getType, type)
                .eq(Announcement::getStatus, 1)
                .orderByDesc(Announcement::getIsTop)
                .orderByDesc(Announcement::getPublishTime);
        
        return Result.success(announcementMapper.selectPage(new Page<>(page, size), wrapper));
    }
    
    @Operation(summary = "获取公告列表")
    @GetMapping("/list")
    public Result<List<Announcement>> getAnnouncementList(@RequestParam(defaultValue = "5") Integer limit) {
        return Result.success(announcementMapper.selectList(
                new LambdaQueryWrapper<Announcement>()
                        .eq(Announcement::getStatus, 1)
                        .orderByDesc(Announcement::getIsTop)
                        .orderByDesc(Announcement::getPublishTime)
                        .last("LIMIT " + limit)
        ));
    }
    
    @Operation(summary = "获取公告详情")
    @GetMapping("/{id}")
    public Result<Announcement> getAnnouncementById(@PathVariable Long id) {
        Announcement announcement = announcementMapper.selectById(id);
        if (announcement != null) {
            announcement.setViewCount(announcement.getViewCount() + 1);
            announcementMapper.updateById(announcement);
        }
        return Result.success(announcement);
    }
    
    @Operation(summary = "添加公告")
    @PostMapping
    public Result<Void> addAnnouncement(@RequestBody Announcement announcement) {
        announcement.setViewCount(0);
        announcement.setPublishTime(LocalDateTime.now());
        announcement.setStatus(1);
        announcement.setDeleted(0);
        announcementMapper.insert(announcement);
        return Result.success();
    }
    
    @Operation(summary = "更新公告")
    @PutMapping("/{id}")
    public Result<Void> updateAnnouncement(@PathVariable Long id, @RequestBody Announcement announcement) {
        announcement.setId(id);
        announcementMapper.updateById(announcement);
        return Result.success();
    }
    
    @Operation(summary = "删除公告")
    @DeleteMapping("/{id}")
    public Result<Void> deleteAnnouncement(@PathVariable Long id) {
        announcementMapper.deleteById(id);
        return Result.success();
    }
}
