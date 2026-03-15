package com.jiayue.cinema.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.entity.SystemConfig;
import com.jiayue.cinema.entity.SystemLog;
import com.jiayue.cinema.mapper.SystemConfigMapper;
import com.jiayue.cinema.mapper.SystemLogMapper;
import com.jiayue.cinema.service.SystemService;

import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SystemServiceImpl implements SystemService {
    
    private final SystemConfigMapper systemConfigMapper;
    private final SystemLogMapper systemLogMapper;
    
    @Override
    public Map<String, String> getConfigMap() {
        List<SystemConfig> configs = systemConfigMapper.selectList(null);
        Map<String, String> map = new HashMap<>();
        for (SystemConfig config : configs) {
            map.put(config.getConfigKey(), config.getConfigValue());
        }
        return map;
    }
    
    @Override
    public String getConfigValue(String key) {
        SystemConfig config = systemConfigMapper.selectOne(
                new LambdaQueryWrapper<SystemConfig>().eq(SystemConfig::getConfigKey, key)
        );
        return config != null ? config.getConfigValue() : null;
    }
    
    @Override
    public void updateConfig(String key, String value) {
        SystemConfig config = systemConfigMapper.selectOne(
                new LambdaQueryWrapper<SystemConfig>().eq(SystemConfig::getConfigKey, key)
        );
        if (config != null) {
            config.setConfigValue(value);
            systemConfigMapper.updateById(config);
        } else {
            config = new SystemConfig();
            config.setConfigKey(key);
            config.setConfigValue(value);
            systemConfigMapper.insert(config);
        }
    }
    
    @Override
    public void updateConfigs(Map<String, String> configs) {
        for (Map.Entry<String, String> entry : configs.entrySet()) {
            updateConfig(entry.getKey(), entry.getValue());
        }
    }
    
    @Override
    public void log(String module, String operation, String method, String params, String ip, String userAgent, boolean result, String errorMsg, long duration) {
        SystemLog log = new SystemLog();
        log.setModule(module);
        log.setOperation(operation);
        log.setMethod(method);
        log.setParams(params);
        log.setIp(ip);
        log.setUserAgent(userAgent);
        log.setResult(result ? 1 : 0);
        log.setErrorMsg(errorMsg);
        log.setDuration(duration);
        systemLogMapper.insert(log);
    }
    
    @Override
    public Page<SystemLog> getLogPage(Integer page, Integer size, String module, String username) {
        LambdaQueryWrapper<SystemLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StrUtil.isNotBlank(module), SystemLog::getModule, module)
                .eq(StrUtil.isNotBlank(username), SystemLog::getUsername, username)
                .orderByDesc(SystemLog::getCreatedAt);
        return systemLogMapper.selectPage(new Page<>(page, size), wrapper);
    }
}
