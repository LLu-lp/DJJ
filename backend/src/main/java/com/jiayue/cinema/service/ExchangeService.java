package com.jiayue.cinema.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.ExchangeItem;
import com.jiayue.cinema.entity.ExchangeRecord;

public interface ExchangeService {
    
    List<ExchangeItem> getAvailableItems();
    
    Page<ExchangeItem> getItemPage(Integer page, Integer size);
    
    void addItem(ExchangeItem item);
    
    void updateItem(ExchangeItem item);
    
    void deleteItem(Long id);
    
    void exchange(Long userId, Long itemId);
    
    Page<ExchangeRecord> getUserExchangeRecords(Long userId, Integer page, Integer size);
}
