package com.jiayue.cinema.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.jiayue.cinema.entity.User;

import lombok.Data;

/**
 * 登录用户信息
 */
@Data
public class LoginUser implements UserDetails {
    
    private static final long serialVersionUID = 1L;
    
    private Long userId;
    private String username;
    private String password;
    private Integer role;
    private Integer status;
    
    public LoginUser() {
    }
    
    public LoginUser(User user) {
        this.userId = user.getId();
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.role = user.getRole();
        this.status = user.getStatus();
    }
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String roleStr = switch (role) {
            case 2 -> "ADMIN";
            case 1 -> "STAFF";
            default -> "USER";
        };
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + roleStr));
    }
    
    @Override
    public String getPassword() {
        return this.password;
    }
    
    @Override
    public String getUsername() {
        return this.username;
    }
    
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    
    @Override
    public boolean isEnabled() {
        return this.status != null && this.status == 1;
    }
}
