package com.jiayue.cinema.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.MovieReview;
import com.jiayue.cinema.entity.User;
import com.jiayue.cinema.mapper.MovieReviewMapper;
import com.jiayue.cinema.service.MovieService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "电影管理", description = "电影相关接口")
@RestController
@RequestMapping("/movies")
@RequiredArgsConstructor
public class MovieController {
    
    private final MovieService movieService;
    private final MovieReviewMapper movieReviewMapper;
    
    @Operation(summary = "分页查询电影")
    @GetMapping("/page")
    public Result<Page<Movie>> getMoviePage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer status) {
        return Result.success(movieService.getMoviePage(page, size, keyword, status));
    }
    
    @Operation(summary = "获取电影详情")
    @GetMapping("/{id}")
    public Result<Movie> getMovieById(@PathVariable Long id) {
        return Result.success(movieService.getMovieById(id));
    }
    
    @Operation(summary = "获取正在上映的电影")
    @GetMapping("/now-showing")
    public Result<List<Movie>> getNowShowing() {
        return Result.success(movieService.getNowShowing());
    }
    
    @Operation(summary = "获取即将上映的电影")
    @GetMapping("/coming-soon")
    public Result<List<Movie>> getComingSoon() {
        return Result.success(movieService.getComingSoon());
    }
    
    @Operation(summary = "获取电影评论")
    @GetMapping("/{id}/reviews")
    public Result<List<MovieReview>> getMovieReviews(@PathVariable Long id) {
        List<MovieReview> reviews = movieReviewMapper.selectList(
                new LambdaQueryWrapper<MovieReview>()
                        .eq(MovieReview::getMovieId, id)
                        .eq(MovieReview::getStatus, 1)
                        .orderByDesc(MovieReview::getCreatedAt)
        );
        return Result.success(reviews);
    }
    
    @Operation(summary = "添加电影评论")
    @PostMapping("/{id}/reviews")
    public Result<Void> addMovieReview(
            @PathVariable Long id,
            @RequestBody MovieReview review,
            @AuthenticationPrincipal com.jiayue.cinema.security.LoginUser loginUser) {
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        review.setMovieId(id);
        review.setUserId(loginUser.getUserId());
        review.setStatus(1);
        review.setLikes(0);
        review.setDeleted(0);
        movieReviewMapper.insert(review);
        return Result.success();
    }
    
    @Operation(summary = "添加电影")
    @PostMapping
    public Result<Void> addMovie(@RequestBody Movie movie) {
        movieService.addMovie(movie);
        return Result.success();
    }
    
    @Operation(summary = "更新电影")
    @PutMapping("/{id}")
    public Result<Void> updateMovie(@PathVariable Long id, @RequestBody Movie movie) {
        movie.setId(id);
        movieService.updateMovie(movie);
        return Result.success();
    }
    
    @Operation(summary = "删除电影")
    @DeleteMapping("/{id}")
    public Result<Void> deleteMovie(@PathVariable Long id) {
        movieService.deleteMovie(id);
        return Result.success();
    }
}
