<template>
  <div class="my-comments">
    <el-card class="header-card">
      <div class="header-content">
        <h1>我的评论</h1>
        <p class="subtitle">查看你在各个电影下的评论</p>
      </div>
    </el-card>

    <!-- 评论列表 -->
    <div v-if="!loading && comments.length > 0" class="comments-container">
      <div v-for="comment in comments" :key="comment.id" class="comment-card">
        <div class="comment-header">
          <div class="movie-info">
            <img :src="comment.movieImage" :alt="comment.movieName" class="movie-poster">
            <div class="movie-details">
              <h3 class="movie-name">{{ comment.movieName }}</h3>
              <div class="rating">
                <el-rate v-model="comment.rating" disabled size="small" />
                <span class="rating-text">{{ comment.rating }}分</span>
              </div>
              <p class="comment-date">{{ formatDate(comment.createdAt) }}</p>
            </div>
          </div>
          <div class="comment-actions">
            <el-button type="danger" size="small" @click="deleteComment(comment.id)">删除</el-button>
          </div>
        </div>
        <div class="comment-content">
          {{ comment.content }}
        </div>

      </div>
    </div>

    <!-- 空状态 -->
    <el-empty v-else-if="!loading" description="还没有评论，去电影详情页写一条吧" />

    <!-- 加载状态 -->
    <div v-else class="loading">
      <el-skeleton :rows="3" animated />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useAuthStore } from '@/stores/auth'


const authStore = useAuthStore()
const comments = ref([])
const loading = ref(false)

const fetchComments = async () => {
  loading.value = true
  try {
    // 获取用户的所有评论
    const res = await fetch('/api/auth/my-comments', {
      headers: {
        'Authorization': `Bearer ${authStore.token}`
      }
    })
    const data = await res.json()
    if (data.code === 200) {
      comments.value = data.data || []
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

const deleteComment = async (commentId) => {
  try {
    await ElMessageBox.confirm('确定要删除这条评论吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    const res = await fetch(`/api/auth/comments/${commentId}`, {
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

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return d.toLocaleDateString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit' })
}

onMounted(() => {
  fetchComments()
})
</script>

<style scoped>
.my-comments {
  max-width: 900px;
  margin: 0 auto;
}

.header-card {
  margin-bottom: 24px;
  border: none;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
}

.header-content {
  padding: 20px 0;
}

.header-content h1 {
  margin: 0 0 8px 0;
  font-size: 28px;
  font-weight: 700;
  color: var(--color-text);
}

.subtitle {
  margin: 0;
  color: var(--color-text-muted);
  font-size: 14px;
}

.comments-container {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.comment-card {
  background: white;
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 20px;
  transition: all 0.3s;
}

.comment-card:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-border);
}

.movie-info {
  display: flex;
  gap: 16px;
  flex: 1;
}

.movie-poster {
  width: 80px;
  height: 120px;
  border-radius: 4px;
  object-fit: cover;
}

.movie-details {
  flex: 1;
}

.movie-name {
  margin: 0 0 8px 0;
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text);
}

.rating {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.rating-text {
  font-size: 14px;
  color: var(--color-text-muted);
}

.comment-date {
  margin: 0;
  font-size: 12px;
  color: var(--color-text-muted);
}

.comment-actions {
  display: flex;
  gap: 8px;
}

.comment-content {
  font-size: 14px;
  line-height: 1.6;
  color: var(--color-text);
  margin-bottom: 12px;
  word-break: break-word;
}

.loading {
  padding: 40px 20px;
}
</style>

