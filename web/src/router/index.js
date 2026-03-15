import { createRouter, createWebHashHistory } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

// 用户端路由
const userRoutes = [
  {
    path: '/',
    component: () => import('@/layouts/UserLayout.vue'),
    children: [
      { path: '', name: 'Home', component: () => import('@/views/user/Home.vue') },
      { path: 'movies', name: 'Movies', component: () => import('@/views/user/Movies.vue') },
      { path: 'movies/:id', name: 'MovieDetail', component: () => import('@/views/user/MovieDetail.vue') },
      { path: 'cinemas', name: 'Cinemas', component: () => import('@/views/user/Cinemas.vue') },
      { path: 'cinemas/:id', name: 'CinemaDetail', component: () => import('@/views/user/CinemaDetail.vue') },
      { path: 'booking/:movieId', name: 'Booking', component: () => import('@/views/user/Booking.vue') },
      { path: 'seat/:scheduleId', name: 'SeatSelect', component: () => import('@/views/user/SeatSelect.vue') },
      { path: 'orders', name: 'Orders', component: () => import('@/views/user/Orders.vue'), meta: { requiresAuth: true } },
      { path: 'member', name: 'Member', component: () => import('@/views/user/Member.vue'), meta: { requiresAuth: true } },
      { path: 'coupons', name: 'Coupons', component: () => import('@/views/user/Coupons.vue'), meta: { requiresAuth: true } },
      { path: 'snacks', name: 'Snacks', component: () => import('@/views/user/Snacks.vue') },
      { path: 'announcements', name: 'Announcements', component: () => import('@/views/user/Announcements.vue') },
      { path: 'ranking', name: 'Ranking', component: () => import('@/views/user/Ranking.vue') },
      { path: 'profile', name: 'Profile', component: () => import('@/views/user/Profile.vue'), meta: { requiresAuth: true } },
      { path: 'chat', name: 'Chat', component: () => import('@/views/user/Chat.vue'), meta: { requiresAuth: true } },
      { path: 'favorites', name: 'Favorites', component: () => import('@/views/user/Favorites.vue'), meta: { requiresAuth: true } },
      { path: 'digital-tickets', name: 'DigitalTickets', component: () => import('@/views/user/DigitalTickets.vue'), meta: { requiresAuth: true } },
    ]
  }
]

// 管理员端路由
const adminRoutes = [
  {
    path: '/admin',
    component: () => import('@/layouts/AdminLayout.vue'),
    meta: { requiresAuth: true, role: 'admin' },
    children: [
      { path: '', redirect: '/admin/dashboard' },
      { path: 'dashboard', name: 'AdminDashboard', component: () => import('@/views/admin/Dashboard.vue') },
      { path: 'movies', name: 'AdminMovies', component: () => import('@/views/admin/Movies.vue') },
      { path: 'cinemas', name: 'AdminCinemas', component: () => import('@/views/admin/Cinemas.vue') },
      { path: 'schedules', name: 'AdminSchedules', component: () => import('@/views/admin/Schedules.vue') },
      { path: 'orders', name: 'AdminOrders', component: () => import('@/views/admin/Orders.vue') },
      { path: 'users', name: 'AdminUsers', component: () => import('@/views/admin/Users.vue') },
      { path: 'member-config', name: 'AdminMemberConfig', component: () => import('@/views/admin/MemberConfig.vue') },
      { path: 'coupons', name: 'AdminCoupons', component: () => import('@/views/admin/CouponManage.vue') },
      { path: 'system', name: 'AdminSystem', component: () => import('@/views/admin/System.vue') },
      { path: 'faq', name: 'AdminFAQ', component: () => import('@/views/admin/FAQManage.vue') },
    ]
  }
]

// 员工端路由
const staffRoutes = [
  {
    path: '/staff',
    component: () => import('@/layouts/StaffLayout.vue'),
    meta: { requiresAuth: true, role: 'staff' },
    children: [
      { path: '', redirect: '/staff/schedules' },
      { path: 'schedules', name: 'StaffSchedules', component: () => import('@/views/staff/Schedules.vue') },
      { path: 'orders', name: 'StaffOrders', component: () => import('@/views/staff/Orders.vue') },
      { path: 'snacks', name: 'StaffSnacks', component: () => import('@/views/staff/Snacks.vue') },
      { path: 'customer-service', name: 'StaffCustomerService', component: () => import('@/views/staff/CustomerService.vue') },
      { path: 'announcements', name: 'StaffAnnouncements', component: () => import('@/views/staff/Announcements.vue') },
    ]
  }
]

// 公共路由
const publicRoutes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/auth/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/auth/Register.vue')
  },
  {
    path: '/reset-password',
    name: 'ResetPassword',
    component: () => import('@/views/auth/ResetPassword.vue')
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/NotFound.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes: [...userRoutes, ...adminRoutes, ...staffRoutes, ...publicRoutes],
  scrollBehavior() {
    return { top: 0 }
  }
})

// 路由守卫
router.beforeEach((to, _from, next) => {
  const authStore = useAuthStore()
  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    next({ name: 'Login', query: { redirect: to.fullPath } })
  } else {
    next()
  }
})

export default router
