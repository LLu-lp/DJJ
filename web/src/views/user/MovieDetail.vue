<template>
  <div class="movie-detail" v-if="movie">
    <div class="detail-hero">
      <img :src="movie.poster" :alt="movie.title" class="hero-poster" />
      <div class="hero-info">
        <h1 class="hero-title">{{ movie.title }}</h1>
        <div class="hero-tags">
          <el-tag v-for="g in movie.genre?.split(',')" :key="g" class="genre-tag" size="small">{{ g }}</el-tag>
        </div>
        <div class="hero-meta">
          <div class="meta-item">
            <span class="meta-label">评分</span>
            <span class="meta-value rating">
              <el-icon style="color:#e8b84b"><StarFilled /></el-icon>
              {{ movie.rating || 0 }}
            </span>
          </div>
          <div class="meta-item">
            <span class="meta-label">时长</span>
            <span class="meta-value">{{ movie.duration }} 分钟</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">上映</span>
            <span class="meta-value">{{ movie.releaseDate }}</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">导演</span>
            <span class="meta-value">{{ movie.director }}</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">主演</span>
            <span class="meta-value">{{ movie.actors }}</span>
          </div>
        </div>
        <p class="hero-desc">{{ movie.description }}</p>
        <div class="hero-actions">
          <el-button type="primary" size="large" @click="$router.push(`/booking/${movie.id}`)">
            立即购票
          </el-button>
          <el-button
            :type="isFavorited ? 'warning' : 'default'"
            size="large"
            :icon="isFavorited ? StarFilled : Star"
            @click="toggleFavorite"
            :loading="favLoading"
          >
            {{ isFavorited ? '已收藏' : '收藏' }}
          </el-button>
        </div>
      </div>
    </div>

    <div class="section">
      <h2 class="section-title">今日场次</h2>
      <div v-if="schedules.length > 0" class="schedules-list">
        <div v-for="s in schedules" :key="s.id" class="schedule-card">
          <div class="schedule-time">
            <span class="time-main">{{ s.startTime }}</span>
            <span class="time-end">散场 {{ s.endTime }}</span>
          </div>
          <div class="schedule-info">
            <span class="hall-name">{{ s.hallName }}</span>
            <el-tag size="small" type="info">{{ s.hallType || '普通' }}</el-tag>
          </div>
          <div class="schedule-cinema">{{ s.cinemaName }}</div>
          <div class="schedule-seats">剩余 <strong>{{ s.availableSeats || 0 }}</strong> 座</div>
          <div class="schedule-price">¥ <strong>{{ s.price }}</strong></div>
          <el-button type="primary" size="small" @click="$router.push(`/seat/${s.id}`)">
            选座购票
          </el-button>
        </div>
      </div>
      <el-empty v-else description="暂无今日场次" />
    </div>

    <div class="section">
      <h2 class="section-title">观众评价</h2>
      <div class="review-form" v-if="authStore.isLoggedIn">
        <el-rate v-model="reviewForm.rating" size="large" style="margin-bottom:12px" />
        <el-input
          v-model="reviewForm.content"
          type="textarea"
          :rows="3"
          placeholder="分享你的观影感受..."
          style="margin-bottom:12px"
        />
        <el-button type="primary" @click="submitReview">
          发表评价
        </el-button>
      </div>
      <div v-else class="login-tip">
        <el-button link @click="$router.push('/login')" style="color:var(--color-primary)">登录后</el-button>
        即可发表评价
      </div>
      <div class="review-list">
        <div v-for="review in reviews" :key="review.id" class="review-item">
          <div class="review-header">
            <el-avatar :size="32" style="background:var(--color-surface-2)">{{ review.username?.[0] || 'U' }}</el-avatar>
            <div>
              <p class="review-user">{{ review.username }}</p>
              <el-rate :model-value="review.rating" disabled size="small" />
            </div>
            <span class="review-time">{{ review.createdAt }}</span>
          </div>
          <p class="review-content">{{ review.content }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { movieApi, scheduleApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { Star, StarFilled } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const authStore = useAuthStore()

const movie = ref(null)
const schedules = ref([])
const reviewForm = ref({ rating: 5, content: '' })
const reviews = ref([])
const isFavorited = ref(false)
const favLoading = ref(false)

onMounted(async () => {
  const id = Number(route.params.id)
  await fetchMovieDetail(id)
  await fetchSchedules(id)
  await fetchReviews(id)
  if (authStore.isLoggedIn) {
    checkFavorite(id)
  }
})

const fetchMovieDetail = async (id) => {
  try {
    const res = await movieApi.getDetail(id)
    if (res.code === 200) {
      movie.value = res.data
    }
  } catch (err) {
    console.error('获取电影详情失败:', err)
  }
}

const fetchSchedules = async (movieId) => {
  try {
    const today = new Date().toISOString().split('T')[0]
    const res = await scheduleApi.getPage({ movieId, showDate: today, size: 20 })
    if (res.code === 200) {
      schedules.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取场次失败:', err)
  }
}

const fetchReviews = async (movieId) => {
  try {
    const res = await movieApi.getReviews(movieId)
    if (res.code === 200) {
      reviews.value = res.data || []
    }
  } catch (err) {
    console.error('获取评论失败:', err)
  }
}

const checkFavorite = async (movieId) => {
  try {
    const res = await movieApi.isFavorited(movieId)
    if (res.code === 200) isFavorited.value = res.data
  } catch (err) {
    // 未登录时忽略
  }
}

const toggleFavorite = async () => {
  if (!authStore.isLoggedIn) return ElMessage.warning('请先登录')
  favLoading.value = true
  try {
    if (isFavorited.value) {
      await movieApi.unfavorite(movie.value.id)
      isFavorited.value = false
      ElMessage.success('已取消收藏')
    } else {
      await movieApi.favorite(movie.value.id)
      isFavorited.value = true
      ElMessage.success('收藏成功')
    }
  } catch (err) {
    ElMessage.error('操作失败')
  } finally {
    favLoading.value = false
  }
}

const submitReview = async () => {
  if (!reviewForm.value.content.trim()) {
    return ElMessage.warning('请输入评价内容')
  }
  try {
    const res = await movieApi.addReview(movie.value.id, reviewForm.value)
    if (res.code === 200) {
      reviewForm.value = { rating: 5, content: '' }
      await fetchReviews(movie.value.id)
      ElMessage.success('评价发布成功')
    }
  } catch (err) {
    console.error('发布评价失败:', err)
  }
}
</script>

<style scoped>
.movie-detail { padding-bottom: 40px; }
.detail-hero { display: flex; gap: 32px; padding: 24px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); margin-bottom: 32px; }
.hero-poster { width: 200px; height: 280px; object-fit: cover; border-radius: 8px; flex-shrink: 0; }
.hero-info { flex: 1; }
.hero-title { font-size: 28px; font-weight: 700; color: var(--color-text); margin-bottom: 12px; }
.hero-tags { display: flex; gap: 8px; margin-bottom: 16px; }
.genre-tag { background: var(--color-primary-light) !important; border-color: rgba(232,184,75,0.3) !important; color: var(--color-primary) !important; }
.hero-meta { display: flex; flex-direction: column; gap: 8px; margin-bottom: 16px; }
.meta-item { display: flex; align-items: center; gap: 8px; font-size: 14px; }
.meta-label { color: var(--color-text-muted); min-width: 40px; }
.meta-value { color: var(--color-text); }
.meta-value.rating { display: flex; align-items: center; gap: 4px; font-size: 20px; font-weight: 700; color: #e8b84b; }
.hero-desc { color: var(--color-text-muted); line-height: 1.7; margin-bottom: 20px; }
.hero-actions { display: flex; gap: 12px; }
.section { margin-bottom: 32px; }
.section-title { font-size: 18px; font-weight: 700; color: var(--color-text); margin-bottom: 16px; padding-left: 12px; border-left: 3px solid var(--color-primary); }
.schedules-list { display: flex; flex-direction: column; gap: 10px; }
.schedule-card { display: flex; align-items: center; gap: 20px; padding: 16px 20px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); transition: border-color .2s; }
.schedule-card:hover { border-color: var(--color-primary); }
.schedule-time { min-width: 80px; }
.time-main { display: block; font-size: 20px; font-weight: 700; color: var(--color-text); }
.time-end { font-size: 12px; color: var(--color-text-muted); }
.schedule-info { display: flex; align-items: center; gap: 8px; flex: 1; }
.hall-name { font-size: 14px; color: var(--color-text); }
.schedule-cinema { flex: 1; font-size: 13px; color: var(--color-text-muted); }
.schedule-seats { font-size: 13px; color: var(--color-text-muted); min-width: 80px; }
.schedule-price { font-size: 16px; color: var(--color-primary); min-width: 70px; }
.review-form { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); padding: 16px; margin-bottom: 16px; }
.login-tip { color: var(--color-text-muted); margin-bottom: 16px; font-size: 14px; }
.review-list { display: flex; flex-direction: column; gap: 12px; }
.review-item { padding: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); }
.review-header { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 8px; }
.review-user { font-size: 14px; font-weight: 600; color: var(--color-text); margin-bottom: 2px; }
.review-time { margin-left: auto; font-size: 12px; color: var(--color-text-muted); }
.review-content { font-size: 14px; color: var(--color-text-muted); line-height: 1.6; }
</style>
