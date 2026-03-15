package com.jiayue.cinema.service;

import java.time.LocalDate;
import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.dto.ScheduleVO;
import com.jiayue.cinema.dto.SeatStatusVO;
import com.jiayue.cinema.entity.Schedule;

/**
 * 排片服务接口
 */
public interface ScheduleService {
    
    /**
     * 分页查询排片
     */
    Page<ScheduleVO> getSchedulePage(Integer page, Integer size, Long cinemaId, Long movieId, LocalDate showDate);
    
    /**
     * 获取排片详情
     */
    ScheduleVO getScheduleById(Long id);
    
    /**
     * 获取某电影在某影院的排片
     */
    List<ScheduleVO> getSchedulesByMovieAndCinema(Long movieId, Long cinemaId, LocalDate showDate);
    
    /**
     * 获取场次座位状态
     */
    List<SeatStatusVO> getScheduleSeats(Long scheduleId);
    
    /**
     * 添加排片
     */
    void addSchedule(Schedule schedule);
    
    /**
     * 更新排片
     */
    void updateSchedule(Schedule schedule);
    
    /**
     * 删除排片
     */
    void deleteSchedule(Long id);
    
    /**
     * 锁定座位
     */
    void lockSeats(Long scheduleId, List<Long> seatIds, Long userId);
    
    /**
     * 解锁座位
     */
    void unlockSeats(Long scheduleId, List<Long> seatIds);
}
