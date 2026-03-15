package com.jiayue.cinema.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.Cinema;
import com.jiayue.cinema.entity.Hall;

/**
 * 影院服务接口
 */
public interface CinemaService {
    
    /**
     * 分页查询影院
     */
    Page<Cinema> getCinemaPage(Integer page, Integer size, String keyword);
    
    /**
     * 获取影院详情
     */
    Cinema getCinemaById(Long id);
    
    /**
     * 获取所有营业中的影院
     */
    List<Cinema> getActiveCinemas();
    
    /**
     * 添加影院
     */
    void addCinema(Cinema cinema);
    
    /**
     * 更新影院
     */
    void updateCinema(Cinema cinema);
    
    /**
     * 删除影院
     */
    void deleteCinema(Long id);
    
    /**
     * 获取影院的影厅列表
     */
    List<Hall> getHallsByCinemaId(Long cinemaId);
    
    /**
     * 添加影厅
     */
    void addHall(Hall hall);
    
    /**
     * 更新影厅
     */
    void updateHall(Hall hall);
    
    /**
     * 删除影厅
     */
    void deleteHall(Long id);
}
