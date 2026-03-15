<template>
  <div class="cinema-detail-page">
    <div class="page-header">
      <el-button type="primary" text @click="$router.back()">
        <el-icon><ArrowLeft /></el-icon> 返回
      </el-button>
    </div>

    <div v-if="cinema" class="cinema-info-section">
      <div class="cinema-banner">
        <img :src="`https://picsum.photos/seed/cinema${cinema.id}/800/300`" :alt="cinema.name" />
      </div>
      <div class="cinema-details">
        <h1 class="cinema-name">{{ cinema.name }}</h1>
        <div class="cinema-meta">
          <p class="meta-item">
            <el-icon><Location /></el-icon>
            {{ cinema.address }}
          </p>
          <p class="meta-item">
            <el-icon><Phone /></el-icon>
            {{ cinema.phone }}
          </p>
        </div>
        <div class="cinema-facilities">
          <el-tag v-for="f in cinema.facilities?.split(',')" :key="f" type="info" style="margin-right:8px;margin-bottom:8px">{{ f }}</el-tag>
        </div>
        <p class="cinema-description">{{ cinema.description }}</p>
      </div>
    </div>

    <!-- 按日期分类的影片 -->
    <div class="schedules-section">
      <h2 class="section-title">影片排期</h2>
      
      <div class="date-tabs">
        <button
          v-for="date in availableDates"
          :key="date"
          class="date-tab"
          :class="{ active: selectedDate === date }"
          @click="selectedDate = date"
        >
          {{ formatDateTab(date) }}
        </button>
      </div>

      <div class="schedules-grid" v-loading="loadingSchedules">
        <div v-for="schedule in filteredSchedules" :key="schedule.id" class="schedule-card" @click="goToBooking(schedule)">
          <div class="schedule-movie">
            <img :src="schedule.moviePoster" :alt="schedule.movieTitle" class="movie-poster" />
            <div class="movie-overlay">
              <el-button type="primary" size="small">购票</el-button>
            </div>
          </div>
          <div class="schedule-info">
            <h3 class="movie-title">{{ schedule.movieTitle }}</h3>
            <p class="show-time">
              <el-icon><Clock /></el-icon>
              {{ formatTime(schedule.startTime) }}
            </p>
            <p class="hall-info">
              <el-icon><VideoPlay /></el-icon>
              {{ schedule.hallName }}
            </p>
            <p class="price">
              <span class="price-label">¥</span>
              <span class="price-value">{{ schedule.price || 0 }}</span>
            </p>
          </div>
        </div>
      </div>

      <el-empty v-if="filteredSchedules.length === 0 && !loadingSchedules" description="暂无排期" />
    </div>
  </div>
</template>

<script setup>
import { cinemaApi, scheduleApi } from '@/api'
import { ArrowLeft, Clock, Location, Phone, VideoPlay } from '@element-plus/icons-vue'
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()
const cinemaId = route.params.id

const cinema = ref(null)
const schedules = ref([])
const loadingSchedules = ref(false)
const selectedDate = ref(new Date().toISOString().split('T')[0])

const availableDates = computed(() => {
  const dates = []
  const today = new Date()
  for (let i = 0; i < 7; i++) {
    const date = new Date(today)
    date.setDate(date.getDate() + i)
    dates.push(date.toISOString().split('T')[0])
  }
  return dates
})

const filteredSchedules = computed(() => {
  return schedules.value.filter(s => {
    try {
      // 后端返回的是 showDate (YYYY-MM-DD 格式)
      if (!s.showDate) return false
      return s.showDate === selectedDate.value
    } catch (e) {
      return false
    }
  })
})

const formatDateTab = (date) => {
  const d = new Date(date + 'T00:00:00')
  const days = ['日', '一', '二', '三', '四', '五', '六']
  return `${d.getMonth() + 1}月${d.getDate()}日 ${days[d.getDay()]}`
}

