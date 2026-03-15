<template>
  <div class="home-page">
    <!-- 顶部 Banner -->
    <section class="banner">
      <el-carousel height="420px" :interval="4000" arrow="always">
        <el-carousel-item v-for="movie in hotMovies.slice(0, 4)" :key="movie.id">
          <div class="banner-item" :style="{ backgroundImage: `url(${movie.poster})` }">
            <div class="banner-overlay">
              <div class="banner-content">
                <h1 class="banner-title">{{ movie.title }}</h1>
                <div class="banner-meta">
                  <el-tag v-for="g in movie.genre?.split(',')" :key="g" size="small" class="genre-tag">{{ g }}</el-tag>
                  <span class="rating">
                    <el-icon style="color:#3b82f6"><StarFilled /></el-icon>
                    {{ movie.rating }}
                  </span>
                </div>
                <p class="banner-desc">{{ movie.description }}</p>
                <el-button type="primary" size="large" @click="$router.push(`/movies/${movie.id}`)">
                  立即购票
                </el-button>
              </div>
            </div>
          </div>
        </el-carousel-item>
      </el-carousel>
    </section>

    <!-- 统计栏 -->
    <section class="stats-bar">
      <div class="stat-item">
        <span class="stat-value">{{ statistics.todayOrders || 0 }}</span>
        <span class="stat-label">今日出票</span>
      </div>
      <div class="stat-divider"></div>
      <div class="stat-item">
        <span class="stat-value">{{ hotMovies.length }}</span>
        <span class="stat-label">正在热映</span>
      </div>
      <div class="stat-divider"></div>
      <div class="stat-item">
        <span class="stat-value">{{ comingSoon.length }}</span>
        <span class="stat-label">即将上映</span>
      </div>
      <div class="stat-divider"></div>
      <div class="stat-item">
        <span class="stat-value">{{ statistics.totalUsers || 0 }}</span>
        <span class="stat-label">注册会员</span>
      </div>
    </section>

    <!-- 快捷入口 -->
    <section class="quick-nav">
      <div class="quick-item" @click="$router.push('/movies')">
        <div class="quick-icon movie-icon"><el-icon size="28"><Film /></el-icon></div>
        <span>购票选座</span>
      </div>
      <div class="quick-item" @click="$router.push('/cinemas')">
        <div class="quick-icon cinema-icon"><el-icon size="28"><Location /></el-icon></div>
        <span>影院信息</span>
      </div>
      <div class="quick-item" @click="$router.push('/snacks')">
        <div class="quick-icon snack-icon"><el-icon size="28"><GoodsFilled /></el-icon></div>
        <span>小食预购</span>
      </div>
      <div class="quick-item" @click="$router.push('/member')">
        <div class="quick-icon member-icon"><el-icon size="28"><UserFilled /></el-icon></div>
        <span>会员中心</span>
      </div>
      <div class="quick-item" @click="$router.push('/orders')">
        <div class="quick-icon order-icon"><el-icon size="28"><Ticket /></el-icon></div>
        <span>我的订单</span>
      </div>
      <div class="quick-item" @click="$router.push('/announcements')">
        <div class="quick-icon notice-icon"><el-icon size="28"><Bell /></el-icon></div>
        <span>最新公告</span>
      </div>
    </section>

    <!-- 公告栏 -->
    <section class="notice-bar" v-if="announcements.length > 0">
      <div class="notice-label"><el-icon><Bell /></el-icon> 公告</div>
      <el-carousel height="32px" direction="vertical" :autoplay="true" :interval="3000" indicator-position="none" arrow="never" class="notice-carousel">
        <el-carousel-item v-for="a in announcements" :key="a.id">
          <div class="notice-text" @click="$router.push('/announcements')">{{ a.title }}</div>
        </el-carousel-item>
      </el-carousel>
      <el-button link style="color:var(--color-primary);font-size:12px" @click="$router.push('/announcements')">更多</el-button>
    </section>

    <!-- 正在热映 -->
    <section class="section">
      <div class="section-header">
        <h2 class="section-title">正在热映</h2>
        <el-button link @click="$router.push('/movies')" style="color:var(--color-primary)">
          查看全部 <el-icon><ArrowRight /></el-icon>
        </el-button>
      </div>
      <div class="movie-grid" v-loading="loading">
        <div
          v-for="movie in hotMovies"
          :key="movie.id"
          class="movie-card"
          @click="$router.push(`/movies/${movie.id}`)"
        >
          <div class="movie-poster-wrap">
            <img :src="movie.poster" :alt="movie.title" class="movie-poster" />
            <div class="movie-overlay">
              <el-button type="primary" size="small">购票</el-button>
            </div>
            <div class="movie-rating">
              <el-icon style="color:#3b82f6;font-size:12px"><StarFilled /></el-icon>
              <span>{{ movie.rating }}</span>
            </div>
          </div>
          <div class="movie-info">
            <h3 class="movie-title">{{ movie.title }}</h3>
            <p class="movie-meta">{{ movie.genre?.replace(/,/g, ' / ') }}</p>
            <p class="movie-box">时长 <strong style="color:var(--color-primary)">{{ movie.duration }}分钟</strong></p>
          </div>
        </div>
      </div>
    </section>

    <!-- 即将上映 -->
    <section class="section" v-if="comingSoon.length > 0">
      <div class="section-header">
        <h2 class="section-title">即将上映</h2>
        <el-button link @click="$router.push('/movies')" style="color:var(--color-primary)">
          查看全部 <el-icon><ArrowRight /></el-icon>
        </el-button>
      </div>
      <div class="coming-list" v-loading="loading">
        <div v-for="movie in comingSoon" :key="movie.id" class="coming-card">
          <img :src="movie.poster" :alt="movie.title" class="coming-poster" />
          <div class="coming-info">
            <h3 class="coming-title">{{ movie.title }}</h3>
            <p class="coming-genre">{{ movie.genre?.replace(/,/g, ' · ') }}</p>
            <p class="coming-date">
              <el-icon><Calendar /></el-icon>
              {{ movie.releaseDate }} 上映
            </p>
            <p class="coming-desc">{{ movie.description }}</p>
            <div class="coming-actors">主演：{{ movie.actors }}</div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { announcementApi, movieApi, publicApi } from '@/api'
