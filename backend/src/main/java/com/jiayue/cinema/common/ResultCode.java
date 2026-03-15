package com.jiayue.cinema.common;

import lombok.Getter;

/**
 * 响应状态码
 */
@Getter
public enum ResultCode {
    
    SUCCESS(200, "操作成功"),
    FAIL(400, "操作失败"),
    UNAUTHORIZED(401, "未授权"),
    FORBIDDEN(403, "禁止访问"),
    NOT_FOUND(404, "资源不存在"),
    INTERNAL_ERROR(500, "服务器内部错误"),
    
    // 用户相关 1xxx
    USER_NOT_FOUND(1001, "用户不存在"),
    USER_EXISTS(1002, "用户已存在"),
    PASSWORD_ERROR(1003, "密码错误"),
    ACCOUNT_DISABLED(1004, "账号已被禁用"),
    PHONE_EXISTS(1005, "手机号已被注册"),
    
    // 电影相关 2xxx
    MOVIE_NOT_FOUND(2001, "电影不存在"),
    MOVIE_OFFLINE(2002, "电影已下架"),
    
    // 场次相关 3xxx
    SCHEDULE_NOT_FOUND(3001, "场次不存在"),
    SCHEDULE_CANCELLED(3002, "场次已取消"),
    SCHEDULE_ENDED(3003, "场次已结束"),
    
    // 座位相关 4xxx
    SEAT_NOT_AVAILABLE(4001, "座位不可用"),
    SEAT_LOCKED(4002, "座位已被锁定"),
    SEAT_SOLD(4003, "座位已售出"),
    
    // 订单相关 5xxx
    ORDER_NOT_FOUND(5001, "订单不存在"),
    ORDER_EXPIRED(5002, "订单已过期"),
    ORDER_PAID(5003, "订单已支付"),
    ORDER_CANCELLED(5004, "订单已取消"),
    
    // 会员相关 6xxx
    MEMBER_NOT_FOUND(6001, "会员信息不存在"),
    INSUFFICIENT_BALANCE(6002, "余额不足"),
    INSUFFICIENT_POINTS(6003, "积分不足"),
    
    // 参数相关 7xxx
    PARAM_ERROR(7001, "参数错误"),
    PARAM_MISSING(7002, "缺少必要参数");
    
    private final Integer code;
    private final String message;
    
    ResultCode(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
