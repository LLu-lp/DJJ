/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : jiayue_cinema

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 15/03/2026 17:41:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `is_top` int NOT NULL,
  `publish_time` datetime(6) NULL DEFAULT NULL,
  `status` int NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `view_count` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcements
-- ----------------------------
INSERT INTO `announcements` VALUES (1, '即日起至本月底，所有会员购票积分翻倍！金卡及以上会员更享三倍积分！快来观影吧！', NULL, '2026-03-08 01:56:51.000000', 0, 1, '2026-03-08 01:56:51.000000', 1, '佳悦影院会员积分翻倍活动', 1, '2026-03-08 01:56:51.000000', 10);
INSERT INTO `announcements` VALUES (2, '郭帆导演力作《流浪地球2》现已上映，IMAX/4DX/杜比全景声多版本同步上映，快来体验震撼视听盛宴！', NULL, '2026-03-08 01:56:51.000000', 0, 1, '2026-03-08 01:56:51.000000', 1, '新片上映：《流浪地球2》震撼来袭', 0, '2026-03-08 01:56:51.000000', 1);
INSERT INTO `announcements` VALUES (3, '春节档热门影片现已开启预售，提前锁定黄金座位，享受观影好时光！', NULL, '2026-03-08 01:56:51.000000', 1, 0, '2026-03-08 01:56:51.000000', 1, '春节档预售开启', 0, '2026-03-08 01:56:51.000000', 0);
INSERT INTO `announcements` VALUES (4, '充值500元送50元，充值1000元送150元，多充多送！', NULL, '2026-03-08 01:56:51.000000', 0, 0, '2026-03-08 01:56:51.000000', 1, '会员充值优惠', 0, '2026-03-08 01:56:51.000000', 1);
INSERT INTO `announcements` VALUES (5, '为提供更好的服务，系统将于本周三凌晨2:00-4:00进行升级维护，届时将暂停服务，敬请谅解。', NULL, '2026-03-08 01:56:51.000000', 0, 0, '2026-03-08 01:56:51.000000', 1, '系统升级通知', 2, '2026-03-08 01:56:51.000000', 1);
INSERT INTO `announcements` VALUES (6, '11', NULL, '2026-03-11 21:23:14.180640', 1, 0, '2026-03-11 21:23:14.115873', 1, '1', 1, '2026-03-11 21:23:14.183135', 1);

-- ----------------------------
-- Table structure for carousels
-- ----------------------------
DROP TABLE IF EXISTS `carousels`;
CREATE TABLE `carousels`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort` int NOT NULL,
  `status` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carousels
-- ----------------------------

-- ----------------------------
-- Table structure for chat_messages
-- ----------------------------
DROP TABLE IF EXISTS `chat_messages`;
CREATE TABLE `chat_messages`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `sender_id` bigint NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发送者名称',
  `sender_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发送者头像',
  `receiver_id` bigint NULL DEFAULT NULL COMMENT '接收者ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息内容',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'text' COMMENT '消息类型',
  `send_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `is_read` tinyint NOT NULL DEFAULT 0 COMMENT '是否已读',
  `user_role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户角色',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_messages
-- ----------------------------
INSERT INTO `chat_messages` VALUES (1, 10, 'dengj', NULL, 0, '你好', 'text', '2026-03-14 12:25:10', 0, 'user', '2026-03-14 12:25:09', '2026-03-14 12:25:09');
INSERT INTO `chat_messages` VALUES (2, 10, 'dengj', NULL, 0, '怎么买票', 'text', '2026-03-14 12:25:32', 0, 'user', '2026-03-14 12:25:32', '2026-03-14 12:25:32');
INSERT INTO `chat_messages` VALUES (3, 10, 'dengj', NULL, 0, '怎么订座位', 'text', '2026-03-14 12:26:28', 0, 'user', '2026-03-14 12:26:27', '2026-03-14 12:26:27');
INSERT INTO `chat_messages` VALUES (4, 10, 'dengj', NULL, 0, '你好', 'text', '2026-03-14 13:15:10', 0, 'user', '2026-03-14 13:15:10', '2026-03-14 13:15:10');
INSERT INTO `chat_messages` VALUES (5, 10, 'dengj', NULL, 0, '你好\n', 'text', '2026-03-14 13:30:41', 0, 'user', '2026-03-14 13:30:41', '2026-03-14 13:30:41');
INSERT INTO `chat_messages` VALUES (8, 2, 'staff001', 'https://ui-avatars.com/api/?name=XL&background=e8b84b&color=fff&size=150', 10, '您好，有什么可以帮助您的吗？', 'text', '2026-03-14 17:35:18', 0, 'staff', '2026-03-14 17:35:18', '2026-03-14 17:35:18');
INSERT INTO `chat_messages` VALUES (9, 2, 'staff001', 'https://ui-avatars.com/api/?name=XL&background=e8b84b&color=fff&size=150', 10, '你好', 'text', '2026-03-14 19:16:07', 0, 'staff', '2026-03-14 19:16:07', '2026-03-14 19:16:07');
INSERT INTO `chat_messages` VALUES (10, 10, 'dengj', NULL, 0, '你好', 'text', '2026-03-14 19:17:11', 0, 'user', '2026-03-14 19:17:10', '2026-03-14 19:17:10');
INSERT INTO `chat_messages` VALUES (11, 10, 'dengj', NULL, 0, '你好', 'text', '2026-03-15 13:22:45', 0, 'user', '2026-03-15 13:22:45', '2026-03-15 13:22:45');

-- ----------------------------
-- Table structure for cinemas
-- ----------------------------
DROP TABLE IF EXISTS `cinemas`;
CREATE TABLE `cinemas`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `facilities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `latitude` decimal(10, 6) NULL DEFAULT NULL,
  `longitude` decimal(10, 6) NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cinemas
-- ----------------------------
INSERT INTO `cinemas` VALUES (1, '北京市朝阳区建国路93号万达广场B座5层', '2026-03-08 01:56:51.000000', 0, '舒适观影体验，配备IMAX影厅', 'IMAX,3D,杜比音效,休息区', NULL, 39.984120, 116.307470, '佳悦影城(万达广场店)', '010-12345678', 1, '2026-03-08 01:56:51.000000');
INSERT INTO `cinemas` VALUES (2, '北京市西城区西单北大街120号', '2026-03-08 01:56:51.000000', 0, '市中心黄金地段，交通便利', '3D,杜比音效,儿童厅', NULL, 39.908760, 116.459620, '佳悦影城(西单店)', '010-23456789', 1, '2026-03-08 01:56:51.000000');
INSERT INTO `cinemas` VALUES (3, '北京市朝阳区建国门外大街1号', '2026-03-08 01:56:51.000000', 0, '高端商务影院', 'IMAX,VIP厅,杜比音效', NULL, 39.912890, 116.372980, '佳悦影城(国贸店)', '010-34567890', 1, '2026-03-08 01:56:51.000000');
INSERT INTO `cinemas` VALUES (4, '北京市海淀区成府路28号', '2026-03-08 01:56:51.000000', 0, '大学城优质影院', '3D,杜比音效', NULL, 39.992880, 116.337420, '佳悦影城(五道口店)', '010-45678901', 1, '2026-03-08 01:56:51.000000');
INSERT INTO `cinemas` VALUES (5, '北京市朝阳区望京街9号', '2026-03-08 01:56:51.000000', 0, '望京地区首选影院', 'IMAX,3D,杜比音效', NULL, 39.988670, 116.474780, '佳悦影城(望京店)', '010-56789012', 1, '2026-03-08 01:56:51.000000');
INSERT INTO `cinemas` VALUES (6, '1', '2026-03-11 21:31:38.976476', 1, NULL, '1', NULL, NULL, NULL, '1', '1', 1, '2026-03-11 21:31:38.978591');

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券名称',
  `type` tinyint NOT NULL COMMENT '类型: 1-满减券 2-折扣券 3-兑换券',
  `discount_type` tinyint NOT NULL COMMENT '优惠类型: 1-金额 2-折扣',
  `discount_value` decimal(10, 2) NOT NULL COMMENT '优惠值（金额或折扣）',
  `min_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最低消费金额',
  `total_count` int NOT NULL COMMENT '发行总数',
  `received_count` int NULL DEFAULT 0 COMMENT '已领取数量',
  `used_count` int NULL DEFAULT 0 COMMENT '已使用数量',
  `valid_days` int NOT NULL COMMENT '有效天数',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用 1-启用',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '使用说明',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupons
-- ----------------------------
INSERT INTO `coupons` VALUES (1, '新用户专享券', 1, 1, 10.00, 50.00, 1000, 1, 0, 30, '2026-03-01 00:00:00', '2026-12-31 23:59:59', 1, '新用户注册即可领取，满50元减10元', '2026-03-14 13:57:53', '2026-03-14 13:57:53');
INSERT INTO `coupons` VALUES (2, '周末观影券', 1, 1, 20.00, 100.00, 500, 0, 0, 7, '2026-03-01 00:00:00', '2026-12-31 23:59:59', 1, '周末专享，满100元减20元', '2026-03-14 13:57:53', '2026-03-14 13:57:53');
INSERT INTO `coupons` VALUES (3, '会员折扣券', 1, 2, 0.85, 0.00, 2000, 0, 0, 60, '2026-03-01 00:00:00', '2026-12-31 23:59:59', 1, '会员专享，全场8.5折', '2026-03-14 13:57:53', '2026-03-14 13:57:53');
INSERT INTO `coupons` VALUES (4, '春季观影券', 1, 1, 15.00, 80.00, 800, 0, 0, 30, '2026-03-01 00:00:00', '2026-06-30 23:59:59', 1, '春季特惠，满80元减15元', '2026-03-14 13:57:53', '2026-03-14 13:57:53');
INSERT INTO `coupons` VALUES (5, '经典原味爆米花（大）', 1, 1, 35.00, 0.00, 9999, 0, 0, 15, '2026-03-14 23:35:57', '2026-12-31 23:36:02', 1, '经典原味爆米花（大）', '2026-03-14 23:36:45', '2026-03-15 13:15:49');
INSERT INTO `coupons` VALUES (6, '可口可乐（大杯）', 1, 1, 20.00, 0.00, 9999, 0, 0, 30, '2026-03-14 16:00:21', '2026-04-13 16:00:21', 1, '可口可乐（大杯）', '2026-03-15 00:02:13', '2026-03-15 00:02:13');
INSERT INTO `coupons` VALUES (7, '爆米花+可乐套餐', 1, 1, 48.00, 0.00, 9999, 0, 0, 30, '2026-03-14 16:00:21', '2026-04-13 16:00:21', 1, '爆米花+可乐套餐', '2026-03-15 00:02:42', '2026-03-15 00:02:41');
INSERT INTO `coupons` VALUES (8, '电影票抵扣10元劵', 1, 1, 10.00, 0.00, 9999, 0, 0, 30, '2026-03-14 16:00:21', '2026-04-13 16:00:21', 1, '电影票抵扣10元劵', '2026-03-15 00:03:29', '2026-03-15 00:03:28');

-- ----------------------------
-- Table structure for exchange_items
-- ----------------------------
DROP TABLE IF EXISTS `exchange_items`;
CREATE TABLE `exchange_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `exchanged_count` int NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `points` int NOT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` int NOT NULL,
  `stock` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `coupon_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exchange_items
-- ----------------------------
INSERT INTO `exchange_items` VALUES (1, '2026-03-08 01:56:51.000000', 0, '到店兑换', 19, '🍿', '经典爆米花(大)', 300, 1, 1, 96, '2026-03-08 01:56:51.000000', 5);
INSERT INTO `exchange_items` VALUES (2, '2026-03-08 01:56:51.000000', 0, '到店兑换', 31, '🥤', '可乐一杯', 200, 2, 1, 197, '2026-03-08 01:56:51.000000', 6);
INSERT INTO `exchange_items` VALUES (3, '2026-03-08 01:56:51.000000', 0, '购票立减10元', 8, '🎫', '电影票折扣券', 500, 3, 1, 50, '2026-03-08 01:56:51.000000', 8);
INSERT INTO `exchange_items` VALUES (4, '2026-03-08 01:56:51.000000', 0, '爆米花+饮品', 12, '🎁', '套餐A优惠券', 400, 4, 1, 80, '2026-03-08 01:56:51.000000', 7);

-- ----------------------------
-- Table structure for exchange_records
-- ----------------------------
DROP TABLE IF EXISTS `exchange_records`;
CREATE TABLE `exchange_records`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exchanged_at` datetime(6) NULL DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `points` int NOT NULL,
  `status` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exchange_records
-- ----------------------------
INSERT INTO `exchange_records` VALUES (1, '2026-03-05 01:56:51.000000', 1, '经典爆米花(大)', 300, 1, 4);
INSERT INTO `exchange_records` VALUES (2, '2026-03-06 01:56:51.000000', 2, '可乐一杯', 200, 1, 4);
INSERT INTO `exchange_records` VALUES (3, '2026-03-08 01:56:51.000000', 3, '电影票折扣券', 500, 0, 7);
INSERT INTO `exchange_records` VALUES (4, '2026-03-07 01:56:51.000000', 4, '套餐A优惠券', 400, 1, 7);
INSERT INTO `exchange_records` VALUES (5, '2026-03-14 13:52:42.121132', 1, '经典爆米花(大)', 300, 0, 10);
INSERT INTO `exchange_records` VALUES (6, '2026-03-14 23:18:03.330142', 1, '经典爆米花(大)', 300, 0, 10);
INSERT INTO `exchange_records` VALUES (7, '2026-03-14 23:25:22.989348', 2, '可乐一杯', 200, 0, 10);
INSERT INTO `exchange_records` VALUES (8, '2026-03-14 23:25:42.103186', 2, '可乐一杯', 200, 0, 10);
INSERT INTO `exchange_records` VALUES (9, '2026-03-14 23:37:38.620793', 2, '可乐一杯', 200, 0, 10);
INSERT INTO `exchange_records` VALUES (10, '2026-03-15 12:57:36.005751', 1, '经典爆米花(大)', 300, 0, 10);
INSERT INTO `exchange_records` VALUES (11, '2026-03-15 13:15:21.409668', 1, '经典爆米花(大)', 300, 0, 10);

