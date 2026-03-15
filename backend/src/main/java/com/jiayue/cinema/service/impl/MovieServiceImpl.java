package com.jiayue.cinema.service.impl;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.MovieMapper;
import com.jiayue.cinema.service.MovieService;

import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;

/**
 * 电影服务实现
 */
@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {
    
    private final MovieMapper movieMapper;
    
    @Override
    public Page<Movie> getMoviePage(Integer page, Integer size, String keyword, Integer status) {
        LambdaQueryWrapper<Movie> wrapper = new LambdaQueryWrapper<>();
        
        if (StrUtil.isNotBlank(keyword)) {
            wrapper.like(Movie::getTitle, keyword)
                    .or().like(Movie::getDirector, keyword)
                    .or().like(Movie::getActors, keyword);
        }
        
        if (status != null) {
            wrapper.eq(Movie::getStatus, status);
        }
        
        wrapper.orderByDesc(Movie::getCreatedAt);
        
        return movieMapper.selectPage(new Page<>(page, size), wrapper);
    }
    
    @Override
    public Movie getMovieById(Long id) {
        Movie movie = movieMapper.selectById(id);
        if (movie == null) {
            throw new BusinessException(ResultCode.MOVIE_NOT_FOUND);
        }
        return movie;
    }
    
    @Override
    public List<Movie> getNowShowing() {
        LocalDate today = LocalDate.now();
        return movieMapper.selectList(
                new LambdaQueryWrapper<Movie>()
                        .eq(Movie::getStatus, 1)
                        .eq(Movie::getDeleted, 0)
                        .le(Movie::getReleaseDate, today)
                        .isNotNull(Movie::getReleaseDate)
                        .orderByDesc(Movie::getRating)
        );
    }
    
    @Override
    public List<Movie> getComingSoon() {
        LocalDate today = LocalDate.now();
        return movieMapper.selectList(
                new LambdaQueryWrapper<Movie>()
                        .eq(Movie::getStatus, 2)
                        .eq(Movie::getDeleted, 0)
                        .gt(Movie::getReleaseDate, today)
                        .isNotNull(Movie::getReleaseDate)
                        .orderByAsc(Movie::getReleaseDate)
        );
    }
    
    @Override
    public void addMovie(Movie movie) {
        movie.setStatus(1);
        movie.setDeleted(0);
        movieMapper.insert(movie);
    }
    
    @Override
    public void updateMovie(Movie movie) {
        Movie existing = movieMapper.selectById(movie.getId());
        if (existing == null) {
            throw new BusinessException(ResultCode.MOVIE_NOT_FOUND);
        }
        movieMapper.updateById(movie);
    }
    
    @Override
    public void deleteMovie(Long id) {
        Movie movie = movieMapper.selectById(id);
        if (movie == null) {
            throw new BusinessException(ResultCode.MOVIE_NOT_FOUND);
        }
        movieMapper.deleteById(id);
    }
}
