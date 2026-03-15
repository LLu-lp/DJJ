-- =============================================
-- 佳悦影院管理系统 - 测试数据
-- 数据库：jiayue_cinema
-- =============================================

-- 清空现有数据（按外键依赖顺序删除）
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE system_logs;
TRUNCATE TABLE system_config;
TRUNCATE TABLE announcements;
TRUNCATE TABLE movie_reviews;
TRUNCATE TABLE recharge_log;
TRUNCATE TABLE points_log;
TRUNCATE TABLE order_snacks;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE schedule_seats;
TRUNCATE TABLE schedules;
TRUNCATE TABLE seats;
TRUNCATE TABLE halls;
TRUNCATE TABLE cinemas;
TRUNCATE TABLE snacks;
TRUNCATE TABLE member_info;
TRUNCATE TABLE member_levels;
TRUNCATE TABLE users;
TRUNCATE TABLE movies;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- 1. 用户表 users
-- =============================================
INSERT INTO users (id, username, password, phone, email, real_name, avatar, gender, role, status, balance, created_at, updated_at, deleted) VALUES
(1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13800000001', 'admin@jiayue.com', '系统管理员', 'https://ui-avatars.com/api/?name=Admin&background=4a9ff5&color=fff&size=150', 0, 2, 1, 0.00, NOW(), NOW(), 0),
(2, 'staff001', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13800000002', 'staff001@jiayue.com', '员工小李', 'https://ui-avatars.com/api/?name=XL&background=e8b84b&color=fff&size=150', 1, 1, 1, 0.00, NOW(), NOW(), 0),
(3, 'staff002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13800000003', 'staff002@jiayue.com', '员工小王', 'https://ui-avatars.com/api/?name=XW&background=4caf82&color=fff&size=150', 2, 1, 1, 0.00, NOW(), NOW(), 0),
(4, 'zhangsan', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13912345678', 'zhangsan@qq.com', '张三', 'https://ui-avatars.com/api/?name=ZS&background=667eea&color=fff&size=150', 1, 0, 1, 500.00, NOW(), NOW(), 0),
(5, 'lisi', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13912345679', 'lisi@qq.com', '李四', 'https://ui-avatars.com/api/?name=LS&background=f093fb&color=fff&size=150', 2, 0, 1, 200.00, NOW(), NOW(), 0),
(6, 'wangwu', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13912345680', 'wangwu@qq.com', '王五', 'https://ui-avatars.com/api/?name=WW&background=f6ad55&color=fff&size=150', 1, 0, 1, 0.00, NOW(), NOW(), 0),
(7, 'zhaoliu', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13912345681', 'zhaoliu@qq.com', '赵六', 'https://ui-avatars.com/api/?name=ZL&background=fc5c65&color=fff&size=150', 1, 0, 1, 1200.00, NOW(), NOW(), 0),
(8, 'sunqi', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '13912345682', 'sunqi@qq.com', '孙七', 'https://ui-avatars.com/api/?name=SQ&background=26de81&color=fff&size=150', 2, 0, 1, 100.00, NOW(), NOW(), 0);
-- 默认密码都是：123456

-- =============================================
-- 2. 电影表 movies（使用picsum随机图片）
-- =============================================
INSERT INTO movies (id, title, poster, director, actors, genre, duration, language, region, release_date, end_date, rating, rating_count, ticket_count, description, status, created_at, updated_at, deleted) VALUES
(1, '流浪地球2', 'https://picsum.photos/seed/movie1/400/600', '郭帆', '吴京,刘德华,李雪健', '科幻,冒险', 173, '国语', '中国大陆', '2023-01-22', NULL, 8.3, 1362, 13625, '太阳即将毁灭，人类在地球表面建造出巨大的推进器，寻找新的家园。然而宇宙之路危机四伏，为了拯救地球，流浪地球时代的年轻人再次挺身而出，展开争分夺秒的生死之战。', 1, NOW(), NOW(), 0),
(2, '哪吒之魔童降世', 'https://picsum.photos/seed/movie2/400/600', '饺子', '吕艳婷,囧森瑟夫,瀚墨', '动画,奇幻', 110, '国语', '中国大陆', '2019-07-26', NULL, 8.4, 1415, 14152, '天地灵气孕育出混元珠，元始天尊将其分为灵珠和魔丸。太乙真人受命将灵珠托生于陈塘关李靖家，却阴差阳错，灵珠和魔丸被掉包。', 1, NOW(), NOW(), 0),
(3, '长津湖', 'https://picsum.photos/seed/movie3/400/600', '陈凯歌,徐克,林超贤', '吴京,易烊千玺,段奕宏', '战争,历史', 176, '国语', '中国大陆', '2021-09-30', NULL, 7.2, 982, 9820, '以抗美援朝战争第二次战役中的长津湖战役为背景，讲述在结束了新兴里和下碣隅里的战斗之后，七连战士们又接到了更艰巨的任务的故事。', 1, NOW(), NOW(), 0),
(4, '封神第一部', 'https://picsum.photos/seed/movie4/400/600', '乌尔善', '费翔,黄渤,于适', '奇幻,动作', 148, '国语', '中国大陆', '2023-07-20', NULL, 7.8, 856, 8560, '殷商末年，纣王帝辛在妲己的蛊惑下，倒行逆施，引发天怒人怨。姬发带领西岐勇士，联合各路诸侯，共同讨伐纣王。', 1, NOW(), NOW(), 0),
(5, '热辣滚烫', 'https://picsum.photos/seed/movie5/400/600', '贾玲', '贾玲,雷佳音,张小斐', '喜剧,剧情', 128, '国语', '中国大陆', '2024-02-10', NULL, 7.5, 723, 7230, '讲述了宅家多年的乐莹，在结识拳击教练昊坤后，克服接连不断的考验，开启滚烫人生的故事。', 1, NOW(), NOW(), 0),
(6, '第二十条', 'https://picsum.photos/seed/movie6/400/600', '张艺谋', '雷佳音,马丽,赵丽颖', '剧情,喜剧', 125, '国语', '中国大陆', '2024-02-10', NULL, 7.6, 645, 6450, '讲述了挂职检察官韩明人到中年，本想努力赶上职业生涯的末班车进入市院工作，不料卷入一分歧巨大的案件的故事。', 1, NOW(), NOW(), 0),
(7, '飞驰人生2', 'https://picsum.photos/seed/movie7/400/600', '韩寒', '沈腾,范丞丞,尹正', '喜剧,运动', 122, '国语', '中国大陆', '2024-02-10', NULL, 7.7, 589, 5890, '讲述了驾校教练张驰，携手潜力新人车手厉小海，出征巴音布鲁克拉力赛的故事。', 1, NOW(), NOW(), 0),
(8, '熊出没·逆转时空', 'https://picsum.photos/seed/movie8/400/600', '林汇达', '张伟,张秉君,谭笑', '动画,科幻', 108, '国语', '中国大陆', '2024-02-10', NULL, 6.9, 412, 4120, '熊大熊二光头强穿越时空，展开一场惊险刺激的冒险之旅。', 1, NOW(), NOW(), 0),
(9, '唐人街探案3', 'https://picsum.photos/seed/movie9/400/600', '陈思诚', '王宝强,刘昊然,张子枫', '喜剧,悬疑', 136, '国语', '中国大陆', '2021-02-12', NULL, 5.3, 1256, 12560, '唐仁和秦风再次联手，前往东京调查一起离奇的密室杀人案。', 2, NOW(), NOW(), 0),
(10, '速度与激情10', 'https://picsum.photos/seed/movie10/400/600', '路易斯·莱特里尔', '范·迪塞尔,杰森·斯坦森,米歇尔·罗德里格兹', '动作,犯罪', 141, '英语', '美国', '2023-05-17', NULL, 6.2, 892, 8920, '多姆和他的家人将面临迄今为止最致命的对手，一场关乎全球安全的终极对决即将展开。', 2, NOW(), NOW(), 0);

-- =============================================
-- 3. 影院表 cinemas
-- =============================================
INSERT INTO cinemas (id, name, address, phone, description, facilities, images, latitude, longitude, status, created_at, updated_at, deleted) VALUES
(1, '佳悦影城(万达广场店)', '北京市朝阳区建国路93号万达广场B座5层', '010-12345678', '舒适观影体验，配备IMAX影厅', 'IMAX,3D,杜比音效,休息区', NULL, 39.984120, 116.307470, 1, NOW(), NOW(), 0),
(2, '佳悦影城(西单店)', '北京市西城区西单北大街120号', '010-23456789', '市中心黄金地段，交通便利', '3D,杜比音效,儿童厅', NULL, 39.908760, 116.459620, 1, NOW(), NOW(), 0),
(3, '佳悦影城(国贸店)', '北京市朝阳区建国门外大街1号', '010-34567890', '高端商务影院', 'IMAX,VIP厅,杜比音效', NULL, 39.912890, 116.372980, 1, NOW(), NOW(), 0),
(4, '佳悦影城(五道口店)', '北京市海淀区成府路28号', '010-45678901', '大学城优质影院', '3D,杜比音效', NULL, 39.992880, 116.337420, 1, NOW(), NOW(), 0),
(5, '佳悦影城(望京店)', '北京市朝阳区望京街9号', '010-56789012', '望京地区首选影院', 'IMAX,3D,杜比音效', NULL, 39.988670, 116.474780, 1, NOW(), NOW(), 0);

-- =============================================
-- 4. 影厅表 halls
-- =============================================
INSERT INTO halls (id, cinema_id, name, type, `rows`, cols, total_seats, facilities, status, created_at, updated_at, deleted) VALUES
(1, 1, '1号厅', 'IMAX', 10, 14, 140, 'IMAX巨幕,杜比音效', 1, NOW(), NOW(), 0),
(2, 1, '2号厅', '4DX', 8, 12, 96, '4DX动感座椅', 1, NOW(), NOW(), 0),
(3, 1, '3号厅', '杜比全景声', 10, 12, 120, '杜比全景声', 1, NOW(), NOW(), 0),
(4, 1, '4号厅', '标准', 8, 10, 80, '标准影厅', 1, NOW(), NOW(), 0),
(5, 2, '1号厅', 'IMAX', 12, 16, 192, 'IMAX巨幕,杜比音效', 1, NOW(), NOW(), 0),
(6, 2, '2号厅', 'VIP', 6, 8, 48, 'VIP豪华座椅', 1, NOW(), NOW(), 0),
(7, 2, '3号厅', '杜比全景声', 10, 14, 140, '杜比全景声', 1, NOW(), NOW(), 0),
(8, 3, '1号厅', 'IMAX', 10, 14, 140, 'IMAX巨幕', 1, NOW(), NOW(), 0),
(9, 3, '2号厅', '4DX', 8, 12, 96, '4DX动感座椅', 1, NOW(), NOW(), 0),
(10, 4, '1号厅', '杜比全景声', 10, 12, 120, '杜比全景声', 1, NOW(), NOW(), 0),
(11, 4, '2号厅', 'VIP', 6, 10, 60, 'VIP豪华座椅', 1, NOW(), NOW(), 0),
(12, 5, '1号厅', 'IMAX', 12, 14, 168, 'IMAX巨幕,杜比音效', 1, NOW(), NOW(), 0);

-- =============================================
-- 5. 座位表 seats
-- =============================================
INSERT INTO seats (hall_id, row_num, col_num, seat_label, seat_type, status, created_at, updated_at, deleted)
SELECT 
    h.id as hall_id,
    r.row_num,
    c.col_num,
    CONCAT(CHAR(64 + r.row_num), c.col_num) as seat_label,
    CASE 
        WHEN r.row_num <= 2 THEN 2
        WHEN r.row_num = 5 AND c.col_num IN (5,6,7,8) THEN 1
        ELSE 0
    END as seat_type,
    1 as status,
    NOW() as created_at,
    NOW() as updated_at,
    0 as deleted
FROM halls h
CROSS JOIN (SELECT 1 as row_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) r
CROSS JOIN (SELECT 1 as col_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16) c
WHERE r.row_num <= h.`rows` AND c.col_num <= h.cols;

-- =============================================
-- 6. 会员等级配置表 member_levels
-- =============================================
INSERT INTO member_levels (level, level_name, level_code, min_points, max_points, discount, points_rate, benefits, sort_order, created_at, updated_at, deleted) VALUES
(1, '普通会员', 'NORMAL', 0, 999, 1.00, 1.00, '基础会员权益', 1, NOW(), NOW(), 0),
(2, '银卡会员', 'SILVER', 1000, 4999, 0.95, 1.20, '95折优惠,积分1.2倍', 2, NOW(), NOW(), 0),
(3, '金卡会员', 'GOLD', 5000, 19999, 0.90, 1.50, '9折优惠,积分1.5倍,生日特权', 3, NOW(), NOW(), 0),
(4, '钻石会员', 'DIAMOND', 20000, NULL, 0.85, 2.00, '85折优惠,积分2倍,专属客服,优先选座', 4, NOW(), NOW(), 0);

-- =============================================
-- 7. 会员信息表 member_info
-- =============================================
INSERT INTO member_info (user_id, member_no, level_id, points, total_points, total_spent, total_recharge, expire_date, created_at, updated_at) VALUES
(4, 'M202401000004', 2, 2580, 3580, 3580.00, 710.00, NULL, DATE_SUB(NOW(), INTERVAL 180 DAY), NOW()),
(5, 'M202401000005', 1, 680, 1280, 1280.00, 210.00, NULL, DATE_SUB(NOW(), INTERVAL 90 DAY), NOW()),
(6, 'M202401000006', 1, 120, 380, 380.00, 0.00, NULL, DATE_SUB(NOW(), INTERVAL 30 DAY), NOW()),
(7, 'M202401000007', 3, 6500, 8500, 8500.00, 1700.00, NULL, DATE_SUB(NOW(), INTERVAL 365 DAY), NOW()),
(8, 'M202401000008', 1, 450, 980, 980.00, 100.00, NULL, DATE_SUB(NOW(), INTERVAL 60 DAY), NOW());

-- =============================================
-- 8. 商品表 snacks（使用picsum随机图片）
-- =============================================
INSERT INTO snacks (id, name, category, image, price, original_price, description, stock, sales, status, sort_order, created_at, updated_at, deleted) VALUES
(1, '经典原味爆米花（小）', 'popcorn', 'https://picsum.photos/seed/popcorn1/400/400', 25.00, 30.00, '香脆可口的经典原味爆米花', 500, 2580, 1, 1, NOW(), NOW(), 0),
(2, '经典原味爆米花（大）', 'popcorn', 'https://picsum.photos/seed/popcorn2/400/400', 35.00, 40.00, '超大份经典原味爆米花', 300, 1680, 1, 2, NOW(), NOW(), 0),
(3, '焦糖爆米花', 'popcorn', 'https://picsum.photos/seed/popcorn3/400/400', 32.00, 38.00, '甜蜜焦糖包裹的爆米花', 400, 980, 1, 3, NOW(), NOW(), 0),
(4, '可口可乐（中杯）', 'drink', 'https://picsum.photos/seed/drink1/400/400', 15.00, 18.00, '冰镇可口可乐 500ml', 800, 3580, 1, 4, NOW(), NOW(), 0),
(5, '可口可乐（大杯）', 'drink', 'https://picsum.photos/seed/drink2/400/400', 20.00, 25.00, '冰镇可口可乐 800ml', 600, 2180, 1, 5, NOW(), NOW(), 0),
(6, '雪碧（中杯）', 'drink', 'https://picsum.photos/seed/drink3/400/400', 15.00, 18.00, '清爽雪碧 500ml', 500, 1280, 1, 6, NOW(), NOW(), 0),
(7, '橙汁', 'drink', 'https://picsum.photos/seed/drink4/400/400', 18.00, 22.00, '鲜榨橙汁 400ml', 300, 680, 1, 7, NOW(), NOW(), 0),
(8, '爆米花+可乐套餐', 'combo', 'https://picsum.photos/seed/combo1/400/400', 38.00, 48.00, '大份爆米花+中杯可乐', 200, 3280, 1, 8, NOW(), NOW(), 0),
(9, '双人套餐', 'combo', 'https://picsum.photos/seed/combo2/400/400', 68.00, 80.00, '2份爆米花+2杯可乐', 150, 1580, 1, 9, NOW(), NOW(), 0),
(10, '家庭套餐', 'combo', 'https://picsum.photos/seed/combo3/400/400', 98.00, 120.00, '3份爆米花+3杯可乐+1份薯条', 100, 680, 1, 10, NOW(), NOW(), 0),
(11, '薯条', 'snack', 'https://picsum.photos/seed/snack1/400/400', 18.00, 22.00, '香脆薯条', 400, 890, 1, 11, NOW(), NOW(), 0),
(12, '烤肠', 'snack', 'https://picsum.photos/seed/snack2/400/400', 12.00, 15.00, '美味烤肠', 500, 1280, 1, 12, NOW(), NOW(), 0);

-- =============================================
-- 9. 排片场次表 schedules
-- =============================================
INSERT INTO schedules (id, movie_id, cinema_id, hall_id, show_date, start_time, end_time, price, vip_price, language, status, created_at, updated_at, deleted) VALUES
-- 今天和明天的场次
(1, 1, 1, 1, CURDATE(), '10:00:00', '12:53:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(2, 1, 1, 1, CURDATE(), '14:30:00', '17:23:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(3, 1, 1, 1, CURDATE(), '19:00:00', '21:53:00', 98.00, 138.00, '国语', 1, NOW(), NOW(), 0),
(4, 1, 1, 2, CURDATE(), '13:00:00', '15:53:00', 108.00, NULL, '国语', 1, NOW(), NOW(), 0),
(5, 1, 1, 3, CURDATE(), '20:00:00', '22:53:00', 78.00, 108.00, '国语', 1, NOW(), NOW(), 0),
(6, 2, 1, 1, CURDATE(), '11:00:00', '12:50:00', 68.00, 98.00, '国语', 1, NOW(), NOW(), 0),
(7, 2, 1, 3, CURDATE(), '15:30:00', '17:20:00', 68.00, 98.00, '国语', 1, NOW(), NOW(), 0),
(8, 2, 1, 4, CURDATE(), '19:30:00', '21:20:00', 58.00, NULL, '国语', 1, NOW(), NOW(), 0),
(9, 3, 2, 5, CURDATE(), '10:30:00', '13:26:00', 78.00, 118.00, '国语', 1, NOW(), NOW(), 0),
(10, 3, 2, 5, CURDATE(), '14:00:00', '16:56:00', 78.00, 118.00, '国语', 1, NOW(), NOW(), 0),
(11, 3, 2, 7, CURDATE(), '18:30:00', '21:26:00', 68.00, 98.00, '国语', 1, NOW(), NOW(), 0),
(12, 4, 2, 5, CURDATE(), '11:30:00', '13:58:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(13, 4, 2, 6, CURDATE(), '15:00:00', '17:28:00', 158.00, NULL, '国语', 1, NOW(), NOW(), 0),
(14, 5, 3, 8, CURDATE(), '10:00:00', '12:08:00', 58.00, 88.00, '国语', 1, NOW(), NOW(), 0),
(15, 5, 3, 8, CURDATE(), '13:30:00', '15:38:00', 58.00, 88.00, '国语', 1, NOW(), NOW(), 0),
(16, 5, 3, 9, CURDATE(), '17:00:00', '19:08:00', 68.00, NULL, '国语', 1, NOW(), NOW(), 0),
-- 明天的场次
(17, 1, 1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:00:00', '12:53:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(18, 1, 1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:30:00', '17:23:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(19, 1, 1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '19:00:00', '21:53:00', 98.00, 138.00, '国语', 1, NOW(), NOW(), 0),
(20, 2, 1, 2, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '11:00:00', '12:50:00', 78.00, NULL, '国语', 1, NOW(), NOW(), 0),
(21, 2, 1, 3, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:30:00', '17:20:00', 68.00, 98.00, '国语', 1, NOW(), NOW(), 0),
(22, 3, 2, 5, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:30:00', '13:26:00', 78.00, 118.00, '国语', 1, NOW(), NOW(), 0),
(23, 3, 2, 5, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:00:00', '16:56:00', 78.00, 118.00, '国语', 1, NOW(), NOW(), 0),
(24, 4, 3, 8, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '11:30:00', '13:58:00', 88.00, 128.00, '国语', 1, NOW(), NOW(), 0),
(25, 5, 4, 10, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:00:00', '12:08:00', 58.00, 88.00, '国语', 1, NOW(), NOW(), 0);

-- =============================================
-- 9.1 场次座位关联表 schedule_seats
-- =============================================
INSERT INTO schedule_seats (schedule_id, seat_id, status, price, created_at, updated_at)
SELECT 
    s.id as schedule_id,
    st.id as seat_id,
    CASE 
        WHEN s.id IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16) THEN 
            CASE 
                WHEN RAND() < 0.3 THEN 1
                ELSE 0
            END
        ELSE 0
    END as status,
    CASE 
        WHEN st.seat_type = 2 THEN IFNULL(s.vip_price, s.price)
        ELSE s.price
    END as price,
    NOW() as created_at,
    NOW() as updated_at
FROM schedules s
INNER JOIN seats st ON st.hall_id = s.hall_id;

-- =============================================
-- 10. 订单表 orders
-- =============================================
INSERT INTO orders (id, order_no, user_id, username, schedule_id, cinema_id, cinema_name, hall_id, hall_name, movie_title, show_time, seat_count, total_amount, ticket_amount, snack_amount, discount_amount, pay_amount, pay_type, pay_time, status, ticketed, ticket_time, qr_code, expire_time, remark, created_at, updated_at, deleted) VALUES
(1, 'JY202501010001', 4, 'zhangsan', 1, 1, '佳悦影院中关村店', 1, '1号厅', '流浪地球2', CONCAT(CURDATE(), ' 10:00:00'), 2, 214.00, 176.00, 38.00, 0.00, 214.00, 'wechat', DATE_SUB(NOW(), INTERVAL 5 DAY), 1, 1, DATE_SUB(NOW(), INTERVAL 5 DAY), 'QR001', NULL, NULL, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 0),
(2, 'JY202501010002', 4, 'zhangsan', 2, 1, '佳悦影院中关村店', 1, '1号厅', '流浪地球2', CONCAT(CURDATE(), ' 14:30:00'), 3, 305.60, 264.00, 68.00, 26.40, 305.60, 'alipay', DATE_SUB(NOW(), INTERVAL 3 DAY), 1, 1, DATE_SUB(NOW(), INTERVAL 3 DAY), 'QR002', NULL, NULL, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 0),
(3, 'JY202501010003', 5, 'lisi', 6, 1, '佳悦影院中关村店', 1, '1号厅', '哪吒之魔童降世', CONCAT(CURDATE(), ' 11:00:00'), 2, 136.00, 136.00, 0.00, 0.00, 136.00, 'memberCard', DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 0, NULL, 'QR003', NULL, NULL, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), 0),
(4, 'JY202501010004', 6, 'wangwu', 9, 2, '佳悦影院国贸店', 5, '1号厅', '长津湖', CONCAT(CURDATE(), ' 10:30:00'), 1, 93.00, 78.00, 15.00, 0.00, 93.00, 'wechat', DATE_SUB(NOW(), INTERVAL 1 DAY), 1, 0, NULL, 'QR004', NULL, NULL, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), 0),
(5, 'JY202501010005', 7, 'zhaoliu', 3, 1, '佳悦影院中关村店', 1, '1号厅', '流浪地球2', CONCAT(CURDATE(), ' 19:00:00'), 4, 450.80, 392.00, 98.00, 39.20, 450.80, 'alipay', NOW(), 1, 0, NULL, 'QR005', NULL, NULL, NOW(), NOW(), 0),
(6, 'JY202501010006', 8, 'sunqi', 14, 3, '佳悦影院西单店', 8, '1号厅', '热辣滚烫', CONCAT(CURDATE(), ' 10:00:00'), 2, 154.00, 116.00, 38.00, 0.00, 154.00, 'wechat', NOW(), 1, 0, NULL, 'QR006', NULL, NULL, NOW(), NOW(), 0),
(7, 'JY202501010007', 4, 'zhangsan', 10, 2, '佳悦影院国贸店', 5, '1号厅', '长津湖', CONCAT(CURDATE(), ' 14:00:00'), 2, 140.40, 156.00, 0.00, 15.60, 140.40, 'memberCard', NOW(), 0, 0, NULL, NULL, DATE_ADD(NOW(), INTERVAL 15 MINUTE), NULL, NOW(), NOW(), 0),
(8, 'JY202501010008', 5, 'lisi', 15, 3, '佳悦影院西单店', 8, '1号厅', '热辣滚烫', CONCAT(CURDATE(), ' 13:30:00'), 1, 83.00, 58.00, 25.00, 0.00, 83.00, NULL, NULL, 0, 0, NULL, NULL, DATE_ADD(NOW(), INTERVAL 20 MINUTE), NULL, NOW(), NOW(), 0);

-- =============================================
-- 11. 订单座位明细表 order_items
-- =============================================
INSERT INTO order_items (order_id, schedule_id, seat_id, seat_label, price, ticket_code, status, created_at, updated_at) VALUES
(1, 1, 1, '1排1座', 88.00, 'T202501010001', 1, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(1, 1, 2, '1排2座', 88.00, 'T202501010002', 1, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 2, 15, '2排1座', 88.00, 'T202501010003', 1, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(2, 2, 16, '2排2座', 88.00, 'T202501010004', 1, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(2, 2, 17, '2排3座', 88.00, 'T202501010005', 1, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 6, 85, '4排5座', 68.00, 'T202501010006', 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 6, 86, '4排6座', 68.00, 'T202501010007', 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
(4, 9, 145, '1排1座', 78.00, 'T202501010008', 0, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
(5, 3, 25, '3排1座', 98.00, 'T202501010009', 0, NOW(), NOW()),
(5, 3, 26, '3排2座', 98.00, 'T202501010010', 0, NOW(), NOW()),
(5, 3, 27, '3排3座', 98.00, 'T202501010011', 0, NOW(), NOW()),
(5, 3, 28, '3排4座', 98.00, 'T202501010012', 0, NOW(), NOW()),
(6, 14, 185, '1排1座', 58.00, 'T202501010013', 0, NOW(), NOW()),
(6, 14, 186, '1排2座', 58.00, 'T202501010014', 0, NOW(), NOW()),
(7, 10, 155, '2排1座', 78.00, NULL, 0, NOW(), NOW()),
(7, 10, 156, '2排2座', 78.00, NULL, 0, NOW(), NOW()),
(8, 15, 205, '1排1座', 58.00, NULL, 0, NOW(), NOW());

-- =============================================
-- 12. 订单商品关联表 order_snacks
-- =============================================
INSERT INTO order_snacks (order_id, snack_id, snack_name, price, quantity, subtotal, created_at, updated_at) VALUES
(1, 8, '爆米花+可乐套餐', 38.00, 1, 38.00, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 9, '双人套餐', 68.00, 1, 68.00, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 4, '可口可乐（中杯）', 15.00, 1, 15.00, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
(5, 10, '家庭套餐', 98.00, 1, 98.00, NOW(), NOW()),
(6, 8, '爆米花+可乐套餐', 38.00, 1, 38.00, NOW(), NOW()),
(8, 1, '经典原味爆米花（小）', 25.00, 1, 25.00, NOW(), NOW());

-- =============================================
-- 13. 积分记录表 points_log
-- =============================================
INSERT INTO points_log (user_id, type, points, balance, related_id, remark, created_at) VALUES
(4, 1, 214, 214, 1, '购票获得积分', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 1, 306, 520, 2, '购票获得积分', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 3, 10, 530, NULL, '每日签到', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(4, 3, 10, 540, NULL, '每日签到', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(4, 1, 451, 991, 5, '购票获得积分', NOW()),
(5, 1, 136, 136, 3, '购票获得积分', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5, 3, 10, 146, NULL, '每日签到', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(6, 1, 93, 93, 4, '购票获得积分', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(7, 1, 214, 214, 1, '购票获得积分', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(7, 1, 306, 520, 2, '购票获得积分', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7, 3, 10, 530, NULL, '每日签到', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 1, 154, 154, 6, '购票获得积分', NOW());

-- =============================================
-- 14. 充值记录表 recharge_log
-- =============================================
INSERT INTO recharge_log (user_id, order_no, amount, gift_amount, gift_points, pay_type, pay_time, status, created_at) VALUES
(4, 'RC202501010001', 500.00, 50.00, 50, 1, DATE_SUB(NOW(), INTERVAL 10 DAY), 1, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 'RC202501010002', 200.00, 10.00, 10, 2, DATE_SUB(NOW(), INTERVAL 5 DAY), 1, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 'RC202501010003', 200.00, 10.00, 10, 1, DATE_SUB(NOW(), INTERVAL 7 DAY), 1, DATE_SUB(NOW(), INTERVAL 7 DAY)),
(7, 'RC202501010004', 1000.00, 150.00, 150, 1, DATE_SUB(NOW(), INTERVAL 15 DAY), 1, DATE_SUB(NOW(), INTERVAL 15 DAY)),
(7, 'RC202501010005', 500.00, 50.00, 50, 2, DATE_SUB(NOW(), INTERVAL 8 DAY), 1, DATE_SUB(NOW(), INTERVAL 8 DAY)),
(8, 'RC202501010006', 100.00, 0.00, 0, 1, DATE_SUB(NOW(), INTERVAL 3 DAY), 1, DATE_SUB(NOW(), INTERVAL 3 DAY));

-- =============================================
-- 15. 电影评论表 movie_reviews
-- =============================================
INSERT INTO movie_reviews (movie_id, user_id, rating, content, likes, status, created_at, updated_at, deleted) VALUES
(1, 4, 5, '太震撼了！特效一流，剧情紧凑，强烈推荐IMAX版本观看！', 128, 1, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 0),
(1, 5, 4, '整体不错，就是中间节奏稍微有点慢，结局很燃！', 56, 1, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), 0),
(2, 4, 5, '国产动画的巅峰之作，画面精美，故事感人！', 89, 1, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), 0),
(3, 6, 5, '致敬英雄！看得热泪盈眶，强烈推荐！', 234, 1, NOW(), NOW(), 0),
(1, 7, 5, '二刷了，依然感动，中国科幻电影的骄傲！', 78, 1, NOW(), NOW(), 0);

-- =============================================
-- 16. 公告表 announcements
-- =============================================
INSERT INTO announcements (id, title, content, type, cover_image, is_top, view_count, status, publish_time, created_at, updated_at, deleted) VALUES
(1, '佳悦影院会员积分翻倍活动', '即日起至本月底，所有会员购票积分翻倍！金卡及以上会员更享三倍积分！快来观影吧！', 1, NULL, 1, 0, 1, NOW(), NOW(), NOW(), 0),
(2, '新片上映：《流浪地球2》震撼来袭', '郭帆导演力作《流浪地球2》现已上映，IMAX/4DX/杜比全景声多版本同步上映，快来体验震撼视听盛宴！', 0, NULL, 1, 0, 1, NOW(), NOW(), NOW(), 0),
(3, '春节档预售开启', '春节档热门影片现已开启预售，提前锁定黄金座位，享受观影好时光！', 0, NULL, 0, 0, 1, NOW(), NOW(), NOW(), 0),
(4, '会员充值优惠', '充值500元送50元，充值1000元送150元，多充多送！', 0, NULL, 0, 0, 1, NOW(), NOW(), NOW(), 0),
(5, '系统升级通知', '为提供更好的服务，系统将于本周三凌晨2:00-4:00进行升级维护，届时将暂停服务，敬请谅解。', 2, NULL, 0, 0, 1, NOW(), NOW(), NOW(), 0);

-- =============================================
-- 17. 系统配置表 system_config
-- =============================================
INSERT INTO system_config (config_key, config_value, config_type, description, group_name, created_at, updated_at) VALUES
('cinemaName', '佳悦影院', 'string', '影院名称', 'basic', NOW(), NOW()),
('contactPhone', '400-888-8888', 'string', '联系电话', 'basic', NOW(), NOW()),
('businessHours', '09:00-23:00', 'string', '营业时间', 'basic', NOW(), NOW()),
('address', '北京市朝阳区建国路93号', 'string', '地址', 'basic', NOW(), NOW()),
('orderTimeout', '15', 'number', '订单超时时间(分钟)', 'order', NOW(), NOW()),
('maxSeatCount', '4', 'number', '最大选座数', 'order', NOW(), NOW()),
('pointRule', '每消费1元获得1积分', 'string', '积分规则', 'member', NOW(), NOW());

-- =============================================
-- 18. 系统操作日志表 system_logs
-- =============================================
INSERT INTO system_logs (user_id, username, module, operation, method, params, ip, user_agent, result, error_msg, duration, created_at) VALUES
(1, 'admin', 'auth', '管理员登录', 'POST', '{"username":"admin"}', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, NULL, 120, NOW()),
(1, 'admin', 'movie', '新增电影：流浪地球2', 'POST', '{"movie_id":1}', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, NULL, 85, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(1, 'admin', 'cinema', '新增影院：佳悦影院中关村店', 'POST', '{"cinema_id":1}', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, NULL, 95, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(1, 'admin', 'schedule', '新增排片：流浪地球2 10:00场', 'POST', '{"schedule_id":1}', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, NULL, 110, DATE_SUB(NOW(), INTERVAL 9 DAY)),
(2, 'staff001', 'auth', '员工登录', 'POST', '{"username":"staff001"}', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 1, NULL, 98, NOW()),
(4, 'zhangsan', 'auth', '用户登录', 'POST', '{"username":"zhangsan"}', '192.168.1.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) Safari/604.1', 1, NULL, 105, NOW()),
(4, 'zhangsan', 'order', '创建订单：JY202501010001', 'POST', '{"order_id":1}', '192.168.1.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) Safari/604.1', 1, NULL, 156, DATE_SUB(NOW(), INTERVAL 5 DAY));

-- =============================================
-- 19. 积分兑换商品表 exchange_items
-- =============================================
INSERT INTO exchange_items (name, icon, description, points, stock, exchanged_count, status, sort, created_at, updated_at, deleted) VALUES
('经典爆米花(大)', '🍿', '到店兑换', 300, 100, 15, 1, 1, NOW(), NOW(), 0),
('可乐一杯', '🥤', '到店兑换', 200, 200, 28, 1, 2, NOW(), NOW(), 0),
('电影票折扣券', '🎫', '购票立减10元', 500, 50, 8, 1, 3, NOW(), NOW(), 0),
('套餐A优惠券', '🎁', '爆米花+饮品', 400, 80, 12, 1, 4, NOW(), NOW(), 0);

-- =============================================
-- 20. 兑换记录表 exchange_records
-- =============================================
INSERT INTO exchange_records (user_id, item_id, item_name, points, status, exchanged_at) VALUES
(4, 1, '经典爆米花(大)', 300, 1, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 2, '可乐一杯', 200, 1, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(7, 3, '电影票折扣券', 500, 0, NOW()),
(7, 4, '套餐A优惠券', 400, 1, DATE_SUB(NOW(), INTERVAL 1 DAY));

-- =============================================
-- 完成提示
-- =============================================
SELECT '测试数据导入完成！' AS message;
SELECT CONCAT('用户数：', COUNT(*)) AS users FROM users;
SELECT CONCAT('电影数：', COUNT(*)) AS movies FROM movies;
SELECT CONCAT('影院数：', COUNT(*)) AS cinemas FROM cinemas;
SELECT CONCAT('影厅数：', COUNT(*)) AS halls FROM halls;
SELECT CONCAT('座位数：', COUNT(*)) AS seats FROM seats;
SELECT CONCAT('场次数：', COUNT(*)) AS schedules FROM schedules;
SELECT CONCAT('订单数：', COUNT(*)) AS orders FROM orders;
SELECT CONCAT('商品数：', COUNT(*)) AS snacks FROM snacks;
