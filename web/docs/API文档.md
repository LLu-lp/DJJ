# 佳悦影院管理系统 - API 接口文档

> **版本**：v1.0.0  
> **基础路径**：`/api`  
> **请求格式**：`application/json`  
> **认证方式**：Bearer Token（在 Header 中携带 `Authorization: Bearer <token>`）

---

## 统一响应格式

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

| 状态码 | 说明 |
|--------|------|
| 200    | 成功 |
| 400    | 参数错误 |
| 401    | 未登录/Token 失效 |
| 403    | 无权限 |
| 404    | 资源不存在 |
| 500    | 服务器错误 |

---

## 一、认证模块 `/api/auth`

### 1.1 用户登录

**POST** `/api/auth/login`

**请求体**：
```json
{
  "username": "string",
  "password": "string",
  "role": "user | admin | staff"
}
```

**响应**：
```json
{
  "code": 200,
  "data": {
    "token": "eyJhbGci...",
    "userInfo": {
      "id": 1,
      "username": "zhangsan",
      "nickname": "张三",
      "role": "user",
      "avatar": "https://..."
    }
  }
}
```

---

### 1.2 用户注册

**POST** `/api/auth/register`

**请求体**：
```json
{
  "username": "string",
  "password": "string",
  "phone": "string",
  "code": "string"
}
```

---

### 1.3 发送短信验证码

**POST** `/api/auth/send-code`

**请求体**：
```json
{
  "phone": "string"
}
```

---

### 1.4 退出登录

**POST** `/api/auth/logout`

> 需携带 Token

---

### 1.5 获取当前用户信息

**GET** `/api/auth/me`

---

## 二、电影模块 `/api/movies`

### 2.1 获取电影列表

**GET** `/api/movies`

**Query 参数**：

| 参数 | 类型 | 说明 |
|------|------|------|
| status | string | `showing`（上映中）/ `coming`（即将上映） |
| genre | string | 类型（动作/喜剧等） |
| keyword | string | 搜索关键词 |
| page | number | 页码，默认 1 |
| size | number | 每页条数，默认 10 |

**响应**：
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "title": "流浪地球3",
        "poster": "https://...",
        "genres": ["科幻", "动作"],
        "duration": 135,
        "rating": 9.2,
        "releaseDate": "2025-01-01",
        "status": "showing",
        "director": "郭帆",
        "actors": ["吴京", "李雪健"]
      }
    ],
    "total": 50,
    "page": 1,
    "size": 10
  }
}
```

---

### 2.2 获取电影详情

**GET** `/api/movies/:id`

---

### 2.3 获取电影排行榜

**GET** `/api/movies/ranking`

**Query 参数**：

| 参数 | 类型 | 说明 |
|------|------|------|
| type | string | `hot`（热映）/ `rating`（评分）/ `week`（周票房） |
| limit | number | 返回数量，默认 10 |

---

### 2.4 获取电影评论

**GET** `/api/movies/:id/reviews`

---

### 2.5 发表评论

**POST** `/api/movies/:id/reviews`

> 需登录

**请求体**：
```json
{
  "rating": 5,
  "content": "string"
}
```

---

## 三、影院模块 `/api/cinemas`

### 3.1 获取影院列表

**GET** `/api/cinemas`

**Query 参数**：`keyword`, `city`, `page`, `size`

---

### 3.2 获取影院详情

**GET** `/api/cinemas/:id`

**响应**：
```json
{
  "code": 200,
  "data": {
    "id": 1,
    "name": "佳悦影院中关村店",
    "address": "北京市海淀区中关村大街1号",
    "phone": "010-12345678",
    "businessHours": "09:00-23:30",
    "facilities": ["IMAX", "4DX", "杜比全景声"],
    "halls": [
      { "id": 1, "name": "1号厅", "type": "IMAX", "rows": 12, "cols": 16 }
    ]
  }
}
```

---

### 3.3 获取影厅座位图

**GET** `/api/cinemas/:cinemaId/halls/:hallId/seats`

---

## 四、排片模块 `/api/schedules`

### 4.1 根据电影获取排片

**GET** `/api/schedules`

**Query 参数**：

| 参数 | 类型 | 说明 |
|------|------|------|
| movieId | number | 电影 ID |
| cinemaId | number | 影院 ID |
| date | string | 日期，格式 `YYYY-MM-DD` |
| page | number | 页码 |
| size | number | 每页条数 |

**响应**：
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "movieId": 1,
        "movieTitle": "流浪地球3",
        "cinemaId": 1,
        "cinemaName": "佳悦影院中关村店",
        "hallId": 1,
        "hallName": "1号厅(IMAX)",
        "showDate": "2025-06-20",
        "showTime": "14:30",
        "endTime": "16:45",
        "price": 88,
        "soldSeats": 45,
        "totalSeats": 120,
        "language": "国语",
        "status": "selling"
      }
    ]
  }
}
```

