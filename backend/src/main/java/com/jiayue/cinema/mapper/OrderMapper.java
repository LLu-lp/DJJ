package com.jiayue.cinema.mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.Order;

@Mapper
public interface OrderMapper extends BaseMapper<Order> {
    
    @Select("SELECT COALESCE(SUM(pay_amount), 0) FROM orders WHERE status = 1 AND pay_time BETWEEN #{startTime} AND #{endTime}")
    java.math.BigDecimal selectTodayRevenue(@Param("startTime") LocalDateTime startTime, @Param("endTime") LocalDateTime endTime);
    
    @Select("SELECT m.genre AS name, ROUND(COALESCE(SUM(o.pay_amount), 0) / 10000, 2) AS value " +
            "FROM movies m " +
            "LEFT JOIN schedules s ON m.id = s.movie_id " +
            "LEFT JOIN orders o ON s.id = o.schedule_id AND o.status = 1 " +
            "WHERE m.deleted = 0 " +
            "GROUP BY m.genre " +
            "ORDER BY value DESC " +
            "LIMIT 10")
    List<Map<String, Object>> selectRevenueByGenre();
}
