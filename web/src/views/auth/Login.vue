<template>
  <div class="login-page">
    <div class="login-bg"></div>
    <div class="login-container">
      <div class="login-box">
        <div class="login-header">
          <div class="logo">
            <el-icon size="40" color="#e50914"><Film /></el-icon>
          </div>
          <h1>佳悦影院管理系统</h1>
          <p>JiaYue Cinema Management System</p>
        </div>

        <el-tabs v-model="activeTab" class="login-tabs">
          <el-tab-pane label="用户登录" name="user">
            <el-form ref="userFormRef" :model="userForm" :rules="rules" class="login-form">
              <el-form-item prop="username">
                <el-input
                  v-model="userForm.username"
                  placeholder="请输入用户名/手机号"
                  size="large"
                  :prefix-icon="User"
                />
              </el-form-item>
              <el-form-item prop="password">
                <el-input
                  v-model="userForm.password"
                  type="password"
                  placeholder="请输入密码"
                  size="large"
                  :prefix-icon="Lock"
                  show-password
                  @keyup.enter="handleLogin('user')"
                />
              </el-form-item>
              <div class="form-footer">
                <el-checkbox v-model="rememberMe">记住我</el-checkbox>
                <el-link type="primary" @click="$router.push('/reset-password')">忘记密码？</el-link>
              </div>
              <el-button type="danger" size="large" class="login-btn" :loading="loading" @click="handleLogin('user')">
                登录
              </el-button>
              <div class="register-link">
                还没有账号？<el-link type="primary" @click="$router.push('/register')">立即注册</el-link>
              </div>
            </el-form>
          </el-tab-pane>

          <el-tab-pane label="管理员" name="admin">
            <el-form ref="adminFormRef" :model="adminForm" :rules="rules" class="login-form">
              <el-form-item prop="username">
                <el-input
                  v-model="adminForm.username"
                  placeholder="管理员账号"
                  size="large"
                  :prefix-icon="User"
                />
              </el-form-item>
              <el-form-item prop="password">
                <el-input
                  v-model="adminForm.password"
                  type="password"
                  placeholder="管理员密码"
                  size="large"
                  :prefix-icon="Lock"
                  show-password
                  @keyup.enter="handleLogin('admin')"
                />
              </el-form-item>
              <el-button type="danger" size="large" class="login-btn" :loading="loading" @click="handleLogin('admin')">
                管理员登录
              </el-button>
            </el-form>
          </el-tab-pane>

          <el-tab-pane label="员工" name="staff">
            <el-form ref="staffFormRef" :model="staffForm" :rules="rules" class="login-form">
              <el-form-item prop="username">
                <el-input
                  v-model="staffForm.username"
                  placeholder="员工工号"
                  size="large"
                  :prefix-icon="User"
                />
              </el-form-item>
              <el-form-item prop="password">
                <el-input
                  v-model="staffForm.password"
                  type="password"
                  placeholder="员工密码"
                  size="large"
                  :prefix-icon="Lock"
                  show-password
                  @keyup.enter="handleLogin('staff')"
                />
              </el-form-item>
              <el-button type="danger" size="large" class="login-btn" :loading="loading" @click="handleLogin('staff')">
                员工登录
              </el-button>
            </el-form>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>

<script setup>
import { authApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { Film, Lock, User } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { reactive, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const activeTab = ref('user')
const loading = ref(false)
const rememberMe = ref(false)

const userForm = reactive({ username: '', password: '' })
const adminForm = reactive({ username: '', password: '' })
const staffForm = reactive({ username: '', password: '' })

const rules = {
  username: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const roleMap = { user: 0, admin: 2, staff: 1 }

const handleLogin = async (role) => {
  loading.value = true
  try {
    const formMap = { user: userForm, admin: adminForm, staff: staffForm }
    const form = formMap[role]
    
    const res = await authApi.login({
      username: form.username,
      password: form.password,
      role: roleMap[role]
    })
    
    if (res.code === 200) {
      // 构建用户信息对象
      const userInfo = {
        userId: res.data.userId,
        username: res.data.username,
        realName: res.data.realName,
        avatar: res.data.avatar,
        role: res.data.role
      }
      authStore.setAuth(res.data.token, userInfo)
      ElMessage.success('登录成功')
      
      const redirect = route.query.redirect
      if (role === 'admin') router.push(redirect || '/admin/dashboard')
      else if (role === 'staff') router.push(redirect || '/staff/schedules')
      else router.push(redirect || '/')
    } else {
      ElMessage.error(res.message || '登录失败')
    }
  } catch (err) {
    console.error('登录失败:', err)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  background: #f5f7fa;
}

.login-bg {
  position: absolute;
  inset: 0;
  background: url('/auth-bg.png') center/cover;
  opacity: 1;
}

.login-container {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 460px;
  padding: 20px;
}

.login-box {
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 16px;
  padding: 40px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
}

.login-header {
  text-align: center;
  margin-bottom: 32px;
}

.login-header .logo {
  width: 72px;
  height: 72px;
  background: rgba(59, 130, 246, 0.15);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  border: 2px solid rgba(59, 130, 246, 0.4);
}

.login-header h1 {
  color: var(--color-text);
  font-size: 22px;
  font-weight: 700;
  margin: 0 0 6px;
}

.login-header p {
  color: var(--color-text-muted);
  font-size: 12px;
  margin: 0;
}

.login-tabs :deep(.el-tabs__nav-wrap::after) {
  background: rgba(255, 255, 255, 0.1);
}

.login-tabs :deep(.el-tabs__item) {
  color: var(--color-text-muted);
}

.login-tabs :deep(.el-tabs__item.is-active) {
  color: var(--color-primary);
}

.login-tabs :deep(.el-tabs__active-bar) {
  background: var(--color-primary);
}

.login-form {
  margin-top: 24px;
}

.login-form :deep(.el-input__wrapper) {
  background: var(--color-surface-2);
  border-color: var(--color-border);
  box-shadow: none;
}

.login-form :deep(.el-input__wrapper:hover),
.login-form :deep(.el-input__wrapper.is-focus) {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 1px var(--color-primary);
}

.login-form :deep(.el-input__inner) {
  color: var(--color-text);
}

.login-form :deep(.el-input__inner::placeholder) {
  color: var(--color-text-muted);
}

.form-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.login-btn {
  width: 100%;
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #ffffff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 2px;
}

.login-btn:hover {
  background: var(--color-primary-hover);
}

.register-link {
  text-align: center;
  margin-top: 16px;
  color: var(--color-text-muted);
  font-size: 14px;
}
</style>
