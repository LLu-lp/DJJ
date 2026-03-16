package com.jiayue.cinema.controller;

import java.util.List;
import java.util.stream.Collectors;

import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.dto.LoginDTO;
import com.jiayue.cinema.dto.LoginVO;
import com.jiayue.cinema.dto.RegisterDTO;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.MovieReview;
import com.jiayue.cinema.service.AuthService;
import com.jiayue.cinema.service.MovieService;
import com.jiayue.cinema.mapper.MovieReviewMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@Tag(name = "认证管理", description = "登录、注册、登出等接口")
@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService;
    private final MovieService movieService;
    private final MovieReviewMapper movieReviewMapper;
    
    @Operation(summary = "用户登录")
    @PostMapping("/login")
    public Result<LoginVO> login(@Valid @RequestBody LoginDTO dto) {
        return Result.success(authService.login(dto));
    }
    
    @Operation(summary = "用户注册")
    @PostMapping("/register")
    public Result<Void> register(@Valid @RequestBody RegisterDTO dto) {
        authService.register(dto);
        return Result.success();
    }
    
    @Operation(summary = "用户登出")
    @PostMapping("/logout")
    public Result<Void> logout() {
        authService.logout();
        return Result.success();
    }
    
    @Operation(summary = "获取当前用户信息")
    @GetMapping("/info")
    public Result<User> getCurrentUser() {
        return Result.success(authService.getCurrentUser());
    }
    
    @Operation(summary = "更新个人信息")
    @PutMapping("/profile")
    public Result<Void> updateProfile(@RequestBody User user) {
        authService.updateProfile(user);
        return Result.success();
    }
    
    @Operation(summary = "修改密码")
    @PutMapping("/password")
    public Result<Void> changePassword(
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {
        authService.changePassword(oldPassword, newPassword);
        return Result.success();
    }
    
    @Operation(summary = "发送验证码")
    @PostMapping("/send-code")
    public Result<Void> sendCode(@RequestBody java.util.Map<String, String> request) {
        String phone = request.get("phone");
        authService.sendCode(phone);
        return Result.success();
    }
    
    @Operation(summary = "重置密码")
    @PostMapping("/reset-password")
    public Result<Void> resetPassword(@RequestBody java.util.Map<String, String> request) {
        String phone = request.get("phone");
        String code = request.get("code");
        String newPassword = request.get("newPassword");
        authService.resetPassword(phone, code, newPassword);
        return Result.success();
    }
    
    @Operation(summary = "获取我的评论")
    @GetMapping("/my-comments")
    public Result<List<java.util.Map<String, Object>>> getMyComments(
            @AuthenticationPrincipal com.jiayue.cinema.security.LoginUser loginUser) {
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        
        List<MovieReview> reviews = movieReviewMapper.selectList(
                new LambdaQueryWrapper<MovieReview>()
                        .eq(MovieReview::getUserId, loginUser.getUserId())
                        .eq(MovieReview::getDeleted, 0)
                        .eq(MovieReview::getStatus, 1)
                        .orderByDesc(MovieReview::getCreatedAt)
        );
        
        List<java.util.Map<String, Object>> result = reviews.stream().map(review -> {
            Movie movie = movieService.getMovieById(review.getMovieId());
            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("id", review.getId());
            map.put("movieId", review.getMovieId());
            map.put("movieName", movie != null ? movie.getTitle() : "");
            map.put("movieImage", movie != null ? movie.getPoster() : "");
            map.put("rating", review.getRating());
            map.put("content", review.getContent());
            map.put("createdAt", review.getCreatedAt());
            return map;
        }).collect(Collectors.toList());
        
        return Result.success(result);
    }
    
    @Operation(summary = "删除我的评论")
    @DeleteMapping("/comments/{id}")
    public Result<Void> deleteMyComment(
            @PathVariable Long id,
            @AuthenticationPrincipal com.jiayue.cinema.security.LoginUser loginUser) {
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        
        MovieReview review = movieReviewMapper.selectById(id);
        if (review == null) {
            return Result.error(404, "评论不存在");
        }
        
        if (!review.getUserId().equals(loginUser.getUserId())) {
            return Result.error(403, "无权删除他人评论");
        }
        
        review.setStatus(0);
        movieReviewMapper.updateById(review);
        return Result.success();
    }
}
