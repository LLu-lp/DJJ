package com.jiayue.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.Cinema;

/**
 * 影院Mapper接口
 */
@Mapper
public interface CinemaMapper extends BaseMapper<Cinema> {
}
