<template>
  <div class="staff-layout">
    <aside class="sidebar">
      <div class="sidebar-logo">
        <span class="logo-icon">🎬</span>
        <span class="logo-text">员工后台</span>
      </div>
      <el-menu :default-active="$route.path" router class="sidebar-menu">
        <el-menu-item index="/staff/schedules">
          <el-icon><Calendar /></el-icon>
          <span>场次管理</span>
        </el-menu-item>
        <el-menu-item index="/staff/orders">
          <el-icon><List /></el-icon>
          <span>订单管理</span>
        </el-menu-item>
        <el-menu-item index="/staff/snacks">
          <el-icon><GoodsFilled /></el-icon>
          <span>商品管理</span>
        </el-menu-item>
        <el-menu-item index="/staff/customer-service">
          <el-icon><ChatDotRound /></el-icon>
          <span>在线客服</span>
        </el-menu-item>
        <el-menu-item index="/staff/announcements">
          <el-icon><Bell /></el-icon>
          <span>公告通知</span>
        </el-menu-item>
      </el-menu>
      <div class="sidebar-footer">
        <el-button link @click="handleLogout" style="color:var(--color-text-muted)">
          <el-icon><SwitchButton /></el-icon> 退出登录
        </el-button>
      </div>
    </aside>
    <div class="staff-main">
      <div class="staff-topbar">
        <span class="page-title">{{ pageTitle }}</span>
        <div class="topbar-right">
          <span class="staff-tag">影院员工</span>
          <el-avatar :size="28" style="background:#4caf82;color:#fff;font-weight:700;margin-left:8px">S</el-avatar>
        </div>
      </div>
      <div class="staff-content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { ElMessage } from 'element-plus'
import { Calendar, List, GoodsFilled, ChatDotRound, Bell, SwitchButton } from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const titleMap = {
  '/staff/schedules': '放映场次管理',
  '/staff/orders': '订单管理',
  '/staff/snacks': '小吃商品管理',
  '/staff/customer-service': '在线客服',
  '/staff/announcements': '公告通知',
}
const pageTitle = computed(() => titleMap[route.path] || '员工后台')

function handleLogout() {
  authStore.logout()
  ElMessage.success('已退出登录')
  router.push('/login')
}
</script>

<style scoped>
.staff-layout { display: flex; height: 100vh; background: var(--color-bg); }
.sidebar { width: 200px; flex-shrink: 0; background: var(--color-surface); border-right: 1px solid var(--color-border); display: flex; flex-direction: column; }
.sidebar-logo { display: flex; align-items: center; gap: 10px; padding: 20px 20px 16px; border-bottom: 1px solid var(--color-border); }
.logo-icon { font-size: 22px; }
.logo-text { font-size: 16px; font-weight: 700; color: #4caf82; }
.sidebar-menu { border-right: none !important; flex: 1; }
.sidebar-footer { padding: 12px 20px; border-top: 1px solid var(--color-border); }
.staff-main { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
.staff-topbar { height: 56px; padding: 0 24px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid var(--color-border); background: var(--color-surface); }
.page-title { font-size: 16px; font-weight: 600; color: var(--color-text); }
.topbar-right { display: flex; align-items: center; }
.staff-tag { font-size: 12px; padding: 2px 8px; border-radius: 4px; background: rgba(76,175,130,0.15); color: #4caf82; border: 1px solid rgba(76,175,130,0.3); }
.staff-content { flex: 1; overflow-y: auto; padding: 24px; }
</style>
