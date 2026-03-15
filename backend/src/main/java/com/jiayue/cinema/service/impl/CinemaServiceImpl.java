package com.jiayue.cinema.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.entity.Cinema;
import com.jiayue.cinema.entity.Hall;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.CinemaMapper;
import com.jiayue.cinema.mapper.HallMapper;
import com.jiayue.cinema.service.CinemaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 影院服务实现
 */
@Service
@RequiredArgsConstructor
public class CinemaServiceImpl implements CinemaService {
    
    private final CinemaMapper cinemaMapper;
    private final HallMapper hallMapper;
    
    @Override
    public Page<Cinema> getCinemaPage(Integer page, Integer size, String keyword) {
        LambdaQueryWrapper<Cinema> wrapper = new LambdaQueryWrapper<>();
        
        if (StrUtil.isNotBlank(keyword)) {
            wrapper.like(Cinema::getName, keyword)
                    .or().like(Cinema::getAddress, keyword);
        }
        
        wrapper.orderByDesc(Cinema::getCreatedAt);
        
        return cinemaMapper.selectPage(new Page<>(page, size), wrapper);
    }
    
    @Override
    public Cinema getCinemaById(Long id) {
        Cinema cinema = cinemaMapper.selectById(id);
        if (cinema == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "影院不存在");
        }
        return cinema;
    }
    
    @Override
    public List<Cinema> getActiveCinemas() {
        return cinemaMapper.selectList(
                new LambdaQueryWrapper<Cinema>()
                        .eq(Cinema::getStatus, 1)
                        .orderByAsc(Cinema::getId)
        );
    }
    
    @Override
    public void addCinema(Cinema cinema) {
        cinema.setStatus(1);
        cinemaMapper.insert(cinema);
    }
    
    @Override
    public void updateCinema(Cinema cinema) {
        Cinema existing = cinemaMapper.selectById(cinema.getId());
        if (existing == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "影院不存在");
        }
        cinemaMapper.updateById(cinema);
    }
    
    @Override
    public void deleteCinema(Long id) {
        Cinema cinema = cinemaMapper.selectById(id);
        if (cinema == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "影院不存在");
        }
        cinemaMapper.deleteById(id);
    }
    
    @Override
    public List<Hall> getHallsByCinemaId(Long cinemaId) {
        return hallMapper.selectList(
                new LambdaQueryWrapper<Hall>()
                        .eq(Hall::getCinemaId, cinemaId)
                        .orderByAsc(Hall::getId)
        );
    }
    
    @Override
    public void addHall(Hall hall) {
        hall.setStatus(1);
        hall.setTotalSeats(hall.getRows() * hall.getCols());
        hallMapper.insert(hall);
    }
    
    @Override
    public void updateHall(Hall hall) {
        Hall existing = hallMapper.selectById(hall.getId());
        if (existing == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "影厅不存在");
        }
        hall.setTotalSeats(hall.getRows() * hall.getCols());
        hallMapper.updateById(hall);
    }
    
    @Override
    public void deleteHall(Long id) {
        Hall hall = hallMapper.selectById(id);
        if (hall == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "影厅不存在");
        }
        hallMapper.deleteById(id);
    }
}
