package com.jiayue.cinema.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class SeatStatusVO {
    
    private Long seatId;
    private Integer rowNum;
    private Integer colNum;
    private String seatLabel;
    private Integer seatType;
    private Integer status;
    private BigDecimal price;
}
