package com.jiayue.cinema.service;

import java.util.Map;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.SystemLog;

public interface SystemService {
    
    Map<String, String> getConfigMap();
    
    String getConfigValue(String key);
    
    void updateConfig(String key, String value);
    
    void updateConfigs(Map<String, String> configs);
    
    void log(String module, String operation, String method, String params, String ip, String userAgent, boolean result, String errorMsg, long duration);
    
    Page<SystemLog> getLogPage(Integer page, Integer size, String module, String username);
}
