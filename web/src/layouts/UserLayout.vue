<template>
  <div class="user-layout">
    <!-- 顶部导航 -->
    <header class="header">
      <div class="header-inner">
        <div class="logo" @click="$router.push('/')">
          <span class="logo-icon">🎬</span>
          <span class="logo-text">佳悦影院</span>
        </div>
        <nav class="nav">
          <router-link to="/" class="nav-link">首页</router-link>
          <router-link to="/movies" class="nav-link">电影</router-link>
          <router-link to="/cinemas" class="nav-link">影院</router-link>
          <router-link to="/announcements" class="nav-link">公告</router-link>
          <router-link to="/ranking" class="nav-link">排行榜</router-link>
          <router-link to="/snacks" class="nav-link">小吃</router-link>
          <router-link v-if="authStore.isLoggedIn" to="/coupons" class="nav-link">优惠券</router-link>
          <router-link v-if="authStore.isLoggedIn" to="/chat" class="nav-link">客服</router-link>
          <router-link v-if="authStore.isLoggedIn" to="/favorites" class="nav-link">收藏</router-link>
        </nav>
        <div class="header-right">
          <template v-if="authStore.isLoggedIn">
            <el-dropdown @command="handleCommand">
              <div class="user-avatar">
                <el-avatar :size="32" :src="authStore.user?.avatar" style="background:#3b82f6;color:#ffffff;font-weight:700">
                  {{ authStore.user?.username?.[0]?.toUpperCase() || 'U' }}
                </el-avatar>
                <span class="username">{{ authStore.user?.username }}</span>
              </div>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                  <el-dropdown-item command="orders">我的订单</el-dropdown-item>
                  <el-dropdown-item command="member">会员中心</el-dropdown-item>
                  <el-dropdown-item command="favorites">我的收藏</el-dropdown-item>
                  <el-dropdown-item command="myComments">我的评论</el-dropdown-item>
                  <el-dropdown-item command="digitalTickets">数字纪念票</el-dropdown-item>
                  <el-dropdown-item divided command="logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </template>
          <template v-else>
            <el-button size="small" @click="$router.push('/login')" style="margin-right:8px">登录</el-button>
            <el-button size="small" type="primary" @click="$router.push('/register')">注册</el-button>
          </template>
        </div>
      </div>
    </header>
    <!-- 主内容 -->
    <main class="main-content">
      <router-view />
    </main>
    <!-- 底部 -->
    <footer class="footer">
      <p>© 2026 佳悦影院管理系统 · 保留所有权利</p>
    </footer>
  </div>
</template>

<script setup>
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const authStore = useAuthStore()
const router = useRouter()

function handleCommand(cmd) {
  if (cmd === 'logout') {
    authStore.logout()
    ElMessage.success('已退出登录')
    router.push('/')
  } else if (cmd === 'profile') {
    router.push('/profile')
  } else if (cmd === 'orders') {
    router.push('/orders')
  } else if (cmd === 'member') {
    router.push('/member')
  } else if (cmd === 'favorites') {
    router.push('/favorites')
  } else if (cmd === 'myComments') {
    router.push('/my-comments')
  } else if (cmd === 'digitalTickets') {
    router.push('/digital-tickets')
  }
}
</script>

<style scoped>
.user-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: var(--color-bg);
}
.header {
  position: sticky;
  top: 0;
  z-index: 100;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--color-border);
}
.header-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 24px;
  height: 64px;
  display: flex;
  align-items: center;
  gap: 40px;
}
.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  text-decoration: none;
}
.logo-icon { font-size: 24px; }
.logo-text {
  font-size: 20px;
  font-weight: 700;
  color: var(--color-primary);
  letter-spacing: 1px;
}
.nav {
  display: flex;
  gap: 8px;
  flex: 1;
}
.nav-link {
  padding: 6px 14px;
  border-radius: 6px;
  color: var(--color-text-muted);
  text-decoration: none;
  font-size: 14px;
  transition: all .2s;
}
.nav-link:hover, .nav-link.router-link-active {
  color: var(--color-text);
  background: var(--color-surface-2);
}
.nav-link.router-link-exact-active {
  color: var(--color-primary);
}
.header-right {
  display: flex;
  align-items: center;
  gap: 8px;
}
.user-avatar {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 8px;
  transition: background .2s;
}
.user-avatar:hover { background: var(--color-surface-2); }
.username { font-size: 14px; color: var(--color-text); }
.main-content {
  flex: 1;
  max-width: 1280px;
  width: 100%;
  margin: 0 auto;
  padding: 24px;
}
.footer {
  text-align: center;
  padding: 20px;
  color: var(--color-text-muted);
  font-size: 12px;
  border-top: 1px solid var(--color-border);
}
</style>
