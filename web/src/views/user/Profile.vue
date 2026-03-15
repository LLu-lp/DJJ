<template>
  <div class="profile-page">
    <h1 class="page-title">个人中心</h1>
    <div class="profile-layout">
      <el-card class="profile-card">
        <div class="avatar-section">
          <el-avatar :size="80" style="background:#e8b84b;color:#1a1a1a;font-size:32px;font-weight:700">
            {{ form.username?.[0]?.toUpperCase() }}
          </el-avatar>
          <h2 class="profile-name">{{ form.realName || form.username }}</h2>
          <el-tag type="warning" size="small">{{ roleLabel(form.role) }}</el-tag>
        </div>
        <el-form :model="form" label-width="80px" style="margin-top:24px">
          <el-form-item label="用户名">
            <el-input v-model="form.username" disabled />
          </el-form-item>
          <el-form-item label="姓名">
            <el-input v-model="form.realName" />
          </el-form-item>
          <el-form-item label="手机号">
            <el-input v-model="form.phone" />
          </el-form-item>
          <el-form-item label="邮箱">
            <el-input v-model="form.email" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="saving" @click="saveProfile">保存修改</el-button>
          </el-form-item>
        </el-form>
      </el-card>

      <el-card class="password-card">
        <h3 class="card-title">修改密码</h3>
        <el-form :model="pwdForm" label-width="100px">
          <el-form-item label="当前密码">
            <el-input v-model="pwdForm.oldPassword" type="password" show-password />
          </el-form-item>
          <el-form-item label="新密码">
            <el-input v-model="pwdForm.newPassword" type="password" show-password />
          </el-form-item>
          <el-form-item label="确认新密码">
            <el-input v-model="pwdForm.confirmPassword" type="password" show-password />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="changingPwd" @click="changePassword">修改密码</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { authApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { ElMessage } from 'element-plus'
import { onMounted, ref } from 'vue'

const authStore = useAuthStore()
const saving = ref(false)
const changingPwd = ref(false)

const form = ref({
  username: '',
  realName: '',
  phone: '',
  email: '',
  role: 0,
})

const pwdForm = ref({ oldPassword: '', newPassword: '', confirmPassword: '' })

const roleLabel = (r) => ({ 0: '普通用户', 1: '员工', 2: '管理员' }[r] || '普通用户')

onMounted(async () => {
  await fetchProfile()
})

const fetchProfile = async () => {
  try {
    const res = await authApi.getInfo()
    if (res.code === 200 && res.data) {
      form.value = {
        username: res.data.username || '',
        realName: res.data.realName || '',
        phone: res.data.phone || '',
        email: res.data.email || '',
        role: res.data.role ?? 0,
      }
    }
  } catch (err) {
    console.error('获取用户信息失败:', err)
  }
}

async function saveProfile() {
  saving.value = true
  try {
    const res = await authApi.updateProfile({
      realName: form.value.realName,
      phone: form.value.phone,
      email: form.value.email,
    })
    if (res.code === 200) {
      ElMessage.success('个人信息已更新')
    }
  } catch (err) {
    console.error('更新个人信息失败:', err)
    ElMessage.error(err.response?.data?.message || '更新失败')
  } finally {
    saving.value = false
  }
}

async function changePassword() {
  if (!pwdForm.value.oldPassword) return ElMessage.error('请输入当前密码')
  if (!pwdForm.value.newPassword) return ElMessage.error('请输入新密码')
  if (pwdForm.value.newPassword !== pwdForm.value.confirmPassword) return ElMessage.error('两次密码不一致')
  
  changingPwd.value = true
  try {
    const res = await authApi.changePassword({
      oldPassword: pwdForm.value.oldPassword,
      newPassword: pwdForm.value.newPassword,
    })
    if (res.code === 200) {
      ElMessage.success('密码修改成功')
      pwdForm.value = { oldPassword: '', newPassword: '', confirmPassword: '' }
    }
  } catch (err) {
    console.error('修改密码失败:', err)
    ElMessage.error(err.response?.data?.message || '修改失败')
  } finally {
    changingPwd.value = false
  }
}
</script>

<style scoped>
.profile-page { padding-bottom: 40px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); margin-bottom: 24px; }
.profile-layout { display: grid; grid-template-columns: 320px 1fr; gap: 24px; }
.avatar-section { text-align: center; padding-bottom: 20px; border-bottom: 1px solid var(--color-border); }
.profile-name { font-size: 20px; font-weight: 700; color: var(--color-text); margin: 12px 0 6px; }
.card-title { font-size: 16px; font-weight: 600; color: var(--color-text); margin-bottom: 20px; }
</style>
