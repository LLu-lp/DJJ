<template>
  <div class="reset-page">
    <div class="reset-bg"></div>
    <div class="reset-container">
      <div class="reset-box">
        <div class="reset-header">
          <el-icon size="36" color="#e50914"><Lock /></el-icon>
          <h1>重置密码</h1>
          <p>通过手机号验证重置您的密码</p>
        </div>

        <el-form ref="formRef" :model="form" :rules="rules" label-position="top" class="reset-form">
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="form.phone" placeholder="请输入注册手机号" :prefix-icon="Phone" size="large" />
          </el-form-item>
          
          <el-form-item label="验证码" prop="code">
            <el-row :gutter="12">
              <el-col :span="14">
                <el-input v-model="form.code" placeholder="请输入验证码" size="large" />
              </el-col>
              <el-col :span="10">
                <el-button 
                  type="danger" 
                  plain 
                  size="large"
                  style="width:100%" 
                  :disabled="countdown > 0" 
                  :loading="sendingCode" 
                  @click="sendCode"
                >
                  {{ countdown > 0 ? `${countdown}s后重发` : '获取验证码' }}
                </el-button>
              </el-col>
            </el-row>
          </el-form-item>

          <el-form-item label="新密码" prop="newPassword">
            <el-input 
              v-model="form.newPassword" 
              type="password" 
              placeholder="请输入新密码（至少6位）" 
              :prefix-icon="Lock" 
              size="large"
              show-password 
            />
          </el-form-item>

          <el-form-item label="确认密码" prop="confirmPassword">
            <el-input 
              v-model="form.confirmPassword" 
              type="password" 
              placeholder="再次输入新密码" 
              :prefix-icon="Lock" 
              size="large"
              show-password 
            />
          </el-form-item>

          <el-button type="danger" size="large" class="reset-btn" :loading="loading" @click="handleReset">
            确认重置
          </el-button>

          <div class="back-link">
            <el-link type="primary" @click="$router.push('/login')">
              <el-icon><ArrowLeft /></el-icon> 返回登录
            </el-link>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { authApi } from '@/api'
import { ArrowLeft, Lock, Phone } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const loading = ref(false)
const sendingCode = ref(false)
const countdown = ref(0)
const formRef = ref()

const form = reactive({
  phone: '',
  code: '',
  newPassword: '',
  confirmPassword: ''
})

const validateConfirmPwd = (rule, value, callback) => {
  if (value !== form.newPassword) callback(new Error('两次密码不一致'))
  else callback()
}

const rules = {
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  code: [{ required: true, message: '请输入验证码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '至少6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validateConfirmPwd, trigger: 'blur' }
  ]
}

const sendCode = async () => {
  if (!form.phone || !/^1[3-9]\d{9}$/.test(form.phone)) {
    return ElMessage.warning('请输入正确的手机号')
  }
  
  sendingCode.value = true
  try {
    const res = await authApi.sendCode({ phone: form.phone, type: 'reset' })
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

const handleReset = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  
  loading.value = true
  try {
    const res = await authApi.resetPassword({
      phone: form.phone,
      code: form.code,
      newPassword: form.newPassword
    })
    if (res.code === 200) {
      ElMessage.success('密码重置成功，请重新登录')
      router.push('/login')
    }
  } catch (err) {
    console.error('重置密码失败:', err)
    ElMessage.error(err.response?.data?.message || '重置失败')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.reset-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  position: relative;
}

.reset-bg {
  position: absolute;
  inset: 0;
  background: url('/auth-bg.png') center/cover;
  opacity: 1;
}

.reset-container {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 480px;
  padding: 20px;
}

.reset-box {
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 16px;
  padding: 40px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
}

.reset-header {
  text-align: center;
  margin-bottom: 28px;
}

.reset-header h1 {
  color: var(--color-text);
  font-size: 24px;
  margin: 12px 0 6px;
}

.reset-header p {
  color: var(--color-text-muted);
  font-size: 13px;
}

.reset-form :deep(.el-form-item__label) {
  color: var(--color-text-muted);
}

.reset-form :deep(.el-input__wrapper) {
  background: var(--color-surface-2);
  box-shadow: none;
  border-color: var(--color-border);
}

.reset-form :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px var(--color-primary);
  border-color: var(--color-primary);
}

.reset-form :deep(.el-input__inner) {
  color: var(--color-text);
}

.reset-form :deep(.el-input__inner::placeholder) {
  color: var(--color-text-muted);
}

.reset-btn {
  width: 100%;
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #ffffff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
  margin-top: 8px;
}

.reset-btn:hover {
  background: var(--color-primary-hover);
}

.back-link {
  text-align: center;
  margin-top: 20px;
}

.back-link :deep(.el-link) {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 14px;
}
</style>

