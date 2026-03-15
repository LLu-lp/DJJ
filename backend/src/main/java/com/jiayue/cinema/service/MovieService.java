package com.jiayue.cinema.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.Movie;

import java.util.List;

/**
 * 电影服务接口
 */
public interface MovieService {
    
    /**
     * 分页查询电影
     */
    Page<Movie> getMoviePage(Integer page, Integer size, String keyword, Integer status);
    
    /**
     * 获取电影详情
     */
    Movie getMovieById(Long id);
    
    /**
     * 获取正在上映的电影
     */
    List<Movie> getNowShowing();
    
    /**
     * 获取即将上映的电影
     */
    List<Movie> getComingSoon();
    
    /**
     * 添加电影
     */
    void addMovie(Movie movie);
    
    /**
     * 更新电影
     */
    void updateMovie(Movie movie);
    
    /**
     * 删除电影
     */
    void deleteMovie(Long id);
}
