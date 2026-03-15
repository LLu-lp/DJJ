package com.jiayue.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.OrderSnack;

/**
 * 订单商品关联Mapper接口
 */
@Mapper
public interface OrderSnackMapper extends BaseMapper<OrderSnack> {
}
