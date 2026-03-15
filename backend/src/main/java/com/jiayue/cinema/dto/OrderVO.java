package com.jiayue.cinema.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {
    
    private Long id;
    private String orderNo;
    private Long userId;
    private String username;
    private Long scheduleId;
    private String movieTitle;
    private String cinemaName;
    private String hallName;
    private String showTime;
    private List<OrderSeatVO> seats;
    private List<OrderSnackVO> snacks;
    private BigDecimal totalAmount;
    private BigDecimal ticketAmount;
    private BigDecimal snackAmount;
    private BigDecimal discountAmount;
    private BigDecimal payAmount;
    private String payType;
    private Integer status;
    private LocalDateTime createdAt;
    private LocalDateTime payTime;
    
    @Data
    public static class OrderSeatVO {
        private String seatNo;
        private String seatLabel;
        private BigDecimal price;
    }
    
    @Data
    public static class OrderSnackVO {
        private String snackName;
        private Integer quantity;
        private BigDecimal price;
        private BigDecimal subtotal;
    }
}
