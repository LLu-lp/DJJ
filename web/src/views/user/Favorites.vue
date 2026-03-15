<template>
  <div class="favorites-page">
    <div class="page-header">
      <h1 class="page-title">我的收藏</h1>
      <div class="header-actions">
        <el-select v-model="filterStatus" placeholder="筛选状态" clearable style="width: 140px" @change="fetchFavorites">
          <el-option label="正在热映" :value="2" />
          <el-option label="即将上映" :value="1" />
        </el-select>
        <el-input
          v-model="searchKeyword"
          placeholder="搜索电影..."
          style="width: 200px"
          clearable
          @keyup.enter="fetchFavorites"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>
    </div>

    <div class="favorites-grid" v-loading="loading">
      <div
        v-for="movie in filteredMovies"
        :key="movie.id"
        class="favorite-card"
      >
        <div class="movie-poster-wrap">
          <img :src="movie.poster" :alt="movie.title" class="movie-poster" />
          <div class="movie-overlay">
            <el-button type="primary" size="small" @click="goToBooking(movie)">购票</el-button>
          </div>
          <div class="movie-rating">
            <el-icon style="color:#e8b84b;font-size:12px"><StarFilled /></el-icon>
            {{ movie.rating || 0 }}
          </div>
          <div class="favorite-badge">
            <el-icon><Star /></el-icon>
          </div>
        </div>
        <div class="movie-info">
          <h3 class="movie-title">{{ movie.title }}</h3>
          <p class="movie-genre">{{ movie.genre?.replace(/,/g, ' / ') }}</p>
          <p class="movie-duration">{{ movie.duration }} 分钟</p>
          <div class="movie-actions">
            <el-button
              link
              type="primary"
              size="small"
              @click="goToDetail(movie)"
            >
              详情
            </el-button>
            <el-button
              link
              type="danger"
              size="small"
              @click="removeFavorite(movie)"
            >
              取消收藏
            </el-button>
          </div>
        </div>
      </div>
    </div>

    <el-empty v-if="filteredMovies.length === 0 && !loading" description="暂无收藏电影" />

    <div class="pagination-wrap" v-if="total > 0">
      <el-pagination
        v-model:current-page="page"
        v-model:page-size="size"
        :total="total"
        :page-sizes="[12, 24, 36]"
        layout="total, sizes, prev, pager, next"
        @size-change="fetchFavorites"
        @current-change="fetchFavorites"
      />
    </div>
  </div>
</template>

<script setup>
import { movieApi } from '@/api'
import { Star, Search, StarFilled } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const loading = ref(false)
const page = ref(1)
const size = ref(12)
const total = ref(0)
const movies = ref([])
const filterStatus = ref(null)
const searchKeyword = ref('')

const filteredMovies = computed(() => {
  let list = movies.value
  if (filterStatus.value) {
    list = list.filter(m => m.status === filterStatus.value)
  }
  if (searchKeyword.value) {
    list = list.filter(m => m.title.includes(searchKeyword.value))
  }
  return list
})

const fetchFavorites = async () => {
  loading.value = true
  try {
    const res = await movieApi.getMyFavorites()
    if (res.code === 200) {
      movies.value = res.data || []
      total.value = movies.value.length
    }
  } catch (err) {
    console.error('获取收藏列表失败:', err)
    ElMessage.error('获取收藏列表失败')
  } finally {
    loading.value = false
  }
}

const goToDetail = (movie) => {
  router.push(`/movies/${movie.id}`)
}

const goToBooking = (movie) => {
  router.push(`/booking/${movie.id}`)
}

const removeFavorite = (movie) => {
  ElMessageBox.confirm(
    `确定要取消收藏《${movie.title}》吗？`,
    '取消收藏',
    { type: 'warning' }
  ).then(async () => {
    try {
      const res = await movieApi.unfavorite(movie.id)
      if (res.code === 200) {
        ElMessage.success('已取消收藏')
        fetchFavorites()
      }
    } catch (err) {
      console.error('取消收藏失败:', err)
      ElMessage.error('取消收藏失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchFavorites()
})
</script>

<style scoped>
.favorites-page {
  padding-bottom: 40px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

.page-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.favorites-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.favorite-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  overflow: hidden;
  transition: transform 0.2s, border-color 0.2s;
}

.favorite-card:hover {
  transform: translateY(-4px);
  border-color: var(--color-primary);
}

.movie-poster-wrap {
  position: relative;
  aspect-ratio: 3/4;
  overflow: hidden;
}

.movie-poster {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.favorite-card:hover .movie-poster {
  transform: scale(1.05);
}

.movie-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.2s;
}

.favorite-card:hover .movie-overlay {
  opacity: 1;
}

.movie-rating {
  position: absolute;
  top: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.7);
  padding: 2px 6px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  gap: 3px;
  font-size: 12px;
  color: #fff;
}

.favorite-badge {
  position: absolute;
  top: 8px;
  left: 8px;
  width: 32px;
  height: 32px;
  background: rgba(239, 68, 68, 0.9);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 16px;
}

.movie-info {
  padding: 12px;
}

.movie-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.movie-genre {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-bottom: 3px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.movie-duration {
  font-size: 11px;
  color: var(--color-text-muted);
  margin-bottom: 8px;
}

.movie-actions {
  display: flex;
  gap: 4px;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

@media (max-width: 1024px) {
  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .header-actions {
    width: 100%;
    flex-direction: column;
  }

  .favorites-grid {
    grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
  }
}
</style>

