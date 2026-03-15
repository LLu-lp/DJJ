package com.jiayue.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiayue.cinema.entity.MemberInfo;

/**
 * 会员信息Mapper接口
 */
@Mapper
public interface MemberInfoMapper extends BaseMapper<MemberInfo> {
}
