package com.jiayue.cinema.service;

import com.jiayue.cinema.dto.LoginDTO;
import com.jiayue.cinema.dto.LoginVO;
import com.jiayue.cinema.dto.RegisterDTO;
import com.jiayue.cinema.entity.User;

public interface AuthService {
    
    LoginVO login(LoginDTO dto);
    
    void register(RegisterDTO dto);
    
    void logout();
    
    User getCurrentUser();
    
    Long getCurrentUserId();
    
    void updateProfile(User user);
    
    void changePassword(String oldPassword, String newPassword);
    
    void sendCode(String phone);
    
    void resetPassword(String phone, String code, String newPassword);
}
