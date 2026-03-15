<template>
  <div class="movie-review-page">
    <div class="page-header">
      <h1 class="page-title">电影评价</h1>
      <p class="page-desc">分享你的观影体验</p>
    </div>

    <div class="review-container">
      <!-- 左侧：电影信息 -->
      <div class="movie-section">
        <div class="movie-card">
          <img :src="movie.poster" :alt="movie.title" class="movie-poster" />
          <div class="movie-info">
            <h2 class="movie-title">{{ movie.title }}</h2>
            <p class="movie-meta">{{ movie.genre?.replace(/,/g, ' / ') }}</p>
            <p class="movie-meta">{{ movie.duration }} 分钟 · {{ movie.releaseDate }}</p>
            <div class="movie-rating-info">
              <span class="rating-label">评分</span>
              <span class="rating-value">
                <el-icon style="color: #e8b84b"><StarFilled /></el-icon>
                {{ movie.rating || 0 }}
              </span>
              <span class="rating-count">({{ reviewCount }} 人评价)</span>
            </div>
          </div>
        </div>

        <!-- 评价列表 -->
        <div class="reviews-section">
          <div class="section-header">
            <h3>用户评价</h3>
            <el-select v-model="sortBy" placeholder="排序" style="width: 120px" @change="fetchReviews">
              <el-option label="最新" value="newest" />
              <el-option label="最热" value="hottest" />
              <el-option label="最有帮助" value="helpful" />
            </el-select>
          </div>

          <div class="reviews-list" v-loading="loadingReviews">
            <div v-for="review in reviews" :key="review.id" class="review-item">
              <div class="review-header">
                <div class="reviewer-info">
                  <img :src="review.avatar" :alt="review.username" class="reviewer-avatar" />
                  <div>
                    <p class="reviewer-name">{{ review.username }}</p>
                    <p class="review-time">{{ formatTime(review.createdAt) }}</p>
                  </div>
                </div>
                <div class="review-rating">
                  <el-rate v-model="review.rating" disabled size="small" />
                </div>
              </div>
              <p class="review-content">{{ review.content }}</p>
              <div class="review-footer">
                <el-button link size="small" @click="likeReview(review)">
                  <el-icon><ThumbsUp /></el-icon>
                  有帮助 ({{ review.likes || 0 }})
                </el-button>
                <el-button link size="small" @click="replyReview(review)">
                  <el-icon><ChatDotRound /></el-icon>
                  回复
                </el-button>
              </div>
            </div>
          </div>

          <el-empty v-if="reviews.length === 0 && !loadingReviews" description="暂无评价" />

          <div class="pagination-wrap" v-if="reviewTotal > 0">
            <el-pagination
              v-model:current-page="reviewPage"
              :total="reviewTotal"
              :page-size="10"
              layout="prev, pager, next"
              @current-change="fetchReviews"
            />
          </div>
        </div>
      </div>

      <!-- 右侧：发表评价 -->
      <div class="write-section">
        <el-card class="write-card">
          <template #header>
            <div class="card-header">发表评价</div>
          </template>

          <div class="write-content">
            <div class="rating-select">
              <p class="label">你的评分</p>
              <el-rate v-model="reviewForm.rating" size="large" />
              <p class="rating-text">{{ getRatingText(reviewForm.rating) }}</p>
            </div>

            <div class="content-input">
              <p class="label">评价内容</p>
              <el-input
                v-model="reviewForm.content"
                type="textarea"
                :rows="6"
                placeholder="分享你的观影体验（至少10个字）"
                maxlength="500"
                show-word-limit
              />
            </div>

            <div class="image-upload">
              <p class="label">上传图片（可选）</p>
              <el-upload
                v-model:file-list="reviewForm.images"
                action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15"
                list-type="picture-card"
                :auto-upload="false"
                :limit="3"
              >
                <template #default>
                  <el-icon><Plus /></el-icon>
                </template>
              </el-upload>
              <p style="font-size: 12px; color: var(--color-text-muted)">最多上传3张图片</p>
            </div>

            <el-button
              type="primary"
              size="large"
              style="width: 100%"
              :loading="submitting"
              :disabled="!canSubmit"
              @click="submitReview"
            >
              提交评价
            </el-button>

            <p class="agreement">
              <el-checkbox v-model="reviewForm.agree" />
              我同意
              <el-link type="primary">《评价协议》</el-link>
            </p>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script setup>
import { movieApi } from '@/api'
import { ChatDotRound, Plus, StarFilled, ThumbsUp } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const movieId = route.params.id

const movie = ref({})
const reviews = ref([])
const reviewPage = ref(1)
const reviewTotal = ref(0)
const sortBy = ref('newest')
const loadingReviews = ref(false)
const submitting = ref(false)

