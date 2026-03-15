package com.jiayue.cinema.service.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.dto.MemberInfoVO;
import com.jiayue.cinema.entity.MemberInfo;
import com.jiayue.cinema.entity.MemberLevel;
import com.jiayue.cinema.entity.PointsLog;
import com.jiayue.cinema.entity.RechargeLog;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.MemberInfoMapper;
import com.jiayue.cinema.mapper.MemberLevelMapper;
import com.jiayue.cinema.mapper.PointsLogMapper;
import com.jiayue.cinema.mapper.RechargeLogMapper;
import com.jiayue.cinema.mapper.UserMapper;
import com.jiayue.cinema.service.MemberService;

import cn.hutool.core.util.IdUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
    
    private final MemberInfoMapper memberInfoMapper;
    private final MemberLevelMapper memberLevelMapper;
    private final UserMapper userMapper;
    private final RechargeLogMapper rechargeLogMapper;
    private final PointsLogMapper pointsLogMapper;
    
    @Override
    public MemberInfoVO getMemberInfo(Long userId) {
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null) {
            // 获取默认会员等级（等级1）
            MemberLevel defaultLevel = memberLevelMapper.selectOne(
                    new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, 1)
            );
            
            memberInfo = new MemberInfo();
            memberInfo.setUserId(userId);
            memberInfo.setMemberNo(generateMemberNo());
            memberInfo.setLevelId(defaultLevel != null ? defaultLevel.getId() : 1L);
            memberInfo.setPoints(0);
            memberInfo.setTotalPoints(0);
            memberInfo.setTotalSpent(BigDecimal.ZERO);
            memberInfo.setTotalRecharge(BigDecimal.ZERO);
            memberInfoMapper.insert(memberInfo);
        } else {
            // 根据累计消费金额重新检查并升级会员等级
            checkAndUpgradeLevel(userId, memberInfo.getTotalSpent());
            // 重新获取最新的会员信息
            memberInfo = memberInfoMapper.selectOne(
                    new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
            );
        }
        
        User user = userMapper.selectById(userId);
        MemberLevel level = null;
        if (memberInfo.getLevelId() != null) {
            level = memberLevelMapper.selectById(memberInfo.getLevelId());
        }
        
        // 获取所有会员等级
        List<MemberLevel> allLevels = memberLevelMapper.selectList(
                new LambdaQueryWrapper<MemberLevel>()
                        .orderByAsc(MemberLevel::getMinSpent)
        );
        
        MemberInfoVO vo = new MemberInfoVO();
        vo.setUserId(userId);
        vo.setLevelId(memberInfo.getLevelId());
        vo.setMemberNo(memberInfo.getMemberNo());
        vo.setPoints(memberInfo.getPoints());
        vo.setTotalPoints(memberInfo.getTotalPoints());
        vo.setTotalSpent(memberInfo.getTotalSpent());
        vo.setTotalConsumed(memberInfo.getTotalSpent());  // 同时设置前端使用的字段
        vo.setTotalRecharge(memberInfo.getTotalRecharge());
        vo.setBalance(user.getBalance());
        vo.setJoinTime(memberInfo.getCreatedAt() != null ? memberInfo.getCreatedAt().toString() : null);
        
        if (level != null) {
            vo.setLevel(level.getLevel());
            vo.setLevelName(level.getLevelName());
            vo.setLevelCode(level.getLevelCode());
            vo.setDiscount(level.getDiscount());
        } else {
            vo.setLevel(0);
            vo.setLevelName("普通会员");
            vo.setLevelCode("NORMAL");
            vo.setDiscount(BigDecimal.ONE);
        }
        
        // 转换会员等级列表
        List<MemberInfoVO.MemberLevelVO> levelVOs = allLevels.stream()
                .map(l -> {
                    MemberInfoVO.MemberLevelVO levelVO = new MemberInfoVO.MemberLevelVO();
                    levelVO.setId(l.getId());
                    levelVO.setLevel(l.getLevel());
                    levelVO.setLevelName(l.getLevelName());
                    levelVO.setLevelCode(l.getLevelCode());
                    levelVO.setMinSpent(l.getMinSpent());
                    levelVO.setMaxSpent(l.getMaxSpent());
                    levelVO.setDiscount(l.getDiscount());
                    levelVO.setBenefits(l.getBenefits());
                    return levelVO;
                })
                .toList();
        vo.setMemberLevels(levelVOs);
        
        return vo;
    }
    
    @Override
    public List<MemberLevel> getMemberLevels() {
        return memberLevelMapper.selectList(
                new LambdaQueryWrapper<MemberLevel>()
                        .orderByAsc(MemberLevel::getMinSpent)
        );
    }
    
    @Override
    @Transactional
    public void recharge(Long userId, BigDecimal amount, Integer payType) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        
        BigDecimal giftAmount = BigDecimal.ZERO;
        int giftPoints = 0;
        
        if (amount.compareTo(BigDecimal.valueOf(200)) >= 0) {
            giftAmount = amount.multiply(BigDecimal.valueOf(0.1));
        }
        if (amount.compareTo(BigDecimal.valueOf(500)) >= 0) {
            giftAmount = amount.multiply(BigDecimal.valueOf(0.15));
        }
        giftPoints = amount.intValue();
        
        BigDecimal newBalance = user.getBalance().add(amount).add(giftAmount);
        user.setBalance(newBalance);
        userMapper.updateById(user);
        
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null) {
            // 获取默认会员等级（等级1）
            MemberLevel defaultLevel = memberLevelMapper.selectOne(
                    new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, 1)
            );
            
            memberInfo = new MemberInfo();
            memberInfo.setUserId(userId);
            memberInfo.setMemberNo(generateMemberNo());
            memberInfo.setLevelId(defaultLevel != null ? defaultLevel.getId() : 1L);
            memberInfo.setPoints(giftPoints);
            memberInfo.setTotalPoints(giftPoints);
            memberInfo.setTotalSpent(BigDecimal.ZERO);
            memberInfo.setTotalRecharge(amount);
            memberInfoMapper.insert(memberInfo);
        } else {
            memberInfo.setPoints(memberInfo.getPoints() + giftPoints);
            memberInfo.setTotalPoints(memberInfo.getTotalPoints() + giftPoints);
            memberInfo.setTotalRecharge(memberInfo.getTotalRecharge().add(amount));
            memberInfoMapper.updateById(memberInfo);
        }
        
        RechargeLog rechargeLog = new RechargeLog();
        rechargeLog.setUserId(userId);
        rechargeLog.setOrderNo(generateOrderNo());
        rechargeLog.setAmount(amount);
        rechargeLog.setGiftAmount(giftAmount);
        rechargeLog.setGiftPoints(giftPoints);
        rechargeLog.setPayType(payType);
        rechargeLog.setPayTime(LocalDateTime.now());
        rechargeLog.setStatus(1);
        rechargeLogMapper.insert(rechargeLog);
        
        if (giftPoints > 0) {
            addPoints(userId, giftPoints, 2, rechargeLog.getId(), "充值赠送积分");
        }
    }
    
    @Override
    public Page<RechargeLog> getRechargeLogPage(Integer page, Integer size, Long userId) {
        return rechargeLogMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<RechargeLog>()
                        .eq(RechargeLog::getUserId, userId)
                        .eq(RechargeLog::getStatus, 1)
                        .orderByDesc(RechargeLog::getCreatedAt)
        );
    }
    
    @Override
    public Page<PointsLog> getPointsLogPage(Integer page, Integer size, Long userId) {
        return pointsLogMapper.selectPage(
                new Page<>(page, size),
                new LambdaQueryWrapper<PointsLog>()
                        .eq(PointsLog::getUserId, userId)
                        .orderByDesc(PointsLog::getCreatedAt)
        );
    }
    
    @Override
    @Transactional
    public void addPoints(Long userId, Integer points, Integer type, Long relatedId, String remark) {
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null) {
            // 获取默认会员等级（等级1）
            MemberLevel defaultLevel = memberLevelMapper.selectOne(
                    new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, 1)
            );
            
            memberInfo = new MemberInfo();
            memberInfo.setUserId(userId);
            memberInfo.setMemberNo(generateMemberNo());
            memberInfo.setLevelId(defaultLevel != null ? defaultLevel.getId() : 1L);
            memberInfo.setPoints(points);
            memberInfo.setTotalPoints(points);
            memberInfo.setTotalSpent(BigDecimal.ZERO);
            memberInfo.setTotalRecharge(BigDecimal.ZERO);
            memberInfoMapper.insert(memberInfo);
        } else {
            memberInfo.setPoints(memberInfo.getPoints() + points);
            memberInfo.setTotalPoints(memberInfo.getTotalPoints() + points);
            memberInfoMapper.updateById(memberInfo);
        }
        
        PointsLog pointsLog = new PointsLog();
        pointsLog.setUserId(userId);
        pointsLog.setPoints(points);
        pointsLog.setBalance(memberInfo.getPoints());
        pointsLog.setType(type);
        pointsLog.setRelatedId(relatedId);
        pointsLog.setRemark(remark);
        pointsLogMapper.insert(pointsLog);
    }
    
    @Override
    @Transactional
    public void usePoints(Long userId, Integer points, Long relatedId, String remark) {
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null || memberInfo.getPoints() < points) {
            throw new BusinessException(ResultCode.INSUFFICIENT_POINTS);
        }
        
        memberInfo.setPoints(memberInfo.getPoints() - points);
        memberInfoMapper.updateById(memberInfo);
        
        PointsLog pointsLog = new PointsLog();
        pointsLog.setUserId(userId);
        pointsLog.setPoints(-points);
        pointsLog.setBalance(memberInfo.getPoints());
        pointsLog.setType(3);
        pointsLog.setRelatedId(relatedId);
        pointsLog.setRemark(remark);
        pointsLogMapper.insert(pointsLog);
    }
    
    private void checkAndUpgradeLevel(Long userId, BigDecimal totalSpent) {
        List<MemberLevel> levels = memberLevelMapper.selectList(
                new LambdaQueryWrapper<MemberLevel>()
                        .le(MemberLevel::getMinSpent, totalSpent)
                        .orderByDesc(MemberLevel::getMinSpent)
                        .last("LIMIT 1")
        );
        
        if (!levels.isEmpty()) {
            MemberLevel level = levels.get(0);
            memberInfoMapper.update(null,
                    new LambdaUpdateWrapper<MemberInfo>()
                        .eq(MemberInfo::getUserId, userId)
                        .set(MemberInfo::getLevelId, level.getId())
            );
        }
    }
    
    private String generateMemberNo() {
        String dateStr = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String randomStr = IdUtil.randomUUID().substring(0, 6).toUpperCase();
        return "JY" + dateStr + randomStr;
    }
    
    @Override
    @Transactional
    public void updateTotalSpent(Long userId, BigDecimal amount) {
        MemberInfo memberInfo = memberInfoMapper.selectOne(
                new LambdaQueryWrapper<MemberInfo>().eq(MemberInfo::getUserId, userId)
        );
        
        if (memberInfo == null) {
            // 如果会员信息不存在，先创建
            MemberLevel defaultLevel = memberLevelMapper.selectOne(
                    new LambdaQueryWrapper<MemberLevel>().eq(MemberLevel::getLevel, 1)
            );
            
            memberInfo = new MemberInfo();
            memberInfo.setUserId(userId);
            memberInfo.setMemberNo(generateMemberNo());
            memberInfo.setLevelId(defaultLevel != null ? defaultLevel.getId() : 1L);
            memberInfo.setPoints(0);
            memberInfo.setTotalPoints(0);
            memberInfo.setTotalSpent(amount);
            memberInfo.setTotalRecharge(BigDecimal.ZERO);
            memberInfoMapper.insert(memberInfo);
            
            // 检查并升级会员等级
            checkAndUpgradeLevel(userId, amount);
        } else {
            // 更新累计消费金额
            BigDecimal newTotalSpent = memberInfo.getTotalSpent().add(amount);
            memberInfo.setTotalSpent(newTotalSpent);
            memberInfoMapper.updateById(memberInfo);
            
            // 检查并升级会员等级
            checkAndUpgradeLevel(userId, newTotalSpent);
        }
    }
    
    private String generateOrderNo() {
        String dateStr = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String randomStr = IdUtil.randomUUID().substring(0, 6).toUpperCase();
        return "R" + dateStr + randomStr;
    }
}
