package com.jiayue.cinema.aspect;

import java.time.LocalDateTime;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.jiayue.cinema.entity.SystemLog;
import com.jiayue.cinema.mapper.SystemLogMapper;
import com.jiayue.cinema.security.LoginUser;
import com.jiayue.cinema.util.RequestUtil;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 系统日志切面
 */
@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class SystemLogAspect {
    
    private final SystemLogMapper systemLogMapper;
    
    /**
     * 定义切点：拦截所有Controller的方法
     */
    @Pointcut("execution(* com.jiayue.cinema.controller..*.*(..))")
    public void controllerPointcut() {}
    
    /**
     * 环绕通知：记录操作日志
     */
    @Around("controllerPointcut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        long startTime = System.currentTimeMillis();
        
        // 获取请求信息
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attributes == null) {
            return point.proceed();
        }
        
        HttpServletRequest request = attributes.getRequest();
        String method = request.getMethod();
        String uri = request.getRequestURI();
        
        // 只记录POST、PUT、DELETE操作
        if (!method.equals("POST") && !method.equals("PUT") && !method.equals("DELETE")) {
            return point.proceed();
        }
        
        // 排除不需要记录的接口
        if (shouldSkip(uri)) {
            return point.proceed();
        }
        
        // 获取当前用户信息
        String username = "匿名用户";
        Long userId = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof LoginUser loginUser) {
            username = loginUser.getUsername();
            userId = loginUser.getUserId();
        }
        
        // 执行方法
        Object result = null;
        boolean success = true;
        String errorMsg = null;
        
        try {
            result = point.proceed();
        } catch (Exception e) {
            success = false;
            errorMsg = e.getMessage();
            throw e;
        } finally {
            long duration = System.currentTimeMillis() - startTime;
            
            // 异步保存日志
            saveLog(userId, username, uri, method, request, success, errorMsg, duration);
        }
        
        return result;
    }
    
    /**
     * 判断是否跳过日志记录
     */
    private boolean shouldSkip(String uri) {
        return uri.contains("/auth/login") 
            || uri.contains("/auth/logout")
            || uri.contains("/auth/send-code")
            || uri.contains("/system/logs");
    }
    
    /**
     * 保存日志
     */
    private void saveLog(Long userId, String username, String uri, String method, 
                        HttpServletRequest request, boolean success, String errorMsg, long duration) {
        try {
            SystemLog log = new SystemLog();
            log.setUserId(userId);
            log.setUsername(username);
            log.setModule(getModule(uri));
            log.setOperation(getOperation(uri, method));
            log.setMethod(method);
            log.setParams(getParams(request));
            log.setIp(RequestUtil.getIpAddress(request));
            log.setUserAgent(request.getHeader("User-Agent"));
            log.setResult(success ? 1 : 0);
            log.setErrorMsg(errorMsg);
            log.setDuration(duration);
            log.setCreatedAt(LocalDateTime.now());
            
            systemLogMapper.insert(log);
        } catch (Exception e) {
            log.error("保存系统日志失败", e);
        }
    }
    
    /**
     * 获取模块名称
     */
    private String getModule(String uri) {
        if (uri.contains("/auth")) return "auth";
        if (uri.contains("/movie")) return "movie";
        if (uri.contains("/cinema")) return "cinema";
        if (uri.contains("/schedule")) return "schedule";
        if (uri.contains("/order")) return "order";
        if (uri.contains("/snack")) return "snack";
        if (uri.contains("/user")) return "user";
        if (uri.contains("/member")) return "member";
        if (uri.contains("/system")) return "system";
        return "other";
    }
    
    /**
     * 获取操作描述
     */
    private String getOperation(String uri, String method) {
        String module = getModule(uri);
        
        if (method.equals("POST")) {
            if (uri.contains("/register")) return "用户注册";
            if (uri.contains("/login")) return "用户登录";
            return module + "新增";
        } else if (method.equals("PUT")) {
            return module + "修改";
        } else if (method.equals("DELETE")) {
            return module + "删除";
        }
        
        return "操作";
    }
    
    /**
     * 获取请求参数
     */
    private String getParams(HttpServletRequest request) {
        try {
            String queryString = request.getQueryString();
            if (StrUtil.isNotBlank(queryString)) {
                return queryString;
            }
            return "";
        } catch (Exception e) {
            return "";
        }
    }
}

