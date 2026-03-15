package com.jiayue.cinema;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 佳悦影院管理系统启动类
 */
@SpringBootApplication
@MapperScan("com.jiayue.cinema.mapper")
public class CinemaApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }
}