const formatTime = (time) => {
  if (!time) return '--'
  try {
    // 后端返回的是 HH:mm:ss 格式的字符串
    if (typeof time === 'string') {
      return time.substring(0, 5) // 取前5个字符 HH:mm
    }
    return '--'
  } catch (e) {
    return '--'
  }
}

const fetchCinemaDetail = async () => {
  try {
    const res = await cinemaApi.getDetail(cinemaId)
    if (res.code === 200) {
      cinema.value = res.data
    }
  } catch (err) {
    console.error('获取影院详情失败:', err)
  }
}

const fetchSchedules = async () => {
  loadingSchedules.value = true
  try {
    const res = await scheduleApi.getPage({
      cinemaId: cinemaId,
      page: 1,
      size: 100
    })
    if (res.code === 200) {
      schedules.value = res.data?.records || []
      console.log('排期数据:', schedules.value)
    }
  } catch (err) {
    console.error('获取排期失败:', err)
  } finally {
    loadingSchedules.value = false
  }
}

const goToBooking = (schedule) => {
  router.push(`/booking/${schedule.movieId}`)
}

onMounted(() => {
  fetchCinemaDetail()
  fetchSchedules()
})
</script>

<style scoped>
.cinema-detail-page { padding-bottom: 40px; }

.page-header { margin-bottom: 20px; }

.cinema-info-section { margin-bottom: 40px; }

.cinema-banner { height: 300px; overflow: hidden; border-radius: var(--radius); margin-bottom: 20px; }
.cinema-banner img { width: 100%; height: 100%; object-fit: cover; }

.cinema-details { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); padding: 24px; }

.cinema-name { font-size: 28px; font-weight: 700; color: var(--color-text); margin-bottom: 16px; }

.cinema-meta { display: flex; flex-direction: column; gap: 8px; margin-bottom: 16px; }
.meta-item { display: flex; align-items: center; gap: 8px; font-size: 14px; color: var(--color-text-muted); margin: 0; }

.cinema-facilities { margin-bottom: 16px; }

.cinema-description { font-size: 14px; color: var(--color-text-muted); line-height: 1.6; margin: 0; }

.schedules-section { }

.section-title { font-size: 20px; font-weight: 700; color: var(--color-text); margin-bottom: 20px; }

.date-tabs { display: flex; gap: 8px; margin-bottom: 20px; overflow-x: auto; padding-bottom: 8px; }
.date-tab { padding: 8px 16px; border-radius: 20px; border: 1px solid var(--color-border); background: var(--color-surface); color: var(--color-text-muted); cursor: pointer; font-size: 13px; transition: all .2s; white-space: nowrap; }
.date-tab:hover { border-color: var(--color-primary); color: var(--color-text); }
.date-tab.active { background: var(--color-primary); border-color: var(--color-primary); color: #1a1a1a; font-weight: 600; }

.schedules-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 16px; }

.schedule-card { cursor: pointer; border-radius: var(--radius); overflow: hidden; background: var(--color-surface); border: 1px solid var(--color-border); transition: transform .2s, border-color .2s; }
.schedule-card:hover { transform: translateY(-4px); border-color: var(--color-primary); }

.schedule-movie { position: relative; aspect-ratio: 3/4; overflow: hidden; }
.movie-poster { width: 100%; height: 100%; object-fit: cover; transition: transform .3s; }
.schedule-card:hover .movie-poster { transform: scale(1.05); }

.movie-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; opacity: 0; transition: opacity .2s; }
.schedule-card:hover .movie-overlay { opacity: 1; }

.schedule-info { padding: 12px; }
.movie-title { font-size: 13px; font-weight: 600; color: var(--color-text); margin-bottom: 6px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

.show-time, .hall-info, .price { display: flex; align-items: center; gap: 4px; font-size: 12px; color: var(--color-text-muted); margin-bottom: 4px; }

.price { color: var(--color-primary); font-weight: 600; }
.price-label { font-size: 10px; }
.price-value { font-size: 16px; }
</style>

