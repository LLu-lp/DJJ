<template>
  <div class="movies-page">
    <div class="page-header">
      <h1 class="page-title">电影列表</h1>
      <div class="filters">
        <el-select v-model="filters.status" placeholder="放映状态" clearable style="width:120px" @change="fetchMovies">
          <el-option label="正在热映" :value="1" />
          <el-option label="即将上映" :value="2" />
        </el-select>
        <el-input
          v-model="filters.keyword"
          placeholder="搜索电影名..."
          style="width:200px"
          clearable
          @keyup.enter="fetchMovies"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>
    </div>

    <div class="status-tabs">
      <button
        v-for="tab in statusTabs"
        :key="tab.value"
        class="status-tab"
        :class="{ active: filters.status === tab.value }"
        @click="filters.status = tab.value; fetchMovies()"
      >
        {{ tab.label }}
        <span class="tab-count">{{ tab.count }}</span>
      </button>
    </div>

    <div class="movie-grid" v-loading="loading">
      <div
        v-for="movie in movies"
        :key="movie.id"
        class="movie-card"
        @click="$router.push(`/movies/${movie.id}`)"
      >
        <div class="movie-poster-wrap">
          <img :src="movie.poster" :alt="movie.title" class="movie-poster" />
          <div class="movie-overlay">
            <el-button type="primary" size="small" @click.stop="$router.push(`/booking/${movie.id}`)">购票</el-button>
          </div>
          <div class="movie-rating">
            <el-icon style="color:#e8b84b;font-size:12px"><StarFilled /></el-icon>
            {{ movie.rating || 0 }}
          </div>
          <div v-if="movie.status === 2" class="movie-badge">即将上映</div>
        </div>
        <div class="movie-info">
          <h3 class="movie-title">{{ movie.title }}</h3>
          <p class="movie-genre">{{ movie.genre?.replace(/,/g, ' / ') }}</p>
          <p class="movie-duration">{{ movie.duration }} 分钟 · {{ movie.releaseDate }}</p>
        </div>
      </div>
    </div>

    <el-empty v-if="movies.length === 0 && !loading" description="暂无符合条件的电影" />

    <div class="pagination-wrap" v-if="total > 0">
      <el-pagination
        v-model:current-page="page"
        v-model:page-size="size"
        :total="total"
        :page-sizes="[12, 24, 36]"
        layout="total, sizes, prev, pager, next"
        @size-change="fetchMovies"
        @current-change="fetchMovies"
      />
    </div>
  </div>
</template>

<script setup>
import { movieApi } from '@/api'
import { Search, StarFilled } from '@element-plus/icons-vue'
import { computed, onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const page = ref(1)
const size = ref(12)
const total = ref(0)
const movies = ref([])
const filters = reactive({ status: null, keyword: '' })

const statusTabs = computed(() => [
  { label: '全部', value: null, count: total.value },
  { label: '正在热映', value: 1, count: movies.value.filter(m => m.status === 1).length },
  { label: '即将上映', value: 2, count: movies.value.filter(m => m.status === 2).length },
])

const fetchMovies = async () => {
  loading.value = true
  try {
    const res = await movieApi.getPage({
      page: page.value,
      size: size.value,
      status: filters.status,
      keyword: filters.keyword
    })
    
    if (res.code === 200) {
      movies.value = res.data?.records || []
      total.value = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取电影列表失败:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchMovies()
})
</script>

<style scoped>
.movies-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: flex-start; justify-content: space-between; flex-wrap: wrap; gap: 16px; margin-bottom: 20px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); }
.filters { display: flex; gap: 10px; flex-wrap: wrap; }
.status-tabs { display: flex; gap: 4px; margin-bottom: 24px; }
.status-tab { padding: 6px 16px; border-radius: 20px; border: 1px solid var(--color-border); background: var(--color-surface); color: var(--color-text-muted); cursor: pointer; font-size: 14px; transition: all .2s; display: flex; align-items: center; gap: 6px; }
.status-tab:hover { border-color: var(--color-primary); color: var(--color-text); }
.status-tab.active { background: var(--color-primary); border-color: var(--color-primary); color: #1a1a1a; font-weight: 600; }
.tab-count { font-size: 12px; background: rgba(0,0,0,0.2); padding: 0 6px; border-radius: 10px; }
.movie-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 16px; }
.movie-card { cursor: pointer; border-radius: var(--radius); overflow: hidden; background: var(--color-surface); border: 1px solid var(--color-border); transition: transform .2s, border-color .2s; }
.movie-card:hover { transform: translateY(-4px); border-color: var(--color-primary); }
.movie-poster-wrap { position: relative; aspect-ratio: 3/4; overflow: hidden; }
.movie-poster { width: 100%; height: 100%; object-fit: cover; transition: transform .3s; }
.movie-card:hover .movie-poster { transform: scale(1.05); }
.movie-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; opacity: 0; transition: opacity .2s; }
.movie-card:hover .movie-overlay { opacity: 1; }
.movie-rating { position: absolute; top: 8px; right: 8px; background: rgba(0,0,0,0.7); padding: 2px 6px; border-radius: 4px; display: flex; align-items: center; gap: 3px; font-size: 12px; color: #fff; }
.movie-badge { position: absolute; top: 8px; left: 8px; background: var(--color-info); padding: 2px 8px; border-radius: 4px; font-size: 11px; color: #fff; }
.movie-info { padding: 10px 12px; }
.movie-title { font-size: 14px; font-weight: 600; color: var(--color-text); margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.movie-genre { font-size: 12px; color: var(--color-text-muted); margin-bottom: 3px; }
.movie-duration { font-size: 11px; color: var(--color-text-muted); }
.pagination-wrap { display: flex; justify-content: center; margin-top: 24px; }
</style>