-- ----------------------------
-- Table structure for faq
-- ----------------------------
DROP TABLE IF EXISTS `faq`;
CREATE TABLE `faq`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'FAQ ID',
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '问题',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '答案',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `enabled` tinyint NOT NULL DEFAULT 1 COMMENT '是否启用: 0-禁用 1-启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'FAQ 表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faq
-- ----------------------------
INSERT INTO `faq` VALUES (1, '如何购票？', '1. 登录账号\n2. 选择电影和场次\n3. 选择座位\n4. 支付订单\n5. 获取电子票券', 'booking', 1, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');
INSERT INTO `faq` VALUES (2, '如何退票？', '放映前24小时可申请全额退款\n放映前2小时可申请90%退款\n放映前1小时可申请80%退款', 'refund', 2, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');
INSERT INTO `faq` VALUES (3, '会员有什么权益？', '普通会员：基础权益\n白银会员：95折优惠\n黄金会员：90折优惠\n钻石会员：85折优惠', 'member', 3, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');
INSERT INTO `faq` VALUES (4, '如何使用积分？', '积分可用于兑换小吃、饮品、购票折扣等\n在会员中心的积分兑换页面操作', 'points', 4, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');
INSERT INTO `faq` VALUES (5, '支持哪些支付方式？', '支持微信支付、支付宝、银行卡、余额支付', 'payment', 5, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');
INSERT INTO `faq` VALUES (6, '如何联系客服？', '可以在线客服聊天\n工作时间：9:00-21:00\n电话：400-888-8888', 'other', 6, 1, '2026-03-13 22:26:46', '2026-03-13 22:26:46');

-- ----------------------------
-- Table structure for halls
-- ----------------------------
DROP TABLE IF EXISTS `halls`;
CREATE TABLE `halls`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cinema_id` bigint NOT NULL,
  `cols` int NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `facilities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rows` int NOT NULL,
  `status` int NOT NULL,
  `total_seats` int NOT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of halls
-- ----------------------------
INSERT INTO `halls` VALUES (1, 1, 14, '2026-03-08 01:56:51.000000', 0, 'IMAX巨幕,杜比音效', '1号厅', 10, 1, 140, 'IMAX', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (2, 1, 12, '2026-03-08 01:56:51.000000', 0, '4DX动感座椅', '2号厅', 8, 1, 96, '4DX', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (3, 1, 12, '2026-03-08 01:56:51.000000', 0, '杜比全景声', '3号厅', 10, 1, 120, '杜比全景声', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (4, 1, 10, '2026-03-08 01:56:51.000000', 0, '标准影厅', '4号厅', 8, 1, 80, '标准', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (5, 2, 16, '2026-03-08 01:56:51.000000', 0, 'IMAX巨幕,杜比音效', '1号厅', 12, 1, 192, 'IMAX', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (6, 2, 8, '2026-03-08 01:56:51.000000', 0, 'VIP豪华座椅', '2号厅', 6, 1, 48, 'VIP', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (7, 2, 14, '2026-03-08 01:56:51.000000', 0, '杜比全景声', '3号厅', 10, 1, 140, '杜比全景声', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (8, 3, 14, '2026-03-08 01:56:51.000000', 0, 'IMAX巨幕', '1号厅', 10, 1, 140, 'IMAX', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (9, 3, 12, '2026-03-08 01:56:51.000000', 0, '4DX动感座椅', '2号厅', 8, 1, 96, '4DX', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (10, 4, 12, '2026-03-08 01:56:51.000000', 0, '杜比全景声', '1号厅', 10, 1, 120, '杜比全景声', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (11, 4, 10, '2026-03-08 01:56:51.000000', 0, 'VIP豪华座椅', '2号厅', 6, 1, 60, 'VIP', '2026-03-08 01:56:51.000000');
INSERT INTO `halls` VALUES (12, 5, 14, '2026-03-08 01:56:51.000000', 0, 'IMAX巨幕,杜比音效', '1号厅', 12, 1, 168, 'IMAX', '2026-03-08 01:56:51.000000');

-- ----------------------------
-- Table structure for member_info
-- ----------------------------
DROP TABLE IF EXISTS `member_info`;
CREATE TABLE `member_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `level_id` bigint NOT NULL,
  `member_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `points` int NOT NULL,
  `total_points` int NOT NULL,
  `total_recharge` decimal(10, 2) NOT NULL,
  `total_spent` decimal(10, 2) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_info
-- ----------------------------
INSERT INTO `member_info` VALUES (1, '2025-09-09 01:56:51.000000', NULL, 2, 'M202401000004', 2580, 3580, 710.00, 3580.00, '2026-03-08 01:56:51.000000', 4);
INSERT INTO `member_info` VALUES (2, '2025-12-08 01:56:51.000000', NULL, 1, 'M202401000005', 680, 1280, 210.00, 1280.00, '2026-03-08 01:56:51.000000', 5);
INSERT INTO `member_info` VALUES (3, '2026-02-06 01:56:51.000000', NULL, 1, 'M202401000006', 120, 380, 0.00, 380.00, '2026-03-08 01:56:51.000000', 6);
INSERT INTO `member_info` VALUES (4, '2025-03-08 01:56:51.000000', NULL, 3, 'M202401000007', 6500, 8500, 1700.00, 8500.00, '2026-03-08 01:56:51.000000', 7);
INSERT INTO `member_info` VALUES (5, '2026-01-07 01:56:51.000000', NULL, 1, 'M202401000008', 450, 980, 100.00, 980.00, '2026-03-08 01:56:51.000000', 8);
INSERT INTO `member_info` VALUES (6, '2026-03-08 22:36:53.022955', NULL, 1, 'JY202603084B197E', 0, 0, 0.00, 0.00, '2026-03-08 22:36:53.022955', 9);
INSERT INTO `member_info` VALUES (7, '2026-03-09 20:07:44.473716', NULL, 2, 'JY20260309B61C0A', 144, 1944, 0.00, 1944.00, '2026-03-09 20:07:44.473716', 10);

-- ----------------------------
-- Table structure for member_levels
-- ----------------------------
DROP TABLE IF EXISTS `member_levels`;
CREATE TABLE `member_levels`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `level` int NOT NULL DEFAULT 0 COMMENT '等级',
  `level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '等级名称',
  `level_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '等级编码',
  `min_spent` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '最低消费额度',
  `max_spent` decimal(10, 2) NULL DEFAULT NULL COMMENT '最高消费额度',
  `discount` decimal(3, 2) NOT NULL DEFAULT 1.00 COMMENT '折扣',
  `points_rate` decimal(3, 2) NOT NULL DEFAULT 1.00 COMMENT '积分倍率',
  `benefits` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权益说明',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '等级图标',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_level_code`(`level_code` ASC) USING BTREE,
  INDEX `idx_min_spent`(`min_spent` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_levels
-- ----------------------------
INSERT INTO `member_levels` VALUES (1, 1, '普通会员', 'NORMAL', 1.00, 999.99, 1.00, 1.00, '基础会员权益', NULL, 1, '2026-03-15 16:29:50', '2026-03-15 16:29:50', 0);
INSERT INTO `member_levels` VALUES (2, 2, '银卡会员', 'SILVER', 1000.00, 4999.99, 0.95, 1.20, '95折优惠,积分1.2倍', NULL, 2, '2026-03-15 16:29:50', '2026-03-15 16:29:50', 0);
INSERT INTO `member_levels` VALUES (3, 3, '金卡会员', 'GOLD', 5000.00, 19999.99, 0.90, 1.50, '9折优惠,积分1.5倍,生日特权', NULL, 3, '2026-03-15 16:29:50', '2026-03-15 16:29:50', 0);
INSERT INTO `member_levels` VALUES (4, 4, '钻石会员', 'DIAMOND', 20000.00, NULL, 0.85, 2.00, '85折优惠,积分2倍,专属客服,优先选座', NULL, 4, '2026-03-15 16:29:50', '2026-03-15 16:29:50', 0);

-- ----------------------------
-- Table structure for member_levels_old
-- ----------------------------
DROP TABLE IF EXISTS `member_levels_old`;
CREATE TABLE `member_levels_old`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `benefits` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `discount` decimal(3, 2) NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level` int NOT NULL,
  `level_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `max_points` int NULL DEFAULT NULL,
  `min_points` int NOT NULL,
  `points_rate` decimal(3, 2) NOT NULL,
  `sort_order` int NULL DEFAULT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `max_spent` decimal(10, 2) NULL DEFAULT NULL,
  `min_spent` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_levels_old
-- ----------------------------
INSERT INTO `member_levels_old` VALUES (1, '基础会员权益', '2026-03-08 01:56:51.000000', 0, 1.00, NULL, 1, 'NORMAL', '普通会员', 999, 0, 1.00, 1, '2026-03-08 01:56:51.000000', NULL, 0.00);
INSERT INTO `member_levels_old` VALUES (2, '95折优惠,积分1.2倍', '2026-03-08 01:56:51.000000', 0, 0.95, NULL, 2, 'SILVER', '银卡会员', 4999, 1000, 1.20, 2, '2026-03-08 01:56:51.000000', NULL, 0.00);
INSERT INTO `member_levels_old` VALUES (3, '9折优惠,积分1.5倍,生日特权', '2026-03-08 01:56:51.000000', 0, 0.90, NULL, 3, 'GOLD', '金卡会员', 19999, 5000, 1.50, 3, '2026-03-08 01:56:51.000000', NULL, 0.00);
INSERT INTO `member_levels_old` VALUES (4, '85折优惠,积分2倍,专属客服,优先选座', '2026-03-08 01:56:51.000000', 0, 0.85, NULL, 4, 'DIAMOND', '钻石会员', NULL, 20000, 2.00, 4, '2026-03-08 01:56:51.000000', NULL, 0.00);

-- ----------------------------
-- Table structure for movie_favorites
-- ----------------------------
DROP TABLE IF EXISTS `movie_favorites`;
CREATE TABLE `movie_favorites`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `movie_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_movie`(`user_id` ASC, `movie_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_movie_id`(`movie_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for movie_reviews
-- ----------------------------
DROP TABLE IF EXISTS `movie_reviews`;
CREATE TABLE `movie_reviews`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `likes` int NOT NULL,
  `movie_id` bigint NOT NULL,
  `rating` int NOT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_reviews
-- ----------------------------
INSERT INTO `movie_reviews` VALUES (1, '太震撼了！特效一流，剧情紧凑，强烈推荐IMAX版本观看！', '2026-03-04 01:56:51.000000', 0, 128, 1, 5, 1, '2026-03-04 01:56:51.000000', 4);
INSERT INTO `movie_reviews` VALUES (2, '整体不错，就是中间节奏稍微有点慢，结局很燃！', '2026-03-06 01:56:51.000000', 0, 56, 1, 4, 1, '2026-03-06 01:56:51.000000', 5);
INSERT INTO `movie_reviews` VALUES (3, '国产动画的巅峰之作，画面精美，故事感人！', '2026-03-07 01:56:51.000000', 0, 89, 2, 5, 1, '2026-03-07 01:56:51.000000', 4);
INSERT INTO `movie_reviews` VALUES (4, '致敬英雄！看得热泪盈眶，强烈推荐！', '2026-03-08 01:56:51.000000', 0, 234, 3, 5, 1, '2026-03-08 01:56:51.000000', 6);
INSERT INTO `movie_reviews` VALUES (5, '二刷了，依然感动，中国科幻电影的骄傲！', '2026-03-08 01:56:51.000000', 0, 78, 1, 5, 1, '2026-03-08 01:56:51.000000', 7);
INSERT INTO `movie_reviews` VALUES (6, '很好看', '2026-03-15 13:59:26.513795', 0, 0, 4, 5, 1, '2026-03-15 13:59:26.516945', 10);

-- ----------------------------
-- Table structure for movies
-- ----------------------------
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `director` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `duration` int NOT NULL,
  `end_date` date NULL DEFAULT NULL,
  `genre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rating` decimal(2, 1) NULL DEFAULT NULL,
  `rating_count` int NULL DEFAULT NULL,
  `region` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `release_date` date NULL DEFAULT NULL,
  `status` int NOT NULL,
  `ticket_count` int NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies
-- ----------------------------
INSERT INTO `movies` VALUES (1, '吴京,刘德华,李雪健', '2026-03-09 20:24:29.000000', 0, '太阳即将毁灭，人类在地球表面建造出巨大的推进器，寻找新的家园。然而宇宙之路危机四伏，为了拯救地球，流浪地球时代的年轻人再次挺身而出，展开争分夺秒的生死之战。', '郭帆', 173, NULL, '科幻,冒险', '国语', 'https://picsum.photos/seed/movie1/400/600', 8.3, 1362, '中国大陆', '2023-01-22', 1, 13637, '流浪地球2', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (2, '吕艳婷,囧森瑟夫,瀚墨', '2026-03-09 20:24:29.000000', 0, '天地灵气孕育出混元珠，元始天尊将其分为灵珠和魔丸。太乙真人受命将灵珠托生于陈塘关李靖家，却阴差阳错，灵珠和魔丸被掉包。', '饺子', 110, NULL, '动画,奇幻', '国语', 'https://picsum.photos/seed/movie2/400/600', 8.4, 1415, '中国大陆', '2025-07-26', 1, 14156, '哪吒之魔童降世', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (3, '吴京,易烊千玺,段奕宏', '2026-03-09 20:24:29.000000', 0, '以抗美援朝战争第二次战役中的长津湖战役为背景，讲述在结束了新兴里和下碣隅里的战斗之后，七连战士们又接到了更艰巨的任务的故事。', '陈凯歌,徐克,林超贤', 176, NULL, '战争,历史', '国语', 'https://picsum.photos/seed/movie3/400/600', 7.2, 982, '中国大陆', '2026-09-30', 2, 9820, '长津湖', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (4, '费翔,黄渤,于适', '2026-03-09 20:24:29.000000', 0, '殷商末年，纣王帝辛在妲己的蛊惑下，倒行逆施，引发天怒人怨。姬发带领西岐勇士，联合各路诸侯，共同讨伐纣王。', '乌尔善', 148, NULL, '奇幻,动作', '国语', 'https://picsum.photos/seed/movie4/400/600', 7.8, 856, '中国大陆', '2026-07-20', 2, 8562, '封神第一部', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (5, '贾玲,雷佳音,张小斐', '2026-03-09 20:24:29.000000', 0, '讲述了宅家多年的乐莹，在结识拳击教练昊坤后，克服接连不断的考验，开启滚烫人生的故事。', '贾玲', 128, NULL, '喜剧,剧情', '国语', 'https://picsum.photos/seed/movie5/400/600', 7.5, 723, '中国大陆', '2026-12-01', 2, 7230, '热辣滚烫', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (6, '雷佳音,马丽,赵丽颖', '2026-03-09 20:24:29.000000', 0, '讲述了挂职检察官韩明人到中年，本想努力赶上职业生涯的末班车进入市院工作，不料卷入一分歧巨大的案件的故事。', '张艺谋', 125, NULL, '剧情,喜剧', '国语', 'https://picsum.photos/seed/movie6/400/600', 7.6, 645, '中国大陆', '2026-12-30', 2, 6450, '第二十条', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (7, '沈腾,范丞丞,尹正', '2026-03-09 20:24:29.000000', 0, '讲述了驾校教练张驰，携手潜力新人车手厉小海，出征巴音布鲁克拉力赛的故事。', '韩寒', 122, NULL, '喜剧,运动', '国语', 'https://picsum.photos/seed/movie7/400/600', 7.7, 589, '中国大陆', '2026-11-01', 2, 5890, '飞驰人生2', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (8, '张伟,张秉君,谭笑', '2026-03-09 20:24:29.000000', 0, '熊大熊二光头强穿越时空，展开一场惊险刺激的冒险之旅。', '林汇达', 108, NULL, '动画,科幻', '国语', 'https://picsum.photos/seed/movie8/400/600', 6.9, 412, '中国大陆', '2026-11-01', 2, 4120, '熊出没·逆转时空', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (9, '王宝强,刘昊然,张子枫', '2026-03-09 20:24:29.000000', 0, '唐仁和秦风再次联手，前往东京调查一起离奇的密室杀人案。', '陈思诚', 136, NULL, '喜剧,悬疑', '国语', 'https://picsum.photos/seed/movie9/400/600', 5.3, 1256, '中国大陆', '2025-02-12', 1, 12560, '唐人街探案3', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (10, '范·迪塞尔,杰森·斯坦森,米歇尔·罗德里格兹', '2026-03-09 20:24:29.000000', 0, '多姆和他的家人将面临迄今为止最致命的对手，一场关乎全球安全的终极对决即将展开。', '路易斯·莱特里尔', 141, NULL, '动作,犯罪', '英语', 'https://picsum.photos/seed/movie10/400/600', 6.2, 892, '美国', '2025-12-01', 1, 8920, '速度与激情10', '2026-03-09 20:24:29.000000');
INSERT INTO `movies` VALUES (11, '1', '2026-03-09 22:09:39.754285', 1, '1', '1', 120, NULL, '动作', NULL, '122', NULL, NULL, NULL, '2026-03-25', 2, NULL, '111', '2026-03-09 22:09:39.756219');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `price` decimal(8, 2) NOT NULL,
  `schedule_id` bigint NOT NULL,
  `seat_id` bigint NOT NULL,
  `seat_label` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` int NOT NULL,
  `ticket_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, '2026-03-03 01:56:51.000000', 1, 88.00, 1, 1, '1排1座', 1, 'T202501010001', '2026-03-03 01:56:51.000000');
INSERT INTO `order_items` VALUES (2, '2026-03-03 01:56:51.000000', 1, 88.00, 1, 2, '1排2座', 1, 'T202501010002', '2026-03-03 01:56:51.000000');
INSERT INTO `order_items` VALUES (3, '2026-03-05 01:56:51.000000', 2, 88.00, 2, 15, '2排1座', 1, 'T202501010003', '2026-03-05 01:56:51.000000');
INSERT INTO `order_items` VALUES (4, '2026-03-05 01:56:51.000000', 2, 88.00, 2, 16, '2排2座', 1, 'T202501010004', '2026-03-05 01:56:51.000000');
INSERT INTO `order_items` VALUES (5, '2026-03-05 01:56:51.000000', 2, 88.00, 2, 17, '2排3座', 1, 'T202501010005', '2026-03-05 01:56:51.000000');
INSERT INTO `order_items` VALUES (6, '2026-03-06 01:56:51.000000', 3, 68.00, 6, 85, '4排5座', 0, 'T202501010006', '2026-03-06 01:56:51.000000');
INSERT INTO `order_items` VALUES (7, '2026-03-06 01:56:51.000000', 3, 68.00, 6, 86, '4排6座', 0, 'T202501010007', '2026-03-06 01:56:51.000000');
INSERT INTO `order_items` VALUES (8, '2026-03-07 01:56:51.000000', 4, 78.00, 9, 145, '1排1座', 0, 'T202501010008', '2026-03-07 01:56:51.000000');
INSERT INTO `order_items` VALUES (9, '2026-03-08 01:56:51.000000', 5, 98.00, 3, 25, '3排1座', 0, 'T202501010009', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (10, '2026-03-08 01:56:51.000000', 5, 98.00, 3, 26, '3排2座', 0, 'T202501010010', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (11, '2026-03-08 01:56:51.000000', 5, 98.00, 3, 27, '3排3座', 0, 'T202501010011', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (12, '2026-03-08 01:56:51.000000', 5, 98.00, 3, 28, '3排4座', 0, 'T202501010012', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (13, '2026-03-08 01:56:51.000000', 6, 58.00, 14, 185, '1排1座', 0, 'T202501010013', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (14, '2026-03-08 01:56:51.000000', 6, 58.00, 14, 186, '1排2座', 0, 'T202501010014', '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (15, '2026-03-08 01:56:51.000000', 7, 78.00, 10, 155, '2排1座', 0, NULL, '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (16, '2026-03-08 01:56:51.000000', 7, 78.00, 10, 156, '2排2座', 0, NULL, '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (17, '2026-03-08 01:56:51.000000', 8, 58.00, 15, 205, '1排1座', 0, NULL, '2026-03-08 01:56:51.000000');
INSERT INTO `order_items` VALUES (18, '2026-03-08 22:36:09.521782', 9, 68.00, 6, 679, 'H7', 0, NULL, '2026-03-08 22:36:09.521782');
INSERT INTO `order_items` VALUES (19, '2026-03-08 22:36:09.537273', 9, 68.00, 6, 789, 'H8', 0, NULL, '2026-03-08 22:36:09.537273');
INSERT INTO `order_items` VALUES (20, '2026-03-09 20:05:20.134950', 10, 68.00, 21, 493, 'E5', 0, NULL, '2026-03-09 20:05:20.135455');
INSERT INTO `order_items` VALUES (21, '2026-03-09 20:05:20.154488', 10, 68.00, 21, 603, 'E6', 0, NULL, '2026-03-09 20:05:20.154488');
INSERT INTO `order_items` VALUES (22, '2026-03-09 20:05:20.166115', 10, 68.00, 21, 713, 'E7', 0, NULL, '2026-03-09 20:05:20.166115');
INSERT INTO `order_items` VALUES (23, '2026-03-09 20:05:20.174961', 10, 68.00, 21, 823, 'E8', 0, NULL, '2026-03-09 20:05:20.174961');
INSERT INTO `order_items` VALUES (24, '2026-03-09 20:06:32.103886', 11, 58.00, 25, 598, 'F6', 0, NULL, '2026-03-09 20:06:32.103886');
INSERT INTO `order_items` VALUES (25, '2026-03-09 20:06:32.112007', 11, 58.00, 25, 708, 'F7', 0, NULL, '2026-03-09 20:06:32.112519');
INSERT INTO `order_items` VALUES (26, '2026-03-09 20:07:59.665433', 12, 68.00, 21, 591, 'F6', 0, NULL, '2026-03-09 20:07:59.665433');
INSERT INTO `order_items` VALUES (27, '2026-03-09 20:07:59.671740', 12, 68.00, 21, 691, 'G7', 0, NULL, '2026-03-09 20:07:59.671740');
INSERT INTO `order_items` VALUES (28, '2026-03-09 20:07:59.677693', 12, 68.00, 21, 911, 'G9', 0, NULL, '2026-03-09 20:07:59.677693');
INSERT INTO `order_items` VALUES (29, '2026-03-09 20:13:00.968036', 13, 68.00, 6, 899, 'H9', 0, NULL, '2026-03-09 20:13:00.968036');
INSERT INTO `order_items` VALUES (30, '2026-03-09 20:13:00.982677', 13, 68.00, 6, 909, 'G9', 0, NULL, '2026-03-09 20:13:00.982677');
INSERT INTO `order_items` VALUES (31, '2026-03-11 23:18:18.417640', 14, 68.00, 6, 613, 'D6', 0, NULL, '2026-03-11 23:18:18.417640');
INSERT INTO `order_items` VALUES (32, '2026-03-11 23:18:18.431299', 14, 68.00, 6, 723, 'D7', 0, NULL, '2026-03-11 23:18:18.431299');
INSERT INTO `order_items` VALUES (33, '2026-03-11 23:22:05.941859', 15, 88.00, 1, 799, 'G8', 0, NULL, '2026-03-11 23:22:05.941859');
INSERT INTO `order_items` VALUES (34, '2026-03-11 23:22:05.947198', 15, 88.00, 1, 909, 'G9', 0, NULL, '2026-03-11 23:22:05.947198');
INSERT INTO `order_items` VALUES (35, '2026-03-11 23:28:18.893283', 16, 88.00, 2, 699, 'F7', 0, NULL, '2026-03-11 23:28:18.893283');
INSERT INTO `order_items` VALUES (36, '2026-03-11 23:28:18.898592', 16, 88.00, 2, 809, 'F8', 0, NULL, '2026-03-11 23:28:18.898592');
INSERT INTO `order_items` VALUES (37, '2026-03-11 23:36:06.931116', 17, 98.00, 3, 679, 'H7', 0, NULL, '2026-03-11 23:36:06.931116');
INSERT INTO `order_items` VALUES (38, '2026-03-11 23:36:06.936905', 17, 98.00, 3, 899, 'H9', 0, NULL, '2026-03-11 23:36:06.936905');
INSERT INTO `order_items` VALUES (39, '2026-03-14 20:34:03.506484', 21, 88.00, 18, 469, 'G5', 0, NULL, '2026-03-14 20:34:03.506484');
INSERT INTO `order_items` VALUES (40, '2026-03-14 20:34:03.517527', 21, 88.00, 18, 579, 'G6', 0, NULL, '2026-03-14 20:34:03.517527');
INSERT INTO `order_items` VALUES (41, '2026-03-14 22:39:04.939695', 23, 88.00, 12, 903, 'H9', 0, NULL, '2026-03-14 22:39:04.939695');
INSERT INTO `order_items` VALUES (42, '2026-03-14 22:39:04.952866', 23, 88.00, 12, 1007, 'H10', 0, NULL, '2026-03-14 22:39:04.952866');
INSERT INTO `order_items` VALUES (43, '2026-03-14 23:08:46.322723', 24, 88.00, 17, 579, 'G6', 0, NULL, '2026-03-14 23:08:46.322723');
INSERT INTO `order_items` VALUES (44, '2026-03-14 23:08:46.335509', 24, 88.00, 17, 799, 'G8', 0, NULL, '2026-03-14 23:08:46.335509');
INSERT INTO `order_items` VALUES (45, '2026-03-14 23:14:22.742780', 25, 88.00, 17, 562, 'I6', 0, NULL, '2026-03-14 23:14:22.742780');
INSERT INTO `order_items` VALUES (46, '2026-03-14 23:14:22.761514', 25, 88.00, 17, 672, 'I7', 0, NULL, '2026-03-14 23:14:22.761514');
INSERT INTO `order_items` VALUES (47, '2026-03-14 23:14:47.173539', 26, 88.00, 17, 562, 'I6', 0, NULL, '2026-03-14 23:14:47.173539');
INSERT INTO `order_items` VALUES (48, '2026-03-14 23:14:47.181735', 26, 88.00, 17, 672, 'I7', 0, NULL, '2026-03-14 23:14:47.181735');
INSERT INTO `order_items` VALUES (49, '2026-03-14 23:18:33.850207', 27, 88.00, 17, 996, 'I10', 0, NULL, '2026-03-14 23:18:33.850207');
INSERT INTO `order_items` VALUES (50, '2026-03-14 23:18:33.859506', 27, 88.00, 17, 1190, 'I12', 0, NULL, '2026-03-14 23:18:33.859506');
INSERT INTO `order_items` VALUES (51, '2026-03-15 14:48:07.196808', 30, 68.00, 6, 892, 'I9', 0, NULL, '2026-03-15 14:48:07.196808');
INSERT INTO `order_items` VALUES (52, '2026-03-15 14:48:07.205622', 30, 68.00, 6, 996, 'I10', 0, NULL, '2026-03-15 14:48:07.205622');

-- ----------------------------
-- Table structure for order_snacks
-- ----------------------------
DROP TABLE IF EXISTS `order_snacks`;
CREATE TABLE `order_snacks`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `price` decimal(8, 2) NOT NULL,
  `quantity` int NOT NULL,
  `snack_id` bigint NOT NULL,
  `snack_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `subtotal` decimal(8, 2) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_snacks
-- ----------------------------
INSERT INTO `order_snacks` VALUES (1, '2026-03-03 01:56:51.000000', 1, 38.00, 1, 8, '爆米花+可乐套餐', 38.00, '2026-03-03 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (2, '2026-03-05 01:56:51.000000', 2, 68.00, 1, 9, '双人套餐', 68.00, '2026-03-05 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (3, '2026-03-07 01:56:51.000000', 4, 15.00, 1, 4, '可口可乐（中杯）', 15.00, '2026-03-07 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (4, '2026-03-08 01:56:51.000000', 5, 98.00, 1, 10, '家庭套餐', 98.00, '2026-03-08 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (5, '2026-03-08 01:56:51.000000', 6, 38.00, 1, 8, '爆米花+可乐套餐', 38.00, '2026-03-08 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (6, '2026-03-08 01:56:51.000000', 8, 25.00, 1, 1, '经典原味爆米花（小）', 25.00, '2026-03-08 01:56:51.000000');
INSERT INTO `order_snacks` VALUES (7, '2026-03-08 22:36:09.549299', 9, 25.00, 1, 1, '经典原味爆米花（小）', 25.00, '2026-03-08 22:36:09.550841');
INSERT INTO `order_snacks` VALUES (8, '2026-03-11 23:28:18.904218', 16, 25.00, 1, 1, '经典原味爆米花（小）', 25.00, '2026-03-11 23:28:18.904218');
INSERT INTO `order_snacks` VALUES (9, '2026-03-11 23:36:06.943347', 17, 98.00, 1, 10, '家庭套餐', 98.00, '2026-03-11 23:36:06.943347');
INSERT INTO `order_snacks` VALUES (10, '2026-03-14 14:38:52.791166', 18, 32.00, 1, 3, '焦糖爆米花', 32.00, '2026-03-14 14:38:52.791166');
INSERT INTO `order_snacks` VALUES (11, '2026-03-14 19:46:45.265928', 19, 15.00, 1, 6, '雪碧（中杯）', 15.00, '2026-03-14 19:46:45.265928');
INSERT INTO `order_snacks` VALUES (12, '2026-03-14 20:33:43.072022', 20, 32.00, 1, 3, '焦糖爆米花', 32.00, '2026-03-14 20:33:43.072022');
INSERT INTO `order_snacks` VALUES (13, '2026-03-14 20:34:03.524100', 21, 18.00, 1, 11, '薯条', 18.00, '2026-03-14 20:34:03.524100');
INSERT INTO `order_snacks` VALUES (14, '2026-03-14 22:38:28.523433', 22, 35.00, 1, 2, '经典原味爆米花（大）', 35.00, '2026-03-14 22:38:28.523433');
INSERT INTO `order_snacks` VALUES (15, '2026-03-14 23:08:46.341524', 24, 12.00, 1, 12, '烤肠', 12.00, '2026-03-14 23:08:46.341524');
INSERT INTO `order_snacks` VALUES (16, '2026-03-15 13:06:17.149845', 28, 35.00, 1, 2, '经典原味爆米花（大）', 35.00, '2026-03-15 13:06:17.149845');
INSERT INTO `order_snacks` VALUES (17, '2026-03-15 13:15:07.439506', 29, 35.00, 1, 2, '经典原味爆米花（大）', 35.00, '2026-03-15 13:15:07.440021');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cinema_id` bigint NULL DEFAULT NULL,
  `cinema_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `discount_amount` decimal(10, 2) NOT NULL,
  `expire_time` datetime(6) NULL DEFAULT NULL,
  `hall_id` bigint NULL DEFAULT NULL,
  `hall_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `movie_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pay_amount` decimal(10, 2) NULL DEFAULT NULL,
  `pay_time` datetime(6) NULL DEFAULT NULL,
  `pay_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qr_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `schedule_id` bigint NULL DEFAULT NULL,
  `seat_count` int NOT NULL,
  `show_time` datetime NULL DEFAULT NULL,
  `snack_amount` decimal(10, 2) NOT NULL,
  `status` int NOT NULL,
  `ticket_amount` decimal(10, 2) NOT NULL,
  `ticket_time` datetime(6) NULL DEFAULT NULL,
  `ticketed` int NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `coupon_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_g8pohnngqi5x1nask7nff2u7w`(`order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, '佳悦影院中关村店', '2026-03-03 01:56:51.000000', 0, 0.00, NULL, 1, '1号厅', '流浪地球2', 'JY202501010001', 214.00, '2026-03-03 01:56:51.000000', 'wechat', 'QR001', NULL, 1, 2, '2026-03-08 10:00:00', 38.00, 1, 176.00, '2026-03-03 01:56:51.000000', 1, 214.00, '2026-03-03 01:56:51.000000', 4, 'zhangsan', NULL);
INSERT INTO `orders` VALUES (2, 1, '佳悦影院中关村店', '2026-03-05 01:56:51.000000', 0, 26.40, NULL, 1, '1号厅', '流浪地球2', 'JY202501010002', 305.60, '2026-03-05 01:56:51.000000', 'alipay', 'QR002', NULL, 2, 3, '2026-03-08 14:30:00', 68.00, 1, 264.00, '2026-03-05 01:56:51.000000', 1, 305.60, '2026-03-05 01:56:51.000000', 4, 'zhangsan', NULL);
INSERT INTO `orders` VALUES (3, 1, '佳悦影院中关村店', '2026-03-06 01:56:51.000000', 0, 0.00, NULL, 1, '1号厅', '哪吒之魔童降世', 'JY202501010003', 136.00, '2026-03-06 01:56:51.000000', 'memberCard', 'QR003', NULL, 6, 2, '2026-03-08 11:00:00', 0.00, 1, 136.00, NULL, 0, 136.00, '2026-03-06 01:56:51.000000', 5, 'lisi', NULL);
INSERT INTO `orders` VALUES (4, 2, '佳悦影院国贸店', '2026-03-07 01:56:51.000000', 0, 0.00, NULL, 5, '1号厅', '长津湖', 'JY202501010004', 93.00, '2026-03-07 01:56:51.000000', 'wechat', 'QR004', NULL, 9, 1, '2026-03-08 10:30:00', 15.00, 1, 78.00, NULL, 0, 93.00, '2026-03-07 01:56:51.000000', 6, 'wangwu', NULL);
INSERT INTO `orders` VALUES (5, 1, '佳悦影院中关村店', '2026-03-08 01:56:51.000000', 0, 39.20, NULL, 1, '1号厅', '流浪地球2', 'JY202501010005', 450.80, '2026-03-08 01:56:51.000000', 'alipay', 'QR005', NULL, 3, 4, '2026-03-08 19:00:00', 98.00, 1, 392.00, NULL, 0, 450.80, '2026-03-08 01:56:51.000000', 7, 'zhaoliu', NULL);
INSERT INTO `orders` VALUES (6, 3, '佳悦影院西单店', '2026-03-08 01:56:51.000000', 0, 0.00, NULL, 8, '1号厅', '热辣滚烫', 'JY202501010006', 154.00, '2026-03-08 01:56:51.000000', 'wechat', 'QR006', NULL, 14, 2, '2026-03-08 10:00:00', 38.00, 1, 116.00, NULL, 0, 154.00, '2026-03-08 01:56:51.000000', 8, 'sunqi', NULL);
INSERT INTO `orders` VALUES (7, 2, '佳悦影院国贸店', '2026-03-08 01:56:51.000000', 0, 15.60, '2026-03-08 02:11:51.000000', 5, '1号厅', '长津湖', 'JY202501010007', 140.40, '2026-03-08 01:56:51.000000', 'memberCard', NULL, NULL, 10, 2, '2026-03-08 14:00:00', 0.00, 0, 156.00, NULL, 0, 140.40, '2026-03-08 01:56:51.000000', 4, 'zhangsan', NULL);
INSERT INTO `orders` VALUES (8, 3, '佳悦影院西单店', '2026-03-08 01:56:51.000000', 0, 0.00, '2026-03-08 02:16:51.000000', 8, '1号厅', '热辣滚烫', 'JY202501010008', 83.00, NULL, NULL, NULL, NULL, 15, 1, '2026-03-08 13:30:00', 25.00, 0, 58.00, NULL, 0, 83.00, '2026-03-08 01:56:51.000000', 5, 'lisi', NULL);
INSERT INTO `orders` VALUES (9, 1, '佳悦影城(万达广场店)', '2026-03-08 22:36:09.503432', 0, 0.00, '2026-03-08 22:51:09.491446', 1, '1号厅', '哪吒之魔童降世', 'JY20260308223609775382', 161.00, '2026-03-08 22:36:34.549364', '1', NULL, NULL, 6, 2, '2026-03-08 11:00:00', 25.00, 1, 136.00, NULL, 0, 161.00, '2026-03-08 22:36:09.506498', 9, NULL, NULL);
INSERT INTO `orders` VALUES (10, 1, '佳悦影城(万达广场店)', '2026-03-09 20:05:20.112384', 0, 0.00, '2026-03-09 20:20:20.095228', 3, '3号厅', '哪吒之魔童降世', 'JY20260309200520CF953C', 272.00, NULL, NULL, NULL, NULL, 21, 4, '2026-03-09 15:30:00', 0.00, 3, 272.00, NULL, 0, 272.00, '2026-03-09 20:05:20.115939', 9, NULL, NULL);
INSERT INTO `orders` VALUES (11, 4, '佳悦影城(五道口店)', '2026-03-09 20:06:32.097902', 0, 0.00, '2026-03-09 20:21:32.097348', 10, '1号厅', '热辣滚烫', 'JY20260309200632AB5CC2', 116.00, '2026-03-09 20:06:41.759896', '1', NULL, NULL, 25, 2, '2026-03-09 10:00:00', 0.00, 1, 116.00, NULL, 0, 116.00, '2026-03-09 20:06:32.097902', 9, NULL, NULL);
INSERT INTO `orders` VALUES (12, 1, '佳悦影城(万达广场店)', '2026-03-09 20:07:59.661004', 0, 0.00, '2026-03-09 20:22:59.660618', 3, '3号厅', '哪吒之魔童降世', 'JY202603092007592535FA', 204.00, '2026-03-09 20:08:03.387729', '1', NULL, NULL, 21, 3, '2026-03-09 15:30:00', 0.00, 1, 204.00, NULL, 0, 204.00, '2026-03-09 20:07:59.661004', 10, NULL, NULL);
INSERT INTO `orders` VALUES (13, 1, '佳悦影城(万达广场店)', '2026-03-09 20:13:00.950665', 0, 0.00, '2026-03-09 20:28:00.942752', 1, '1号厅', '哪吒之魔童降世', 'JY2026030920130066CB68', 136.00, '2026-03-09 20:13:04.737395', '1', NULL, NULL, 6, 2, '2026-03-08 11:00:00', 0.00, 1, 136.00, NULL, 0, 136.00, '2026-03-09 20:13:00.953993', 10, NULL, NULL);
INSERT INTO `orders` VALUES (14, 1, '佳悦影城(万达广场店)', '2026-03-11 23:18:18.398270', 0, 0.00, '2026-03-11 23:33:18.391383', 1, '1号厅', '哪吒之魔童降世', 'JY202603112318182D39DD', 136.00, '2026-03-11 23:18:26.282711', 'wechat', NULL, NULL, 6, 2, '2026-03-08 11:00:00', 0.00, 1, 136.00, NULL, 0, 136.00, '2026-03-11 23:18:18.399759', 10, NULL, NULL);
INSERT INTO `orders` VALUES (15, 1, '佳悦影城(万达广场店)', '2026-03-11 23:22:05.935799', 0, 0.00, '2026-03-11 23:37:05.934613', 1, '1号厅', '流浪地球2', 'JY2026031123220539A1A3', 176.00, '2026-03-11 23:22:11.140526', 'wechat', NULL, NULL, 1, 2, '2026-03-08 10:00:00', 0.00, 1, 176.00, NULL, 0, 176.00, '2026-03-11 23:22:05.935799', 10, NULL, NULL);
INSERT INTO `orders` VALUES (16, 1, '佳悦影城(万达广场店)', '2026-03-11 23:28:18.888865', 0, 0.00, '2026-03-11 23:43:18.887839', 1, '1号厅', '流浪地球2', 'JY2026031123281892D4ED', 201.00, '2026-03-11 23:28:23.809884', 'wechat', NULL, NULL, 2, 2, '2026-03-08 14:30:00', 25.00, 1, 176.00, NULL, 0, 201.00, '2026-03-11 23:28:18.888865', 10, NULL, NULL);
INSERT INTO `orders` VALUES (17, 1, '佳悦影城(万达广场店)', '2026-03-11 23:36:06.926949', 0, 0.00, '2026-03-11 23:51:06.925846', 1, '1号厅', '流浪地球2', 'JY2026031123360619DB11', 294.00, '2026-03-11 23:36:11.855563', 'wechat', NULL, NULL, 3, 2, '2026-03-08 19:00:00', 98.00, 1, 196.00, NULL, 0, 294.00, '2026-03-11 23:36:06.926949', 10, NULL, NULL);
INSERT INTO `orders` VALUES (18, 0, '', '2026-03-14 14:38:52.775967', 0, 0.00, '2026-03-14 14:53:52.765190', 0, '', '小吃订单', 'JY20260314143852FB28C6', 32.00, '2026-03-14 14:39:05.637872', 'wechat', NULL, NULL, NULL, 0, NULL, 32.00, 1, 0.00, NULL, 0, 32.00, '2026-03-14 14:38:52.779050', 10, NULL, NULL);
INSERT INTO `orders` VALUES (19, 0, '', '2026-03-14 19:46:45.253790', 0, 0.00, '2026-03-14 20:01:45.245136', 0, '', '小吃订单', 'JY202603141946451CD4EA', 15.00, '2026-03-14 19:46:52.634574', 'wechat', NULL, NULL, NULL, 0, NULL, 15.00, 1, 0.00, NULL, 0, 15.00, '2026-03-14 19:46:45.255892', 10, NULL, NULL);
INSERT INTO `orders` VALUES (20, 0, '', '2026-03-14 20:33:43.050145', 0, 0.00, '2026-03-14 20:48:43.035932', 0, '', '小吃订单', 'JY202603142033437AFC1E', 32.00, '2026-03-14 20:33:54.995682', 'balance', NULL, NULL, NULL, 0, NULL, 32.00, 1, 0.00, NULL, 0, 32.00, '2026-03-14 20:33:43.055131', 10, NULL, NULL);
INSERT INTO `orders` VALUES (21, 1, '佳悦影城(万达广场店)', '2026-03-14 20:34:03.498359', 0, 0.00, '2026-03-14 20:49:03.498359', 1, '1号厅', '流浪地球2', 'JY20260314203403B18A05', 194.00, NULL, NULL, NULL, NULL, 18, 2, '2026-03-14 14:30:00', 18.00, 3, 176.00, NULL, 0, 194.00, '2026-03-14 20:34:03.498359', 10, NULL, NULL);
INSERT INTO `orders` VALUES (22, 0, '', '2026-03-14 22:38:28.499533', 0, 0.00, '2026-03-14 22:53:28.485264', 0, '', '小吃订单', 'JY202603142238283320AC', 35.00, NULL, NULL, NULL, NULL, NULL, 0, NULL, 35.00, 3, 0.00, NULL, 0, 35.00, '2026-03-14 22:38:28.504141', 10, NULL, NULL);
INSERT INTO `orders` VALUES (23, 2, '佳悦影城(西单店)', '2026-03-14 22:39:04.929505', 0, 0.00, '2026-03-14 22:54:04.929505', 5, '1号厅', '封神第一部', 'JY202603142239043C7AAF', 176.00, '2026-03-14 22:39:08.502155', 'balance', NULL, NULL, 12, 2, '2026-03-16 11:30:00', 0.00, 1, 176.00, NULL, 0, 176.00, '2026-03-14 22:39:04.929505', 10, NULL, NULL);
INSERT INTO `orders` VALUES (24, 1, '佳悦影城(万达广场店)', '2026-03-14 23:08:46.304986', 0, 0.00, '2026-03-14 23:23:46.296447', 1, '1号厅', '流浪地球2', 'JY20260314230846A99B9E', 188.00, '2026-03-14 23:08:51.010767', 'balance', NULL, NULL, 17, 2, '2026-03-15 10:00:00', 12.00, 1, 176.00, NULL, 0, 188.00, '2026-03-14 23:08:46.309408', 10, NULL, NULL);
INSERT INTO `orders` VALUES (25, 1, '佳悦影城(万达广场店)', '2026-03-14 23:14:22.724003', 0, 0.00, '2026-03-14 23:29:22.716101', 1, '1号厅', '流浪地球2', 'JY20260314231422860738', 176.00, NULL, NULL, NULL, NULL, 17, 2, '2026-03-15 10:00:00', 0.00, 3, 176.00, NULL, 0, 176.00, '2026-03-14 23:14:22.727031', 10, NULL, NULL);
INSERT INTO `orders` VALUES (26, 1, '佳悦影城(万达广场店)', '2026-03-14 23:14:47.165541', 0, 0.00, '2026-03-14 23:29:47.164071', 1, '1号厅', '流浪地球2', 'JY202603142314478058B8', 176.00, '2026-03-14 23:17:23.675193', 'balance', NULL, NULL, 17, 2, '2026-03-15 10:00:00', 0.00, 1, 176.00, NULL, 0, 176.00, '2026-03-14 23:14:47.165541', 10, NULL, NULL);
INSERT INTO `orders` VALUES (27, 1, '佳悦影城(万达广场店)', '2026-03-14 23:18:33.841600', 0, 0.00, '2026-03-14 23:33:33.834390', 1, '1号厅', '流浪地球2', 'JY2026031423183374358A', 176.00, '2026-03-14 23:18:37.754167', 'balance', NULL, NULL, 17, 2, '2026-03-15 10:00:00', 0.00, 1, 176.00, NULL, 0, 176.00, '2026-03-14 23:18:33.841600', 10, NULL, 1);
INSERT INTO `orders` VALUES (28, 0, '', '2026-03-15 13:06:17.138390', 0, 0.00, '2026-03-15 13:21:17.076901', 0, '', '小吃订单', 'JY2026031513061726E974', 35.00, '2026-03-15 13:06:26.871303', 'alipay', NULL, NULL, 16, 0, NULL, 35.00, 1, 0.00, NULL, 0, 35.00, '2026-03-15 13:06:17.140686', 10, NULL, 3);
INSERT INTO `orders` VALUES (29, 0, '', '2026-03-15 13:15:07.432120', 0, 0.00, '2026-03-15 13:30:07.426671', 0, '', '小吃订单', 'JY20260315131507ED58DF', 35.00, '2026-03-15 13:15:12.830390', 'balance', NULL, NULL, 16, 0, NULL, 35.00, 3, 0.00, NULL, 0, 35.00, '2026-03-15 13:15:07.433122', 10, NULL, 2);
INSERT INTO `orders` VALUES (30, 1, '佳悦影城(万达广场店)', '2026-03-15 14:48:07.187775', 0, 0.00, '2026-03-15 15:03:07.181121', 1, '1号厅', '哪吒之魔童降世', 'JY20260315144807F0B6B2', 136.00, '2026-03-15 14:48:11.277937', 'balance', NULL, NULL, 6, 2, '2026-03-16 11:00:00', 0.00, 1, 136.00, '2026-03-15 14:49:34.923005', 1, 136.00, '2026-03-15 14:48:07.187775', 10, NULL, NULL);

-- ----------------------------
-- Table structure for points_log
-- ----------------------------
DROP TABLE IF EXISTS `points_log`;
CREATE TABLE `points_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` int NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `points` int NOT NULL,
  `related_id` bigint NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of points_log
-- ----------------------------
INSERT INTO `points_log` VALUES (1, 214, '2026-03-03 01:56:51.000000', 214, 1, '购票获得积分', 1, 4);
INSERT INTO `points_log` VALUES (2, 520, '2026-03-05 01:56:51.000000', 306, 2, '购票获得积分', 1, 4);
INSERT INTO `points_log` VALUES (3, 530, '2026-03-06 01:56:51.000000', 10, NULL, '每日签到', 3, 4);
INSERT INTO `points_log` VALUES (4, 540, '2026-03-07 01:56:51.000000', 10, NULL, '每日签到', 3, 4);
INSERT INTO `points_log` VALUES (5, 991, '2026-03-08 01:56:51.000000', 451, 5, '购票获得积分', 1, 4);
INSERT INTO `points_log` VALUES (6, 136, '2026-03-06 01:56:51.000000', 136, 3, '购票获得积分', 1, 5);
INSERT INTO `points_log` VALUES (7, 146, '2026-03-07 01:56:51.000000', 10, NULL, '每日签到', 3, 5);
INSERT INTO `points_log` VALUES (8, 93, '2026-03-07 01:56:51.000000', 93, 4, '购票获得积分', 1, 6);
INSERT INTO `points_log` VALUES (9, 214, '2026-03-03 01:56:51.000000', 214, 1, '购票获得积分', 1, 7);
INSERT INTO `points_log` VALUES (10, 520, '2026-03-05 01:56:51.000000', 306, 2, '购票获得积分', 1, 7);
INSERT INTO `points_log` VALUES (11, 530, '2026-03-06 01:56:51.000000', 10, NULL, '每日签到', 3, 7);
INSERT INTO `points_log` VALUES (12, 154, '2026-03-08 01:56:51.000000', 154, 6, '购票获得积分', 1, 8);
INSERT INTO `points_log` VALUES (13, 136, '2026-03-09 20:13:04.767970', 136, 13, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (14, 272, '2026-03-11 23:18:26.309329', 136, 14, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (15, 448, '2026-03-11 23:22:11.151338', 176, 15, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (16, 649, '2026-03-11 23:28:23.816994', 201, 16, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (17, 943, '2026-03-11 23:36:11.866757', 294, 17, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (18, 675, '2026-03-14 14:39:05.665942', 32, 18, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (19, 690, '2026-03-14 19:46:52.661315', 15, 19, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (20, 722, '2026-03-14 20:33:55.044705', 32, 20, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (21, 898, '2026-03-14 22:39:08.526186', 176, 23, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (22, 1086, '2026-03-14 23:08:51.031885', 188, 24, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (23, 1262, '2026-03-14 23:17:23.821624', 176, 26, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (24, 1138, '2026-03-14 23:18:37.770912', 176, 27, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (25, 273, '2026-03-15 13:06:26.907005', 35, 28, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (26, 308, '2026-03-15 13:15:12.867015', 35, 29, '购票消费获得积分', 1, 10);
INSERT INTO `points_log` VALUES (27, 144, '2026-03-15 14:48:11.301690', 136, 30, '购票消费获得积分', 1, 10);

-- ----------------------------
-- Table structure for recharge_log
-- ----------------------------
DROP TABLE IF EXISTS `recharge_log`;
CREATE TABLE `recharge_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10, 2) NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `gift_amount` decimal(10, 2) NULL DEFAULT NULL,
  `gift_points` int NULL DEFAULT NULL,
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pay_time` datetime(6) NULL DEFAULT NULL,
  `pay_type` int NOT NULL,
  `status` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recharge_log
-- ----------------------------
INSERT INTO `recharge_log` VALUES (1, 500.00, '2026-02-26 01:56:51.000000', 50.00, 50, 'RC202501010001', '2026-02-26 01:56:51.000000', 1, 1, 4);
INSERT INTO `recharge_log` VALUES (2, 200.00, '2026-03-03 01:56:51.000000', 10.00, 10, 'RC202501010002', '2026-03-03 01:56:51.000000', 2, 1, 4);
INSERT INTO `recharge_log` VALUES (3, 200.00, '2026-03-01 01:56:51.000000', 10.00, 10, 'RC202501010003', '2026-03-01 01:56:51.000000', 1, 1, 5);
INSERT INTO `recharge_log` VALUES (4, 1000.00, '2026-02-21 01:56:51.000000', 150.00, 150, 'RC202501010004', '2026-02-21 01:56:51.000000', 1, 1, 7);
INSERT INTO `recharge_log` VALUES (5, 500.00, '2026-02-28 01:56:51.000000', 50.00, 50, 'RC202501010005', '2026-02-28 01:56:51.000000', 2, 1, 7);
INSERT INTO `recharge_log` VALUES (6, 100.00, '2026-03-05 01:56:51.000000', 0.00, 0, 'RC202501010006', '2026-03-05 01:56:51.000000', 1, 1, 8);

-- ----------------------------
-- Table structure for schedule_seats
-- ----------------------------
DROP TABLE IF EXISTS `schedule_seats`;
CREATE TABLE `schedule_seats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `locked_at` datetime(6) NULL DEFAULT NULL,
  `locked_by` bigint NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `schedule_id` bigint NOT NULL,
  `seat_id` bigint NOT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UKl4p8cuqju20iuseifxayse9aw`(`schedule_id` ASC, `seat_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3397 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_seats
-- ----------------------------
INSERT INTO `schedule_seats` VALUES (1, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 319, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (4, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (5, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (6, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (7, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (8, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 869, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (9, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (10, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1078, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (11, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (12, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (13, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (14, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (15, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 87, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (16, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 197, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (17, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (18, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (19, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (20, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 637, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (21, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 747, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (22, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 857, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (23, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (24, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (25, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1161, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (26, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1251, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (27, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (28, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 1, 1367, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (29, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (30, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (31, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (32, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 405, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (33, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 515, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (34, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 625, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (35, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 735, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (36, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (37, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 952, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (38, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1056, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (39, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1152, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (40, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1242, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (41, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1308, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (42, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (43, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (44, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 173, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (45, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (46, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 393, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (47, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 503, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (48, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (49, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 723, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (50, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (51, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (52, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (53, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1143, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (54, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1233, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (55, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (56, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (57, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 51, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (58, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 161, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (59, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (60, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 381, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (61, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (62, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (63, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 711, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (64, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (65, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 930, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (66, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1034, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (67, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (68, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (69, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (70, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (71, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 39, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (72, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 149, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (73, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (74, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (75, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (76, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 589, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (77, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 699, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (78, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 809, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (79, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 919, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (80, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1023, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (81, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (82, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (83, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (84, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1347, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (85, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (86, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (87, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (88, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 359, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (89, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (90, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 579, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (91, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (92, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 799, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (93, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 909, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (94, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (95, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (96, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (97, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (98, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (99, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (100, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (101, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (102, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (103, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 459, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (104, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (105, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 679, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (106, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 789, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (107, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 899, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (108, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1003, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (109, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (110, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (111, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (112, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (113, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (114, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (115, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (116, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 342, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (117, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (118, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 562, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (119, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (120, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 782, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (121, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (122, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 996, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (123, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (124, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1190, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (125, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1278, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (126, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1332, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (127, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (128, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 115, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (129, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 225, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (130, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (131, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (132, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 555, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (133, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (134, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 775, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (135, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (136, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 989, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (137, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1093, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (138, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1183, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (139, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1273, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (140, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 1, 1327, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (141, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (142, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (143, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (144, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (145, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 539, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (146, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (147, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (148, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 869, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (149, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 974, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (150, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (151, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (152, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (153, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (154, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1372, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (155, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 87, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (156, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (157, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (158, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 417, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (159, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (160, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 637, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (161, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 747, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (162, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (163, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 963, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (164, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (165, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1161, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (166, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1251, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (167, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (168, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 2, 1367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (169, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (170, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (171, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 295, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (172, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 405, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (173, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 515, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (174, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 625, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (175, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (176, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (177, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 952, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (178, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1056, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (179, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1152, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (180, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1242, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (181, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (182, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (183, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (184, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (185, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (186, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 393, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (187, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 503, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (188, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (189, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 723, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (190, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (191, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (192, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (193, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1143, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (194, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1233, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (195, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1303, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (196, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (197, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 51, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (198, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (199, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 271, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (200, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (201, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (202, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (203, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 711, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (204, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (205, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 930, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (206, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (207, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1134, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (208, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (209, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1298, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (210, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (211, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 39, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (212, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 149, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (213, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (214, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 369, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (215, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (216, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 589, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (217, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 699, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (218, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 809, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (219, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (220, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1023, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (221, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (222, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (223, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (224, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (225, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (226, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (227, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (228, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (229, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (230, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 579, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (231, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 689, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (232, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 799, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (233, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 909, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (234, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (235, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (236, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (237, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (238, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (239, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (240, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (241, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (242, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (243, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 459, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (244, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (245, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 679, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (246, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 789, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (247, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 899, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (248, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1003, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (249, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (250, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (251, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (252, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1337, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (253, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 12, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (254, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (255, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (256, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (257, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 452, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (258, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 562, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (259, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (260, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 782, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (261, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (262, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 996, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (263, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (264, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (265, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1278, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (266, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1332, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (267, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 5, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (268, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 115, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (269, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (270, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (271, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (272, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 555, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (273, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (274, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 775, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (275, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 885, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (276, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 989, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (277, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1093, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (278, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1183, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (279, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1273, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (280, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 2, 1327, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (281, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (282, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (283, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (284, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 429, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (285, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (286, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (287, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (288, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 869, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (289, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (290, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (291, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1170, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (292, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1260, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (293, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (294, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1372, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (295, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 87, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (296, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (297, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 307, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (298, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (299, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (300, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 637, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (301, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 747, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (302, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (303, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (304, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (305, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (306, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (307, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (308, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 3, 1367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (309, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (310, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (311, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (312, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 405, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (313, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 515, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (314, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 625, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (315, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (316, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 845, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (317, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 952, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (318, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1056, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (319, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1152, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (320, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (321, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (322, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (323, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (324, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 173, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (325, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (326, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (327, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 503, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (328, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (329, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 723, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (330, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (331, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (332, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (333, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (334, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (335, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (336, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (337, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 51, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (338, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (339, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (340, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (341, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (342, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (343, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 711, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (344, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (345, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 930, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (346, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (347, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (348, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (349, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (350, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (351, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 39, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (352, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 149, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (353, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (354, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (355, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (356, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 589, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (357, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 699, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (358, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 809, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (359, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (360, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1023, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (361, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1125, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (362, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1215, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (363, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (364, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (365, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (366, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (367, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (368, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (369, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (370, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 579, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (371, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (372, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 799, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (373, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 909, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (374, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (375, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (376, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1206, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (377, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (378, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (379, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 19, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (380, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 129, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (381, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (382, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 349, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (383, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 459, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (384, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (385, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 679, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (386, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 789, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (387, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 899, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (388, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1003, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (389, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (390, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (391, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (392, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (393, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (394, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (395, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (396, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (397, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (398, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 562, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (399, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (400, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 782, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (401, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (402, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 996, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (403, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (404, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (405, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1278, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (406, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1332, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (407, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (408, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 115, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (409, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (410, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 335, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (411, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (412, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 555, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (413, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 665, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (414, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 775, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (415, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (416, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 989, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (417, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1093, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (418, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1183, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (419, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1273, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (420, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 3, 1327, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (421, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (422, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 210, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (423, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 320, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (424, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 430, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (425, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 540, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (426, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 650, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (427, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 760, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (428, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 870, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (429, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 975, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (430, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1079, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (431, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1171, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (432, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1261, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (433, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 88, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (434, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 198, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (435, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 308, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (436, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 418, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (437, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 528, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (438, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 638, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (439, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 748, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (440, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 858, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (441, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 964, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (442, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1068, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (443, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1162, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (444, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1252, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (445, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 76, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (446, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 186, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (447, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 296, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (448, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 406, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (449, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 516, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (450, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 626, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (451, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 736, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (452, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 846, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (453, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 953, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (454, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1057, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (455, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1153, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (456, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (457, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 64, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (458, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 174, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (459, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (460, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (461, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 504, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (462, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 614, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (463, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 724, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (464, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 834, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (465, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 942, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (466, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1046, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (467, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1144, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (468, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1234, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (469, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 52, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (470, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 162, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (471, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 272, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (472, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 382, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (473, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 492, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (474, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 602, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (475, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 712, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (476, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 822, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (477, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 931, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (478, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1035, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (479, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1135, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (480, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1225, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (481, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 40, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (482, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 150, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (483, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 260, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (484, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 370, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (485, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 480, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (486, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 590, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (487, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 700, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (488, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 810, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (489, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 920, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (490, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1024, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (491, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1126, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (492, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1216, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (493, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 30, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (494, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 140, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (495, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 250, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (496, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 360, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (497, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 470, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (498, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 580, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (499, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 690, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (500, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 800, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (501, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 910, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (502, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1014, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (503, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1117, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (504, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1207, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (505, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 20, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (506, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 130, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (507, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 240, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (508, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 350, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (509, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 460, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (510, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 570, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (511, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 680, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (512, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 790, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (513, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 900, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (514, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1004, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (515, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1108, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (516, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 4, 1198, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (517, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 101, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (518, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 211, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (519, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 321, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (520, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 431, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (521, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 541, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (522, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 651, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (523, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 761, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (524, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 871, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (525, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 976, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (526, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1080, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (527, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1172, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (528, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1262, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (529, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 89, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (530, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 199, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (531, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (532, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 419, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (533, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 529, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (534, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 639, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (535, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 749, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (536, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 859, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (537, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 965, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (538, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1069, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (539, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1163, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (540, '2026-03-08 01:56:51.000000', NULL, NULL, 108.00, 5, 1253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (541, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 77, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (542, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 187, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (543, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 297, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (544, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 407, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (545, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 517, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (546, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 627, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (547, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 737, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (548, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 847, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (549, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 954, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (550, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1058, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (551, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1154, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (552, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1244, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (553, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 65, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (554, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 175, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (555, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 285, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (556, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (557, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 505, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (558, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 615, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (559, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 725, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (560, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 835, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (561, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 943, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (562, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1047, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (563, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1145, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (564, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1235, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (565, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 53, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (566, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 163, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (567, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 273, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (568, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (569, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 493, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (570, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 603, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (571, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 713, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (572, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 823, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (573, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 932, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (574, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1036, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (575, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1136, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (576, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1226, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (577, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 41, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (578, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 151, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (579, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 261, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (580, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 371, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (581, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 481, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (582, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 591, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (583, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 701, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (584, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 811, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (585, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 921, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (586, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1025, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (587, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1127, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (588, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1217, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (589, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 31, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (590, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 141, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (591, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (592, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 361, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (593, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 471, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (594, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 581, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (595, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 691, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (596, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 801, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (597, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 911, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (598, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1015, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (599, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1118, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (600, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1208, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (601, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 21, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (602, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 131, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (603, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 241, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (604, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 351, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (605, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 461, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (606, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 571, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (607, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 681, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (608, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 791, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (609, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 901, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (610, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1005, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (611, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1109, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (612, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1199, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (613, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 13, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (614, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 123, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (615, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (616, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (617, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 453, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (618, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 563, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (619, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 673, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (620, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 783, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (621, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 893, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (622, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 997, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (623, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1101, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (624, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1191, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (625, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 6, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (626, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (627, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 226, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (628, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 336, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (629, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 446, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (630, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 556, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (631, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 666, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (632, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 776, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (633, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 886, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (634, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 990, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (635, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1094, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (636, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 5, 1184, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (637, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (638, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (639, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 319, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (640, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (641, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (642, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (643, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (644, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 869, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (645, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (646, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (647, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1170, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (648, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (649, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1318, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (650, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (651, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 87, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (652, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 197, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (653, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (654, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (655, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 527, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (656, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 637, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (657, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 747, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (658, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (659, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (660, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1067, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (661, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1161, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (662, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (663, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1313, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (664, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 6, 1367, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (665, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (666, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (667, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (668, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 405, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (669, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 515, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (670, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 625, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (671, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (672, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (673, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 952, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (674, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1056, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (675, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1152, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (676, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (677, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (678, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (679, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (680, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (681, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (682, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (683, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 503, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (684, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 613, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (685, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 723, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (686, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (687, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (688, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1045, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (689, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (690, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1233, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (691, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (692, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1357, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (693, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 51, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (694, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (695, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (696, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (697, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (698, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 601, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (699, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 711, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (700, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (701, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 930, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (702, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (703, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1134, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (704, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1224, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (705, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (706, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1352, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (707, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 39, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (708, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 149, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (709, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 259, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (710, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (711, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (712, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 589, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (713, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 699, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (714, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 809, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (715, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (716, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1023, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (717, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (718, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1215, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (719, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (720, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (721, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (722, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (723, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (724, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (725, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 469, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (726, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 579, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (727, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (728, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 799, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (729, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 909, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (730, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (731, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (732, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1206, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (733, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (734, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1342, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (735, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (736, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 129, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (737, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (738, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (739, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 459, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (740, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (741, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 679, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (742, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 789, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (743, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 899, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (744, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1003, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (745, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1107, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (746, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (747, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (748, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1337, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (749, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (750, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 122, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (751, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (752, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (753, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (754, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 562, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (755, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (756, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 782, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (757, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 892, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (758, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 996, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (759, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (760, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (761, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1278, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (762, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1332, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (763, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (764, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 115, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (765, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (766, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (767, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 445, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (768, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 555, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (769, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (770, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 775, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (771, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (772, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 989, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (773, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1093, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (774, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1183, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (775, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1273, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (776, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 6, 1327, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (777, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 101, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (778, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 211, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (779, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 321, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (780, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 431, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (781, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 541, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (782, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 651, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (783, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 761, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (784, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 871, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (785, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 976, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (786, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1080, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (787, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1172, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (788, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1262, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (789, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 89, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (790, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 199, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (791, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (792, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 419, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (793, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 529, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (794, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 639, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (795, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 749, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (796, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 859, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (797, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 965, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (798, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1069, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (799, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1163, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (800, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 7, 1253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (801, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 77, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (802, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 187, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (803, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 297, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (804, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 407, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (805, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 517, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (806, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 627, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (807, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 737, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (808, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 847, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (809, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 954, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (810, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1058, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (811, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1154, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (812, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1244, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (813, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 65, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (814, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 175, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (815, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 285, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (816, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 395, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (817, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 505, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (818, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 615, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (819, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 725, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (820, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 835, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (821, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 943, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (822, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1047, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (823, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1145, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (824, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1235, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (825, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 53, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (826, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 163, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (827, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 273, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (828, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (829, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 493, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (830, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 603, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (831, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 713, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (832, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 823, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (833, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 932, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (834, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1036, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (835, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1136, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (836, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1226, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (837, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 41, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (838, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 151, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (839, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 261, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (840, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 371, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (841, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 481, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (842, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 591, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (843, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 701, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (844, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 811, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (845, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 921, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (846, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1025, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (847, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1127, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (848, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1217, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (849, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 31, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (850, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 141, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (851, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (852, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 361, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (853, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 471, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (854, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 581, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (855, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 691, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (856, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 801, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (857, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 911, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (858, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1015, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (859, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1118, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (860, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1208, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (861, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 21, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (862, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 131, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (863, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 241, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (864, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 351, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (865, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 461, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (866, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 571, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (867, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 681, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (868, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 791, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (869, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 901, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (870, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1005, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (871, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1109, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (872, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1199, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (873, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 13, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (874, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 123, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (875, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (876, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (877, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 453, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (878, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 563, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (879, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 673, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (880, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 783, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (881, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 893, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (882, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 997, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (883, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1101, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (884, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1191, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (885, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 6, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (886, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (887, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 226, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (888, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 336, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (889, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 446, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (890, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 556, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (891, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 666, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (892, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 776, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (893, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 886, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (894, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 990, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (895, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1094, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (896, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 7, 1184, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (897, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (898, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 212, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (899, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 322, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (900, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 432, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (901, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 542, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (902, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 652, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (903, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 762, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (904, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 872, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (905, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 977, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (906, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1081, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (907, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 90, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (908, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 200, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (909, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 310, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (910, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 420, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (911, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 530, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (912, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 640, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (913, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 750, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (914, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 860, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (915, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 966, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (916, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1070, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (917, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 78, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (918, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 188, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (919, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (920, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 408, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (921, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 518, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (922, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 628, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (923, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 738, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (924, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 848, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (925, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 955, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (926, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1059, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (927, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 66, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (928, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 176, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (929, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 286, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (930, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (931, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 506, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (932, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 616, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (933, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 726, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (934, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 836, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (935, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 944, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (936, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1048, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (937, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 54, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (938, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 164, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (939, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 274, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (940, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (941, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 494, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (942, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 604, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (943, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 714, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (944, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 824, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (945, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 933, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (946, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1037, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (947, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 42, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (948, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 152, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (949, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 262, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (950, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (951, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 482, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (952, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 592, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (953, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 702, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (954, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 812, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (955, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 922, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (956, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1026, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (957, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 32, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (958, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 142, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (959, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 252, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (960, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 362, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (961, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 472, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (962, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 582, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (963, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 692, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (964, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 802, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (965, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 912, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (966, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1016, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (967, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 22, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (968, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 132, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (969, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (970, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 352, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (971, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 462, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (972, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 572, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (973, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 682, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (974, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 792, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (975, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 902, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (976, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 8, 1006, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (977, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 103, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (978, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 213, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (979, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 323, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (980, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 433, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (981, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 543, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (982, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 653, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (983, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 763, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (984, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 873, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (985, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 978, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (986, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1082, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (987, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1173, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (988, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1263, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (989, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1319, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (990, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (991, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1388, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (992, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (993, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 91, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (994, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 201, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (995, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 311, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (996, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 421, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (997, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 531, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (998, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 641, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (999, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 751, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1000, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 861, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1001, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 967, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1002, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1071, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1003, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1164, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1004, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1254, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1005, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1006, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1368, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1007, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1008, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 9, 1399, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1009, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 79, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1010, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 189, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1011, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1012, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 409, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1013, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 519, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1014, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 629, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1015, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 739, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1016, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 849, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1017, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 956, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1018, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1060, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1019, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1155, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1020, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1021, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1022, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1023, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1386, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1024, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1025, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 67, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1026, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1027, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 287, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1028, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 397, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1029, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 507, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1030, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 617, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1031, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 727, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1032, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 837, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1033, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 945, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1034, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1049, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1035, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1146, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1036, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1236, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1037, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1304, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1038, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1358, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1039, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1385, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1040, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1041, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 55, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1042, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 165, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1043, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 275, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1044, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1045, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 495, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1046, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 605, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1047, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 715, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1048, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 825, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1049, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 934, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1050, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1038, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1051, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1052, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1227, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1053, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1054, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1353, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1055, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1056, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1057, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 43, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1058, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 153, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1059, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1060, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1061, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 483, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1062, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 593, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1063, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 703, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1064, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 813, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1065, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 923, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1066, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1027, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1067, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1128, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1068, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1218, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1069, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1294, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1070, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1348, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1071, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1072, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1073, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 33, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1074, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1075, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1076, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1077, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 473, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1078, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 583, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1079, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 693, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1080, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 803, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1081, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 913, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1082, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1017, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1083, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1084, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1209, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1085, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1086, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1087, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1382, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1088, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1089, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 23, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1090, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 133, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1091, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1092, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1093, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 463, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1094, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 573, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1095, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 683, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1096, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 793, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1097, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 903, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1098, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1007, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1099, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1110, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1100, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1200, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1101, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1284, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1102, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1338, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1103, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1381, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1104, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1393, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1105, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 14, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1106, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 124, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1107, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 234, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1108, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 344, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1109, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 454, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1110, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 564, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1111, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 674, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1112, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 784, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1113, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 894, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1114, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 998, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1115, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1116, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1117, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1279, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1118, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1333, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1119, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1380, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1120, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1392, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1121, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 7, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1122, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1123, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1124, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1125, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 447, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1126, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 557, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1127, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 667, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1128, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 777, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1129, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 887, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1130, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 991, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1131, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1095, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1132, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1185, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1133, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1274, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1134, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1328, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1135, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1379, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1136, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1391, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1137, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 3, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1138, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 113, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1139, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 223, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1140, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1141, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 443, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1142, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 553, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1143, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 663, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1144, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 773, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1145, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 883, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1146, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 987, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1147, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1091, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1148, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1149, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1150, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1325, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1151, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1152, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1390, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1153, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1154, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 111, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1155, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 221, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1156, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 331, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1157, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 441, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1158, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 551, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1159, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 661, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1160, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 771, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1161, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 881, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1162, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 985, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1163, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1089, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1164, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1179, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1165, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1269, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1166, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1167, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1377, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1168, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 9, 1389, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1169, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 103, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1170, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 213, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1171, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 323, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1172, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 433, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1173, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 543, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1174, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 653, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1175, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 763, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1176, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 873, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1177, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 978, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1178, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1082, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1179, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1173, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1180, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1181, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1319, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1182, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1183, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1184, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1185, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 91, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1186, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 201, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1187, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 311, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1188, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 421, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1189, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 531, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1190, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 641, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1191, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 751, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1192, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 861, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1193, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 967, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1194, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1071, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1195, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1164, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1196, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1254, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1197, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1314, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1198, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1368, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1199, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1200, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 10, 1399, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1201, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 79, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1202, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 189, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1203, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 299, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1204, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 409, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1205, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 519, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1206, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 629, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1207, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 739, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1208, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 849, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1209, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 956, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1210, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1060, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1211, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1155, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1212, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1213, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1309, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1214, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1363, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1215, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1386, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1216, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1217, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 67, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1218, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1219, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 287, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1220, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1221, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 507, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1222, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 617, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1223, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 727, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1224, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 837, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1225, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 945, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1226, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1049, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1227, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1146, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1228, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1236, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1229, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1304, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1230, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1358, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1231, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1232, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1233, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 55, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1234, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 165, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1235, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 275, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1236, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 385, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1237, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 495, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1238, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 605, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1239, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 715, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1240, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 825, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1241, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 934, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1242, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1038, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1243, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1244, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1245, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1246, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1247, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1248, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1249, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 43, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1250, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 153, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1251, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1252, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1253, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 483, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1254, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 593, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1255, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 703, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1256, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 813, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1257, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 923, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1258, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1027, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1259, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1128, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1260, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1218, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1261, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1294, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1262, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1348, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1263, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1264, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1265, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 33, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1266, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 143, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1267, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1268, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1269, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 473, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1270, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 583, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1271, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 693, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1272, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 803, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1273, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 913, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1274, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1017, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1275, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1276, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1209, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1277, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1278, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1343, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1279, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1382, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1280, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1281, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 23, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1282, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 133, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1283, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1284, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1285, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 463, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1286, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 573, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1287, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 683, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1288, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 793, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1289, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 903, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1290, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1007, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1291, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1110, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1292, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1200, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1293, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1294, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1338, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1295, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1381, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1296, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1297, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 14, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1298, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 124, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1299, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 234, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1300, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 344, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1301, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 454, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1302, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 564, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1303, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 674, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1304, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 784, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1305, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 894, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1306, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 998, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1307, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1308, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1309, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1279, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1310, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1333, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1311, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1380, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1312, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1392, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1313, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 7, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1314, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1315, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1316, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1317, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 447, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1318, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 557, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1319, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 667, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1320, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 777, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1321, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 887, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1322, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 991, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1323, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1095, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1324, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1325, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1274, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1326, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1328, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1327, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1379, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1328, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1391, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1329, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 3, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1330, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 113, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1331, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 223, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1332, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1333, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 443, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1334, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 553, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1335, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 663, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1336, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 773, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1337, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 883, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1338, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 987, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1339, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1091, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1340, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1341, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1342, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1325, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1343, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1344, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1390, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1345, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1346, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 111, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1347, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 221, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1348, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 331, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1349, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 441, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1350, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 551, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1351, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 661, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1352, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 771, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1353, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 881, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1354, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 985, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1355, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1089, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1356, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1179, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1357, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1269, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1358, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1359, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1377, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1360, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 10, 1389, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1361, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 105, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1362, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1363, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 325, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1364, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 435, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1365, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 545, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1366, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 655, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1367, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 765, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1368, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 875, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1369, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 979, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1370, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1083, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1371, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1174, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1372, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1264, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1373, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1320, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1374, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1374, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1375, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 93, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1376, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 203, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1377, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1378, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 423, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1379, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 533, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1380, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 643, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1381, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 753, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1382, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 863, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1383, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 968, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1384, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1072, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1385, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1165, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1386, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1255, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1387, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1315, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1388, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 11, 1369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1389, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 81, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1390, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 191, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1391, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 301, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1392, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 411, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1393, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 521, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1394, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 631, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1395, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 741, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1396, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 851, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1397, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 957, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1398, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1061, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1399, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1156, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1400, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1246, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1401, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1310, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1402, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1364, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1403, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 69, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1404, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 179, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1405, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1406, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 399, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1407, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 509, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1408, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 619, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1409, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 729, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1410, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 839, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1411, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 946, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1412, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1050, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1413, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1147, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1414, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1237, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1415, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1305, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1416, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1417, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 57, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1418, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 167, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1419, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 277, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1420, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1421, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 497, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1422, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 607, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1423, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 717, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1424, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 827, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1425, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 935, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1426, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1039, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1427, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1138, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1428, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1228, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1429, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1300, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1430, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1354, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1431, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 45, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1432, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 155, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1433, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 265, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1434, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 375, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1435, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 485, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1436, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 595, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1437, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 705, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1438, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 815, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1439, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 924, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1440, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1028, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1441, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1442, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1219, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1443, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1444, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1445, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 34, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1446, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 144, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1447, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 254, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1448, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 364, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1449, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 474, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1450, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 584, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1451, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 694, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1452, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 804, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1453, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 914, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1454, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1018, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1455, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1120, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1456, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1210, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1457, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1290, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1458, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1344, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1459, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 24, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1460, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1461, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 244, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1462, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 354, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1463, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 464, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1464, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 574, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1465, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 684, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1466, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 794, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1467, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 904, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1468, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1008, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1469, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1111, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1470, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1201, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1471, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1285, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1472, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1339, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1473, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 15, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1474, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 125, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1475, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 235, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1476, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 345, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1477, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 455, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1478, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 565, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1479, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 675, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1480, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 785, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1481, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 895, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1482, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 999, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1483, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1103, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1484, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1193, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1485, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1280, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1486, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1334, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1487, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 8, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1488, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 118, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1489, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 228, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1490, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 338, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1491, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 448, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1492, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 558, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1493, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 668, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1494, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 778, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1495, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 888, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1496, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 992, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1497, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1096, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1498, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1186, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1499, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1275, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1500, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 11, 1329, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1501, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 103, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1502, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 213, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1503, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1504, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 433, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1505, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 543, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1506, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 653, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1507, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 763, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1508, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 873, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1509, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 978, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1510, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1082, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1511, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1512, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1513, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1514, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1515, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1516, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1517, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 91, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1518, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 201, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1519, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1520, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 421, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1521, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 531, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1522, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 641, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1523, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 751, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1524, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 861, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1525, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 967, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1526, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1071, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1527, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1164, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1528, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1254, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1529, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1530, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1368, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1531, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1532, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 12, 1399, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1533, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 79, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1534, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 189, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1535, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1536, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 409, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1537, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 519, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1538, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 629, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1539, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 739, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1540, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 849, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1541, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 956, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1542, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1060, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1543, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1155, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1544, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1545, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1546, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1547, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1386, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1548, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1549, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 67, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1550, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1551, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 287, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1552, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1553, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 507, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1554, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 617, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1555, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 727, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1556, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 837, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1557, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 945, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1558, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1049, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1559, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1146, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1560, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1236, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1561, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1304, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1562, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1358, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1563, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1385, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1564, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1397, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1565, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 55, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1566, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 165, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1567, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 275, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1568, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1569, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 495, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1570, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 605, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1571, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 715, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1572, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 825, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1573, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 934, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1574, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1038, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1575, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1576, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1227, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1577, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1578, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1353, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1579, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1580, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1581, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 43, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1582, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 153, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1583, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1584, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1585, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 483, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1586, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 593, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1587, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 703, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1588, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 813, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1589, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 923, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1590, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1027, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1591, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1128, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1592, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1218, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1593, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1294, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1594, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1348, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1595, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1596, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1597, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 33, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1598, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1599, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 253, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1600, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1601, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 473, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1602, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 583, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1603, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 693, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1604, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 803, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1605, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 913, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1606, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1017, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1607, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1119, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1608, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1609, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1610, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1343, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1611, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1382, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1612, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1394, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1613, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 23, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1614, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 133, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1615, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1616, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1617, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 463, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1618, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 573, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1619, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 683, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1620, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 793, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1621, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 903, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1622, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1007, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1623, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1110, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1624, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1200, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1625, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1626, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1338, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1627, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1628, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1393, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1629, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 14, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1630, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 124, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1631, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 234, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1632, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 344, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1633, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 454, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1634, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 564, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1635, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 674, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1636, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 784, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1637, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 894, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1638, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 998, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1639, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1640, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1192, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1641, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1279, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1642, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1333, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1643, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1380, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1644, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1392, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1645, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 7, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1646, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1647, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1648, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 337, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1649, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 447, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1650, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 557, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1651, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 667, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1652, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 777, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1653, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 887, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1654, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 991, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1655, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1095, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1656, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1657, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1274, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1658, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1328, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1659, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1379, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1660, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1391, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1661, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 3, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1662, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 113, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1663, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 223, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1664, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1665, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 443, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1666, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 553, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1667, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 663, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1668, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 773, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1669, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 883, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1670, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 987, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1671, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1091, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1672, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1673, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1271, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1674, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1325, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1675, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1676, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1390, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1677, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1678, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 111, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1679, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 221, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1680, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 331, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1681, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 441, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1682, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 551, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1683, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 661, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1684, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 771, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1685, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 881, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1686, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 985, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1687, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1089, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1688, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1179, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1689, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1269, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1690, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1323, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1691, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1377, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1692, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 12, 1389, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1693, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 104, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1694, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 214, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1695, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 324, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1696, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 434, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1697, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 544, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1698, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 654, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1699, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 764, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1700, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 874, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1701, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 92, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1702, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 202, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1703, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 312, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1704, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 422, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1705, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 532, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1706, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 642, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1707, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 752, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1708, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 862, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1709, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 80, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1710, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1711, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 300, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1712, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 410, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1713, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 520, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1714, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 630, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1715, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 740, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1716, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 850, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1717, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 68, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1718, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 178, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1719, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1720, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1721, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 508, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1722, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 618, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1723, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 728, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1724, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 838, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1725, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 56, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1726, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 166, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1727, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 276, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1728, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 386, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1729, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 496, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1730, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 606, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1731, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 716, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1732, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 826, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1733, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 44, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1734, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 154, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1735, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 264, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1736, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 374, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1737, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 484, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1738, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 594, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1739, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 704, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1740, '2026-03-08 01:56:51.000000', NULL, NULL, 158.00, 13, 814, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1741, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 106, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1742, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 216, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1743, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 326, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1744, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 436, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1745, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 546, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1746, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 656, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1747, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 766, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1748, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 876, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1749, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 980, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1750, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1084, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1751, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1175, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1752, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1265, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1753, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1321, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1754, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1375, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1755, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 94, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1756, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 204, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1757, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 314, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1758, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 424, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1759, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 534, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1760, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 644, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1761, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 754, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1762, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 864, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1763, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 969, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1764, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1073, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1765, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1166, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1766, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1256, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1767, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1316, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1768, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 14, 1370, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1769, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 82, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1770, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1771, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 302, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1772, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 412, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1773, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 522, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1774, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 632, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1775, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 742, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1776, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 852, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1777, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 958, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1778, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1062, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1779, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1157, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1780, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1247, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1781, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1782, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1365, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1783, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 70, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1784, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 180, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1785, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 290, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1786, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 400, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1787, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 510, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1788, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 620, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1789, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 730, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1790, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 840, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1791, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 947, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1792, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1051, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1793, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1148, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1794, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1238, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1795, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1306, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1796, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1360, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1797, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 58, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1798, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 168, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1799, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 278, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1800, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1801, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 498, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1802, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 608, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1803, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 718, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1804, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 828, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1805, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 936, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1806, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1040, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1807, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1139, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1808, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1809, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1301, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1810, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1355, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1811, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 46, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1812, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 156, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1813, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 266, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1814, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 376, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1815, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 486, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1816, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 596, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1817, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 706, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1818, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 816, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1819, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 925, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1820, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1029, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1821, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1130, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1822, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1220, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1823, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1296, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1824, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1350, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1825, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 35, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1826, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 145, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1827, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 255, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1828, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 365, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1829, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 475, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1830, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 585, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1831, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 695, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1832, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 805, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1833, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 915, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1834, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1019, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1835, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1121, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1836, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1211, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1837, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1291, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1838, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1345, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1839, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 25, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1840, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 135, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1841, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1842, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 355, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1843, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 465, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1844, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 575, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1845, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 685, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1846, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 795, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1847, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 905, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1848, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1009, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1849, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1112, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1850, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1202, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1851, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1286, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1852, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1340, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1853, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 16, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1854, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 126, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1855, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 236, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1856, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 346, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1857, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 456, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1858, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 566, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1859, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 676, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1860, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 786, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1861, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 896, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1862, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1000, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1863, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1104, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1864, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1194, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1865, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1281, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1866, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1867, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 9, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1868, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1869, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1870, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 339, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1871, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 449, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1872, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 559, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1873, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 669, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1874, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 779, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1875, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 889, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1876, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 993, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1877, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1097, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1878, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1187, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1879, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1276, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1880, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 14, 1330, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1881, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 106, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1882, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 216, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1883, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 326, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1884, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 436, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1885, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 546, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1886, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 656, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1887, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 766, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1888, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 876, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1889, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 980, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1890, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1084, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1891, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1175, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1892, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1265, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1893, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1321, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1894, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1375, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1895, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 94, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1896, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 204, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1897, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1898, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 424, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1899, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 534, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1900, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 644, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1901, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 754, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1902, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 864, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1903, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 969, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1904, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1073, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1905, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1166, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1906, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1256, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1907, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1316, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1908, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 15, 1370, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1909, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 82, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1910, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1911, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 302, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1912, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 412, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1913, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 522, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1914, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 632, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1915, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 742, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1916, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 852, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1917, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 958, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1918, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1062, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1919, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1157, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1920, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1247, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1921, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1922, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1365, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1923, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 70, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1924, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 180, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1925, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 290, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1926, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1927, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 510, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1928, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 620, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1929, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 730, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1930, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 840, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1931, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 947, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1932, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1051, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1933, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1148, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1934, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1238, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1935, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1306, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1936, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1360, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1937, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 58, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1938, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 168, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1939, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 278, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1940, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 388, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1941, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 498, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1942, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 608, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1943, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 718, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1944, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 828, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1945, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 936, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1946, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1040, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1947, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1948, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1949, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1301, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1950, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1355, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1951, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 46, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1952, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 156, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1953, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 266, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1954, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 376, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1955, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 486, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1956, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 596, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1957, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 706, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1958, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 816, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1959, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 925, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1960, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1029, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1961, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1130, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1962, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1220, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1963, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1296, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1964, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1350, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1965, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 35, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1966, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 145, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1967, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 255, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1968, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 365, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1969, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 475, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1970, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 585, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1971, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 695, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1972, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 805, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1973, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 915, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1974, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1019, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1975, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1121, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1976, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1211, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1977, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1291, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1978, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1345, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1979, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 25, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1980, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 135, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1981, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 245, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1982, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 355, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1983, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 465, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1984, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 575, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1985, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 685, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1986, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 795, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1987, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 905, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1988, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1009, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1989, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1112, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1990, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1202, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1991, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1286, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1992, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1340, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1993, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 16, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1994, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 126, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1995, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 236, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1996, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 346, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1997, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 456, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1998, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 566, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (1999, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 676, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2000, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 786, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2001, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 896, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2002, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1000, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2003, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1104, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2004, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1194, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2005, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1281, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2006, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2007, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 9, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2008, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2009, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2010, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 339, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2011, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 449, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2012, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 559, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2013, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 669, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2014, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 779, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2015, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 889, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2016, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 993, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2017, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1097, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2018, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1187, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2019, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1276, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2020, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 15, 1330, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2021, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2022, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 217, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2023, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 327, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2024, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 437, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2025, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 547, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2026, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 657, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2027, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 767, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2028, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 877, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2029, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 981, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2030, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1085, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2031, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1176, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2032, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1266, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2033, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 95, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2034, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 205, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2035, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 315, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2036, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 425, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2037, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 535, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2038, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 645, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2039, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 755, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2040, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 865, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2041, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 970, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2042, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1074, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2043, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1167, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2044, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1257, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2045, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 83, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2046, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 193, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2047, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 303, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2048, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 413, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2049, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 523, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2050, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 633, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2051, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 743, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2052, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 853, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2053, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 959, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2054, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1063, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2055, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1158, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2056, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1248, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2057, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 71, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2058, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2059, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 291, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2060, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 401, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2061, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 511, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2062, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 621, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2063, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 731, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2064, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 841, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2065, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 948, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2066, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1052, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2067, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1149, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2068, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2069, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 59, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2070, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 169, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2071, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 279, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2072, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 389, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2073, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 499, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2074, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 609, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2075, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 719, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2076, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 829, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2077, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 937, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2078, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1041, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2079, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1140, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2080, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1230, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2081, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 47, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2082, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 157, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2083, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 267, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2084, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 377, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2085, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 487, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2086, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 597, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2087, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 707, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2088, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 817, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2089, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 926, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2090, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1030, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2091, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1131, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2092, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1221, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2093, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 36, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2094, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 146, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2095, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 256, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2096, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 366, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2097, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 476, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2098, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 586, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2099, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 696, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2100, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 806, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2101, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 916, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2102, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1020, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2103, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2104, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1212, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2105, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 26, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2106, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 136, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2107, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 246, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2108, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 356, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2109, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 466, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2110, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 576, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2111, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 686, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2112, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 796, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2113, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 906, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2114, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1010, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2115, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1113, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2116, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 16, 1203, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2117, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2118, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2119, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2120, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2121, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2122, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2123, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2124, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 869, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2125, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2126, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2127, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2128, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2129, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2130, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2131, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 87, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2132, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2133, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2134, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2135, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2136, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 637, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2137, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 747, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2138, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2139, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2140, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2141, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2142, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2143, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2144, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 17, 1367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2145, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2146, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2147, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2148, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 405, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2149, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 515, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2150, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 625, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2151, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2152, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2153, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 952, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2154, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1056, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2155, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1152, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2156, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2157, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2158, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2159, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2160, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2161, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2162, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2163, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 503, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2164, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2165, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 723, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2166, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2167, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2168, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2169, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2170, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2171, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2172, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2173, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 51, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2174, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2175, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2176, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2177, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2178, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2179, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 711, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2180, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2181, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 930, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2182, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2183, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2184, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2185, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2186, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2187, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 39, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2188, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 149, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2189, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2190, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2191, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2192, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 589, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2193, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 699, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2194, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 809, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2195, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2196, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1023, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2197, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2198, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2199, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2200, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2201, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2202, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2203, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2204, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2205, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2206, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 579, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2207, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2208, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 799, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2209, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 909, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2210, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2211, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2212, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2213, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2214, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2215, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2216, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2217, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2218, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2219, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 459, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2220, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2221, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 679, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2222, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 789, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2223, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 899, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2224, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1003, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2225, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2226, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2227, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2228, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2229, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2230, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2231, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2232, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2233, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2234, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 562, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2235, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 672, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2236, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 782, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2237, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2238, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 996, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2239, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2240, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1190, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2241, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1278, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2242, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1332, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2243, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2244, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 115, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2245, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2246, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2247, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2248, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 555, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2249, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2250, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 775, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2251, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2252, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 989, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2253, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1093, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2254, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1183, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2255, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1273, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2256, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 17, 1327, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2257, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2258, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2259, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2260, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2261, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2262, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2263, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2264, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 869, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2265, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2266, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2267, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2268, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2269, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2270, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2271, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 87, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2272, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2273, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2274, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2275, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2276, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 637, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2277, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 747, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2278, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2279, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2280, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2281, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2282, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2283, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2284, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 18, 1367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2285, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2286, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2287, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2288, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 405, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2289, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 515, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2290, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 625, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2291, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2292, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2293, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 952, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2294, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1056, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2295, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1152, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2296, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2297, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2298, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2299, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2300, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2301, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2302, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2303, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 503, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2304, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2305, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 723, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2306, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2307, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2308, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2309, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2310, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2311, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2312, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2313, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 51, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2314, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2315, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2316, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2317, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2318, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2319, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 711, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2320, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2321, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 930, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2322, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2323, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2324, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2325, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2326, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2327, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 39, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2328, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 149, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2329, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2330, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2331, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2332, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 589, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2333, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 699, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2334, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 809, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2335, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2336, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1023, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2337, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2338, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2339, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2340, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2341, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2342, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2343, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2344, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2345, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2346, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 579, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2347, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2348, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 799, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2349, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 909, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2350, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2351, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2352, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2353, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2354, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2355, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2356, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2357, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2358, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2359, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 459, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2360, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2361, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 679, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2362, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 789, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2363, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 899, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2364, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1003, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2365, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2366, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2367, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2368, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2369, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2370, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2371, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2372, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2373, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2374, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 562, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2375, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2376, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 782, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2377, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2378, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 996, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2379, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2380, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2381, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1278, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2382, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1332, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2383, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2384, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 115, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2385, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2386, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2387, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2388, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 555, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2389, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2390, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 775, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2391, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2392, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 989, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2393, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1093, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2394, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1183, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2395, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1273, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2396, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 18, 1327, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2397, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 99, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2398, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2399, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2400, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 429, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2401, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 539, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2402, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 649, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2403, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 759, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2404, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 869, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2405, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 974, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2406, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1078, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2407, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2408, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2409, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1318, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2410, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1372, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2411, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 87, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2412, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2413, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 307, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2414, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 417, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2415, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 527, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2416, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 637, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2417, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 747, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2418, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 857, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2419, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 963, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2420, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1067, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2421, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2422, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2423, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1313, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2424, '2026-03-08 01:56:51.000000', NULL, NULL, 138.00, 19, 1367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2425, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 75, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2426, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2427, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 295, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2428, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 405, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2429, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 515, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2430, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 625, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2431, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 735, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2432, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 845, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2433, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 952, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2434, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1056, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2435, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1152, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2436, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1242, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2437, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2438, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1362, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2439, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 63, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2440, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2441, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2442, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2443, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 503, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2444, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 613, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2445, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 723, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2446, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 833, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2447, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 941, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2448, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1045, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2449, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2450, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2451, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1303, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2452, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2453, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 51, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2454, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 161, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2455, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2456, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2457, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 491, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2458, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 601, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2459, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 711, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2460, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 821, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2461, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 930, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2462, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1034, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2463, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1134, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2464, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1224, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2465, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1298, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2466, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1352, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2467, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 39, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2468, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 149, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2469, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 259, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2470, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 369, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2471, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 479, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2472, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 589, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2473, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 699, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2474, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 809, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2475, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 919, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2476, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1023, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2477, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1125, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2478, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1215, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2479, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1293, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2480, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2481, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 29, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2482, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2483, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2484, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 359, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2485, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 469, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2486, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 579, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2487, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 689, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2488, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 799, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2489, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 909, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2490, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1013, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2491, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2492, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2493, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1288, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2494, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2495, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 19, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2496, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 129, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2497, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 239, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2498, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 349, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2499, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 459, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2500, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 569, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2501, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 679, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2502, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 789, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2503, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 899, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2504, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1003, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2505, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1107, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2506, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1197, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2507, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1283, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2508, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2509, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 12, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2510, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 122, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2511, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 232, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2512, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 342, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2513, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 452, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2514, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 562, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2515, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 672, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2516, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 782, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2517, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 892, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2518, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 996, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2519, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2520, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1190, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2521, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1278, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2522, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1332, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2523, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 5, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2524, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 115, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2525, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2526, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2527, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 445, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2528, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 555, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2529, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 665, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2530, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 775, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2531, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 885, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2532, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 989, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2533, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1093, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2534, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1183, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2535, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1273, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2536, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 19, 1327, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2537, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 100, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2538, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 210, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2539, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 320, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2540, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 430, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2541, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 540, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2542, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 650, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2543, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 760, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2544, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 870, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2545, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 975, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2546, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1079, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2547, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1171, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2548, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1261, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2549, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 88, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2550, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 198, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2551, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 308, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2552, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 418, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2553, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 528, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2554, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 638, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2555, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 748, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2556, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 858, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2557, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 964, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2558, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1068, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2559, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1162, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2560, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1252, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2561, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 76, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2562, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 186, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2563, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 296, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2564, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 406, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2565, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 516, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2566, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 626, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2567, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 736, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2568, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 846, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2569, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 953, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2570, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1057, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2571, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1153, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2572, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2573, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 64, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2574, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 174, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2575, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2576, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2577, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 504, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2578, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 614, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2579, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 724, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2580, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 834, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2581, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 942, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2582, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1046, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2583, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1144, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2584, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1234, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2585, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 52, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2586, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 162, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2587, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 272, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2588, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 382, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2589, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 492, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2590, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 602, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2591, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 712, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2592, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 822, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2593, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 931, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2594, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1035, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2595, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1135, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2596, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1225, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2597, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 40, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2598, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 150, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2599, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 260, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2600, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 370, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2601, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 480, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2602, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 590, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2603, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 700, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2604, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 810, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2605, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 920, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2606, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1024, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2607, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1126, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2608, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1216, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2609, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 30, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2610, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 140, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2611, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 250, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2612, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 360, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2613, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 470, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2614, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 580, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2615, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 690, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2616, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 800, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2617, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 910, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2618, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1014, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2619, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2620, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1207, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2621, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 20, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2622, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 130, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2623, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 240, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2624, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 350, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2625, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 460, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2626, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 570, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2627, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 680, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2628, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 790, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2629, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 900, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2630, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1004, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2631, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1108, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2632, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 20, 1198, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2633, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 101, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2634, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 211, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2635, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 321, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2636, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 431, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2637, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 541, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2638, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 651, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2639, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 761, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2640, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 871, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2641, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 976, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2642, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1080, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2643, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1172, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2644, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1262, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2645, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 89, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2646, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 199, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2647, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2648, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 419, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2649, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 529, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2650, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 639, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2651, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 749, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2652, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 859, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2653, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 965, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2654, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1069, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2655, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1163, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2656, '2026-03-08 01:56:51.000000', NULL, NULL, 98.00, 21, 1253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2657, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 77, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2658, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 187, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2659, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 297, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2660, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 407, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2661, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 517, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2662, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 627, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2663, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 737, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2664, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 847, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2665, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 954, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2666, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1058, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2667, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1154, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2668, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1244, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2669, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 65, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2670, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 175, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2671, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 285, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2672, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2673, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 505, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2674, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 615, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2675, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 725, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2676, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 835, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2677, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 943, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2678, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1047, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2679, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1145, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2680, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1235, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2681, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 53, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2682, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 163, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2683, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 273, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2684, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2685, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 493, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2686, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 603, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2687, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 713, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2688, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 823, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2689, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 932, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2690, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1036, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2691, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1136, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2692, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1226, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2693, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 41, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2694, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 151, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2695, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 261, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2696, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 371, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2697, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 481, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2698, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 591, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2699, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 701, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2700, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 811, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2701, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 921, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2702, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1025, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2703, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1127, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2704, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1217, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2705, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 31, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2706, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 141, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2707, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 251, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2708, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 361, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2709, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 471, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2710, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 581, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2711, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 691, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2712, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 801, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2713, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 911, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2714, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1015, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2715, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1118, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2716, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1208, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2717, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 21, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2718, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 131, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2719, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 241, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2720, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 351, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2721, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 461, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2722, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 571, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2723, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 681, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2724, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 791, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2725, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 901, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2726, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1005, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2727, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1109, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2728, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1199, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2729, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 13, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2730, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 123, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2731, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 233, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2732, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2733, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 453, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2734, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 563, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2735, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 673, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2736, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 783, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2737, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 893, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2738, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 997, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2739, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1101, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2740, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1191, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2741, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 6, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2742, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 116, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2743, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 226, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2744, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 336, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2745, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 446, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2746, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 556, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2747, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 666, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2748, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 776, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2749, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 886, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2750, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 990, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2751, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1094, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2752, '2026-03-08 01:56:51.000000', NULL, NULL, 68.00, 21, 1184, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2753, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 103, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2754, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 213, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2755, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2756, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 433, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2757, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 543, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2758, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 653, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2759, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 763, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2760, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 873, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2761, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 978, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2762, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1082, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2763, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2764, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2765, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2766, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2767, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2768, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2769, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 91, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2770, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 201, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2771, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2772, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 421, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2773, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 531, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2774, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 641, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2775, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 751, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2776, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 861, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2777, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 967, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2778, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1071, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2779, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1164, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2780, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1254, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2781, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2782, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1368, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2783, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2784, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 22, 1399, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2785, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 79, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2786, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 189, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2787, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2788, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 409, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2789, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 519, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2790, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 629, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2791, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 739, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2792, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 849, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2793, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 956, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2794, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1060, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2795, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1155, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2796, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2797, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2798, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2799, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1386, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2800, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2801, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 67, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2802, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2803, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 287, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2804, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2805, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 507, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2806, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 617, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2807, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 727, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2808, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 837, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2809, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 945, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2810, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1049, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2811, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1146, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2812, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1236, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2813, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1304, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2814, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1358, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2815, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2816, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2817, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 55, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2818, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 165, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2819, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 275, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2820, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2821, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 495, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2822, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 605, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2823, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 715, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2824, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 825, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2825, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 934, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2826, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1038, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2827, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2828, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2829, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2830, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2831, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2832, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2833, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 43, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2834, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 153, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2835, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2836, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2837, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 483, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2838, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 593, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2839, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 703, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2840, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 813, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2841, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 923, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2842, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1027, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2843, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1128, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2844, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1218, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2845, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1294, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2846, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1348, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2847, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2848, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2849, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 33, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2850, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2851, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2852, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2853, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 473, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2854, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 583, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2855, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 693, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2856, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 803, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2857, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 913, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2858, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1017, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2859, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2860, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2861, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2862, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2863, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1382, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2864, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2865, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 23, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2866, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 133, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2867, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2868, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2869, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 463, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2870, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 573, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2871, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 683, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2872, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 793, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2873, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 903, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2874, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1007, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2875, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1110, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2876, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1200, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2877, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2878, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1338, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2879, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2880, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2881, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 14, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2882, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 124, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2883, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 234, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2884, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 344, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2885, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 454, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2886, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 564, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2887, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 674, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2888, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 784, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2889, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 894, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2890, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 998, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2891, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2892, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2893, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1279, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2894, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2895, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1380, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2896, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1392, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2897, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 7, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2898, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2899, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2900, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2901, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 447, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2902, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 557, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2903, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 667, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2904, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 777, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2905, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 887, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2906, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 991, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2907, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1095, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2908, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2909, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1274, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2910, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1328, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2911, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1379, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2912, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1391, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2913, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 3, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2914, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 113, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2915, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 223, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2916, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2917, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 443, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2918, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 553, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2919, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 663, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2920, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 773, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2921, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 883, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2922, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 987, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2923, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1091, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2924, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2925, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2926, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1325, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2927, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2928, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1390, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2929, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2930, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 111, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2931, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 221, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2932, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 331, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2933, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 441, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2934, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 551, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2935, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 661, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2936, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 771, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2937, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 881, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2938, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 985, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2939, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1089, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2940, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1179, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2941, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1269, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2942, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2943, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1377, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2944, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 22, 1389, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2945, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 103, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2946, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 213, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2947, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2948, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 433, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2949, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 543, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2950, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 653, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2951, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 763, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2952, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 873, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2953, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 978, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2954, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1082, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2955, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1173, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2956, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2957, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1319, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2958, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2959, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2960, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2961, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 91, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2962, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 201, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2963, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2964, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 421, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2965, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 531, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2966, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 641, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2967, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 751, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2968, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 861, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2969, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 967, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2970, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1071, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2971, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1164, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2972, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1254, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2973, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2974, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1368, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2975, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1387, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2976, '2026-03-08 01:56:51.000000', NULL, NULL, 118.00, 23, 1399, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2977, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 79, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2978, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 189, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2979, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2980, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 409, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2981, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 519, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2982, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 629, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2983, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 739, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2984, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 849, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2985, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 956, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2986, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1060, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2987, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1155, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2988, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2989, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1309, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2990, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2991, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1386, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2992, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1398, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2993, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 67, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2994, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2995, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 287, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2996, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2997, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 507, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2998, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 617, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (2999, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 727, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3000, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 837, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3001, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 945, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3002, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1049, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3003, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1146, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3004, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1236, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3005, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1304, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3006, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1358, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3007, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3008, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1397, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3009, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 55, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3010, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 165, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3011, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 275, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3012, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 385, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3013, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 495, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3014, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 605, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3015, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 715, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3016, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 825, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3017, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 934, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3018, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1038, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3019, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3020, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3021, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1299, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3022, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3023, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1384, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3024, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1396, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3025, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 43, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3026, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 153, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3027, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 263, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3028, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 373, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3029, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 483, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3030, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 593, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3031, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 703, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3032, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 813, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3033, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 923, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3034, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1027, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3035, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1128, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3036, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1218, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3037, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1294, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3038, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1348, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3039, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1383, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3040, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1395, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3041, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 33, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3042, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 143, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3043, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 253, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3044, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 363, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3045, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 473, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3046, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 583, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3047, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 693, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3048, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 803, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3049, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 913, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3050, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1017, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3051, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3052, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1209, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3053, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1289, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3054, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1343, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3055, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1382, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3056, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1394, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3057, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 23, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3058, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 133, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3059, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 243, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3060, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 353, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3061, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 463, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3062, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 573, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3063, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 683, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3064, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 793, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3065, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 903, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3066, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1007, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3067, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1110, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3068, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1200, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3069, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1284, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3070, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1338, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3071, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1381, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3072, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1393, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3073, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 14, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3074, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 124, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3075, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 234, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3076, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 344, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3077, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 454, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3078, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 564, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3079, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 674, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3080, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 784, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3081, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 894, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3082, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 998, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3083, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1102, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3084, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3085, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1279, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3086, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3087, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1380, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3088, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1392, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3089, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 7, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3090, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 117, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3091, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 227, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3092, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 337, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3093, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 447, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3094, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 557, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3095, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 667, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3096, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 777, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3097, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 887, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3098, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 991, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3099, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1095, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3100, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1185, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3101, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1274, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3102, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1328, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3103, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1379, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3104, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1391, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3105, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 3, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3106, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 113, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3107, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 223, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3108, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 333, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3109, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 443, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3110, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 553, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3111, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 663, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3112, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 773, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3113, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 883, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3114, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 987, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3115, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1091, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3116, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1181, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3117, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1271, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3118, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1325, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3119, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3120, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1390, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3121, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3122, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 111, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3123, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 221, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3124, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 331, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3125, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 441, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3126, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 551, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3127, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 661, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3128, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 771, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3129, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 881, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3130, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 985, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3131, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1089, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3132, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1179, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3133, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1269, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3134, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1323, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3135, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1377, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3136, '2026-03-08 01:56:51.000000', NULL, NULL, 78.00, 23, 1389, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3137, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 106, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3138, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 216, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3139, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 326, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3140, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 436, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3141, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 546, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3142, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 656, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3143, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 766, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3144, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 876, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3145, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 980, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3146, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1084, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3147, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1175, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3148, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1265, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3149, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1321, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3150, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1375, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3151, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 94, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3152, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 204, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3153, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 314, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3154, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 424, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3155, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 534, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3156, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 644, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3157, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 754, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3158, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 864, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3159, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 969, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3160, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1073, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3161, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1166, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3162, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1256, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3163, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1316, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3164, '2026-03-08 01:56:51.000000', NULL, NULL, 128.00, 24, 1370, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3165, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 82, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3166, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 192, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3167, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 302, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3168, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 412, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3169, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 522, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3170, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 632, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3171, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 742, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3172, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 852, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3173, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 958, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3174, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1062, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3175, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1157, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3176, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1247, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3177, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1311, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3178, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1365, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3179, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 70, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3180, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 180, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3181, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 290, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3182, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 400, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3183, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 510, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3184, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 620, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3185, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 730, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3186, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 840, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3187, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 947, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3188, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1051, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3189, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1148, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3190, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1238, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3191, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1306, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3192, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1360, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3193, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 58, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3194, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 168, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3195, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 278, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3196, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 388, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3197, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 498, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3198, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 608, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3199, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 718, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3200, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 828, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3201, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 936, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3202, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1040, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3203, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1139, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3204, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3205, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1301, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3206, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1355, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3207, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 46, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3208, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 156, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3209, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 266, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3210, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 376, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3211, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 486, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3212, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 596, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3213, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 706, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3214, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 816, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3215, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 925, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3216, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1029, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3217, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1130, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3218, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1220, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3219, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1296, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3220, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1350, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3221, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 35, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3222, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 145, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3223, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 255, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3224, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 365, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3225, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 475, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3226, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 585, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3227, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 695, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3228, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 805, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3229, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 915, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3230, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1019, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3231, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1121, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3232, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1211, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3233, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1291, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3234, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1345, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3235, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 25, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3236, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 135, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3237, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 245, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3238, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 355, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3239, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 465, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3240, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 575, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3241, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 685, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3242, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 795, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3243, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 905, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3244, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1009, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3245, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1112, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3246, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1202, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3247, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1286, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3248, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1340, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3249, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 16, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3250, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 126, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3251, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 236, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3252, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 346, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3253, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 456, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3254, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 566, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3255, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 676, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3256, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 786, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3257, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 896, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3258, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1000, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3259, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1104, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3260, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1194, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3261, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1281, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3262, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1335, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3263, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 9, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3264, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 119, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3265, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 229, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3266, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 339, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3267, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 449, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3268, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 559, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3269, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 669, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3270, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 779, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3271, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 889, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3272, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 993, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3273, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1097, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3274, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1187, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3275, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1276, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3276, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 24, 1330, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3277, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 108, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3278, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 218, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3279, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 328, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3280, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 438, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3281, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 548, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3282, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 658, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3283, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 768, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3284, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 878, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3285, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 982, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3286, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1086, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3287, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1177, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3288, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1267, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3289, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 96, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3290, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 206, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3291, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 316, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3292, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 426, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3293, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 536, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3294, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 646, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3295, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 756, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3296, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 866, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3297, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 971, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3298, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1075, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3299, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1168, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3300, '2026-03-08 01:56:51.000000', NULL, NULL, 88.00, 25, 1258, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3301, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 84, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3302, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 194, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3303, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 304, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3304, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 414, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3305, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 524, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3306, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 634, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3307, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 744, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3308, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 854, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3309, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 960, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3310, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1064, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3311, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1159, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3312, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1249, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3313, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 72, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3314, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 182, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3315, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 292, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3316, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 402, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3317, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 512, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3318, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 622, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3319, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 732, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3320, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 842, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3321, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 949, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3322, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1053, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3323, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1150, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3324, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1240, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3325, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 60, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3326, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 170, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3327, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 280, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3328, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 390, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3329, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 500, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3330, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 610, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3331, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 720, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3332, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 830, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3333, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 938, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3334, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1042, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3335, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1141, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3336, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1231, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3337, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 48, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3338, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 158, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3339, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 268, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3340, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 378, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3341, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 488, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3342, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 598, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3343, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 708, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3344, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 818, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3345, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 927, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3346, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1031, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3347, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1132, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3348, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1222, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3349, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 37, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3350, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 147, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3351, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 257, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3352, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 367, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3353, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 477, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3354, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 587, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3355, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 697, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3356, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 807, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3357, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 917, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3358, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1021, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3359, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1123, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3360, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1213, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3361, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 27, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3362, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 137, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3363, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 247, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3364, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 357, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3365, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 467, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3366, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 577, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3367, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 687, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3368, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 797, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3369, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 907, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3370, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1011, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3371, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1114, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3372, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1204, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3373, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 17, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3374, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 127, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3375, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 237, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3376, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 347, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3377, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 457, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3378, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 567, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3379, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 677, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3380, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 787, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3381, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 897, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3382, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1001, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3383, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1105, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3384, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1195, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3385, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 10, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3386, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 120, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3387, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 230, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3388, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 340, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3389, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 450, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3390, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 560, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3391, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 670, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3392, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 780, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3393, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 890, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3394, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 994, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3395, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1098, 0, '2026-03-08 01:56:51.000000');
INSERT INTO `schedule_seats` VALUES (3396, '2026-03-08 01:56:51.000000', NULL, NULL, 58.00, 25, 1188, 0, '2026-03-08 01:56:51.000000');

-- ----------------------------
-- Table structure for schedules
-- ----------------------------
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cinema_id` bigint NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `end_time` time(6) NOT NULL,
  `hall_id` bigint NOT NULL,
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `movie_id` bigint NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `show_date` date NOT NULL,
  `start_time` time(6) NOT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `vip_price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedules
-- ----------------------------
INSERT INTO `schedules` VALUES (1, 1, '2026-03-08 01:56:51.000000', 0, '12:53:00.000000', 1, '国语', 1, 88.00, '2026-03-14', '10:00:00.000000', 1, '2026-03-14 19:52:37.156402', 128.00);
INSERT INTO `schedules` VALUES (2, 1, '2026-03-08 01:56:51.000000', 0, '17:23:00.000000', 1, '国语', 1, 88.00, '2026-03-17', '14:30:00.000000', 1, '2026-03-08 01:56:51.000000', 128.00);
INSERT INTO `schedules` VALUES (3, 1, '2026-03-08 01:56:51.000000', 0, '21:53:00.000000', 1, '国语', 1, 98.00, '2026-03-17', '19:00:00.000000', 1, '2026-03-08 01:56:51.000000', 138.00);
INSERT INTO `schedules` VALUES (4, 1, '2026-03-08 01:56:51.000000', 0, '15:53:00.000000', 2, '国语', 1, 108.00, '2026-03-17', '13:00:00.000000', 1, '2026-03-08 01:56:51.000000', NULL);
INSERT INTO `schedules` VALUES (5, 1, '2026-03-08 01:56:51.000000', 0, '22:53:00.000000', 3, '国语', 1, 78.00, '2026-03-16', '20:00:00.000000', 1, '2026-03-08 01:56:51.000000', 108.00);
INSERT INTO `schedules` VALUES (6, 1, '2026-03-08 01:56:51.000000', 0, '12:50:00.000000', 1, '国语', 2, 68.00, '2026-03-16', '11:00:00.000000', 1, '2026-03-08 01:56:51.000000', 98.00);
INSERT INTO `schedules` VALUES (7, 1, '2026-03-08 01:56:51.000000', 0, '17:20:00.000000', 3, '国语', 2, 68.00, '2026-03-16', '15:30:00.000000', 1, '2026-03-08 01:56:51.000000', 98.00);
INSERT INTO `schedules` VALUES (8, 1, '2026-03-08 01:56:51.000000', 0, '21:20:00.000000', 4, '国语', 2, 58.00, '2026-03-16', '19:30:00.000000', 1, '2026-03-08 01:56:51.000000', NULL);
INSERT INTO `schedules` VALUES (9, 2, '2026-03-08 01:56:51.000000', 0, '13:26:00.000000', 5, '国语', 3, 78.00, '2026-03-16', '10:30:00.000000', 1, '2026-03-08 01:56:51.000000', 118.00);
INSERT INTO `schedules` VALUES (10, 2, '2026-03-08 01:56:51.000000', 0, '16:56:00.000000', 5, '国语', 3, 78.00, '2026-03-16', '14:00:00.000000', 1, '2026-03-08 01:56:51.000000', 118.00);
INSERT INTO `schedules` VALUES (11, 2, '2026-03-08 01:56:51.000000', 0, '21:26:00.000000', 7, '国语', 3, 68.00, '2026-03-16', '18:30:00.000000', 1, '2026-03-08 01:56:51.000000', 98.00);
INSERT INTO `schedules` VALUES (12, 2, '2026-03-08 01:56:51.000000', 0, '13:58:00.000000', 5, '国语', 4, 88.00, '2026-03-16', '11:30:00.000000', 1, '2026-03-08 01:56:51.000000', 128.00);
INSERT INTO `schedules` VALUES (13, 2, '2026-03-08 01:56:51.000000', 0, '17:28:00.000000', 6, '国语', 4, 158.00, '2026-03-15', '15:00:00.000000', 1, '2026-03-08 01:56:51.000000', NULL);
INSERT INTO `schedules` VALUES (14, 3, '2026-03-08 01:56:51.000000', 0, '12:08:00.000000', 8, '国语', 5, 58.00, '2026-03-15', '10:00:00.000000', 1, '2026-03-08 01:56:51.000000', 88.00);
INSERT INTO `schedules` VALUES (15, 3, '2026-03-08 01:56:51.000000', 0, '15:38:00.000000', 8, '国语', 5, 58.00, '2026-03-15', '13:30:00.000000', 1, '2026-03-08 01:56:51.000000', 88.00);
INSERT INTO `schedules` VALUES (16, 3, '2026-03-08 01:56:51.000000', 0, '19:08:00.000000', 9, '国语', 5, 68.00, '2026-03-15', '17:00:00.000000', 1, '2026-03-08 01:56:51.000000', NULL);
INSERT INTO `schedules` VALUES (17, 1, '2026-03-08 01:56:51.000000', 0, '12:53:00.000000', 1, '国语', 1, 88.00, '2026-03-15', '10:00:00.000000', 1, '2026-03-08 01:56:51.000000', 128.00);
INSERT INTO `schedules` VALUES (18, 1, '2026-03-08 01:56:51.000000', 0, '17:23:00.000000', 1, '国语', 1, 88.00, '2026-03-14', '14:30:00.000000', 1, '2026-03-08 01:56:51.000000', 128.00);
INSERT INTO `schedules` VALUES (19, 1, '2026-03-08 01:56:51.000000', 0, '21:53:00.000000', 1, '国语', 1, 98.00, '2026-03-14', '19:00:00.000000', 1, '2026-03-08 01:56:51.000000', 138.00);
INSERT INTO `schedules` VALUES (20, 1, '2026-03-08 01:56:51.000000', 0, '12:50:00.000000', 2, '国语', 2, 78.00, '2026-03-14', '11:00:00.000000', 1, '2026-03-08 01:56:51.000000', NULL);
INSERT INTO `schedules` VALUES (21, 1, '2026-03-08 01:56:51.000000', 0, '17:20:00.000000', 3, '国语', 2, 68.00, '2026-03-14', '15:30:00.000000', 1, '2026-03-08 01:56:51.000000', 98.00);
INSERT INTO `schedules` VALUES (22, 2, '2026-03-08 01:56:51.000000', 0, '13:26:00.000000', 5, '国语', 3, 78.00, '2026-03-14', '10:30:00.000000', 1, '2026-03-08 01:56:51.000000', 118.00);
INSERT INTO `schedules` VALUES (23, 2, '2026-03-08 01:56:51.000000', 0, '16:56:00.000000', 5, '国语', 3, 78.00, '2026-03-14', '14:00:00.000000', 1, '2026-03-08 01:56:51.000000', 118.00);
INSERT INTO `schedules` VALUES (24, 3, '2026-03-08 01:56:51.000000', 0, '13:58:00.000000', 8, '国语', 4, 88.00, '2026-03-14', '11:30:00.000000', 1, '2026-03-08 01:56:51.000000', 128.00);
INSERT INTO `schedules` VALUES (25, 4, '2026-03-08 01:56:51.000000', 0, '12:08:00.000000', 10, '国语', 5, 58.00, '2026-03-14', '10:00:00.000000', 1, '2026-03-08 01:56:51.000000', 88.00);

-- ----------------------------
-- Table structure for seats
-- ----------------------------
DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `col_num` int NOT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `hall_id` bigint NOT NULL,
  `row_num` int NOT NULL,
  `seat_label` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `seat_type` int NOT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UKadsqgkgyt9fiajiui5bqbmy7b`(`hall_id` ASC, `row_num` ASC, `col_num` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1401 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats
-- ----------------------------
INSERT INTO `seats` VALUES (1, 1, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (2, 1, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (3, 1, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (4, 1, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (5, 1, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (6, 1, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (7, 1, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (8, 1, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (9, 1, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (10, 1, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (11, 1, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (12, 1, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (13, 1, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (14, 1, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (15, 1, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (16, 1, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (17, 1, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (18, 1, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (19, 1, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (20, 1, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (21, 1, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (22, 1, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (23, 1, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (24, 1, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (25, 1, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (26, 1, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (27, 1, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (28, 1, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (29, 1, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (30, 1, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (31, 1, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (32, 1, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (33, 1, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (34, 1, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (35, 1, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (36, 1, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (37, 1, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (38, 1, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (39, 1, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (40, 1, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (41, 1, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (42, 1, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (43, 1, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (44, 1, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (45, 1, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (46, 1, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (47, 1, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (48, 1, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (49, 1, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (50, 1, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (51, 1, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (52, 1, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (53, 1, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (54, 1, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (55, 1, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (56, 1, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (57, 1, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (58, 1, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (59, 1, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (60, 1, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (61, 1, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (62, 1, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (63, 1, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (64, 1, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (65, 1, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (66, 1, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (67, 1, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (68, 1, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (69, 1, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (70, 1, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (71, 1, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (72, 1, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (73, 1, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (74, 1, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (75, 1, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (76, 1, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (77, 1, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (78, 1, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (79, 1, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (80, 1, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (81, 1, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (82, 1, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (83, 1, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (84, 1, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (85, 1, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (86, 1, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C1', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (87, 1, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (88, 1, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (89, 1, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (90, 1, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (91, 1, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (92, 1, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (93, 1, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (94, 1, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (95, 1, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (96, 1, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (97, 1, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (98, 1, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (99, 1, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (100, 1, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (101, 1, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (102, 1, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (103, 1, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (104, 1, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (105, 1, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (106, 1, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (107, 1, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (108, 1, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (109, 1, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (110, 1, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A1', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (111, 2, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (112, 2, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (113, 2, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (114, 2, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (115, 2, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (116, 2, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (117, 2, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (118, 2, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (119, 2, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (120, 2, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (121, 2, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (122, 2, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (123, 2, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (124, 2, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (125, 2, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (126, 2, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (127, 2, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (128, 2, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (129, 2, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (130, 2, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (131, 2, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (132, 2, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (133, 2, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (134, 2, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (135, 2, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (136, 2, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (137, 2, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (138, 2, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (139, 2, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (140, 2, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (141, 2, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (142, 2, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (143, 2, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (144, 2, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (145, 2, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (146, 2, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (147, 2, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (148, 2, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (149, 2, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (150, 2, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (151, 2, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (152, 2, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (153, 2, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (154, 2, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (155, 2, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (156, 2, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (157, 2, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (158, 2, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (159, 2, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (160, 2, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (161, 2, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (162, 2, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (163, 2, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (164, 2, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (165, 2, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (166, 2, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (167, 2, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (168, 2, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (169, 2, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (170, 2, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (171, 2, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (172, 2, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (173, 2, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (174, 2, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (175, 2, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (176, 2, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (177, 2, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (178, 2, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (179, 2, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (180, 2, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (181, 2, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (182, 2, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (183, 2, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (184, 2, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (185, 2, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (186, 2, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (187, 2, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (188, 2, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (189, 2, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (190, 2, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (191, 2, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (192, 2, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (193, 2, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (194, 2, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (195, 2, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (196, 2, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C2', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (197, 2, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (198, 2, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (199, 2, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (200, 2, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (201, 2, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (202, 2, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (203, 2, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (204, 2, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (205, 2, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (206, 2, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (207, 2, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (208, 2, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (209, 2, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (210, 2, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (211, 2, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (212, 2, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (213, 2, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (214, 2, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (215, 2, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (216, 2, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (217, 2, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (218, 2, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (219, 2, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (220, 2, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A2', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (221, 3, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (222, 3, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (223, 3, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (224, 3, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (225, 3, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (226, 3, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (227, 3, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (228, 3, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (229, 3, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (230, 3, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (231, 3, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (232, 3, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (233, 3, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (234, 3, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (235, 3, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (236, 3, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (237, 3, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (238, 3, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (239, 3, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (240, 3, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (241, 3, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (242, 3, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (243, 3, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (244, 3, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (245, 3, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (246, 3, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (247, 3, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (248, 3, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (249, 3, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (250, 3, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (251, 3, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (252, 3, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (253, 3, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (254, 3, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (255, 3, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (256, 3, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (257, 3, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (258, 3, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (259, 3, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (260, 3, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (261, 3, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (262, 3, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (263, 3, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (264, 3, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (265, 3, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (266, 3, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (267, 3, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (268, 3, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (269, 3, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (270, 3, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (271, 3, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (272, 3, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (273, 3, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (274, 3, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (275, 3, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (276, 3, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (277, 3, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (278, 3, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (279, 3, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (280, 3, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (281, 3, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (282, 3, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (283, 3, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (284, 3, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (285, 3, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (286, 3, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (287, 3, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (288, 3, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (289, 3, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (290, 3, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (291, 3, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (292, 3, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (293, 3, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (294, 3, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (295, 3, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (296, 3, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (297, 3, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (298, 3, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (299, 3, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (300, 3, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (301, 3, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (302, 3, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (303, 3, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (304, 3, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (305, 3, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (306, 3, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C3', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (307, 3, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (308, 3, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (309, 3, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (310, 3, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (311, 3, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (312, 3, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (313, 3, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (314, 3, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (315, 3, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (316, 3, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (317, 3, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (318, 3, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (319, 3, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (320, 3, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (321, 3, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (322, 3, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (323, 3, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (324, 3, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (325, 3, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (326, 3, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (327, 3, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (328, 3, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (329, 3, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (330, 3, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A3', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (331, 4, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (332, 4, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (333, 4, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (334, 4, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (335, 4, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (336, 4, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (337, 4, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (338, 4, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (339, 4, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (340, 4, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (341, 4, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (342, 4, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (343, 4, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (344, 4, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (345, 4, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (346, 4, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (347, 4, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (348, 4, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (349, 4, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (350, 4, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (351, 4, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (352, 4, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (353, 4, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (354, 4, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (355, 4, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (356, 4, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (357, 4, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (358, 4, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (359, 4, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (360, 4, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (361, 4, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (362, 4, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (363, 4, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (364, 4, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (365, 4, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (366, 4, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (367, 4, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (368, 4, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (369, 4, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (370, 4, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (371, 4, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (372, 4, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (373, 4, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (374, 4, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (375, 4, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (376, 4, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (377, 4, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (378, 4, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (379, 4, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (380, 4, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (381, 4, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (382, 4, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (383, 4, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (384, 4, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (385, 4, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (386, 4, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (387, 4, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (388, 4, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (389, 4, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (390, 4, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (391, 4, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (392, 4, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (393, 4, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (394, 4, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (395, 4, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (396, 4, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (397, 4, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (398, 4, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (399, 4, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (400, 4, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (401, 4, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (402, 4, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (403, 4, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (404, 4, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (405, 4, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (406, 4, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (407, 4, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (408, 4, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (409, 4, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (410, 4, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (411, 4, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (412, 4, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (413, 4, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (414, 4, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (415, 4, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (416, 4, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C4', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (417, 4, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (418, 4, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (419, 4, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (420, 4, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (421, 4, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (422, 4, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (423, 4, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (424, 4, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (425, 4, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (426, 4, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (427, 4, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (428, 4, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (429, 4, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (430, 4, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (431, 4, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (432, 4, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (433, 4, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (434, 4, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (435, 4, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (436, 4, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (437, 4, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (438, 4, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (439, 4, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (440, 4, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A4', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (441, 5, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (442, 5, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (443, 5, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (444, 5, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (445, 5, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (446, 5, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (447, 5, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (448, 5, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (449, 5, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (450, 5, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (451, 5, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (452, 5, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (453, 5, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (454, 5, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (455, 5, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (456, 5, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (457, 5, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (458, 5, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (459, 5, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (460, 5, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (461, 5, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (462, 5, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (463, 5, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (464, 5, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (465, 5, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (466, 5, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (467, 5, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (468, 5, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (469, 5, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (470, 5, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (471, 5, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (472, 5, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (473, 5, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (474, 5, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (475, 5, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (476, 5, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (477, 5, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (478, 5, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (479, 5, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (480, 5, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (481, 5, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (482, 5, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (483, 5, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (484, 5, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (485, 5, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (486, 5, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (487, 5, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (488, 5, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (489, 5, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (490, 5, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (491, 5, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (492, 5, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (493, 5, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (494, 5, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (495, 5, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (496, 5, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (497, 5, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (498, 5, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (499, 5, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (500, 5, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (501, 5, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (502, 5, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E5', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (503, 5, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (504, 5, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (505, 5, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (506, 5, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (507, 5, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (508, 5, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (509, 5, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (510, 5, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (511, 5, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (512, 5, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (513, 5, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (514, 5, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (515, 5, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (516, 5, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (517, 5, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (518, 5, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (519, 5, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (520, 5, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (521, 5, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (522, 5, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (523, 5, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (524, 5, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (525, 5, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (526, 5, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C5', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (527, 5, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (528, 5, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (529, 5, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (530, 5, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (531, 5, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (532, 5, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (533, 5, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (534, 5, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (535, 5, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (536, 5, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (537, 5, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (538, 5, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (539, 5, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (540, 5, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (541, 5, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (542, 5, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (543, 5, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (544, 5, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (545, 5, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (546, 5, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (547, 5, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (548, 5, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (549, 5, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (550, 5, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A5', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (551, 6, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (552, 6, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (553, 6, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (554, 6, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (555, 6, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (556, 6, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (557, 6, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (558, 6, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (559, 6, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (560, 6, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (561, 6, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (562, 6, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (563, 6, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (564, 6, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (565, 6, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (566, 6, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (567, 6, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (568, 6, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (569, 6, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (570, 6, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (571, 6, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (572, 6, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (573, 6, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (574, 6, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (575, 6, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (576, 6, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (577, 6, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (578, 6, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (579, 6, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (580, 6, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (581, 6, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (582, 6, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (583, 6, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (584, 6, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (585, 6, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (586, 6, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (587, 6, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (588, 6, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (589, 6, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (590, 6, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (591, 6, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (592, 6, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (593, 6, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (594, 6, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (595, 6, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (596, 6, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (597, 6, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (598, 6, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (599, 6, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (600, 6, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (601, 6, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (602, 6, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (603, 6, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (604, 6, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (605, 6, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (606, 6, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (607, 6, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (608, 6, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (609, 6, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (610, 6, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (611, 6, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (612, 6, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E6', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (613, 6, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (614, 6, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (615, 6, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (616, 6, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (617, 6, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (618, 6, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (619, 6, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (620, 6, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (621, 6, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (622, 6, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (623, 6, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (624, 6, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (625, 6, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (626, 6, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (627, 6, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (628, 6, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (629, 6, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (630, 6, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (631, 6, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (632, 6, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (633, 6, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (634, 6, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (635, 6, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (636, 6, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C6', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (637, 6, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (638, 6, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (639, 6, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (640, 6, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (641, 6, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (642, 6, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (643, 6, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (644, 6, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (645, 6, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (646, 6, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (647, 6, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (648, 6, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (649, 6, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (650, 6, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (651, 6, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (652, 6, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (653, 6, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (654, 6, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (655, 6, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (656, 6, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (657, 6, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (658, 6, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (659, 6, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (660, 6, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A6', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (661, 7, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (662, 7, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (663, 7, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (664, 7, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (665, 7, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (666, 7, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (667, 7, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (668, 7, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (669, 7, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (670, 7, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (671, 7, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (672, 7, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (673, 7, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (674, 7, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (675, 7, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (676, 7, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (677, 7, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (678, 7, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (679, 7, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (680, 7, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (681, 7, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (682, 7, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (683, 7, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (684, 7, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (685, 7, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (686, 7, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (687, 7, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (688, 7, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (689, 7, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (690, 7, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (691, 7, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (692, 7, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (693, 7, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (694, 7, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (695, 7, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (696, 7, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (697, 7, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (698, 7, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (699, 7, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (700, 7, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (701, 7, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (702, 7, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (703, 7, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (704, 7, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (705, 7, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (706, 7, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (707, 7, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (708, 7, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (709, 7, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (710, 7, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (711, 7, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (712, 7, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (713, 7, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (714, 7, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (715, 7, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (716, 7, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (717, 7, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (718, 7, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (719, 7, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (720, 7, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (721, 7, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (722, 7, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E7', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (723, 7, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (724, 7, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (725, 7, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (726, 7, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (727, 7, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (728, 7, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (729, 7, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (730, 7, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (731, 7, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (732, 7, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (733, 7, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (734, 7, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (735, 7, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (736, 7, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (737, 7, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (738, 7, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (739, 7, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (740, 7, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (741, 7, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (742, 7, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (743, 7, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (744, 7, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (745, 7, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (746, 7, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C7', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (747, 7, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (748, 7, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (749, 7, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (750, 7, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (751, 7, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (752, 7, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (753, 7, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (754, 7, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (755, 7, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (756, 7, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (757, 7, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (758, 7, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (759, 7, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (760, 7, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (761, 7, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (762, 7, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (763, 7, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (764, 7, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (765, 7, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (766, 7, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (767, 7, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (768, 7, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (769, 7, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (770, 7, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A7', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (771, 8, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (772, 8, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (773, 8, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (774, 8, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (775, 8, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (776, 8, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (777, 8, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (778, 8, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (779, 8, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (780, 8, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (781, 8, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (782, 8, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (783, 8, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (784, 8, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (785, 8, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (786, 8, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (787, 8, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (788, 8, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (789, 8, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (790, 8, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (791, 8, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (792, 8, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (793, 8, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (794, 8, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (795, 8, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (796, 8, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (797, 8, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (798, 8, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (799, 8, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (800, 8, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (801, 8, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (802, 8, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (803, 8, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (804, 8, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (805, 8, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (806, 8, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (807, 8, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (808, 8, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (809, 8, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (810, 8, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (811, 8, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (812, 8, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (813, 8, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (814, 8, '2026-03-08 01:56:51.000000', 0, 6, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (815, 8, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (816, 8, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (817, 8, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (818, 8, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (819, 8, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (820, 8, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (821, 8, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (822, 8, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (823, 8, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (824, 8, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (825, 8, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (826, 8, '2026-03-08 01:56:51.000000', 0, 6, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (827, 8, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (828, 8, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (829, 8, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (830, 8, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (831, 8, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (832, 8, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E8', 1, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (833, 8, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (834, 8, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (835, 8, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (836, 8, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (837, 8, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (838, 8, '2026-03-08 01:56:51.000000', 0, 6, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (839, 8, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (840, 8, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (841, 8, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (842, 8, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (843, 8, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (844, 8, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (845, 8, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (846, 8, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (847, 8, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (848, 8, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (849, 8, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (850, 8, '2026-03-08 01:56:51.000000', 0, 6, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (851, 8, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (852, 8, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (853, 8, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (854, 8, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (855, 8, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (856, 8, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C8', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (857, 8, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (858, 8, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (859, 8, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (860, 8, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (861, 8, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (862, 8, '2026-03-08 01:56:51.000000', 0, 6, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (863, 8, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (864, 8, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (865, 8, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (866, 8, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (867, 8, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (868, 8, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (869, 8, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (870, 8, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (871, 8, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (872, 8, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (873, 8, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (874, 8, '2026-03-08 01:56:51.000000', 0, 6, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (875, 8, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (876, 8, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (877, 8, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (878, 8, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (879, 8, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (880, 8, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A8', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (881, 9, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (882, 9, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (883, 9, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (884, 9, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (885, 9, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (886, 9, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (887, 9, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (888, 9, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (889, 9, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (890, 9, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (891, 9, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (892, 9, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (893, 9, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (894, 9, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (895, 9, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (896, 9, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (897, 9, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (898, 9, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (899, 9, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (900, 9, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (901, 9, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (902, 9, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (903, 9, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (904, 9, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (905, 9, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (906, 9, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (907, 9, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (908, 9, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (909, 9, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (910, 9, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (911, 9, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (912, 9, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (913, 9, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (914, 9, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (915, 9, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (916, 9, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (917, 9, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (918, 9, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (919, 9, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (920, 9, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (921, 9, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (922, 9, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (923, 9, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (924, 9, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (925, 9, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (926, 9, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (927, 9, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (928, 9, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (929, 9, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (930, 9, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (931, 9, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (932, 9, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (933, 9, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (934, 9, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (935, 9, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (936, 9, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (937, 9, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (938, 9, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (939, 9, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (940, 9, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (941, 9, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (942, 9, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (943, 9, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (944, 9, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (945, 9, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (946, 9, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (947, 9, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (948, 9, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (949, 9, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (950, 9, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (951, 9, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (952, 9, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (953, 9, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (954, 9, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (955, 9, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (956, 9, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (957, 9, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (958, 9, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (959, 9, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (960, 9, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (961, 9, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (962, 9, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C9', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (963, 9, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (964, 9, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (965, 9, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (966, 9, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (967, 9, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (968, 9, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (969, 9, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (970, 9, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (971, 9, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (972, 9, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (973, 9, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (974, 9, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (975, 9, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (976, 9, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (977, 9, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (978, 9, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (979, 9, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (980, 9, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (981, 9, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (982, 9, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (983, 9, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (984, 9, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A9', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (985, 10, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (986, 10, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (987, 10, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (988, 10, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (989, 10, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (990, 10, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (991, 10, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (992, 10, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (993, 10, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (994, 10, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (995, 10, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (996, 10, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (997, 10, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (998, 10, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (999, 10, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1000, 10, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1001, 10, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1002, 10, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1003, 10, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1004, 10, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1005, 10, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1006, 10, '2026-03-08 01:56:51.000000', 0, 4, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1007, 10, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1008, 10, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1009, 10, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1010, 10, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1011, 10, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1012, 10, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1013, 10, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1014, 10, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1015, 10, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1016, 10, '2026-03-08 01:56:51.000000', 0, 4, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1017, 10, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1018, 10, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1019, 10, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1020, 10, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1021, 10, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1022, 10, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1023, 10, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1024, 10, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1025, 10, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1026, 10, '2026-03-08 01:56:51.000000', 0, 4, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1027, 10, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1028, 10, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1029, 10, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1030, 10, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1031, 10, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1032, 10, '2026-03-08 01:56:51.000000', 0, 11, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1033, 10, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1034, 10, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1035, 10, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1036, 10, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1037, 10, '2026-03-08 01:56:51.000000', 0, 4, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1038, 10, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1039, 10, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1040, 10, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1041, 10, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1042, 10, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1043, 10, '2026-03-08 01:56:51.000000', 0, 11, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1044, 10, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1045, 10, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1046, 10, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1047, 10, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1048, 10, '2026-03-08 01:56:51.000000', 0, 4, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1049, 10, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1050, 10, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1051, 10, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1052, 10, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1053, 10, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1054, 10, '2026-03-08 01:56:51.000000', 0, 11, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1055, 10, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1056, 10, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1057, 10, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1058, 10, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1059, 10, '2026-03-08 01:56:51.000000', 0, 4, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1060, 10, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1061, 10, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1062, 10, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1063, 10, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1064, 10, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1065, 10, '2026-03-08 01:56:51.000000', 0, 11, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1066, 10, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C10', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1067, 10, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1068, 10, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1069, 10, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1070, 10, '2026-03-08 01:56:51.000000', 0, 4, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1071, 10, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1072, 10, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1073, 10, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1074, 10, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1075, 10, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1076, 10, '2026-03-08 01:56:51.000000', 0, 11, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1077, 10, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1078, 10, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1079, 10, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1080, 10, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1081, 10, '2026-03-08 01:56:51.000000', 0, 4, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1082, 10, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1083, 10, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1084, 10, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1085, 10, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1086, 10, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1087, 10, '2026-03-08 01:56:51.000000', 0, 11, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1088, 10, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A10', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1089, 11, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1090, 11, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1091, 11, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1092, 11, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1093, 11, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1094, 11, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1095, 11, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1096, 11, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1097, 11, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1098, 11, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1099, 11, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1100, 11, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1101, 11, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1102, 11, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1103, 11, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1104, 11, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1105, 11, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1106, 11, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1107, 11, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1108, 11, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1109, 11, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1110, 11, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1111, 11, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1112, 11, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1113, 11, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1114, 11, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1115, 11, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1116, 11, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1117, 11, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1118, 11, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1119, 11, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1120, 11, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1121, 11, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1122, 11, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1123, 11, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1124, 11, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1125, 11, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1126, 11, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1127, 11, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1128, 11, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1129, 11, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1130, 11, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1131, 11, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1132, 11, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1133, 11, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1134, 11, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1135, 11, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1136, 11, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1137, 11, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1138, 11, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1139, 11, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1140, 11, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1141, 11, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1142, 11, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1143, 11, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1144, 11, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1145, 11, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1146, 11, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1147, 11, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1148, 11, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1149, 11, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1150, 11, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1151, 11, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1152, 11, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1153, 11, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1154, 11, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1155, 11, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1156, 11, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1157, 11, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1158, 11, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1159, 11, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1160, 11, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C11', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1161, 11, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1162, 11, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1163, 11, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1164, 11, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1165, 11, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1166, 11, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1167, 11, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1168, 11, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1169, 11, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1170, 11, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1171, 11, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1172, 11, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1173, 11, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1174, 11, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1175, 11, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1176, 11, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1177, 11, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1178, 11, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A11', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1179, 12, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1180, 12, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1181, 12, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1182, 12, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1183, 12, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1184, 12, '2026-03-08 01:56:51.000000', 0, 3, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1185, 12, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1186, 12, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1187, 12, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1188, 12, '2026-03-08 01:56:51.000000', 0, 10, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1189, 12, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1190, 12, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1191, 12, '2026-03-08 01:56:51.000000', 0, 3, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1192, 12, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1193, 12, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1194, 12, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1195, 12, '2026-03-08 01:56:51.000000', 0, 10, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1196, 12, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1197, 12, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1198, 12, '2026-03-08 01:56:51.000000', 0, 2, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1199, 12, '2026-03-08 01:56:51.000000', 0, 3, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1200, 12, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1201, 12, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1202, 12, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1203, 12, '2026-03-08 01:56:51.000000', 0, 9, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1204, 12, '2026-03-08 01:56:51.000000', 0, 10, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1205, 12, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1206, 12, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1207, 12, '2026-03-08 01:56:51.000000', 0, 2, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1208, 12, '2026-03-08 01:56:51.000000', 0, 3, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1209, 12, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1210, 12, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1211, 12, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1212, 12, '2026-03-08 01:56:51.000000', 0, 9, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1213, 12, '2026-03-08 01:56:51.000000', 0, 10, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1214, 12, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1215, 12, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1216, 12, '2026-03-08 01:56:51.000000', 0, 2, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1217, 12, '2026-03-08 01:56:51.000000', 0, 3, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1218, 12, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1219, 12, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1220, 12, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1221, 12, '2026-03-08 01:56:51.000000', 0, 9, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1222, 12, '2026-03-08 01:56:51.000000', 0, 10, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1223, 12, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1224, 12, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1225, 12, '2026-03-08 01:56:51.000000', 0, 2, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1226, 12, '2026-03-08 01:56:51.000000', 0, 3, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1227, 12, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1228, 12, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1229, 12, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1230, 12, '2026-03-08 01:56:51.000000', 0, 9, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1231, 12, '2026-03-08 01:56:51.000000', 0, 10, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1232, 12, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1233, 12, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1234, 12, '2026-03-08 01:56:51.000000', 0, 2, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1235, 12, '2026-03-08 01:56:51.000000', 0, 3, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1236, 12, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1237, 12, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1238, 12, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1239, 12, '2026-03-08 01:56:51.000000', 0, 9, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1240, 12, '2026-03-08 01:56:51.000000', 0, 10, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1241, 12, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1242, 12, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1243, 12, '2026-03-08 01:56:51.000000', 0, 2, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1244, 12, '2026-03-08 01:56:51.000000', 0, 3, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1245, 12, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1246, 12, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1247, 12, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1248, 12, '2026-03-08 01:56:51.000000', 0, 9, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1249, 12, '2026-03-08 01:56:51.000000', 0, 10, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1250, 12, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C12', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1251, 12, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1252, 12, '2026-03-08 01:56:51.000000', 0, 2, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1253, 12, '2026-03-08 01:56:51.000000', 0, 3, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1254, 12, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1255, 12, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1256, 12, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1257, 12, '2026-03-08 01:56:51.000000', 0, 9, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1258, 12, '2026-03-08 01:56:51.000000', 0, 10, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1259, 12, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1260, 12, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1261, 12, '2026-03-08 01:56:51.000000', 0, 2, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1262, 12, '2026-03-08 01:56:51.000000', 0, 3, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1263, 12, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1264, 12, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1265, 12, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1266, 12, '2026-03-08 01:56:51.000000', 0, 9, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1267, 12, '2026-03-08 01:56:51.000000', 0, 10, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1268, 12, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A12', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1269, 13, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1270, 13, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1271, 13, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1272, 13, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1273, 13, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1274, 13, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1275, 13, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1276, 13, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1277, 13, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1278, 13, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1279, 13, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1280, 13, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1281, 13, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1282, 13, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1283, 13, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1284, 13, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1285, 13, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1286, 13, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1287, 13, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1288, 13, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1289, 13, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1290, 13, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1291, 13, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1292, 13, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1293, 13, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1294, 13, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1295, 13, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1296, 13, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1297, 13, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1298, 13, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1299, 13, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1300, 13, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1301, 13, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1302, 13, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1303, 13, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1304, 13, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1305, 13, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1306, 13, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1307, 13, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1308, 13, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1309, 13, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1310, 13, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1311, 13, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1312, 13, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C13', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1313, 13, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1314, 13, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1315, 13, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1316, 13, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1317, 13, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1318, 13, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1319, 13, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1320, 13, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1321, 13, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1322, 13, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A13', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1323, 14, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1324, 14, '2026-03-08 01:56:51.000000', 0, 12, 12, 'L14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1325, 14, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1326, 14, '2026-03-08 01:56:51.000000', 0, 12, 11, 'K14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1327, 14, '2026-03-08 01:56:51.000000', 0, 1, 10, 'J14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1328, 14, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1329, 14, '2026-03-08 01:56:51.000000', 0, 7, 10, 'J14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1330, 14, '2026-03-08 01:56:51.000000', 0, 8, 10, 'J14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1331, 14, '2026-03-08 01:56:51.000000', 0, 12, 10, 'J14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1332, 14, '2026-03-08 01:56:51.000000', 0, 1, 9, 'I14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1333, 14, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1334, 14, '2026-03-08 01:56:51.000000', 0, 7, 9, 'I14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1335, 14, '2026-03-08 01:56:51.000000', 0, 8, 9, 'I14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1336, 14, '2026-03-08 01:56:51.000000', 0, 12, 9, 'I14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1337, 14, '2026-03-08 01:56:51.000000', 0, 1, 8, 'H14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1338, 14, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1339, 14, '2026-03-08 01:56:51.000000', 0, 7, 8, 'H14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1340, 14, '2026-03-08 01:56:51.000000', 0, 8, 8, 'H14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1341, 14, '2026-03-08 01:56:51.000000', 0, 12, 8, 'H14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1342, 14, '2026-03-08 01:56:51.000000', 0, 1, 7, 'G14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1343, 14, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1344, 14, '2026-03-08 01:56:51.000000', 0, 7, 7, 'G14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1345, 14, '2026-03-08 01:56:51.000000', 0, 8, 7, 'G14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1346, 14, '2026-03-08 01:56:51.000000', 0, 12, 7, 'G14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1347, 14, '2026-03-08 01:56:51.000000', 0, 1, 6, 'F14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1348, 14, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1349, 14, '2026-03-08 01:56:51.000000', 0, 7, 6, 'F14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1350, 14, '2026-03-08 01:56:51.000000', 0, 8, 6, 'F14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1351, 14, '2026-03-08 01:56:51.000000', 0, 12, 6, 'F14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1352, 14, '2026-03-08 01:56:51.000000', 0, 1, 5, 'E14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1353, 14, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1354, 14, '2026-03-08 01:56:51.000000', 0, 7, 5, 'E14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1355, 14, '2026-03-08 01:56:51.000000', 0, 8, 5, 'E14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1356, 14, '2026-03-08 01:56:51.000000', 0, 12, 5, 'E14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1357, 14, '2026-03-08 01:56:51.000000', 0, 1, 4, 'D14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1358, 14, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1359, 14, '2026-03-08 01:56:51.000000', 0, 7, 4, 'D14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1360, 14, '2026-03-08 01:56:51.000000', 0, 8, 4, 'D14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1361, 14, '2026-03-08 01:56:51.000000', 0, 12, 4, 'D14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1362, 14, '2026-03-08 01:56:51.000000', 0, 1, 3, 'C14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1363, 14, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1364, 14, '2026-03-08 01:56:51.000000', 0, 7, 3, 'C14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1365, 14, '2026-03-08 01:56:51.000000', 0, 8, 3, 'C14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1366, 14, '2026-03-08 01:56:51.000000', 0, 12, 3, 'C14', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1367, 14, '2026-03-08 01:56:51.000000', 0, 1, 2, 'B14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1368, 14, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1369, 14, '2026-03-08 01:56:51.000000', 0, 7, 2, 'B14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1370, 14, '2026-03-08 01:56:51.000000', 0, 8, 2, 'B14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1371, 14, '2026-03-08 01:56:51.000000', 0, 12, 2, 'B14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1372, 14, '2026-03-08 01:56:51.000000', 0, 1, 1, 'A14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1373, 14, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1374, 14, '2026-03-08 01:56:51.000000', 0, 7, 1, 'A14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1375, 14, '2026-03-08 01:56:51.000000', 0, 8, 1, 'A14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1376, 14, '2026-03-08 01:56:51.000000', 0, 12, 1, 'A14', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1377, 15, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1378, 15, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1379, 15, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1380, 15, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1381, 15, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1382, 15, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1383, 15, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1384, 15, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1385, 15, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1386, 15, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C15', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1387, 15, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B15', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1388, 15, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A15', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1389, 16, '2026-03-08 01:56:51.000000', 0, 5, 12, 'L16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1390, 16, '2026-03-08 01:56:51.000000', 0, 5, 11, 'K16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1391, 16, '2026-03-08 01:56:51.000000', 0, 5, 10, 'J16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1392, 16, '2026-03-08 01:56:51.000000', 0, 5, 9, 'I16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1393, 16, '2026-03-08 01:56:51.000000', 0, 5, 8, 'H16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1394, 16, '2026-03-08 01:56:51.000000', 0, 5, 7, 'G16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1395, 16, '2026-03-08 01:56:51.000000', 0, 5, 6, 'F16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1396, 16, '2026-03-08 01:56:51.000000', 0, 5, 5, 'E16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1397, 16, '2026-03-08 01:56:51.000000', 0, 5, 4, 'D16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1398, 16, '2026-03-08 01:56:51.000000', 0, 5, 3, 'C16', 0, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1399, 16, '2026-03-08 01:56:51.000000', 0, 5, 2, 'B16', 2, 1, '2026-03-08 01:56:51.000000');
INSERT INTO `seats` VALUES (1400, 16, '2026-03-08 01:56:51.000000', 0, 5, 1, 'A16', 2, 1, '2026-03-08 01:56:51.000000');

-- ----------------------------
-- Table structure for snacks
-- ----------------------------
DROP TABLE IF EXISTS `snacks`;
CREATE TABLE `snacks`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `original_price` decimal(10, 2) NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `sales` int NOT NULL,
  `sort_order` int NULL DEFAULT NULL,
  `status` int NOT NULL,
  `stock` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of snacks
-- ----------------------------
INSERT INTO `snacks` VALUES (1, 'popcorn', '2026-03-08 01:56:51.000000', 0, '香脆可口的经典原味爆米花', 'https://picsum.photos/seed/popcorn1/400/400', '经典原味爆米花（小）', 30.00, 25.00, 2580, 1, 1, 500, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (2, 'popcorn', '2026-03-08 01:56:51.000000', 0, '超大份经典原味爆米花', 'https://picsum.photos/seed/popcorn2/400/400', '经典原味爆米花（大）', 40.00, 35.00, 1680, 2, 1, 300, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (3, 'popcorn', '2026-03-08 01:56:51.000000', 0, '甜蜜焦糖包裹的爆米花', 'https://picsum.photos/seed/popcorn3/400/400', '焦糖爆米花', 38.00, 32.00, 980, 3, 1, 400, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (4, 'drink', '2026-03-08 01:56:51.000000', 0, '冰镇可口可乐 500ml', 'https://picsum.photos/seed/drink1/400/400', '可口可乐（中杯）', 18.00, 15.00, 3580, 4, 1, 800, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (5, 'drink', '2026-03-08 01:56:51.000000', 0, '冰镇可口可乐 800ml', 'https://picsum.photos/seed/drink2/400/400', '可口可乐（大杯）', 25.00, 20.00, 2180, 5, 1, 600, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (6, 'drink', '2026-03-08 01:56:51.000000', 0, '清爽雪碧 500ml', 'https://picsum.photos/seed/drink3/400/400', '雪碧（中杯）', 18.00, 15.00, 1280, 6, 1, 500, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (7, 'drink', '2026-03-08 01:56:51.000000', 0, '鲜榨橙汁 400ml', 'https://picsum.photos/seed/drink4/400/400', '橙汁', 22.00, 18.00, 680, 7, 1, 300, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (8, 'combo', '2026-03-08 01:56:51.000000', 0, '大份爆米花+中杯可乐', 'https://picsum.photos/seed/combo1/400/400', '爆米花+可乐套餐', 48.00, 38.00, 3280, 8, 1, 200, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (9, 'combo', '2026-03-08 01:56:51.000000', 0, '2份爆米花+2杯可乐', 'https://picsum.photos/seed/combo2/400/400', '双人套餐', 80.00, 68.00, 1580, 9, 1, 150, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (10, 'combo', '2026-03-08 01:56:51.000000', 0, '3份爆米花+3杯可乐+1份薯条', 'https://picsum.photos/seed/combo3/400/400', '家庭套餐', 120.00, 98.00, 680, 10, 1, 100, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (11, 'snack', '2026-03-08 01:56:51.000000', 0, '香脆薯条', 'https://picsum.photos/seed/snack1/400/400', '薯条', 22.00, 18.00, 890, 11, 1, 400, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (12, 'snack', '2026-03-08 01:56:51.000000', 0, '美味烤肠', 'https://picsum.photos/seed/snack2/400/400', '烤肠', 15.00, 12.00, 1280, 12, 1, 500, '2026-03-08 01:56:51.000000');
INSERT INTO `snacks` VALUES (13, 'drink', '2026-03-09 23:01:30.098931', 1, '1', NULL, '1', NULL, 10.00, 0, NULL, 1, 10, '2026-03-09 23:01:30.101982');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `config_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_npsxm1erd0lbetjn5d3ayrsof`(`config_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'cinemaName', 'string', '佳悦影院', '2026-03-09 23:33:45.000000', '影院名称', 'basic', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (2, 'contactPhone', 'string', '400-888-8888', '2026-03-09 23:33:45.000000', '联系电话', 'basic', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (3, 'businessHours', 'string', '09:00-23:00', '2026-03-09 23:33:45.000000', '营业时间', 'basic', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (4, 'address', 'string', '北京市朝阳区建国路93号', '2026-03-09 23:33:45.000000', '地址', 'basic', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (5, 'orderTimeout', 'number', '15', '2026-03-09 23:33:45.000000', '订单超时时间(分钟)', 'order', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (6, 'maxSeatCount', 'number', '4', '2026-03-09 23:33:45.000000', '最大选座数', 'order', '2026-03-09 23:33:45.000000');
INSERT INTO `system_config` VALUES (7, 'pointRule', 'string', '每消费1元获得1积分', '2026-03-09 23:33:45.000000', '积分规则', 'member', '2026-03-09 23:33:45.000000');

-- ----------------------------
-- Table structure for system_logs
-- ----------------------------
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `duration` bigint NULL DEFAULT NULL,
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `operation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `result` int NULL DEFAULT NULL,
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_logs
-- ----------------------------
INSERT INTO `system_logs` VALUES (1, '2026-03-08 01:56:51.000000', 120, NULL, '192.168.1.100', 'POST', 'auth', '管理员登录', '{\"username\":\"admin\"}', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (2, '2026-02-26 01:56:51.000000', 85, NULL, '192.168.1.100', 'POST', 'movie', '新增电影：流浪地球2', '{\"movie_id\":1}', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (3, '2026-02-26 01:56:51.000000', 95, NULL, '192.168.1.100', 'POST', 'cinema', '新增影院：佳悦影院中关村店', '{\"cinema_id\":1}', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (4, '2026-02-27 01:56:51.000000', 110, NULL, '192.168.1.100', 'POST', 'schedule', '新增排片：流浪地球2 10:00场', '{\"schedule_id\":1}', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (5, '2026-03-08 01:56:51.000000', 98, NULL, '192.168.1.101', 'POST', 'auth', '员工登录', '{\"username\":\"staff001\"}', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (6, '2026-03-08 01:56:51.000000', 105, NULL, '192.168.1.102', 'POST', 'auth', '用户登录', '{\"username\":\"zhangsan\"}', 1, 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) Safari/604.1', 4, 'zhangsan');
INSERT INTO `system_logs` VALUES (7, '2026-03-03 01:56:51.000000', 156, NULL, '192.168.1.102', 'POST', 'order', '创建订单：JY202501010001', '{\"order_id\":1}', 1, 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) Safari/604.1', 4, 'zhangsan');
INSERT INTO `system_logs` VALUES (8, '2026-03-11 21:17:35.666414', 220, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/AnnouncementMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.AnnouncementMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO announcements  ( title, content, type,  is_top, view_count, status, publish_time, created_at, updated_at )  VALUES (  ?, ?, ?,  ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (9, '2026-03-11 21:17:41.587455', 4, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/AnnouncementMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.AnnouncementMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO announcements  ( title, content, type,  is_top, view_count, status, publish_time, created_at, updated_at )  VALUES (  ?, ?, ?,  ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (10, '2026-03-11 21:22:46.265647', 4, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/AnnouncementMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.AnnouncementMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO announcements  ( title, content, type,  is_top, view_count, status, publish_time, created_at, updated_at )  VALUES (  ?, ?, ?,  ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (11, '2026-03-11 21:23:14.220235', 103, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (12, '2026-03-11 21:23:39.030589', 16, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'snack', 'snack修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (13, '2026-03-11 21:23:46.244395', 13, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'snack', 'snack修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (14, '2026-03-11 21:26:26.421134', 17, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'schedule', 'schedule修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (15, '2026-03-11 21:26:30.699082', 11, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'schedule', 'schedule修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (16, '2026-03-11 21:27:26.693485', 189, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/CinemaMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.CinemaMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO cinemas  ( name, address, phone,  facilities,    status, created_at, updated_at )  VALUES (  ?, ?, ?,  ?,    ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'cinema', 'cinema新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (17, '2026-03-11 21:27:28.585613', 4, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/CinemaMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.CinemaMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO cinemas  ( name, address, phone,  facilities,    status, created_at, updated_at )  VALUES (  ?, ?, ?,  ?,    ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'cinema', 'cinema新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (18, '2026-03-11 21:27:31.855240', 4, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/CinemaMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.CinemaMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO cinemas  ( name, address, phone,  facilities,    status, created_at, updated_at )  VALUES (  ?, ?, ?,  ?,    ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'cinema', 'cinema新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (19, '2026-03-11 21:31:38.991030', 20, NULL, '0:0:0:0:0:0:0:1', 'POST', 'cinema', 'cinema新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (20, '2026-03-11 21:31:42.601210', 20, NULL, '0:0:0:0:0:0:0:1', 'DELETE', 'cinema', 'cinema删除', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (21, '2026-03-11 23:18:18.442515', 111, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (22, '2026-03-11 23:18:26.376724', 98, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (23, '2026-03-11 23:22:05.955105', 41, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (24, '2026-03-11 23:22:11.180331', 43, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (25, '2026-03-11 23:23:27.332424', 9, NULL, '0:0:0:0:0:0:0:1', 'DELETE', 'other', 'other删除', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (26, '2026-03-11 23:28:18.909478', 40, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (27, '2026-03-11 23:28:23.837034', 31, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (28, '2026-03-11 23:36:06.948216', 34, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (29, '2026-03-11 23:36:11.886795', 34, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (30, '2026-03-14 13:52:42.151104', 60, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (31, '2026-03-14 13:53:02.368221', 8, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (32, '2026-03-14 13:53:04.318719', 4, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (33, '2026-03-14 13:53:08.521109', 8, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (34, '2026-03-14 13:53:12.635482', 4, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (35, '2026-03-14 13:53:13.210924', 9, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (36, '2026-03-14 13:53:19.707015', 4, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (37, '2026-03-14 13:53:24.798590', 5, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (38, '2026-03-14 14:18:16.598453', 49, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (39, '2026-03-14 14:18:26.686088', 7, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (40, '2026-03-14 14:18:31.832581', 4, '场次不存在', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (41, '2026-03-14 14:25:40.856189', 267, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'cinema_id\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/OrderMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.OrderMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO orders  ( order_no, user_id,       movie_title,  seat_count, total_amount, ticket_amount, snack_amount, discount_amount, pay_amount,   status, ticketed,   expire_time,  created_at, updated_at, deleted )  VALUES (  ?, ?,       ?,  ?, ?, ?, ?, ?, ?,   ?, ?,   ?,  ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'cinema_id\' doesn\'t have a default value\n; Field \'cinema_id\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (42, '2026-03-14 14:31:19.509282', 260, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'schedule_id\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/OrderMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.OrderMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO orders  ( order_no, user_id,   cinema_id, cinema_name, hall_id, hall_name, movie_title,  seat_count, total_amount, ticket_amount, snack_amount, discount_amount, pay_amount,   status, ticketed,   expire_time,  created_at, updated_at, deleted )  VALUES (  ?, ?,   ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?, ?,   ?, ?,   ?,  ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'schedule_id\' doesn\'t have a default value\n; Field \'schedule_id\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (43, '2026-03-14 14:31:38.354606', 12, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'schedule_id\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/OrderMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.OrderMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO orders  ( order_no, user_id,   cinema_id, cinema_name, hall_id, hall_name, movie_title,  seat_count, total_amount, ticket_amount, snack_amount, discount_amount, pay_amount,   status, ticketed,   expire_time,  created_at, updated_at, deleted )  VALUES (  ?, ?,   ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?, ?,   ?, ?,   ?,  ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'schedule_id\' doesn\'t have a default value\n; Field \'schedule_id\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (44, '2026-03-14 14:38:52.807892', 67, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (45, '2026-03-14 14:39:05.708773', 75, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (46, '2026-03-14 14:40:49.662913', 9, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (47, '2026-03-14 14:59:21.218821', 12, NULL, '0:0:0:0:0:0:0:1', 'DELETE', 'movie', 'movie删除', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (48, '2026-03-14 19:10:50.361564', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (49, '2026-03-14 19:10:51.265012', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (50, '2026-03-14 19:10:54.206237', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (51, '2026-03-14 19:10:56.690445', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (52, '2026-03-14 19:46:45.277590', 52, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (53, '2026-03-14 19:46:52.698944', 68, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (54, '2026-03-14 19:52:24.682190', 15, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (55, '2026-03-14 19:52:27.830624', 9, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (56, '2026-03-14 19:52:37.161293', 9, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'schedule', 'schedule修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (57, '2026-03-14 20:33:43.086904', 89, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (58, '2026-03-14 20:33:55.084800', 94, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (59, '2026-03-14 20:34:03.528596', 53, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (60, '2026-03-14 20:34:09.597471', 28, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (61, '2026-03-14 22:38:28.541795', 97, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (62, '2026-03-14 22:39:04.961034', 61, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (63, '2026-03-14 22:39:08.564664', 66, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (64, '2026-03-14 22:39:10.407329', 16, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (65, '2026-03-14 23:08:46.352535', 103, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (66, '2026-03-14 23:08:51.063577', 55, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (67, '2026-03-14 23:14:22.780889', 112, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (68, '2026-03-14 23:14:28.019440', 49, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (69, '2026-03-14 23:14:47.189894', 50, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (70, '2026-03-14 23:14:52.050711', 8, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=alipay', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (71, '2026-03-14 23:14:54.998718', 1, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (72, '2026-03-14 23:15:06.707831', 1, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=wechat', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (73, '2026-03-14 23:15:13.304068', 3, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (74, '2026-03-14 23:15:35.488847', 2, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (75, '2026-03-14 23:17:23.886499', 227, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (76, '2026-03-14 23:18:03.339559', 27, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (77, '2026-03-14 23:18:33.866833', 55, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (78, '2026-03-14 23:18:37.793292', 43, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (79, '2026-03-14 23:25:23.003705', 46, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (80, '2026-03-14 23:25:42.108552', 21, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (81, '2026-03-14 23:37:38.636255', 30, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (82, '2026-03-14 23:51:16.711085', 28, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'other', 'other修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (83, '2026-03-14 23:51:46.851941', 194, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'5\' for key \'coupons.PRIMARY\'\r\n### The error may exist in com/jiayue/cinema/mapper/CouponMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.CouponMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO coupons  ( id, name, type, discount_type, discount_value, min_amount, total_count, received_count, used_count, valid_days, start_time, end_time, status, description, created_at, updated_at )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'5\' for key \'coupons.PRIMARY\'\n; Duplicate entry \'5\' for key \'coupons.PRIMARY\'', '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (84, '2026-03-14 23:52:04.807177', 7, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'other', 'other修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (85, '2026-03-14 23:52:18.925837', 5, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'5\' for key \'coupons.PRIMARY\'\r\n### The error may exist in com/jiayue/cinema/mapper/CouponMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.CouponMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO coupons  ( id, name, type, discount_type, discount_value, min_amount, total_count, received_count, used_count, valid_days, start_time, end_time, status, description, created_at, updated_at )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'5\' for key \'coupons.PRIMARY\'\n; Duplicate entry \'5\' for key \'coupons.PRIMARY\'', '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (86, '2026-03-15 00:02:13.269708', 88, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (87, '2026-03-15 00:02:41.910991', 13, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (88, '2026-03-15 00:03:28.693118', 7, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (89, '2026-03-15 12:57:36.029674', 51, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (90, '2026-03-15 12:57:58.206505', 5, '请选择座位', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (91, '2026-03-15 12:58:04.369242', 4, '请选择座位', '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (92, '2026-03-15 13:06:17.165403', 122, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (93, '2026-03-15 13:06:26.945802', 78, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=alipay', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (94, '2026-03-15 13:14:48.118859', 33, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (95, '2026-03-15 13:15:07.448375', 35, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (96, '2026-03-15 13:15:12.901357', 76, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (97, '2026-03-15 13:15:21.420973', 22, NULL, '0:0:0:0:0:0:0:1', 'POST', 'other', 'other新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (98, '2026-03-15 13:23:21.403700', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (99, '2026-03-15 13:23:26.162902', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (100, '2026-03-15 13:30:26.662976', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (101, '2026-03-15 13:33:15.102217', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (102, '2026-03-15 13:33:38.241538', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (103, '2026-03-15 13:42:46.118841', 0, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (104, '2026-03-15 13:54:50.966795', 196, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\r\n### The error may exist in com/jiayue/cinema/mapper/MovieReviewMapper.java (best guess)\r\n### The error may involve com.jiayue.cinema.mapper.MovieReviewMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO movie_reviews  ( movie_id, user_id, rating, content, likes, status, created_at, updated_at )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLException: Field \'deleted\' doesn\'t have a default value\n; Field \'deleted\' doesn\'t have a default value', '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (105, '2026-03-15 13:59:26.528144', 75, NULL, '0:0:0:0:0:0:0:1', 'POST', 'movie', 'movie新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (106, '2026-03-15 14:04:42.983528', 19, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (107, '2026-03-15 14:04:52.248806', 7, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (108, '2026-03-15 14:05:11.922398', 13, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (109, '2026-03-15 14:05:17.593671', 6, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (110, '2026-03-15 14:05:28.515448', 12, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (111, '2026-03-15 14:05:37.570504', 9, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (112, '2026-03-15 14:05:51.760461', 7, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (113, '2026-03-15 14:05:59.471986', 7, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (114, '2026-03-15 14:06:13.452352', 8, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (115, '2026-03-15 14:06:23.222164', 8, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (116, '2026-03-15 14:06:34.691127', 13, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'movie', 'movie修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (117, '2026-03-15 14:25:10.901222', 25, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (118, '2026-03-15 14:36:15.412428', 17, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'user', 'user修改', 'status=0', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');
INSERT INTO `system_logs` VALUES (119, '2026-03-15 14:48:07.217259', 77, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (120, '2026-03-15 14:48:11.342139', 68, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', 'payType=balance', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 10, 'dengj');
INSERT INTO `system_logs` VALUES (121, '2026-03-15 14:48:58.009174', 4, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (122, '2026-03-15 14:49:34.927365', 8, NULL, '0:0:0:0:0:0:0:1', 'POST', 'order', 'order新增', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 2, 'staff001');
INSERT INTO `system_logs` VALUES (123, '2026-03-15 16:53:55.418002', 26, NULL, '0:0:0:0:0:0:0:1', 'PUT', 'member', 'member修改', '', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1, 'admin');

-- ----------------------------
-- Table structure for user_coupons
-- ----------------------------
DROP TABLE IF EXISTS `user_coupons`;
CREATE TABLE `user_coupons`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `coupon_id` bigint NOT NULL COMMENT '优惠券ID',
  `coupon_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券名称',
  `type` tinyint NOT NULL COMMENT '类型',
  `discount_type` tinyint NOT NULL COMMENT '优惠类型',
  `discount_value` decimal(10, 2) NOT NULL COMMENT '优惠值',
  `min_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最低消费金额',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: 0-未使用 1-已使用 2-已过期',
  `receive_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `order_id` bigint NULL DEFAULT NULL COMMENT '使用的订单ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_coupon_id`(`coupon_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_coupons
-- ----------------------------
INSERT INTO `user_coupons` VALUES (1, 10, 1, '新用户专享券', 1, 1, 10.00, 50.00, 1, '2026-03-14 14:18:17', '2026-03-14 23:18:38', '2026-04-13 14:18:17', 27, '2026-03-14 14:18:16', '2026-03-14 14:18:16');
INSERT INTO `user_coupons` VALUES (2, 10, 5, '经典原味爆米花（大）', 1, 1, 10.00, 0.00, 1, '2026-03-14 23:37:39', '2026-03-15 13:15:13', '2026-03-29 23:37:39', 29, '2026-03-14 23:37:38', '2026-03-15 13:16:06');
INSERT INTO `user_coupons` VALUES (3, 10, 5, '经典原味爆米花（大）', 1, 1, 35.00, 0.00, 1, '2026-03-15 12:57:36', '2026-03-15 13:06:27', '2026-03-30 12:57:36', 28, '2026-03-15 12:57:36', '2026-03-15 13:16:06');
INSERT INTO `user_coupons` VALUES (4, 10, 5, '经典原味爆米花（大）', 1, 1, 35.00, 0.00, 0, '2026-03-15 13:15:21', NULL, '2026-03-30 13:15:21', NULL, '2026-03-15 13:15:21', '2026-03-15 13:15:58');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `balance` decimal(10, 2) NOT NULL,
  `birthday` date NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT NULL,
  `deleted` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` int NULL DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` int NOT NULL,
  `status` int NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_r43af9ap4edm43mmtq01oddj6`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'https://ui-avatars.com/api/?name=Admin&background=4a9ff5&color=fff&size=150', 0.00, NULL, '2026-03-08 01:56:51.000000', 0, 'admin@jiayue.com', 0, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13800000001', '系统管理员', 2, 1, '2026-03-08 01:56:51.000000', 'admin');
INSERT INTO `users` VALUES (2, 'https://ui-avatars.com/api/?name=XL&background=e8b84b&color=fff&size=150', 0.00, NULL, '2026-03-08 01:56:51.000000', 0, 'staff001@jiayue.com', 1, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13800000002', '员工小李', 1, 1, '2026-03-08 01:56:51.000000', 'staff001');
INSERT INTO `users` VALUES (3, 'https://ui-avatars.com/api/?name=XW&background=4caf82&color=fff&size=150', 0.00, NULL, '2026-03-08 01:56:51.000000', 0, 'staff002@jiayue.com', 2, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13800000003', '员工小王', 1, 1, '2026-03-08 01:56:51.000000', 'staff002');
INSERT INTO `users` VALUES (4, 'https://ui-avatars.com/api/?name=ZS&background=667eea&color=fff&size=150', 500.00, NULL, '2026-03-08 01:56:51.000000', 0, 'zhangsan@qq.com', 1, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13912345678', '张三', 0, 1, '2026-03-08 01:56:51.000000', 'zhangsan');
INSERT INTO `users` VALUES (5, 'https://ui-avatars.com/api/?name=LS&background=f093fb&color=fff&size=150', 200.00, NULL, '2026-03-08 01:56:51.000000', 0, 'lisi@qq.com', 2, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13912345679', '李四', 0, 1, '2026-03-08 01:56:51.000000', 'lisi');
INSERT INTO `users` VALUES (6, 'https://ui-avatars.com/api/?name=WW&background=f6ad55&color=fff&size=150', 0.00, NULL, '2026-03-08 01:56:51.000000', 0, 'wangwu@qq.com', 1, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13912345680', '王五', 0, 1, '2026-03-08 01:56:51.000000', 'wangwu');
INSERT INTO `users` VALUES (7, 'https://ui-avatars.com/api/?name=ZL&background=fc5c65&color=fff&size=150', 1200.00, NULL, '2026-03-08 01:56:51.000000', 0, 'zhaoliu@qq.com', 1, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13912345681', '赵六', 0, 1, '2026-03-08 01:56:51.000000', 'zhaoliu');
INSERT INTO `users` VALUES (8, 'https://ui-avatars.com/api/?name=SQ&background=26de81&color=fff&size=150', 100.00, NULL, '2026-03-08 01:56:51.000000', 0, 'sunqi@qq.com', 2, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '13912345682', '孙七', 0, 1, '2026-03-08 01:56:51.000000', 'sunqi');
INSERT INTO `users` VALUES (9, NULL, 0.00, NULL, '2026-03-08 20:00:11.119959', 0, NULL, NULL, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '19947264958', NULL, 0, 0, '2026-03-15 14:36:15.402817', 'dengjj');
INSERT INTO `users` VALUES (10, NULL, 0.00, NULL, '2026-03-09 20:07:32.359865', 0, NULL, NULL, '$2a$10$9DEoMzOkyaZv0J1TGTRCQu9xg24auAjbreFpWM/qjqYKNSw5ycOuW', '19944873593', NULL, 0, 1, '2026-03-09 20:07:32.360873', 'dengj');

SET FOREIGN_KEY_CHECKS = 1;
