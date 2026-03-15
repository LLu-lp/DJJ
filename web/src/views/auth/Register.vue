<template>
  <div class="register-page">
    <div class="register-bg"></div>
    <div class="register-container">
      <div class="register-box">
        <div class="register-header">
          <el-icon size="36" color="#e50914"><Film /></el-icon>
          <h1>注册账号</h1>
          <p>加入佳悦影院，享受专属会员权益</p>
        </div>

        <el-form ref="formRef" :model="form" :rules="rules" label-position="top" class="register-form">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="form.username" placeholder="4-16位字母数字" :prefix-icon="User" />
          </el-form-item>
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="form.phone" placeholder="请输入手机号" :prefix-icon="Phone" />
          </el-form-item>
          <el-form-item label="验证码" prop="code">
          <el-row :gutter="12">
            <el-col :span="14">
                <el-input v-model="form.code" placeholder="请输入验证码" />
            </el-col>
            <el-col :span="10">
                <el-button type="danger" plain style="width:100%" :disabled="countdown > 0" :loading="sendingCode" @click="sendCode">
                  {{ countdown > 0 ? `${countdown}s后重发` : '获取验证码' }}
                </el-button>
            </el-col>
          </el-row>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="form.password" type="password" placeholder="8-20位，含字母和数字" :prefix-icon="Lock" show-password />
          </el-form-item>
          <el-form-item label="确认密码" prop="confirmPassword">
            <el-input v-model="form.confirmPassword" type="password" placeholder="再次输入密码" :prefix-icon="Lock" show-password />
          </el-form-item>
          <el-form-item prop="agree">
            <el-checkbox v-model="form.agree">
              我已阅读并同意 <el-link type="primary">用户协议</el-link> 和 <el-link type="primary">隐私政策</el-link>
            </el-checkbox>
          </el-form-item>

          <el-button type="danger" size="large" class="register-btn" :loading="loading" @click="handleRegister">
            立即注册
          </el-button>

          <div class="login-link">
            已有账号？<el-link type="primary" @click="$router.push('/login')">立即登录</el-link>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { authApi } from '@/api'
import { Film, Lock, Phone, User } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const loading = ref(false)
const sendingCode = ref(false)
const countdown = ref(0)

const form = reactive({
  username: '',
  phone: '',
  code: '',
  password: '',
  confirmPassword: '',
  agree: false
})

const validateConfirmPwd = (rule, value, callback) => {
  if (value !== form.password) callback(new Error('两次密码不一致'))
  else callback()
}

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 4, max: 16, message: '4-16位', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  code: [{ required: true, message: '请输入验证码', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '至少6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validateConfirmPwd, trigger: 'blur' }
  ],
  agree: [{ validator: (r, v, cb) => v ? cb() : cb(new Error('请阅读并同意协议')), trigger: 'change' }]
}

const sendCode = async () => {
  if (!form.phone || !/^1[3-9]\d{9}$/.test(form.phone)) {
    return ElMessage.warning('请输入正确的手机号')
  }
  
  sendingCode.value = true
  try {
    const res = await authApi.sendCode({ phone: form.phone })
    if (res.code === 200) {
      ElMessage.success('验证码已发送')
      countdown.value = 60
      const timer = setInterval(() => {
        countdown.value--
        if (countdown.value <= 0) clearInterval(timer)
      }, 1000)
    }
  } catch (err) {
    console.error('发送验证码失败:', err)
    ElMessage.error(err.response?.data?.message || '发送失败')
  } finally {
    sendingCode.value = false
  }
}

const formRef = ref()
const handleRegister = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  
  loading.value = true
  try {
    const res = await authApi.register({
      username: form.username,
      phone: form.phone,
      code: form.code,
      password: form.password
    })
    if (res.code === 200) {
      ElMessage.success('注册成功，请登录')
      router.push('/login')
    }
  } catch (err) {
    console.error('注册失败:', err)
    ElMessage.error(err.response?.data?.message || '注册失败')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.register-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  position: relative;
}

.register-bg {
  position: absolute;
  inset: 0;
  background: url('/auth-bg.png') center/cover;
  opacity: 1;
}

.register-container {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 480px;
  padding: 20px;
}

.register-box {
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 16px;
  padding: 40px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.1);
}

.register-header {
  text-align: center;
  margin-bottom: 28px;
}

.register-header h1 {
  color: var(--color-text);
  font-size: 24px;
  margin: 12px 0 6px;
}

.register-header p {
  color: var(--color-text-muted);
  font-size: 13px;
}

.register-form :deep(.el-form-item__label) {
  color: var(--color-text-muted);
}

.register-form :deep(.el-input__wrapper) {
  background: var(--color-surface-2);
  box-shadow: none;
  border-color: var(--color-border);
}

.register-form :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px var(--color-primary);
  border-color: var(--color-primary);
}

.register-form :deep(.el-input__inner) {
  color: var(--color-text);
}

.register-form :deep(.el-input__inner::placeholder) {
  color: var(--color-text-muted);
}

.register-form :deep(.el-checkbox__label) {
  color: var(--color-text-muted);
}

.register-btn {
  width: 100%;
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #ffffff;
  font-size: 16px;
}

.login-link {
  text-align: center;
  margin-top: 16px;
  color: var(--color-text-muted);
  font-size: 14px;
}
</style>
