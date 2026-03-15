package com.jiayue.cinema.dto;

import lombok.Data;

/**
 * 登录响应DTO
 */
@Data
public class LoginVO {
    
    private Long userId;
    private String username;
    private String realName;
    private String avatar;
    private Integer role;
    private String token;
}
