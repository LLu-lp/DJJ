package com.jiayue.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.Schedule;

/**
 * 排片场次Mapper接口
 */
@Mapper
public interface ScheduleMapper extends BaseMapper<Schedule> {
}
