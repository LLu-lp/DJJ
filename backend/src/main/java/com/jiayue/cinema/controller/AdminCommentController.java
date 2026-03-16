package com.jiayue.cinema.controller;

import java.util.List;
import java.util.stream.Collectors;

import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.MovieReview;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.mapper.MovieReviewMapper;
import com.jiayue.cinema.mapper.UserMapper;
import com.jiayue.cinema.service.MovieService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@Tag(name = "评论管理", description = "管理员评论管理接口")
@RestController
@RequestMapping("/admin/comments")
@RequiredArgsConstructor
public class AdminCommentController {
    
    private final MovieReviewMapper movieReviewMapper;
    private final MovieService movieService;
    private final UserMapper userMapper;
    
    @Operation(summary = "获取所有评论")
    @GetMapping
    public Result<List<java.util.Map<String, Object>>> getAllComments() {
        List<MovieReview> reviews = movieReviewMapper.selectList(
                new LambdaQueryWrapper<MovieReview>()
                        .eq(MovieReview::getStatus, 1)
                        .orderByDesc(MovieReview::getCreatedAt)
        );
        
        List<java.util.Map<String, Object>> result = reviews.stream().map(review -> {
            Movie movie = movieService.getMovieById(review.getMovieId());
            User user = userMapper.selectById(review.getUserId());
            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("id", review.getId());
            map.put("movieId", review.getMovieId());
            map.put("movieTitle", movie != null ? movie.getTitle() : "");
            map.put("userId", review.getUserId());
            map.put("username", user != null ? user.getUsername() : "");
            map.put("rating", review.getRating());
            map.put("content", review.getContent());
            map.put("status", review.getStatus());
            map.put("createdAt", review.getCreatedAt());
            return map;
        }).collect(Collectors.toList());
        
        return Result.success(result);
    }
    
    @Operation(summary = "删除评论")
    @DeleteMapping("/{id}")
    public Result<Void> deleteComment(@PathVariable Long id) {
        MovieReview review = movieReviewMapper.selectById(id);
        if (review == null) {
            return Result.error(404, "评论不存在");
        }
        
        review.setStatus(0);
        movieReviewMapper.updateById(review);
        return Result.success();
    }
    
    @Operation(summary = "恢复评论")
    @PutMapping("/{id}/restore")
    public Result<Void> restoreComment(@PathVariable Long id) {
        MovieReview review = movieReviewMapper.selectById(id);
        if (review == null) {
            return Result.error(404, "评论不存在");
        }
        
        review.setStatus(1);
        movieReviewMapper.updateById(review);
        return Result.success();
    }
}

