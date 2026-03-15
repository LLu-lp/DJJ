<template>
  <div class="admin-layout">
    <!-- 侧边栏 -->
    <aside class="sidebar">
      <div class="sidebar-logo">
        <span class="logo-icon">🎬</span>
        <span class="logo-text">佳悦后台</span>
      </div>
      <el-menu
        :default-active="$route.path"
        router
        class="sidebar-menu"
      >
        <el-menu-item index="/admin/dashboard">
          <el-icon><TrendCharts /></el-icon>
          <span>数据总览</span>
        </el-menu-item>
        <el-menu-item index="/admin/movies">
          <el-icon><Film /></el-icon>
          <span>电影管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/cinemas">
          <el-icon><OfficeBuilding /></el-icon>
          <span>影院管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/schedules">
          <el-icon><Calendar /></el-icon>
          <span>场次管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/orders">
          <el-icon><List /></el-icon>
          <span>订单管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/users">
          <el-icon><User /></el-icon>
          <span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/member-config">
          <el-icon><Trophy /></el-icon>
          <span>会员体系</span>
        </el-menu-item>
        <el-menu-item index="/admin/coupons">
          <el-icon><Ticket /></el-icon>
          <span>优惠券管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/snacks">
          <el-icon><ShoppingCart /></el-icon>
          <span>商品管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/faq">
          <el-icon><QuestionFilled /></el-icon>
          <span>FAQ 管理</span>
        </el-menu-item>
        <el-menu-item index="/admin/system">
          <el-icon><Setting /></el-icon>
          <span>系统管理</span>
        </el-menu-item>
      </el-menu>
      <div class="sidebar-footer">
        <el-button link @click="handleLogout" style="color:var(--color-text-muted)">
          <el-icon><SwitchButton /></el-icon> 退出登录
        </el-button>
      </div>
    </aside>
    <!-- 主区域 -->
    <div class="admin-main">
      <div class="admin-topbar">
        <span class="page-title">{{ pageTitle }}</span>
        <div class="topbar-right">
          <span class="admin-tag">管理员</span>
          <el-avatar :size="28" style="background:#e8b84b;color:#1a1a1a;font-weight:700;margin-left:8px">A</el-avatar>
        </div>
      </div>
      <div class="admin-content">
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
import { QuestionFilled, Ticket, ShoppingCart } from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const titleMap = {
  '/admin/dashboard': '数据总览',
  '/admin/movies': '电影管理',
  '/admin/cinemas': '影院管理',
  '/admin/schedules': '场次管理',
  '/admin/orders': '订单管理',
  '/admin/users': '用户管理',
  '/admin/member-config': '会员体系配置',
  '/admin/coupons': '优惠券管理',
  '/admin/snacks': '商品管理',
  '/admin/faq': 'FAQ 管理',
  '/admin/system': '系统管理',
}
const pageTitle = computed(() => titleMap[route.path] || '管理后台')

function handleLogout() {
  authStore.logout()
  ElMessage.success('已退出登录')
  router.push('/login')
}
</script>

<style scoped>
.admin-layout {
  display: flex;
  height: 100vh;
  background: var(--color-bg);
}
.sidebar {
  width: 220px;
  flex-shrink: 0;
  background: var(--color-surface);
  border-right: 1px solid var(--color-border);
  display: flex;
  flex-direction: column;
}
.sidebar-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 20px 20px 16px;
  border-bottom: 1px solid var(--color-border);
}
.logo-icon { font-size: 22px; }
.logo-text { font-size: 16px; font-weight: 700; color: var(--color-primary); }
.sidebar-menu { border-right: none !important; flex: 1; overflow-y: auto; }
.sidebar-footer {
  padding: 12px 20px;
  border-top: 1px solid var(--color-border);
}
.admin-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
.admin-topbar {
  height: 56px;
  padding: 0 24px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid var(--color-border);
  background: var(--color-surface);
}
.page-title { font-size: 16px; font-weight: 600; color: var(--color-text); }
.topbar-right { display: flex; align-items: center; }
.admin-tag {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 4px;
  background: var(--color-primary-light);
  color: var(--color-primary);
  border: 1px solid rgba(232,184,75,0.3);
}
.admin-content {
  flex: 1;
  overflow-y: auto;
  padding: 24px;
}
</style>
