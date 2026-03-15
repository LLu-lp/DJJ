package com.jiayue.cinema.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class MemberInfoVO {
    
    private Long userId;
    private Long levelId;
    private String memberNo;
    private String levelName;
    private String levelCode;
    private BigDecimal discount;
    private Integer points;
    private Integer totalPoints;
    private BigDecimal totalSpent;
    private BigDecimal totalConsumed;  // 前端使用的字段名
    private BigDecimal totalRecharge;
    private BigDecimal balance;
    private String joinTime;
    private Integer level;
    private List<MemberLevelVO> memberLevels;
    
    @Data
    public static class MemberLevelVO {
        private Long id;
        private Integer level;
        private String levelName;
        private String levelCode;
        private BigDecimal minSpent;
        private BigDecimal maxSpent;
        private BigDecimal discount;
        private String benefits;
    }
}
