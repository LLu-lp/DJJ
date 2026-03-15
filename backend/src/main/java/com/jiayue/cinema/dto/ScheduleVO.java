package com.jiayue.cinema.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;

/**
 * 排片详情VO
 */
@Data
public class ScheduleVO {
    
    private Long id;
    private Long movieId;
    private String movieTitle;
    private String moviePoster;
    private Long cinemaId;
    private String cinemaName;
    private Long hallId;
    private String hallName;
    private String hallType;
    private LocalDate showDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private BigDecimal price;
    private BigDecimal vipPrice;
    private String language;
    private Integer status;
    private Integer availableSeats;
    private Integer soldSeats;
    private Integer totalSeats;
}
