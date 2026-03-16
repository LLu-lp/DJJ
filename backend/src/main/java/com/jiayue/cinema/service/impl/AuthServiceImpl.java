package com.jiayue.cinema.service.impl;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.jiayue.cinema.common.ResultCode;
import com.jiayue.cinema.dto.LoginDTO;
import com.jiayue.cinema.dto.LoginVO;
import com.jiayue.cinema.dto.RegisterDTO;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.exception.BusinessException;
import com.jiayue.cinema.mapper.UserMapper;
import com.jiayue.cinema.security.LoginUser;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.util.JwtUtil;

import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {
    
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    
    @Override
    public LoginVO login(LoginDTO dto) {
        User user = userMapper.selectOne(
                new LambdaQueryWrapper<User>().eq(User::getUsername, dto.getUsername())
        );
        
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        
        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new BusinessException(ResultCode.PASSWORD_ERROR);
        }
        
        if (user.getStatus() != 1) {
            throw new BusinessException(ResultCode.ACCOUNT_DISABLED);
        }

        // 校验账号角色与登录端是否匹配
        if (dto.getRole() != null) {
            int expectedRole = dto.getRole();
            int actualRole = user.getRole();
            // 管理员端(2)：只允许 role=2 的账号
            // 员工端(1)：只允许 role=1 或 role=2 的账号
            // 用户端(0)：只允许 role=0 的账号
            boolean roleMismatch = switch (expectedRole) {
                case 2 -> actualRole != 2;
                case 1 -> actualRole != 1 && actualRole != 2;
                case 0 -> actualRole != 0;
                default -> false;
            };
            if (roleMismatch) {
                throw new BusinessException(ResultCode.FAIL, "账号与登录端不匹配，请使用正确的登录入口");
            }
        }

        String token = jwtUtil.generateToken(user.getId(), user.getUsername(), user.getRole());
        
        LoginVO vo = new LoginVO();
        vo.setUserId(user.getId());
        vo.setUsername(user.getUsername());
        vo.setRealName(user.getRealName());
        vo.setAvatar(user.getAvatar());
        vo.setRole(user.getRole());
        vo.setToken(token);
        
        return vo;
    }
    
    @Override
    public void register(RegisterDTO dto) {
        Long count = userMapper.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getUsername, dto.getUsername())
        );
        if (count > 0) {
            throw new BusinessException(ResultCode.USER_EXISTS);
        }
        
        if (StrUtil.isNotBlank(dto.getPhone())) {
            count = userMapper.selectCount(
                    new LambdaQueryWrapper<User>().eq(User::getPhone, dto.getPhone())
            );
            if (count > 0) {
                throw new BusinessException(ResultCode.PHONE_EXISTS);
            }
        }
        
        User user = new User();
        user.setUsername(dto.getUsername());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setPhone(dto.getPhone());
        user.setRealName(dto.getRealName());
        user.setEmail(dto.getEmail());
        user.setRole(0);
        user.setStatus(1);
        user.setBalance(java.math.BigDecimal.ZERO);
        user.setDeleted(0);
        
        userMapper.insert(user);
    }
    
    @Override
    public void logout() {
    }
    
    @Override
    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof LoginUser loginUser) {
            return userMapper.selectById(loginUser.getUserId());
        }
        return null;
    }
    
    @Override
    public Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof LoginUser loginUser) {
            return loginUser.getUserId();
        }
        return null;
    }
    
    @Override
    public void updateProfile(User user) {
        Long userId = getCurrentUserId();
        if (userId == null) {
            throw new BusinessException(ResultCode.UNAUTHORIZED);
        }
        
        LambdaUpdateWrapper<User> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(User::getId, userId)
                .set(StrUtil.isNotBlank(user.getRealName()), User::getRealName, user.getRealName())
                .set(StrUtil.isNotBlank(user.getPhone()), User::getPhone, user.getPhone())
                .set(StrUtil.isNotBlank(user.getEmail()), User::getEmail, user.getEmail())
                .set(StrUtil.isNotBlank(user.getAvatar()), User::getAvatar, user.getAvatar());
        
        userMapper.update(null, updateWrapper);
    }
    
    @Override
    public void changePassword(String oldPassword, String newPassword) {
        Long userId = getCurrentUserId();
        if (userId == null) {
            throw new BusinessException(ResultCode.UNAUTHORIZED);
        }
        
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new BusinessException(ResultCode.PASSWORD_ERROR);
        }
        
        LambdaUpdateWrapper<User> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(User::getId, userId)
                .set(User::getPassword, passwordEncoder.encode(newPassword));
        
        userMapper.update(null, updateWrapper);
    }
    
    @Override
    public void sendCode(String phone) {
        if (StrUtil.isBlank(phone) || !phone.matches("^1[3-9]\\d{9}$")) {
            throw new BusinessException(ResultCode.FAIL, "手机号格式不正确");
        }
    }
    
    @Override
    public void resetPassword(String phone, String code, String newPassword) {
        if (StrUtil.isBlank(phone) || !phone.matches("^1[3-9]\\d{9}$")) {
            throw new BusinessException(ResultCode.FAIL, "手机号格式不正确");
        }
        
        if (StrUtil.isBlank(code)) {
            throw new BusinessException(ResultCode.FAIL, "验证码不能为空");
        }
        
        if (StrUtil.isBlank(newPassword) || newPassword.length() < 6) {
            throw new BusinessException(ResultCode.FAIL, "密码至少6位");
        }
        
        // 查找用户
        User user = userMapper.selectOne(
                new LambdaQueryWrapper<User>().eq(User::getPhone, phone)
        );
        
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND, "该手机号未注册");
        }
        
        // 更新密码
        LambdaUpdateWrapper<User> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(User::getId, user.getId())
                .set(User::getPassword, passwordEncoder.encode(newPassword));
        
        userMapper.update(null, updateWrapper);
    }
}
