package com.jiayue.cinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.Movie;

/**
 * 电影Mapper接口
 */
@Mapper
public interface MovieMapper extends BaseMapper<Movie> {
    
    @Select("SELECT genre AS name, COUNT(*) AS value FROM movies WHERE deleted = 0 GROUP BY genre ORDER BY value DESC LIMIT 10")
    List<Map<String, Object>> selectGenreDistribution();
}