import { ArrowRight, Bell, Calendar, Film, GoodsFilled, Location, StarFilled, Ticket, UserFilled } from '@element-plus/icons-vue'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const hotMovies = ref([])
const comingSoon = ref([])
const statistics = ref({})
const announcements = ref([])

const fetchData = async () => {
  loading.value = true
  try {
    const [showingRes, comingRes, statsRes, noticeRes] = await Promise.all([
      movieApi.getNowShowing(),
      movieApi.getComingSoon(),
      publicApi.getStatistics().catch(() => ({ code: 200, data: {} })),
      announcementApi.getList({ limit: 5 }).catch(() => ({ code: 200, data: [] }))
    ])
    if (showingRes.code === 200) hotMovies.value = showingRes.data || []
    if (comingRes.code === 200) comingSoon.value = comingRes.data || []
    if (statsRes.code === 200) statistics.value = statsRes.data || {}
    if (noticeRes.code === 200) announcements.value = noticeRes.data || []
  } catch (err) {
    console.error('获取数据失败:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchData()
})
</script>

<style scoped>
.home-page { padding-bottom: 40px; }

/* Banner */
.banner { margin: -24px -24px 0; }
.banner-item { width: 100%; height: 420px; background-size: cover; background-position: center; position: relative; }
.banner-overlay { position: absolute; inset: 0; background: linear-gradient(to right, rgba(31,41,55,0.8) 0%, rgba(31,41,55,0.3) 60%, transparent 100%); display: flex; align-items: center; }
.banner-content { padding: 0 80px; max-width: 560px; }
.banner-title { font-size: 36px; font-weight: 700; color: #fff; margin-bottom: 12px; }
.banner-meta { display: flex; align-items: center; gap: 8px; margin-bottom: 12px; }
.genre-tag { background: rgba(59,130,246,0.15) !important; border-color: rgba(59,130,246,0.3) !important; color: var(--color-primary) !important; }
.rating { display: flex; align-items: center; gap: 4px; font-size: 16px; font-weight: 600; color: var(--color-primary); }
.banner-desc { color: rgba(255,255,255,0.85); line-height: 1.7; margin-bottom: 20px; font-size: 14px; }

/* 统计栏 */
.stats-bar { display: flex; align-items: center; justify-content: center; gap: 40px; padding: 20px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); margin: 24px 0; }
.stat-item { text-align: center; }
.stat-value { display: block; font-size: 28px; font-weight: 700; color: var(--color-primary); }
.stat-label { font-size: 12px; color: var(--color-text-muted); }
.stat-divider { width: 1px; height: 40px; background: var(--color-border); }

/* 快捷入口 */
.quick-nav { display: flex; gap: 12px; margin-bottom: 24px; }
.quick-item { flex: 1; display: flex; flex-direction: column; align-items: center; gap: 8px; padding: 16px 8px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); cursor: pointer; transition: all .2s; font-size: 13px; color: var(--color-text-muted); }
.quick-item:hover { border-color: var(--color-primary); color: var(--color-text); transform: translateY(-2px); }
.quick-icon { width: 52px; height: 52px; border-radius: 14px; display: flex; align-items: center; justify-content: center; }
.movie-icon { background: rgba(59,130,246,0.15); color: #3b82f6; }
.cinema-icon { background: rgba(59,130,246,0.15); color: #3b82f6; }
.snack-icon { background: rgba(16,185,129,0.15); color: #10b981; }
.member-icon { background: rgba(239,68,68,0.15); color: #ef4444; }
.order-icon { background: rgba(107,114,128,0.15); color: #6b7280; }
.notice-icon { background: rgba(6,182,212,0.15); color: #06b6d4; }

/* 公告栏 */
.notice-bar { display: flex; align-items: center; gap: 12px; padding: 10px 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); margin-bottom: 24px; }
.notice-label { display: flex; align-items: center; gap: 6px; font-size: 13px; color: var(--color-primary); white-space: nowrap; font-weight: 600; }
.notice-carousel { flex: 1; }
.notice-text { font-size: 13px; color: var(--color-text-muted); line-height: 32px; cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.notice-text:hover { color: var(--color-primary); }

/* 板块 */
.section { margin-bottom: 40px; }
.section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.section-title { font-size: 20px; font-weight: 700; color: var(--color-text); position: relative; padding-left: 12px; }
.section-title::before { content: ''; position: absolute; left: 0; top: 50%; transform: translateY(-50%); width: 4px; height: 20px; background: var(--color-primary); border-radius: 2px; }

/* 电影格 */
.movie-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 16px; }
.movie-card { cursor: pointer; border-radius: var(--radius); overflow: hidden; background: var(--color-surface); border: 1px solid var(--color-border); transition: transform .2s, border-color .2s; }
.movie-card:hover { transform: translateY(-4px); border-color: var(--color-primary); }
.movie-poster-wrap { position: relative; aspect-ratio: 3/4; overflow: hidden; }
.movie-poster { width: 100%; height: 100%; object-fit: cover; transition: transform .3s; }
.movie-card:hover .movie-poster { transform: scale(1.05); }
.movie-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; opacity: 0; transition: opacity .2s; }
.movie-card:hover .movie-overlay { opacity: 1; }
.movie-rating { position: absolute; top: 8px; right: 8px; background: rgba(0,0,0,0.7); padding: 2px 6px; border-radius: 4px; display: flex; align-items: center; gap: 3px; font-size: 12px; color: #fff; }
.movie-info { padding: 10px 12px; }
.movie-title { font-size: 14px; font-weight: 600; color: var(--color-text); margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.movie-meta { font-size: 12px; color: var(--color-text-muted); margin-bottom: 4px; }
.movie-box { font-size: 12px; color: var(--color-text-muted); }

/* 即将上映 */
.coming-list { display: flex; flex-direction: column; gap: 16px; }
.coming-card { display: flex; gap: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); padding: 16px; transition: border-color .2s; }
.coming-card:hover { border-color: var(--color-primary); }
.coming-poster { width: 90px; height: 120px; object-fit: cover; border-radius: 6px; flex-shrink: 0; }
.coming-info { flex: 1; }
.coming-title { font-size: 16px; font-weight: 600; color: var(--color-text); margin-bottom: 6px; }
.coming-genre { font-size: 12px; color: var(--color-text-muted); margin-bottom: 6px; }
.coming-date { display: flex; align-items: center; gap: 4px; font-size: 13px; color: var(--color-primary); margin-bottom: 8px; }
.coming-desc { font-size: 13px; color: var(--color-text-muted); line-height: 1.6; margin-bottom: 6px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
.coming-actors { font-size: 12px; color: var(--color-text-muted); }
</style>
