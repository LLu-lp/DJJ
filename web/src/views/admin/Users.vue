<template>
  <div class="page-container">
    <div class="page-header">
      <h2>用户管理</h2>
      <el-input v-model="query.keyword" placeholder="搜索用户名/手机号" style="width:220px" clearable @keyup.enter="fetchUsers">
        <template #prefix><el-icon><Search /></el-icon></template>
      </el-input>
    </div>

    <el-card>
      <el-table :data="users" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column label="用户" min-width="150">
          <template #default="{ row }">
            <div style="display:flex;align-items:center;gap:10px">
              <el-avatar :size="36" :src="row.avatar">{{ row.username?.[0]?.toUpperCase() }}</el-avatar>
              <div>
                <div style="font-weight:600">{{ row.nickname || row.username }}</div>
                <div style="font-size:12px;color:var(--color-text-muted)">@{{ row.username }}</div>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="phone" label="手机号" width="130" />
        <el-table-column label="角色" width="100">
          <template #default="{ row }">
            <el-tag :type="roleType(row.role)" size="small">{{ roleLabel(row.role) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">
              {{ row.status === 1 ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="注册时间" width="160" />
        <el-table-column label="操作" width="130" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="primary" text @click="viewUser(row)">详情</el-button>
            <el-button size="small" :type="row.status === 1 ? 'danger' : 'success'" text @click="toggleStatus(row)">
              {{ row.status === 1 ? '禁用' : '启用' }}
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-model:current-page="page"
        :total="total"
        :page-size="size"
        layout="total, prev, pager, next"
        class="mt-16"
        @current-change="fetchUsers"
      />
    </el-card>

    <el-drawer v-model="drawerVisible" title="用户详情" size="400px">
      <template v-if="currentUser">
        <div class="user-info-header">
          <el-avatar :size="64" :src="currentUser.avatar">{{ currentUser.username?.[0]?.toUpperCase() }}</el-avatar>
          <div>
            <div class="user-name">{{ currentUser.nickname || currentUser.username }}</div>
            <el-tag :type="roleType(currentUser.role)" size="small">{{ roleLabel(currentUser.role) }}</el-tag>
          </div>
        </div>
        <el-descriptions :column="1" border class="mt-16">
          <el-descriptions-item label="用户名">{{ currentUser.username }}</el-descriptions-item>
          <el-descriptions-item label="手机号">{{ currentUser.phone }}</el-descriptions-item>
          <el-descriptions-item label="邮箱">{{ currentUser.email }}</el-descriptions-item>
          <el-descriptions-item label="余额">¥{{ currentUser.balance || 0 }}</el-descriptions-item>
          <el-descriptions-item label="注册时间">{{ currentUser.createdAt }}</el-descriptions-item>
        </el-descriptions>
      </template>
    </el-drawer>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const query = reactive({ keyword: '' })
const page = ref(1)
const size = ref(10)
const total = ref(0)
const users = ref([])
const drawerVisible = ref(false)
const currentUser = ref(null)

const roleLabel = (r) => ({ 0: '普通用户', 1: '员工', 2: '管理员' }[r] || '未知')
const roleType = (r) => ({ 0: 'info', 1: 'warning', 2: 'danger' }[r] || 'info')

const fetchUsers = async () => {
  loading.value = true
  try {
    const res = await adminApi.getUsers({
      keyword: query.keyword,
      page: page.value,
      size: size.value
    })
    if (res.code === 200) {
      users.value = res.data?.records || []
      total.value = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取用户列表失败:', err)
  } finally {
    loading.value = false
  }
}

const viewUser = (row) => {
  currentUser.value = row
  drawerVisible.value = true
}

const toggleStatus = (row) => {
  const action = row.status === 1 ? '禁用' : '启用'
  const newStatus = row.status === 1 ? 0 : 1
  
  ElMessageBox.confirm(`确定${action}用户 ${row.username}？`, '提示', { type: 'warning' }).then(async () => {
    try {
      const res = await adminApi.updateUserStatus(row.id, newStatus)
      if (res.code === 200) {
        row.status = newStatus
        ElMessage.success(`${action}成功`)
      }
    } catch (err) {
      console.error('更新用户状态失败:', err)
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchUsers()
})
</script>

<style scoped>
.mt-16 { margin-top: 16px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.user-info-header { display: flex; align-items: center; gap: 16px; margin-bottom: 20px; }
.user-name { font-size: 18px; font-weight: 600; margin-bottom: 6px; }
</style>
