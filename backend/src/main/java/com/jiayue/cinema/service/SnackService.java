package com.jiayue.cinema.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.Snack;

/**
 * 小食商品服务接口
 */
public interface SnackService {
    
    /**
     * 分页查询商品
     */
    Page<Snack> getSnackPage(Integer page, Integer size, String category);
    
    /**
     * 获取商品列表
     */
    List<Snack> getSnackList(String category);
    
    /**
     * 获取商品详情
     */
    Snack getSnackById(Long id);
    
    /**
     * 添加商品
     */
    void addSnack(Snack snack);
    
    /**
     * 更新商品
     */
    void updateSnack(Snack snack);
    
    /**
     * 删除商品
     */
    void deleteSnack(Long id);
}
