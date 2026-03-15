package com.jiayue.cinema.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.jiayue.cinema.common.Result;
import com.jiayue.cinema.entity.Movie;
import com.jiayue.cinema.entity.MovieFavorite;
import com.jiayue.cinema.mapper.MovieFavoriteMapper;
import com.jiayue.cinema.mapper.MovieMapper;
import com.jiayue.cinema.service.AuthService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Tag(name = "电影收藏", description = "电影收藏相关接口")
@RestController
@RequestMapping("/favorites")
@RequiredArgsConstructor
public class MovieFavoriteController {

    private final MovieFavoriteMapper favoriteMapper;
    private final MovieMapper movieMapper;
    private final AuthService authService;

    @Operation(summary = "收藏电影")
    @PostMapping("/movies/{movieId}")
    public Result<Void> favorite(@PathVariable Long movieId) {
        Long userId = authService.getCurrentUserId();
        long count = favoriteMapper.selectCount(
                new LambdaQueryWrapper<MovieFavorite>()
                        .eq(MovieFavorite::getUserId, userId)
                        .eq(MovieFavorite::getMovieId, movieId)
        );
        if (count == 0) {
            MovieFavorite fav = new MovieFavorite();
            fav.setUserId(userId);
            fav.setMovieId(movieId);
            favoriteMapper.insert(fav);
        }
        return Result.success();
    }

    @Operation(summary = "取消收藏")
    @DeleteMapping("/movies/{movieId}")
    public Result<Void> unfavorite(@PathVariable Long movieId) {
        Long userId = authService.getCurrentUserId();
        favoriteMapper.delete(
                new LambdaQueryWrapper<MovieFavorite>()
                        .eq(MovieFavorite::getUserId, userId)
                        .eq(MovieFavorite::getMovieId, movieId)
        );
        return Result.success();
    }

    @Operation(summary = "是否已收藏")
    @GetMapping("/movies/{movieId}")
    public Result<Boolean> isFavorited(@PathVariable Long movieId) {
        Long userId = authService.getCurrentUserId();
        long count = favoriteMapper.selectCount(
                new LambdaQueryWrapper<MovieFavorite>()
                        .eq(MovieFavorite::getUserId, userId)
                        .eq(MovieFavorite::getMovieId, movieId)
        );
        return Result.success(count > 0);
    }

    @Operation(summary = "我的收藏列表")
    @GetMapping("/movies")
    public Result<List<Movie>> myFavorites() {
        Long userId = authService.getCurrentUserId();
        List<MovieFavorite> favs = favoriteMapper.selectList(
                new LambdaQueryWrapper<MovieFavorite>()
                        .eq(MovieFavorite::getUserId, userId)
                        .orderByDesc(MovieFavorite::getCreatedAt)
        );
        if (favs.isEmpty()) return Result.success(List.of());
        List<Long> movieIds = favs.stream().map(MovieFavorite::getMovieId).collect(Collectors.toList());
        List<Movie> movies = movieMapper.selectBatchIds(movieIds);
        return Result.success(movies);
    }
}
