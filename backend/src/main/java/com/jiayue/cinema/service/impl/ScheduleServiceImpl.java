package com.jiayue.cinema.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.dto.ScheduleVO;
import com.jiayue.cinema.dto.SeatStatusVO;
import com.jiayue.cinema.entity.*;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.*;
import com.jiayue.cinema.service.ScheduleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 排片服务实现
 */
@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {
    
    private final ScheduleMapper scheduleMapper;
    private final MovieMapper movieMapper;
    private final CinemaMapper cinemaMapper;
    private final HallMapper hallMapper;
    private final SeatMapper seatMapper;
    private final ScheduleSeatMapper scheduleSeatMapper;
    
    @Override
    public Page<ScheduleVO> getSchedulePage(Integer page, Integer size, Long cinemaId, Long movieId, LocalDate showDate) {
        Page<Schedule> schedulePage = scheduleMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<Schedule>()
                        .eq(cinemaId != null, Schedule::getCinemaId, cinemaId)
                        .eq(movieId != null, Schedule::getMovieId, movieId)
                        .eq(showDate != null, Schedule::getShowDate, showDate)
                        .ge(showDate == null, Schedule::getShowDate, LocalDate.now()) // 如果没有指定日期，只查询今天及以后的场次
                        .eq(Schedule::getStatus, 1) // 只查询有效的场次
                        .orderByAsc(Schedule::getShowDate)
                        .orderByAsc(Schedule::getStartTime)
        );
        
        // 过滤掉已过期或即将开始的场次（距离开始时间少于 20 分钟）
        List<Schedule> filteredSchedules = filterAvailableSchedules(schedulePage.getRecords());
        
        Page<ScheduleVO> voPage = new Page<>(schedulePage.getCurrent(), schedulePage.getSize(), schedulePage.getTotal());
        voPage.setRecords(convertToVOList(filteredSchedules));
        
        return voPage;
    }
    
    @Override
    public ScheduleVO getScheduleById(Long id) {
        Schedule schedule = scheduleMapper.selectById(id);
        if (schedule == null) {
            throw new BusinessException(ResultCode.SCHEDULE_NOT_FOUND);
        }
        return convertToVO(schedule);
    }
    
    @Override
    public List<ScheduleVO> getSchedulesByMovieAndCinema(Long movieId, Long cinemaId, LocalDate showDate) {
        List<Schedule> schedules = scheduleMapper.selectList(
                new LambdaQueryWrapper<Schedule>()
                        .eq(movieId != null, Schedule::getMovieId, movieId)
                        .eq(cinemaId != null, Schedule::getCinemaId, cinemaId)
                        .eq(showDate != null, Schedule::getShowDate, showDate)
                        .ge(Schedule::getShowDate, LocalDate.now())
                        .eq(Schedule::getStatus, 1)
                        .orderByAsc(Schedule::getShowDate)
                        .orderByAsc(Schedule::getStartTime)
        );
        // 过滤掉已过期或即将开始的场次（距离开始时间少于 20 分钟）
        List<Schedule> filteredSchedules = filterAvailableSchedules(schedules);
        return convertToVOList(filteredSchedules);
    }
    
    @Override
    public List<SeatStatusVO> getScheduleSeats(Long scheduleId) {
        Schedule schedule = scheduleMapper.selectById(scheduleId);
        if (schedule == null) {
            throw new BusinessException(ResultCode.SCHEDULE_NOT_FOUND);
        }
        
        // 获取影厅所有座位
        List<Seat> seats = seatMapper.selectList(
                new LambdaQueryWrapper<Seat>()
                        .eq(Seat::getHallId, schedule.getHallId())
                        .orderByAsc(Seat::getRowNum)
                        .orderByAsc(Seat::getColNum)
        );
        
        // 获取场次座位状态
        List<ScheduleSeat> scheduleSeats = scheduleSeatMapper.selectList(
                new LambdaQueryWrapper<ScheduleSeat>()
                        .eq(ScheduleSeat::getScheduleId, scheduleId)
        );
        
        Map<Long, ScheduleSeat> seatStatusMap = scheduleSeats.stream()
                .collect(Collectors.toMap(ScheduleSeat::getSeatId, s -> s));
        
        List<SeatStatusVO> result = new ArrayList<>();
        for (Seat seat : seats) {
            SeatStatusVO vo = new SeatStatusVO();
            vo.setSeatId(seat.getId());
            vo.setRowNum(seat.getRowNum());
            vo.setColNum(seat.getColNum());
            vo.setSeatLabel(seat.getSeatLabel());
            vo.setSeatType(seat.getSeatType());
            
            ScheduleSeat scheduleSeat = seatStatusMap.get(seat.getId());
            if (scheduleSeat != null) {
                vo.setStatus(scheduleSeat.getStatus());
                vo.setPrice(scheduleSeat.getPrice());
            } else {
                vo.setStatus(0);
                vo.setPrice(schedule.getPrice());
            }
            
            result.add(vo);
        }
        
        return result;
    }
    
    @Override
    @Transactional
    public void addSchedule(Schedule schedule) {
        // 验证必要字段
        if (schedule.getMovieId() == null || schedule.getCinemaId() == null || 
            schedule.getHallId() == null || schedule.getShowDate() == null || 
            schedule.getStartTime() == null || schedule.getPrice() == null) {
            throw new BusinessException(ResultCode.PARAM_ERROR, "排片信息不完整");
        }
        
        // 获取电影信息，计算结束时间
        Movie movie = movieMapper.selectById(schedule.getMovieId());
        if (movie == null) {
            throw new BusinessException(ResultCode.MOVIE_NOT_FOUND);
        }
        
        // 自动计算结束时间 = 开始时间 + 电影时长 + 15分钟清场时间
        LocalTime endTime = schedule.getStartTime().plusMinutes(movie.getDuration() + 15);
        schedule.setEndTime(endTime);
        
        schedule.setStatus(1);
        schedule.setDeleted(0);
        scheduleMapper.insert(schedule);
        
        // 验证 Schedule ID 是否正确生成
        if (schedule.getId() == null || schedule.getId() <= 0) {
            throw new BusinessException(ResultCode.INTERNAL_ERROR, "排片创建失败，无法获取排片ID");
        }
        
        // 初始化场次座位
        List<Seat> seats = seatMapper.selectList(
                new LambdaQueryWrapper<Seat>().eq(Seat::getHallId, schedule.getHallId())
        );
        
        if (seats == null || seats.isEmpty()) {
            throw new BusinessException(ResultCode.INTERNAL_ERROR, "影厅中没有座位，请先为影厅添加座位");
        }
        
        for (Seat seat : seats) {
            ScheduleSeat scheduleSeat = new ScheduleSeat();
            scheduleSeat.setScheduleId(schedule.getId());
            scheduleSeat.setSeatId(seat.getId());
            scheduleSeat.setStatus(0);
            scheduleSeat.setPrice(schedule.getPrice());
            scheduleSeatMapper.insert(scheduleSeat);
        }
    }
    
    @Override
    public void updateSchedule(Schedule schedule) {
        Schedule existing = scheduleMapper.selectById(schedule.getId());
        if (existing == null) {
            throw new BusinessException(ResultCode.SCHEDULE_NOT_FOUND);
        }
        scheduleMapper.updateById(schedule);
    }
    
    @Override
    public void deleteSchedule(Long id) {
        Schedule schedule = scheduleMapper.selectById(id);
        if (schedule == null) {
            throw new BusinessException(ResultCode.SCHEDULE_NOT_FOUND);
        }
        scheduleMapper.deleteById(id);
    }
    
    @Override
    @Transactional
    public void lockSeats(Long scheduleId, List<Long> seatIds, Long userId) {
        if (CollUtil.isEmpty(seatIds)) {
            return;
        }
        
        for (Long seatId : seatIds) {
            ScheduleSeat scheduleSeat = scheduleSeatMapper.selectOne(
                    new LambdaQueryWrapper<ScheduleSeat>()
                            .eq(ScheduleSeat::getScheduleId, scheduleId)
                            .eq(ScheduleSeat::getSeatId, seatId)
            );
            
            if (scheduleSeat == null || scheduleSeat.getStatus() != 0) {
                throw new BusinessException(ResultCode.SEAT_NOT_AVAILABLE);
            }
            
            scheduleSeatMapper.update(null,
                    new LambdaUpdateWrapper<ScheduleSeat>()
                            .eq(ScheduleSeat::getId, scheduleSeat.getId())
                            .set(ScheduleSeat::getStatus, 2)
                            .set(ScheduleSeat::getLockedBy, userId)
                            .set(ScheduleSeat::getLockedAt, LocalDateTime.now())
            );
        }
    }
    
    @Override
    @Transactional
    public void unlockSeats(Long scheduleId, List<Long> seatIds) {
        if (CollUtil.isEmpty(seatIds)) {
            return;
        }
        
        scheduleSeatMapper.update(null,
                new LambdaUpdateWrapper<ScheduleSeat>()
                        .eq(ScheduleSeat::getScheduleId, scheduleId)
                        .in(ScheduleSeat::getSeatId, seatIds)
                        .set(ScheduleSeat::getStatus, 0)
                        .set(ScheduleSeat::getLockedBy, null)
                        .set(ScheduleSeat::getLockedAt, null)
        );
    }
    
    private List<ScheduleVO> convertToVOList(List<Schedule> schedules) {
        if (CollUtil.isEmpty(schedules)) {
            return new ArrayList<>();
        }
        
        // 批量获取关联数据
        List<Long> movieIds = schedules.stream().map(Schedule::getMovieId).distinct().toList();
        List<Long> cinemaIds = schedules.stream().map(Schedule::getCinemaId).distinct().toList();
        List<Long> hallIds = schedules.stream().map(Schedule::getHallId).distinct().toList();
        
        Map<Long, Movie> movieMap = movieMapper.selectBatchIds(movieIds).stream()
                .collect(Collectors.toMap(Movie::getId, m -> m));
        Map<Long, Cinema> cinemaMap = cinemaMapper.selectBatchIds(cinemaIds).stream()
                .collect(Collectors.toMap(Cinema::getId, c -> c));
        Map<Long, Hall> hallMap = hallMapper.selectBatchIds(hallIds).stream()
                .collect(Collectors.toMap(Hall::getId, h -> h));
        
        return schedules.stream().map(schedule -> {
            ScheduleVO vo = new ScheduleVO();
            vo.setId(schedule.getId());
            vo.setMovieId(schedule.getMovieId());
            vo.setCinemaId(schedule.getCinemaId());
            vo.setHallId(schedule.getHallId());
            vo.setShowDate(schedule.getShowDate());
            vo.setStartTime(schedule.getStartTime());
            vo.setEndTime(schedule.getEndTime());
            vo.setPrice(schedule.getPrice());
            vo.setVipPrice(schedule.getVipPrice());
            vo.setLanguage(schedule.getLanguage());
            vo.setStatus(schedule.getStatus());
            
            Movie movie = movieMap.get(schedule.getMovieId());
            if (movie != null) {
                vo.setMovieTitle(movie.getTitle());
                vo.setMoviePoster(movie.getPoster());
            }
            
            Cinema cinema = cinemaMap.get(schedule.getCinemaId());
            if (cinema != null) {
                vo.setCinemaName(cinema.getName());
            }
            
            Hall hall = hallMap.get(schedule.getHallId());
            if (hall != null) {
                vo.setHallName(hall.getName());
                vo.setHallType(hall.getType());
                vo.setTotalSeats(hall.getTotalSeats());
            }
            
            // 计算可用座位数和已售座位数
            Long availableSeats = scheduleSeatMapper.selectCount(
                    new LambdaQueryWrapper<ScheduleSeat>()
                            .eq(ScheduleSeat::getScheduleId, schedule.getId())
                            .eq(ScheduleSeat::getStatus, 0)
            );
            Long soldSeats = scheduleSeatMapper.selectCount(
                    new LambdaQueryWrapper<ScheduleSeat>()
                            .eq(ScheduleSeat::getScheduleId, schedule.getId())
                            .eq(ScheduleSeat::getStatus, 1)
            );
            vo.setAvailableSeats(availableSeats.intValue());
            vo.setSoldSeats(soldSeats.intValue());
            
            return vo;
        }).toList();
    }
    
    private ScheduleVO convertToVO(Schedule schedule) {
        return convertToVOList(List.of(schedule)).get(0);
    }
    
    /**
     * 过滤掉已过期或即将开始的场次
     * 规则：只返回距离开始时间至少 20 分钟以上的场次
     */
    private List<Schedule> filterAvailableSchedules(List<Schedule> schedules) {
        LocalDateTime now = LocalDateTime.now();
        LocalDate today = LocalDate.now();
        LocalTime currentTime = LocalTime.now();
        
        return schedules.stream().filter(schedule -> {
            // 如果是今天的场次，检查时间
            if (schedule.getShowDate().equals(today)) {
                // 计算距离开始时间的分钟数
                LocalDateTime scheduleStartDateTime = LocalDateTime.of(schedule.getShowDate(), schedule.getStartTime());
                long minutesUntilStart = java.time.temporal.ChronoUnit.MINUTES.between(now, scheduleStartDateTime);
                
                // 只返回距离开始时间至少 20 分钟以上的场次
                return minutesUntilStart >= 20;
            }
            
            // 如果是未来的日期，直接返回
            return schedule.getShowDate().isAfter(today);
        }).collect(Collectors.toList());
    }
}
