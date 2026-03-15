<template>
  <div class="booking-page">
    <div class="page-header">
      <el-button link @click="$router.back()" style="color:var(--color-text-muted)">
        <el-icon><ArrowLeft /></el-icon> 返回
      </el-button>
      <h1 class="page-title">选择场次</h1>
    </div>
    <div class="movie-info-bar" v-if="movie">
      <img :src="movie.poster" class="movie-mini-poster" />
      <div>
        <h2 style="font-size:18px;font-weight:700;color:var(--color-text)">{{ movie.title }}</h2>
        <p style="font-size:13px;color:var(--color-text-muted)">{{ movie.genres }} · {{ movie.duration }}分钟</p>
      </div>
    </div>
    <!-- 日期选择 -->
    <div class="date-tabs">
      <button
        v-for="date in dates"
        :key="date.value"
        class="date-tab"
        :class="{ active: selectedDate === date.value }"
        @click="selectedDate = date.value"
      >
        <span class="date-day">{{ date.day }}</span>
        <span class="date-week">{{ date.week }}</span>
      </button>
    </div>
    <!-- 影院筛选 -->
    <el-select v-model="selectedCinema" placeholder="全部影院" clearable style="width:200px;margin-bottom:16px" @change="fetchSchedules">
      <el-option v-for="c in cinemas" :key="c.id" :label="c.name" :value="c.id" />
    </el-select>
    <!-- 场次列表 -->
    <div v-for="cinema in filteredSchedulesByCinema" :key="cinema.id" class="cinema-schedules">
      <div class="cinema-header">
        <h3 class="cinema-name">{{ cinema.name }}</h3>
        <span class="cinema-addr">{{ cinema.address }}</span>
      </div>
      <div class="schedules-grid">
        <div
          v-for="s in cinema.schedules"
          :key="s.id"
          class="schedule-item"
          @click="$router.push(`/seat/${s.id}`)"
        >
          <div class="s-time">{{ s.startTime }}</div>
          <div class="s-hall">
            <span>{{ s.hallName }}</span>
            <el-tag size="small" type="info">{{ s.hallType || '普通' }}</el-tag>
          </div>
          <div class="s-bottom">
            <span class="s-seats">余{{ s.availableSeats || 0 }}座</span>
            <span class="s-price">¥{{ s.price }}起</span>
          </div>
        </div>
      </div>
    </div>
    <el-empty v-if="filteredSchedulesByCinema.length === 0 && !loading" description="暂无该日期场次" />
  </div>
</template>

<script setup>
import { cinemaApi, movieApi, scheduleApi } from '@/api'
import { computed, onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const movie = ref(null)
const selectedDate = ref(new Date().toISOString().split('T')[0])
const selectedCinema = ref(null)
const cinemas = ref([])
const schedules = ref([])
const loading = ref(false)

const dates = computed(() => {
  const result = []
  const weekDays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
  for (let i = 0; i < 4; i++) {
    const d = new Date()
    d.setDate(d.getDate() + i)
    result.push({
      value: d.toISOString().split('T')[0],
      day: `${String(d.getMonth() + 1).padStart(2, '0')}/${String(d.getDate()).padStart(2, '0')}`,
      week: i === 0 ? '今天' : weekDays[d.getDay()]
    })
  }
  return result
})

onMounted(async () => {
  const movieId = route.params.movieId
  await Promise.all([fetchMovie(movieId), fetchCinemas()])
  await fetchSchedules()
})

const fetchMovie = async (id) => {
  try {
    const res = await movieApi.getDetail(id)
    if (res.code === 200) {
      movie.value = res.data
    }
  } catch (err) {
    console.error('获取电影详情失败:', err)
  }
}

const fetchCinemas = async () => {
  try {
    const res = await cinemaApi.getPage({ size: 100 })
    if (res.code === 200) {
      cinemas.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取影院列表失败:', err)
  }
}

const fetchSchedules = async () => {
  loading.value = true
  try {
    const res = await scheduleApi.getPage({
      movieId: route.params.movieId,
      showDate: selectedDate.value,
      cinemaId: selectedCinema.value || undefined,
      size: 100
    })
    if (res.code === 200) {
      schedules.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取场次列表失败:', err)
  } finally {
    loading.value = false
  }
}

watch(selectedDate, fetchSchedules)

const filteredSchedulesByCinema = computed(() => {
  const grouped = {}
  schedules.value.forEach(s => {
    if (!grouped[s.cinemaId]) {
      const cinema = cinemas.value.find(c => c.id === s.cinemaId)
      grouped[s.cinemaId] = { 
        id: s.cinemaId, 
        name: s.cinemaName || cinema?.name, 
        address: cinema?.address, 
        schedules: [] 
      }
    }
    grouped[s.cinemaId].schedules.push(s)
  })
  return Object.values(grouped)
})
</script>

<style scoped>
.booking-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; gap: 16px; margin-bottom: 20px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); }
.movie-info-bar { display: flex; align-items: center; gap: 16px; padding: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); margin-bottom: 20px; }
.movie-mini-poster { width: 60px; height: 80px; object-fit: cover; border-radius: 4px; }
.date-tabs { display: flex; gap: 8px; margin-bottom: 16px; }
.date-tab { padding: 10px 20px; border-radius: 8px; border: 1px solid var(--color-border); background: var(--color-surface); cursor: pointer; text-align: center; transition: all .2s; }
.date-tab:hover { border-color: var(--color-primary); }
.date-tab.active { background: var(--color-primary); border-color: var(--color-primary); }
.date-day { display: block; font-size: 14px; font-weight: 600; color: var(--color-text); }
.date-tab.active .date-day, .date-tab.active .date-week { color: #1a1a1a; }
.date-week { display: block; font-size: 12px; color: var(--color-text-muted); }
.cinema-schedules { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); padding: 16px; margin-bottom: 16px; }
.cinema-header { display: flex; align-items: baseline; gap: 12px; margin-bottom: 12px; }
.cinema-name { font-size: 15px; font-weight: 600; color: var(--color-text); }
.cinema-addr { font-size: 12px; color: var(--color-text-muted); }
.schedules-grid { display: flex; flex-wrap: wrap; gap: 10px; }
.schedule-item { width: 130px; padding: 12px; border: 1px solid var(--color-border); border-radius: 8px; cursor: pointer; transition: all .2s; }
.schedule-item:hover { border-color: var(--color-primary); background: var(--color-primary-light); }
.s-time { font-size: 20px; font-weight: 700; color: var(--color-text); margin-bottom: 4px; }
.s-hall { display: flex; align-items: center; gap: 4px; font-size: 12px; color: var(--color-text-muted); margin-bottom: 6px; flex-wrap: wrap; }
.s-bottom { display: flex; justify-content: space-between; font-size: 12px; }
.s-seats { color: var(--color-text-muted); }
.s-price { color: var(--color-primary); font-weight: 600; }
</style>
