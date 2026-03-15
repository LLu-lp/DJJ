import request from '@/utils/request'

export const authApi = {
  login: (data) => request.post('/auth/login', data),
  register: (data) => request.post('/auth/register', data),
  logout: () => request.post('/auth/logout'),
  getInfo: () => request.get('/auth/info'),
  updateProfile: (data) => request.put('/auth/profile', data),
  changePassword: (data) => request.put('/auth/password', null, { params: data }),
  sendCode: (data) => request.post('/auth/send-code', data),
  resetPassword: (data) => request.post('/auth/reset-password', data),
}

export const movieApi = {
  getPage: (params) => request.get('/movies/page', { params }),
  getDetail: (id) => request.get(`/movies/${id}`),
  getNowShowing: () => request.get('/movies/now-showing'),
  getComingSoon: () => request.get('/movies/coming-soon'),
  create: (data) => request.post('/movies', data),
  update: (id, data) => request.put(`/movies/${id}`, data),
  delete: (id) => request.delete(`/movies/${id}`),
  getReviews: (id) => request.get(`/movies/${id}/reviews`),
  addReview: (id, data) => request.post(`/movies/${id}/reviews`, data),
  // 收藏
  favorite: (id) => request.post(`/favorites/movies/${id}`),
  unfavorite: (id) => request.delete(`/favorites/movies/${id}`),
  isFavorited: (id) => request.get(`/favorites/movies/${id}`),
  getMyFavorites: () => request.get('/favorites/movies'),
}

export const cinemaApi = {
  getPage: (params) => request.get('/cinemas/page', { params }),
  getDetail: (id) => request.get(`/cinemas/${id}`),
  getList: () => request.get('/cinemas/list'),
  create: (data) => request.post('/cinemas', data),
  update: (id, data) => request.put(`/cinemas/${id}`, data),
  delete: (id) => request.delete(`/cinemas/${id}`),
  getHalls: (cinemaId) => request.get(`/cinemas/${cinemaId}/halls`),
  createHall: (data) => request.post('/cinemas/halls', data),
  updateHall: (id, data) => request.put(`/cinemas/halls/${id}`, data),
  deleteHall: (id) => request.delete(`/cinemas/halls/${id}`),
}

export const scheduleApi = {
  getPage: (params) => request.get('/schedules/page', { params }),
  getDetail: (id) => request.get(`/schedules/${id}`),
  getSeats: (scheduleId) => request.get(`/schedules/${scheduleId}/seats`),
  getByMovieAndCinema: (movieId, cinemaId) => request.get(`/schedules/movie/${movieId}/cinema/${cinemaId}`),
  create: (data) => request.post('/schedules', data),
  update: (id, data) => request.put(`/schedules/${id}`, data),
  delete: (id) => request.delete(`/schedules/${id}`),
  lockSeats: (scheduleId, data) => request.post(`/schedules/${scheduleId}/lock-seats`, data),
  unlockSeats: (scheduleId, data) => request.post(`/schedules/${scheduleId}/unlock-seats`, data),
}

export const orderApi = {
  create: (data) => request.post('/orders', data),
  getMyOrders: (params) => request.get('/orders/page', { params }),
  getDetail: (orderId) => request.get(`/orders/${orderId}`),
  cancel: (orderId) => request.post(`/orders/${orderId}/cancel`),
  pay: (orderId, data) => request.post(`/orders/${orderId}/pay`, null, { params: data }),
  refund: (orderId) => request.post(`/orders/${orderId}/refund`),
}

export const memberApi = {
  getInfo: () => request.get('/member/info'),
  recharge: (data) => request.post('/member/recharge', null, { params: data }),
  getPointsLog: (params) => request.get('/member/points-logs', { params }),
  getRechargeLogs: (params) => request.get('/member/recharge-logs', { params }),
}

export const snackApi = {
  getList: (params) => request.get('/snacks/list', { params }),
  getPage: (params) => request.get('/snacks/page', { params }),
  getDetail: (id) => request.get(`/snacks/${id}`),
  create: (data) => request.post('/snacks', data),
  update: (id, data) => request.put(`/snacks/${id}`, data),
  delete: (id) => request.delete(`/snacks/${id}`),
}

