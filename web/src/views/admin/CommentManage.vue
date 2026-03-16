<template>
  <div class="comment-manage">
    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-row :gutter="16" align="middle">
        <el-col :span="8">
          <el-input v-model="keyword" placeholder="搜索电影名或用户..." clearable @input="filterComments">
            <template #prefix><el-icon><Search /></el-icon></template>
          </el-input>
        </el-col>
        <el-col :span="8">
          <el-select v-model="filterStatus" placeholder="筛选状态" clearable @change="filterComments">
            <el-option label="全部" value="" />
            <el-option label="已发布" value="1" />
            <el-option label="已删除" value="0" />
          </el-select>
        </el-col>
        <el-col :span="8">
          <el-button @click="resetQuery">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 评论列表 -->
    <el-card class="table-card">
      <el-table
        :data="comments"
        stripe
        style="width: 100%"
        v-loading="loading"
      >
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="movieTitle" label="电影" min-width="150" />
        <el-table-column prop="username" label="用户" width="120" />
        <el-table-column prop="rating" label="评分" width="130">
          <template #default="{ row }">
            <el-rate v-model="row.rating" disabled size="small" />
          </template>
        </el-table-column>
        <el-table-column prop="content" label="评论内容" min-width="200" show-overflow-tooltip />
        <el-table-column prop="createdAt" label="发布时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createdAt) }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '已发布' : '已删除' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button
              v-if="row.status === 1"
              type="danger"
              size="small"
              @click="deleteComment(row.id)"
            >
              删除
            </el-button>
            <el-button
              v-else
              type="primary"
              size="small"
              @click="restoreComment(row.id)"
            >
              恢复
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.size"
        :total="pagination.total"
        layout="total, prev, pager, next"
        class="mt-16"
        @current-change="filterComments"
      />
    </el-card>
  </div>
</template>

<script setup>
import { useAuthStore } from '@/stores/auth'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const authStore = useAuthStore()
const allComments = ref([])
const comments = ref([])
const keyword = ref('')
const filterStatus = ref('')
const loading = ref(false)
const pagination = reactive({ page: 1, size: 10, total: 0 })

const fetchComments = async () => {
  loading.value = true
  try {
    const res = await fetch('/api/admin/comments', {
      headers: {
        'Authorization': `Bearer ${authStore.token}`
      }
    })
    const data = await res.json()
    if (data.code === 200) {
      allComments.value = data.data || []
      filterComments()
    } else {
      ElMessage.error(data.message || '获取评论失败')
    }
  } catch (err) {
    console.error('获取评论失败:', err)
    ElMessage.error('获取评论失败')
  } finally {
    loading.value = false
  }
}

const filterComments = () => {
  let filtered = allComments.value

  // 按状态筛选
  if (filterStatus.value) {
    filtered = filtered.filter(c => c.status === parseInt(filterStatus.value))
  }

  // 按关键词搜索
  if (keyword.value) {
    filtered = filtered.filter(c =>
      c.movieTitle.includes(keyword.value) ||
      c.username.includes(keyword.value) ||
      c.content.includes(keyword.value)
    )
  }

  // 分页
  pagination.total = filtered.length
  const start = (pagination.page - 1) * pagination.size
  const end = start + pagination.size
  comments.value = filtered.slice(start, end)
}

const resetQuery = () => {
  keyword.value = ''
  filterStatus.value = ''
  pagination.page = 1
  filterComments()
}

const deleteComment = async (commentId) => {
  try {
    await ElMessageBox.confirm('确定要删除这条评论吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    const res = await fetch(`/api/admin/comments/${commentId}`, {
      method: 'DELETE',
      headers: {
        'Authorization': `Bearer ${authStore.token}`
      }
    })
    const data = await res.json()
    if (data.code === 200) {
      ElMessage.success('删除成功')
      fetchComments()
    } else {
      ElMessage.error(data.message || '删除失败')
    }
  } catch (err) {
    if (err !== 'cancel') {
      console.error('删除评论失败:', err)
      ElMessage.error('删除评论失败')
    }
  }
}

const restoreComment = async (commentId) => {
  try {
    const res = await fetch(`/api/admin/comments/${commentId}/restore`, {
      method: 'PUT',
      headers: {
        'Authorization': `Bearer ${authStore.token}`
      }
    })
    const data = await res.json()
    if (data.code === 200) {
      ElMessage.success('恢复成功')
      fetchComments()
    } else {
      ElMessage.error(data.message || '恢复失败')
    }
  } catch (err) {
    console.error('恢复评论失败:', err)
    ElMessage.error('恢复评论失败')
  }
}

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return d.toLocaleString('zh-CN')
}

onMounted(() => {
  fetchComments()
})
</script>

<style scoped>
.comment-manage {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.search-card {
  border: none;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
}

.table-card {
  border: none;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
}

.mt-16 {
  margin-top: 16px;
  text-align: right;
}
</style>

