package com.jiayue.cinema.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 登录请求DTO
 */
@Data
public class LoginDTO {
    
    @NotBlank(message = "用户名不能为空")
    private String username;
    
    @NotBlank(message = "密码不能为空")
    private String password;

    /**
     * 登录端角色：0=用户，1=员工，2=管理员
     * 前端根据登录Tab传入，后端校验账号角色是否匹配
     */
    private Integer role;
}