export const adminApi = {
  getStatistics: () => request.get('/admin/statistics'),
  getUsers: (params) => request.get('/admin/users', { params }),
  updateUserStatus: (id, status) => request.put(`/admin/users/${id}/status`, null, { params: { status } }),
  addStaff: (data) => request.post('/admin/staff', data),
  getMemberLevels: () => request.get('/admin/member-levels'),
  addMemberLevel: (data) => request.post('/admin/member-levels', data),
  updateMemberLevel: (level, data) => request.put(`/admin/member-levels/${level}`, data),
  deleteMemberLevel: (level) => request.delete(`/admin/member-levels/${level}`),
  getExchangeItems: (params) => request.get('/admin/exchange-items', { params }),
  addExchangeItem: (data) => request.post('/admin/exchange-items', data),
  updateExchangeItem: (id, data) => request.put(`/admin/exchange-items/${id}`, data),
  deleteExchangeItem: (id) => request.delete(`/admin/exchange-items/${id}`),
  getCoupons: (page, size) => request.get('/admin/coupons/page', { params: { page, size } }),
  createCoupon: (data) => request.post('/admin/coupons', data),
  updateCoupon: (id, data) => request.put(`/admin/coupons/${id}`, data),
  deleteCoupon: (id) => request.delete(`/admin/coupons/${id}`),
  getConfig: () => request.get('/admin/system/config'),
  updateConfig: (data) => request.put('/admin/system/config', data),
  getSystemLogs: (params) => request.get('/admin/system/logs', { params }),
  getOrders: (params) => request.get('/admin/orders', { params }),
  getOrderDetail: (id) => request.get(`/admin/orders/${id}`),
  refundOrder: (id) => request.post(`/admin/orders/${id}/refund`),
  exportOrders: (params) => request.get('/admin/orders/export', { params, responseType: 'blob' }),
  getReviews: (params) => request.get('/admin/reviews', { params }),
  approveReview: (id) => request.put(`/admin/reviews/${id}/approve`),
  rejectReview: (id) => request.put(`/admin/reviews/${id}/reject`),
  deleteReview: (id) => request.delete(`/admin/reviews/${id}`),
  getOrderStats: (params) => request.get('/admin/order-stats', { params }),
}

export const staffApi = {
  getTodaySchedules: () => request.get('/staff/schedules/today'),
  getOrders: (params) => request.get('/staff/orders', { params }),
  verifyTicket: (code) => request.post('/staff/orders/verify', { code }),
  getScheduleStats: (scheduleId) => request.get(`/staff/schedules/${scheduleId}/stats`),
}

export const announcementApi = {
  getList: (params) => request.get('/announcements/list', { params }),
  getPage: (params) => request.get('/announcements/page', { params }),
  getDetail: (id) => request.get(`/announcements/${id}`),
  create: (data) => request.post('/announcements', data),
  update: (id, data) => request.put(`/announcements/${id}`, data),
  delete: (id) => request.delete(`/announcements/${id}`),
}

export const publicApi = {
  getStatistics: () => request.get('/public/statistics'),
  getMemberLevels: () => request.get('/public/member-levels'),
}

export const exchangeApi = {
  getItems: () => request.get('/exchange/items'),
  exchange: (itemId) => request.post(`/exchange/items/${itemId}`),
  getRecords: (params) => request.get('/exchange/records', { params }),
}

export const carouselApi = {
  getList: () => request.get('/carousels/list'),
  getActive: () => request.get('/carousels/active'),
  create: (data) => request.post('/carousels', data),
  update: (id, data) => request.put(`/carousels/${id}`, data),
  delete: (id) => request.delete(`/carousels/${id}`),
}

export const faqApi = {
  getList: () => request.get('/faq/list'),
  getByCategory: (category) => request.get(`/faq/category/${category}`),
  getDetail: (id) => request.get(`/faq/${id}`),
}

export const chatApi = {
  getHistory: (userId) => request.get(`/chat/history/${userId}`),
  getUnreadCount: (userId) => request.get(`/chat/unread/${userId}`),
  markAsRead: (messageId) => request.put(`/chat/read/${messageId}`),
  getChatUsers: () => request.get('/chat/users'),
}

export const couponApi = {
  getAvailable: () => request.get('/coupons/available'),
  receive: (couponId) => request.post(`/coupons/receive/${couponId}`),
  getMyCoupons: (status) => request.get('/coupons/my', { params: { status } }),
}
