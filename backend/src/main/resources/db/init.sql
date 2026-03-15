-- =============================================
-- 佳悦影院管理系统数据库初始化脚本
-- 数据库版本: MySQL 8.0+
-- =============================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS jiayue_cinema DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE jiayue_cinema;

-- =============================================
-- 1. 用户表
-- =============================================
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(255) NOT NULL COMMENT '密码',
    `real_name` VARCHAR(50) DEFAULT NULL COMMENT '真实姓名',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像URL',
    `gender` TINYINT DEFAULT 0 COMMENT '性别: 0-未知 1-男 2-女',
    `birthday` DATE DEFAULT NULL COMMENT '生日',
    `role` TINYINT NOT NULL DEFAULT 0 COMMENT '角色: 0-普通用户 1-员工 2-管理员',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用 1-正常',
    `balance` DECIMAL(10,2) DEFAULT 0.00 COMMENT '账户余额',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除: 0-未删除 1-已删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_phone` (`phone`),
    KEY `idx_role` (`role`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- =============================================
-- 2. 电影表
-- =============================================
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '电影ID',
    `title` VARCHAR(100) NOT NULL COMMENT '电影名称',
    `poster` VARCHAR(255) DEFAULT NULL COMMENT '海报URL',
    `director` VARCHAR(100) DEFAULT NULL COMMENT '导演',
    `actors` VARCHAR(500) DEFAULT NULL COMMENT '演员',
    `genre` VARCHAR(100) DEFAULT NULL COMMENT '类型',
    `duration` INT DEFAULT NULL COMMENT '时长(分钟)',
    `language` VARCHAR(50) DEFAULT NULL COMMENT '语言',
    `region` VARCHAR(50) DEFAULT NULL COMMENT '地区',
    `release_date` DATE DEFAULT NULL COMMENT '上映日期',
    `end_date` DATE DEFAULT NULL COMMENT '下映日期',
    `rating` DECIMAL(2,1) DEFAULT 0.0 COMMENT '评分',
    `description` TEXT COMMENT '简介',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-下架 1-上映中 2-即将上映',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`),
    KEY `idx_release_date` (`release_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='电影表';

-- =============================================
-- 3. 影院表
-- =============================================
DROP TABLE IF EXISTS `cinemas`;
CREATE TABLE `cinemas` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '影院ID',
    `name` VARCHAR(100) NOT NULL COMMENT '影院名称',
    `address` VARCHAR(255) DEFAULT NULL COMMENT '地址',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    `description` TEXT COMMENT '影院介绍',
    `facilities` VARCHAR(255) DEFAULT NULL COMMENT '设施服务',
    `latitude` DECIMAL(10,6) DEFAULT NULL COMMENT '纬度',
    `longitude` DECIMAL(10,6) DEFAULT NULL COMMENT '经度',
    `images` VARCHAR(1000) DEFAULT NULL COMMENT '影院图片(JSON数组)',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-关闭 1-营业中',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='影院表';

-- =============================================
-- 4. 影厅表
-- =============================================
DROP TABLE IF EXISTS `halls`;
CREATE TABLE `halls` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '影厅ID',
    `cinema_id` BIGINT NOT NULL COMMENT '影院ID',
    `name` VARCHAR(50) NOT NULL COMMENT '影厅名称',
    `type` VARCHAR(50) DEFAULT NULL COMMENT '影厅类型(如: IMAX, 3D, 4D等)',
    `rows` INT NOT NULL DEFAULT 10 COMMENT '行数',
    `cols` INT NOT NULL DEFAULT 12 COMMENT '列数',
    `total_seats` INT NOT NULL DEFAULT 0 COMMENT '总座位数',
    `facilities` VARCHAR(255) DEFAULT NULL COMMENT '设施',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-关闭 1-正常',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_cinema_id` (`cinema_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='影厅表';

-- =============================================
-- 5. 座位表
-- =============================================
DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '座位ID',
    `hall_id` BIGINT NOT NULL COMMENT '影厅ID',
    `row_num` INT NOT NULL COMMENT '行号',
    `col_num` INT NOT NULL COMMENT '列号',
    `seat_label` VARCHAR(10) NOT NULL COMMENT '座位标签(如: A1, B2)',
    `seat_type` TINYINT NOT NULL DEFAULT 0 COMMENT '座位类型: 0-普通 1-情侣座 2-VIP',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-不可用 1-可用',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_hall_seat` (`hall_id`, `row_num`, `col_num`),
    KEY `idx_hall_id` (`hall_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='座位表';

-- =============================================
-- 6. 排片场次表
-- =============================================
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '场次ID',
    `movie_id` BIGINT NOT NULL COMMENT '电影ID',
    `cinema_id` BIGINT NOT NULL COMMENT '影院ID',
    `hall_id` BIGINT NOT NULL COMMENT '影厅ID',
    `show_date` DATE NOT NULL COMMENT '放映日期',
    `start_time` TIME NOT NULL COMMENT '开始时间',
    `end_time` TIME NOT NULL COMMENT '结束时间',
    `price` DECIMAL(10,2) NOT NULL COMMENT '票价',
    `vip_price` DECIMAL(10,2) DEFAULT NULL COMMENT 'VIP票价',
    `language` VARCHAR(50) DEFAULT NULL COMMENT '语言版本',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-取消 1-正常 2-已结束',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_movie_id` (`movie_id`),
    KEY `idx_cinema_id` (`cinema_id`),
    KEY `idx_hall_id` (`hall_id`),
    KEY `idx_show_date` (`show_date`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='排片场次表';

-- =============================================
-- 7. 场次座位状态表
-- =============================================
DROP TABLE IF EXISTS `schedule_seats`;
CREATE TABLE `schedule_seats` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `schedule_id` BIGINT NOT NULL COMMENT '场次ID',
    `seat_id` BIGINT NOT NULL COMMENT '座位ID',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-可售 1-已售 2-锁定',
    `price` DECIMAL(10,2) NOT NULL COMMENT '该座位价格',
    `locked_by` BIGINT DEFAULT NULL COMMENT '锁定用户ID',
    `locked_at` DATETIME DEFAULT NULL COMMENT '锁定时间',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_schedule_seat` (`schedule_id`, `seat_id`),
    KEY `idx_schedule_id` (`schedule_id`),
    KEY `idx_seat_id` (`seat_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='场次座位状态表';

-- =============================================
-- 8. 订单表
-- =============================================
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单ID',
    `order_no` VARCHAR(32) NOT NULL COMMENT '订单编号',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `username` VARCHAR(50) DEFAULT NULL COMMENT '用户名',
    `schedule_id` BIGINT NOT NULL COMMENT '场次ID',
    `cinema_id` BIGINT NOT NULL COMMENT '影院ID',
    `cinema_name` VARCHAR(100) DEFAULT NULL COMMENT '影院名称',
    `hall_id` BIGINT DEFAULT NULL COMMENT '影厅ID',
    `hall_name` VARCHAR(50) DEFAULT NULL COMMENT '影厅名称',
    `movie_title` VARCHAR(100) DEFAULT NULL COMMENT '电影名称',
    `show_time` DATETIME DEFAULT NULL COMMENT '放映时间',
    `seat_count` INT DEFAULT 0 COMMENT '座位数量',
    `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `ticket_amount` DECIMAL(10,2) NOT NULL COMMENT '电影票金额',
    `snack_amount` DECIMAL(10,2) DEFAULT 0.00 COMMENT '小食金额',
    `discount_amount` DECIMAL(10,2) DEFAULT 0.00 COMMENT '优惠金额',
    `pay_amount` DECIMAL(10,2) NOT NULL COMMENT '实付金额',
    `pay_type` VARCHAR(20) DEFAULT NULL COMMENT '支付方式',
    `pay_time` DATETIME DEFAULT NULL COMMENT '支付时间',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-待支付 1-已支付 2-已取消 3-已退款',
    `ticketed` TINYINT DEFAULT 0 COMMENT '是否已取票: 0-未取票 1-已取票',
    `ticket_time` DATETIME DEFAULT NULL COMMENT '取票时间',
    `qr_code` VARCHAR(255) DEFAULT NULL COMMENT '二维码',
    `expire_time` DATETIME DEFAULT NULL COMMENT '过期时间',
    `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_schedule_id` (`schedule_id`),
    KEY `idx_status` (`status`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- =============================================
-- 9. 订单座位明细表
-- =============================================
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `schedule_id` BIGINT NOT NULL COMMENT '场次ID',
    `seat_id` BIGINT NOT NULL COMMENT '座位ID',
    `seat_label` VARCHAR(10) NOT NULL COMMENT '座位标签',
    `price` DECIMAL(10,2) NOT NULL COMMENT '票价',
    `ticket_code` VARCHAR(32) DEFAULT NULL COMMENT '取票码',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-未取票 1-已取票 2-已退票',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`),
    KEY `idx_schedule_id` (`schedule_id`),
    KEY `idx_ticket_code` (`ticket_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单座位明细表';

-- =============================================
-- 10. 商品/小食表
-- =============================================
DROP TABLE IF EXISTS `snacks`;
CREATE TABLE `snacks` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品ID',
    `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '分类',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '图片URL',
    `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
    `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
    `description` VARCHAR(255) DEFAULT NULL COMMENT '描述',
    `stock` INT NOT NULL DEFAULT 0 COMMENT '库存',
    `sales` INT NOT NULL DEFAULT 0 COMMENT '销量',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-下架 1-上架',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_category` (`category`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品/小食表';

-- =============================================
-- 11. 订单商品关联表
-- =============================================
DROP TABLE IF EXISTS `order_snacks`;
CREATE TABLE `order_snacks` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `snack_id` BIGINT NOT NULL COMMENT '商品ID',
    `snack_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `price` DECIMAL(10,2) NOT NULL COMMENT '单价',
    `quantity` INT NOT NULL COMMENT '数量',
    `subtotal` DECIMAL(10,2) NOT NULL COMMENT '小计',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`),
    KEY `idx_snack_id` (`snack_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单商品关联表';

-- =============================================
-- 12. 会员等级配置表
-- =============================================
DROP TABLE IF EXISTS `member_levels`;
CREATE TABLE `member_levels` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '等级ID',
    `level` INT NOT NULL DEFAULT 0 COMMENT '等级',
    `level_name` VARCHAR(50) NOT NULL COMMENT '等级名称',
    `level_code` VARCHAR(20) NOT NULL COMMENT '等级编码',
    `min_spent` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '最低消费额度',
    `max_spent` DECIMAL(10,2) DEFAULT NULL COMMENT '最高消费额度',
    `discount` DECIMAL(3,2) NOT NULL DEFAULT 1.00 COMMENT '折扣(如0.95表示95折)',
    `points_rate` DECIMAL(3,2) NOT NULL DEFAULT 1.00 COMMENT '积分倍率',
    `benefits` VARCHAR(500) DEFAULT NULL COMMENT '权益说明',
    `icon` VARCHAR(255) DEFAULT NULL COMMENT '等级图标',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_level_code` (`level_code`),
    KEY `idx_min_spent` (`min_spent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级配置表';

-- =============================================
-- 13. 会员信息表
-- =============================================
DROP TABLE IF EXISTS `member_info`;
CREATE TABLE `member_info` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `member_no` VARCHAR(20) NOT NULL COMMENT '会员编号',
    `level_id` BIGINT DEFAULT NULL COMMENT '等级ID',
    `points` INT NOT NULL DEFAULT 0 COMMENT '当前积分',
    `total_points` INT NOT NULL DEFAULT 0 COMMENT '累计积分',
    `total_spent` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '累计消费',
    `total_recharge` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '累计充值',
    `expire_date` DATE DEFAULT NULL COMMENT '会员到期日',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_id` (`user_id`),
    UNIQUE KEY `uk_member_no` (`member_no`),
    KEY `idx_level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员信息表';

-- =============================================
-- 14. 积分记录表
-- =============================================
DROP TABLE IF EXISTS `points_log`;
CREATE TABLE `points_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `points` INT NOT NULL COMMENT '积分变动(正为获取,负为消耗)',
    `balance` INT NOT NULL COMMENT '变动后余额',
    `type` TINYINT NOT NULL COMMENT '类型: 1-消费获取 2-充值赠送 3-积分抵扣 4-系统赠送 5-过期扣除',
    `related_id` BIGINT DEFAULT NULL COMMENT '关联ID',
    `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_type` (`type`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分记录表';

-- =============================================
-- 15. 充值记录表
-- =============================================
DROP TABLE IF EXISTS `recharge_log`;
CREATE TABLE `recharge_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `order_no` VARCHAR(32) NOT NULL COMMENT '订单号',
    `amount` DECIMAL(10,2) NOT NULL COMMENT '充值金额',
    `gift_amount` DECIMAL(10,2) DEFAULT 0.00 COMMENT '赠送金额',
    `gift_points` INT DEFAULT 0 COMMENT '赠送积分',
    `pay_type` TINYINT NOT NULL COMMENT '支付方式: 2-微信 3-支付宝',
    `pay_time` DATETIME DEFAULT NULL COMMENT '支付时间',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-待支付 1-成功 2-失败',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录表';

-- =============================================
-- 16. 电影评论表
-- =============================================
DROP TABLE IF EXISTS `movie_reviews`;
CREATE TABLE `movie_reviews` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '评论ID',
    `movie_id` BIGINT NOT NULL COMMENT '电影ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `rating` TINYINT NOT NULL COMMENT '评分: 1-5',
    `content` TEXT COMMENT '评论内容',
    `likes` INT NOT NULL DEFAULT 0 COMMENT '点赞数',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-隐藏 1-显示',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_movie_id` (`movie_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='电影评论表';

-- =============================================
-- 17. 公告表
-- =============================================
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '公告ID',
    `title` VARCHAR(200) NOT NULL COMMENT '标题',
    `content` TEXT NOT NULL COMMENT '内容',
    `type` TINYINT NOT NULL DEFAULT 0 COMMENT '类型: 0-普通 1-重要 2-紧急',
    `cover_image` VARCHAR(255) DEFAULT NULL COMMENT '封面图',
    `is_top` TINYINT NOT NULL DEFAULT 0 COMMENT '是否置顶: 0-否 1-是',
    `view_count` INT NOT NULL DEFAULT 0 COMMENT '浏览次数',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-草稿 1-发布',
    `publish_time` DATETIME DEFAULT NULL COMMENT '发布时间',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_type` (`type`),
    KEY `idx_status` (`status`),
    KEY `idx_publish_time` (`publish_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告表';

-- =============================================
-- 18. 系统配置表
-- =============================================
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '配置ID',
    `config_key` VARCHAR(100) NOT NULL COMMENT '配置键',
    `config_value` VARCHAR(500) DEFAULT NULL COMMENT '配置值',
    `config_type` VARCHAR(50) DEFAULT 'string' COMMENT '值类型',
    `description` VARCHAR(255) DEFAULT NULL COMMENT '描述',
    `group_name` VARCHAR(50) DEFAULT NULL COMMENT '分组',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- =============================================
-- 19. 系统操作日志表
-- =============================================
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    `user_id` BIGINT DEFAULT NULL COMMENT '操作用户ID',
    `username` VARCHAR(50) DEFAULT NULL COMMENT '操作用户名',
    `module` VARCHAR(50) DEFAULT NULL COMMENT '模块',
    `operation` VARCHAR(100) DEFAULT NULL COMMENT '操作',
    `method` VARCHAR(200) DEFAULT NULL COMMENT '请求方法',
    `params` TEXT COMMENT '请求参数',
    `ip` VARCHAR(50) DEFAULT NULL COMMENT 'IP地址',
    `user_agent` VARCHAR(255) DEFAULT NULL COMMENT '用户代理',
    `result` TINYINT DEFAULT NULL COMMENT '结果: 0-失败 1-成功',
    `error_msg` TEXT COMMENT '错误信息',
    `duration` BIGINT DEFAULT NULL COMMENT '执行时长(ms)',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_module` (`module`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统操作日志表';

-- =============================================
-- 初始化数据
-- =============================================

-- 初始化会员等级
INSERT INTO `member_levels` (`level`, `level_name`, `level_code`, `min_spent`, `max_spent`, `discount`, `points_rate`, `benefits`, `sort_order`) VALUES
(1, '普通会员', 'NORMAL', 0.00, 999.99, 1.00, 1.00, '基础会员权益', 1),
(2, '银卡会员', 'SILVER', 1000.00, 4999.99, 0.95, 1.20, '95折优惠,积分1.2倍', 2),
(3, '金卡会员', 'GOLD', 5000.00, 19999.99, 0.90, 1.50, '9折优惠,积分1.5倍,生日特权', 3),
(4, '钻石会员', 'DIAMOND', 20000.00, NULL, 0.85, 2.00, '85折优惠,积分2倍,专属客服,优先选座', 4);

-- 初始化系统配置
INSERT INTO `system_config` (`config_key`, `config_value`, `config_type`, `description`, `group_name`) VALUES
('site_name', '佳悦影院', 'string', '网站名称', 'basic'),
('site_logo', '/uploads/logo.png', 'string', '网站Logo', 'basic'),
('order_timeout', '15', 'number', '订单超时时间(分钟)', 'order'),
('seat_lock_time', '5', 'number', '座位锁定时间(分钟)', 'order'),
('points_rate', '1', 'number', '积分兑换比例(元:积分)', 'member'),
('max_points_deduction', '50', 'number', '最大积分抵扣比例(%)', 'member'),
('recharge_min', '50', 'number', '最低充值金额', 'member'),
('recharge_rules', '[{"amount":100,"gift":0},{"amount":200,"gift":20},{"amount":500,"gift":80},{"amount":1000,"gift":200}]', 'json', '充值赠送规则', 'member');

----- 初始化管理员账号 (密码: admin123, 使用BCrypt加密)
INSERT INTO `users` (`username`, `password`, `real_name`, `phone`, `role`, `status`) VALUES
('admin', '$2a$10$EqKcp1WFKVQISheBxkVJceXIhUQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '系统管理员', '13800000000', 2, 1);

-- 初始化测试影院
INSERT INTO `cinemas` (`name`, `address`, `phone`, `description`, `facilities`, `status`) VALUES
('佳悦影城(万达广场店)', '北京市朝阳区建国路93号万达广场B座5层', '010-12345678', '舒适观影体验，配备IMAX影厅', 'IMAX,3D,杜比音效,休息区', 1),
('佳悦影城(西单店)', '北京市西城区西单北大街120号', '010-87654321', '市中心黄金地段，交通便利', '3D,杜比音效,儿童厅', 1);

-- 初始化测试电影
INSERT INTO `movies` (`title`, `poster`, `director`, `actors`, `genre`, `duration`, `language`, `region`, `release_date`, `rating`, `description`, `status`) VALUES
('流浪地球3', '/uploads/movies/poster1.jpg', '郭帆', '吴京,刘德华,李雪健', '科幻,冒险', 180, '国语', '中国大陆', '2025-02-01', 9.2, '太阳即将毁灭，人类在地球表面建造出巨大的推进器，寻找新的家园。', 1),
('热辣滚烫', '/uploads/movies/poster2.jpg', '贾玲', '贾玲,雷佳音,张小斐', '喜剧,剧情', 128, '国语', '中国大陆', '2024-02-10', 8.5, '一个关于成长和蜕变的故事。', 1),
('飞驰人生2', '/uploads/movies/poster3.jpg', '韩寒', '沈腾,范丞丞,尹正', '喜剧,运动', 122, '国语', '中国大陆', '2024-02-10', 8.3, '赛车手张驰重返赛道的故事。', 1);

-- =============================================
-- 22. 电影收藏表
-- =============================================
CREATE TABLE IF NOT EXISTS `movie_favorites` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `movie_id` BIGINT NOT NULL COMMENT '电影ID',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_movie` (`user_id`, `movie_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_movie_id` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='电影收藏表';

SELECT '数据库初始化完成!' AS message;

-- =============================================
-- 20. 积分兑换商品表
-- =============================================
DROP TABLE IF EXISTS `exchange_items`;
CREATE TABLE `exchange_items` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品ID',
    `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `icon` VARCHAR(50) DEFAULT NULL COMMENT '图标(emoji)',
    `description` VARCHAR(255) DEFAULT NULL COMMENT '描述',
    `points` INT NOT NULL COMMENT '所需积分',
    `stock` INT NOT NULL DEFAULT 0 COMMENT '库存',
    `exchanged_count` INT NOT NULL DEFAULT 0 COMMENT '已兑换数量',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 0-下架 1-上架',
    `sort` INT NOT NULL DEFAULT 0 COMMENT '排序',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`),
    KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分兑换商品表';

-- =============================================
-- 21. 兑换记录表
-- =============================================
DROP TABLE IF EXISTS `exchange_records`;
CREATE TABLE `exchange_records` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `item_id` BIGINT NOT NULL COMMENT '商品ID',
    `item_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `points` INT NOT NULL COMMENT '消耗积分',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态: 0-待领取 1-已领取',
    `exchanged_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '兑换时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_item_id` (`item_id`),
    KEY `idx_exchanged_at` (`exchanged_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='兑换记录表';

-- 初始化兑换商品
INSERT INTO `exchange_items` (`name`, `icon`, `description`, `points`, `stock`, `status`, `sort`) VALUES
('经典爆米花(大)', '🍿', '到店兑换', 300, 100, 1, 1),
('可乐一杯', '🥤', '到店兑换', 200, 200, 1, 2),
('电影票折扣券', '🎫', '购票立减10元', 500, 50, 1, 3),
('套餐A优惠券', '🎁', '爆米花+饮品', 400, 80, 1, 4);

-- =============================================
-- 23. FAQ 表
-- =============================================
DROP TABLE IF EXISTS `faq`;
CREATE TABLE `faq` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'FAQ ID',
    `question` VARCHAR(255) NOT NULL COMMENT '问题',
    `answer` TEXT NOT NULL COMMENT '答案',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '分类',
    `sort` INT NOT NULL DEFAULT 0 COMMENT '排序',
    `enabled` TINYINT NOT NULL DEFAULT 1 COMMENT '是否启用: 0-禁用 1-启用',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_category` (`category`),
    KEY `idx_enabled` (`enabled`),
    KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQ 表';

-- 初始化 FAQ 数据
INSERT INTO `faq` (`question`, `answer`, `category`, `sort`, `enabled`) VALUES
('如何购票？', '1. 登录账号\n2. 选择电影和场次\n3. 选择座位\n4. 支付订单\n5. 获取电子票券', 'booking', 1, 1),
('如何退票？', '放映前24小时可申请全额退款\n放映前2小时可申请90%退款\n放映前1小时可申请80%退款', 'refund', 2, 1),
('会员有什么权益？', '普通会员：基础权益\n白银会员：95折优惠\n黄金会员：90折优惠\n钻石会员：85折优惠', 'member', 3, 1),
('如何使用积分？', '积分可用于兑换小吃、饮品、购票折扣等\n在会员中心的积分兑换页面操作', 'points', 4, 1),
('支持哪些支付方式？', '支持微信支付、支付宝、银行卡、余额支付', 'payment', 5, 1),
('如何联系客服？', '可以在线客服聊天\n工作时间：9:00-21:00\n电话：400-888-8888', 'other', 6, 1);

-- =============================================
-- 24. 聊天消息表
-- =============================================
DROP TABLE IF EXISTS `chat_messages`;
CREATE TABLE `chat_messages` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '消息ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者ID',
    `sender_name` VARCHAR(50) DEFAULT NULL COMMENT '发送者名称',
    `sender_avatar` VARCHAR(255) DEFAULT NULL COMMENT '发送者头像',
    `receiver_id` BIGINT DEFAULT NULL COMMENT '接收者ID(0表示客服)',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `type` VARCHAR(20) DEFAULT 'text' COMMENT '消息类型: text/image/file',
    `send_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    `is_read` TINYINT NOT NULL DEFAULT 0 COMMENT '是否已读: 0-未读 1-已读',
    `user_role` VARCHAR(20) DEFAULT NULL COMMENT '用户角色: user/staff/admin',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_sender_id` (`sender_id`),
    KEY `idx_receiver_id` (`receiver_id`),
    KEY `idx_send_time` (`send_time`),
    KEY `idx_is_read` (`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='聊天消息表';