---

### 4.2 获取场次座位状态

**GET** `/api/schedules/:scheduleId/seats`

**响应**：
```json
{
  "code": 200,
  "data": {
    "rows": 10,
    "cols": 12,
    "seats": [
      { "row": 1, "col": 1, "status": "available", "seatNo": "A1" },
      { "row": 1, "col": 2, "status": "sold", "seatNo": "A2" }
    ]
  }
}
```

---

## 五、订单模块 `/api/orders`

### 5.1 创建订单

**POST** `/api/orders`

> 需登录

**请求体**：
```json
{
  "scheduleId": 1,
  "seatIds": [101, 102],
  "snackItems": [
    { "snackId": 1, "quantity": 2 }
  ],
  "couponId": null
}
```

**响应**：
```json
{
  "code": 200,
  "data": {
    "orderId": 100,
    "orderNo": "JY20250620001",
    "amount": 176,
    "expireTime": "2025-06-20 14:30:00"
  }
}
```

---

### 5.2 获取用户订单列表

**GET** `/api/orders`

> 需登录

**Query 参数**：`status`, `page`, `size`

---

### 5.3 获取订单详情

**GET** `/api/orders/:id`

> 需登录，只能查看自己的订单

---

### 5.4 取消订单

**POST** `/api/orders/:id/cancel`

---

### 5.5 支付订单

**POST** `/api/orders/:id/pay`

**请求体**：
```json
{
  "payType": "wechat | alipay | memberCard",
  "usePoints": 100
}
```

---

### 5.6 申请退款

**POST** `/api/orders/:id/refund`

---

## 六、会员模块 `/api/member`

### 6.1 获取会员信息

**GET** `/api/member/info`

> 需登录

**响应**：
```json
{
  "code": 200,
  "data": {
    "userId": 1,
    "level": 2,
    "levelName": "金卡会员",
    "points": 1280,
    "balance": 200.5,
    "discount": 9.0,
    "totalConsumed": 1350.0,
    "joinTime": "2024-01-15"
  }
}
```

---

### 6.2 会员充值

**POST** `/api/member/recharge`

**请求体**：
```json
{
  "amount": 200,
  "payType": "wechat | alipay"
}
```

---

### 6.3 积分兑换

**POST** `/api/member/exchange-points`

**请求体**：
```json
{
  "points": 500
}
```

---

### 6.4 获取积分记录

**GET** `/api/member/points-log`

**Query 参数**：`type`（earn/spend），`page`，`size`

---

### 6.5 签到

**POST** `/api/member/sign-in`

---

## 七、小食商品模块 `/api/snacks`

### 7.1 获取商品列表

**GET** `/api/snacks`

**Query 参数**：`category`, `available`

---

### 7.2 获取商品详情

**GET** `/api/snacks/:id`

---

## 八、管理员模块 `/api/admin`

> 以下所有接口需要 `admin` 角色 Token

### 8.1 数据总览

**GET** `/api/admin/dashboard`

**响应**：
```json
{
  "code": 200,
  "data": {
    "todayRevenue": 12580,
    "todayOrders": 186,
    "totalUsers": 3842,
    "activeSchedules": 24,
    "monthRevenue": 258000,
    "revenueChart": [
      { "date": "2025-06-01", "amount": 8500 }
    ],
    "movieRankChart": [
      { "title": "流浪地球3", "revenue": 45000 }
    ]
  }
}
```

