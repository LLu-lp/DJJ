package com.jiayue.cinema.service;

import java.math.BigDecimal;
import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.dto.MemberInfoVO;
import com.jiayue.cinema.entity.MemberLevel;
import com.jiayue.cinema.entity.PointsLog;
import com.jiayue.cinema.entity.RechargeLog;

/**
 * 会员服务接口
 */
public interface MemberService {
    
    /**
     * 获取会员信息
     */
    MemberInfoVO getMemberInfo(Long userId);
    
    /**
     * 获取会员等级列表
     */
    List<MemberLevel> getMemberLevels();
    
    /**
     * 充值
     */
    void recharge(Long userId, BigDecimal amount, Integer payType);
    
    /**
     * 获取充值记录
     */
    Page<RechargeLog> getRechargeLogPage(Integer page, Integer size, Long userId);
    
    /**
     * 获取积分记录
     */
    Page<PointsLog> getPointsLogPage(Integer page, Integer size, Long userId);
    
    /**
     * 添加积分
     */
    void addPoints(Long userId, Integer points, Integer type, Long relatedId, String remark);
    
    /**
     * 使用积分
     */
    void usePoints(Long userId, Integer points, Long relatedId, String remark);
    
    /**
     * 更新累计消费金额
     */
    void updateTotalSpent(Long userId, BigDecimal amount);
}
