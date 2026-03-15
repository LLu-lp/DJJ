package com.jiayue.cinema.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.entity.Snack;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.SnackMapper;
import com.jiayue.cinema.service.SnackService;

import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;

/**
 * 小食商品服务实现
 */
@Service
@RequiredArgsConstructor
public class SnackServiceImpl implements SnackService {
    
    private final SnackMapper snackMapper;
    
    @Override
    public Page<Snack> getSnackPage(Integer page, Integer size, String category) {
        LambdaQueryWrapper<Snack> wrapper = new LambdaQueryWrapper<>();
        
        if (StrUtil.isNotBlank(category)) {
            wrapper.eq(Snack::getCategory, category);
        }
        
        wrapper.orderByAsc(Snack::getSortOrder)
                .orderByDesc(Snack::getCreatedAt);
        
        return snackMapper.selectPage(new Page<>(page, size), wrapper);
    }
    
    @Override
    public List<Snack> getSnackList(String category) {
        LambdaQueryWrapper<Snack> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Snack::getStatus, 1);
        
        if (StrUtil.isNotBlank(category)) {
            wrapper.eq(Snack::getCategory, category);
        }
        
        wrapper.orderByAsc(Snack::getSortOrder)
                .orderByDesc(Snack::getSales);
        
        return snackMapper.selectList(wrapper);
    }
    
    @Override
    public Snack getSnackById(Long id) {
        Snack snack = snackMapper.selectById(id);
        if (snack == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "商品不存在");
        }
        return snack;
    }
    
    @Override
    public void addSnack(Snack snack) {
        snack.setStatus(1);
        snack.setSales(0);
        snack.setDeleted(0);
        snackMapper.insert(snack);
    }
    
    @Override
    public void updateSnack(Snack snack) {
        Snack existing = snackMapper.selectById(snack.getId());
        if (existing == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "商品不存在");
        }
        snackMapper.updateById(snack);
    }
    
    @Override
    public void deleteSnack(Long id) {
        Snack snack = snackMapper.selectById(id);
        if (snack == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "商品不存在");
        }
        snackMapper.deleteById(id);
    }
}