---

### 8.2 电影管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/movies` | 获取电影列表（含分页） |
| POST | `/api/admin/movies` | 新增电影 |
| PUT | `/api/admin/movies/:id` | 修改电影信息 |
| DELETE | `/api/admin/movies/:id` | 删除电影 |
| PUT | `/api/admin/movies/:id/status` | 修改上映状态 |

**POST/PUT 请求体**：
```json
{
  "title": "流浪地球3",
  "poster": "https://...",
  "genres": ["科幻", "动作"],
  "duration": 135,
  "director": "郭帆",
  "actors": "吴京,李雪健",
  "synopsis": "...",
  "releaseDate": "2025-01-01",
  "status": "showing"
}
```

---

### 8.3 影院管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/cinemas` | 获取影院列表 |
| POST | `/api/admin/cinemas` | 新增影院 |
| PUT | `/api/admin/cinemas/:id` | 修改影院 |
| DELETE | `/api/admin/cinemas/:id` | 删除影院 |
| GET | `/api/admin/cinemas/:id/halls` | 获取影厅列表 |
| POST | `/api/admin/cinemas/:id/halls` | 新增影厅 |
| PUT | `/api/admin/halls/:id` | 修改影厅 |

---

### 8.4 排片管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/schedules` | 获取排片列表（含筛选） |
| POST | `/api/admin/schedules` | 新增排片 |
| PUT | `/api/admin/schedules/:id` | 修改排片 |
| DELETE | `/api/admin/schedules/:id` | 删除排片 |

---

### 8.5 订单管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/orders` | 获取订单列表（含筛选、分页） |
| GET | `/api/admin/orders/:id` | 订单详情 |
| POST | `/api/admin/orders/:id/refund` | 手动退款 |
| GET | `/api/admin/orders/export` | 导出订单（返回文件流） |

---

### 8.6 用户管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/users` | 获取用户列表 |
| GET | `/api/admin/users/:id` | 用户详情 |
| PUT | `/api/admin/users/:id/status` | 启用/禁用用户 |

---

### 8.7 会员配置

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/member-config` | 获取当前会员配置 |
| PUT | `/api/admin/member-config` | 保存会员配置 |
| PUT | `/api/admin/member-config/levels` | 更新等级设置 |

---

### 8.8 系统管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/admin/system/config` | 获取系统配置 |
| PUT | `/api/admin/system/config` | 保存系统配置 |
| GET | `/api/admin/system/logs` | 获取系统日志 |
| GET | `/api/admin/staff` | 获取员工列表 |
| POST | `/api/admin/staff` | 新增员工 |
| PUT | `/api/admin/staff/:id/reset-password` | 重置员工密码 |

---

## 九、员工模块 `/api/staff`

> 需要 `staff` 角色 Token

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/staff/schedules` | 获取当日场次列表 |
| GET | `/api/staff/schedules/:id/seats` | 查看场次座位图 |
| GET | `/api/staff/orders/lookup` | 根据订单号/手机号查询订单 |
| POST | `/api/staff/orders/:id/ticket` | 出票核销 |
| POST | `/api/staff/orders/verify` | 扫码核销 |
| GET | `/api/staff/snacks` | 获取商品列表 |
| POST | `/api/staff/snacks` | 新增商品 |
| PUT | `/api/staff/snacks/:id` | 修改商品 |
| DELETE | `/api/staff/snacks/:id` | 删除商品 |
| PUT | `/api/staff/snacks/:id/available` | 上架/下架商品 |
| POST | `/api/staff/snacks/:id/stock` | 商品入库 |
| GET | `/api/staff/announcements` | 获取公告列表 |
| POST | `/api/staff/announcements` | 发布公告 |
| PUT | `/api/staff/announcements/:id` | 修改公告 |
| DELETE | `/api/staff/announcements/:id` | 删除公告 |
