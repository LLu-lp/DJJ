package com.jiayue.cinema.dto;

import java.util.List;

import lombok.Data;

/**
 * 订单创建DTO
 */
@Data
public class CreateOrderDTO {
    
    private Long scheduleId;
    private List<Long> seatIds;
    private List<SnackItem> snacks;
    private Long couponId; // 使用的优惠券ID
    private Boolean usePoints;
    private Integer pointsAmount;
    
    @Data
    public static class SnackItem {
        private Long snackId;
        private Integer quantity;
    }
}
