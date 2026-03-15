<template>
  <div class="ranking-page">
    <h1 class="page-title">电影排行榜</h1>
    <div class="rank-tabs">
      <button v-for="tab in rankTabs" :key="tab.value" class="rank-tab" :class="{ active: activeTab === tab.value }" @click="activeTab = tab.value">
        {{ tab.label }}
      </button>
    </div>
    <div class="rank-list" v-loading="loading">
      <div v-for="(movie, idx) in rankedMovies" :key="movie.id" class="rank-item">
        <div class="rank-num" :class="{ top3: idx < 3 }">{{ idx + 1 }}</div>
        <img :src="movie.poster" :alt="movie.title" class="rank-poster" />
        <div class="rank-info">
          <h3 class="rank-title">{{ movie.title }}</h3>
          <p class="rank-meta">{{ movie.genres }} · {{ movie.duration }}分钟</p>
          <el-progress :percentage="getBarPercent(movie, idx)" :show-text="false" :stroke-width="4" color="#e8b84b" />
        </div>
        <div class="rank-value">
          <span v-if="activeTab === 'rating'" class="value-main">
            <el-icon style="color:#e8b84b"><StarFilled /></el-icon>
            {{ movie.rating || 0 }}
          </span>
          <span v-else-if="activeTab === 'ticketCount'" class="value-main">{{ (movie.ticketCount || 0).toLocaleString() }}</span>
          <span class="value-label">{{ rankTabs.find(t => t.value === activeTab)?.unit }}</span>
        </div>
      </div>
    </div>
    <el-empty v-if="rankedMovies.length === 0 && !loading" description="暂无排行数据" />
  </div>
</template>

<script setup>
import { movieApi } from '@/api'
import { computed, onMounted, ref } from 'vue'

const loading = ref(false)
const activeTab = ref('ticketCount')
const movies = ref([])

const rankTabs = [
  { label: '票房榜', value: 'ticketCount', unit: '张' },
  { label: '评分榜', value: 'rating', unit: '分' },
]

onMounted(() => {
  fetchMovies()
})

const fetchMovies = async () => {
  loading.value = true
  try {
    const res = await movieApi.getPage({ size: 50, status: 2 })
    if (res.code === 200) {
      movies.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取电影列表失败:', err)
  } finally {
    loading.value = false
  }
}

const rankedMovies = computed(() => {
  return [...movies.value].sort((a, b) => {
    if (activeTab.value === 'rating') {
      return (b.rating || 0) - (a.rating || 0)
    }
    return (b.ticketCount || 0) - (a.ticketCount || 0)
  })
})

function getBarPercent(movie, idx) {
  const max = rankedMovies.value[0]?.[activeTab.value] || 1
  const val = movie[activeTab.value] || 0
  return Math.round(val / max * 100)
}
</script>

<style scoped>
.ranking-page { padding-bottom: 40px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); margin-bottom: 20px; }
.rank-tabs { display: flex; gap: 8px; margin-bottom: 24px; }
.rank-tab { padding: 6px 20px; border-radius: 20px; border: 1px solid var(--color-border); background: var(--color-surface); color: var(--color-text-muted); cursor: pointer; font-size: 14px; transition: all .2s; }
.rank-tab.active { background: var(--color-primary); border-color: var(--color-primary); color: #1a1a1a; font-weight: 600; }
.rank-list { display: flex; flex-direction: column; gap: 12px; }
.rank-item { display: flex; align-items: center; gap: 16px; padding: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); transition: border-color .2s; }
.rank-item:hover { border-color: var(--color-primary); }
.rank-num { width: 32px; height: 32px; border-radius: 50%; background: var(--color-surface-2); display: flex; align-items: center; justify-content: center; font-weight: 700; color: var(--color-text-muted); flex-shrink: 0; }
.rank-num.top3 { background: var(--color-primary); color: #1a1a1a; }
.rank-poster { width: 56px; height: 76px; object-fit: cover; border-radius: 4px; flex-shrink: 0; }
.rank-info { flex: 1; }
.rank-title { font-size: 15px; font-weight: 600; color: var(--color-text); margin-bottom: 4px; }
.rank-meta { font-size: 12px; color: var(--color-text-muted); margin-bottom: 8px; }
.rank-value { text-align: right; min-width: 80px; }
.value-main { display: flex; align-items: center; justify-content: flex-end; gap: 4px; font-size: 20px; font-weight: 700; color: var(--color-primary); }
.value-label { font-size: 12px; color: var(--color-text-muted); }
</style>