const reviewForm = ref({
  rating: 5,
  content: '',
  images: [],
  agree: false
})

const reviewCount = computed(() => {
  return reviews.value.length
})

const canSubmit = computed(() => {
  return reviewForm.value.rating > 0 &&
    reviewForm.value.content.length >= 10 &&
    reviewForm.value.agree
})

const getRatingText = (rating) => {
  const texts = ['', '很差', '差', '一般', '好', '很好']
  return texts[rating] || ''
}

const formatTime = (time) => {
  if (!time) return ''
  const date = new Date(time)
  const now = new Date()
  const diff = now - date
  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  
  if (days === 0) return '今天'
  if (days === 1) return '昨天'
  if (days < 7) return `${days}天前`
  if (days < 30) return `${Math.floor(days / 7)}周前`
  return `${Math.floor(days / 30)}个月前`
}

const fetchMovie = async () => {
  try {
    const res = await movieApi.getDetail(movieId)
    if (res.code === 200) {
      movie.value = res.data || {}
    }
  } catch (err) {
    console.error('获取电影详情失败:', err)
  }
}

const fetchReviews = async () => {
  loadingReviews.value = true
  try {
    const res = await movieApi.getReviews(movieId)
    if (res.code === 200) {
      reviews.value = res.data || []
      reviewTotal.value = reviews.value.length
    }
  } catch (err) {
    console.error('获取评价列表失败:', err)
  } finally {
    loadingReviews.value = false
  }
}

const submitReview = async () => {
  if (!canSubmit.value) {
    ElMessage.warning('请完成所有必填项')
    return
  }

  submitting.value = true
  try {
    const res = await movieApi.addReview(movieId, {
      rating: reviewForm.value.rating,
      content: reviewForm.value.content
    })

    if (res.code === 200) {
      ElMessage.success('评价提交成功！')
      reviewForm.value = {
        rating: 5,
        content: '',
        images: [],
        agree: false
      }
      fetchReviews()
    }
  } catch (err) {
    console.error('提交评价失败:', err)
    ElMessage.error(err.response?.data?.message || '提交失败')
  } finally {
    submitting.value = false
  }
}

const likeReview = (review) => {
  review.likes = (review.likes || 0) + 1
  ElMessage.success('感谢你的点赞')
}

const replyReview = (review) => {
  ElMessage.info('回复功能开发中...')
}

onMounted(() => {
  fetchMovie()
  fetchReviews()
})
</script>

<style scoped>
.movie-review-page {
  padding-bottom: 40px;
}

.page-header {
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 8px;
}

.page-desc {
  font-size: 14px;
  color: var(--color-text-muted);
}

.review-container {
  display: grid;
  grid-template-columns: 1fr 360px;
  gap: 24px;
}

.movie-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.movie-card {
  display: flex;
  gap: 20px;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 20px;
}

.movie-poster {
  width: 120px;
  height: 160px;
  object-fit: cover;
  border-radius: 8px;
  flex-shrink: 0;
}

.movie-info {
  flex: 1;
}

.movie-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 8px;
}

.movie-meta {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: 4px;
}

.movie-rating-info {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid var(--color-border);
}

.rating-label {
  font-size: 13px;
  color: var(--color-text-muted);
}

.rating-value {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 18px;
  font-weight: 700;
  color: var(--color-primary);
}

.rating-count {
  font-size: 12px;
  color: var(--color-text-muted);
}

.reviews-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 20px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.section-header h3 {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.reviews-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.review-item {
  padding: 16px;
  background: var(--color-surface-2);
  border-radius: 8px;
}

.review-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.reviewer-info {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.reviewer-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.reviewer-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin: 0;
}

.review-time {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 4px 0 0;
}

.review-rating {
  display: flex;
  gap: 4px;
}

.review-content {
  font-size: 13px;
  color: var(--color-text);
  line-height: 1.6;
  margin-bottom: 12px;
}

.review-footer {
  display: flex;
  gap: 12px;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.write-section {
  position: sticky;
  top: 80px;
}

.write-card {
  background: var(--color-surface) !important;
  border: 1px solid var(--color-border) !important;
}

.card-header {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
}

.write-content {
  padding: 16px 0;
}

.rating-select {
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid var(--color-border);
}

.label {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

.rating-text {
  font-size: 12px;
  color: var(--color-primary);
  margin-top: 8px;
}

.content-input {
  margin-bottom: 20px;
}

.image-upload {
  margin-bottom: 20px;
}

.agreement {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-top: 12px;
  display: flex;
  align-items: center;
  gap: 6px;
}

@media (max-width: 1024px) {
  .review-container {
    grid-template-columns: 1fr;
  }

  .write-section {
    position: static;
  }

  .movie-card {
    flex-direction: column;
  }
}
</style>

