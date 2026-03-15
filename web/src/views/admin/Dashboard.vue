<template>
  <div class="dashboard-page">
    <div class="stats-grid">
      <div v-for="stat in statCards" :key="stat.label" class="stat-card">
        <div class="stat-icon" :style="{ background: stat.bg, color: stat.color }">
          <el-icon :size="22"><component :is="stat.icon" /></el-icon>
        </div>
        <div>
          <p class="stat-label">{{ stat.label }}</p>
          <p class="stat-value">{{ stat.value }}</p>
        </div>
      </div>
    </div>

    <div class="charts-grid">
      <el-card class="chart-card">
        <template #header><span class="chart-title">近7日票房趋势（元）</span></template>
        <div ref="lineChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card">
        <template #header><span class="chart-title">电影类型分布</span></template>
        <div ref="pieChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card chart-card--wide">
        <template #header><span class="chart-title">各类型总票房（万元）</span></template>
        <div ref="barChartRef" class="chart-box"></div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { Film, List, Money, User } from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { markRaw, onBeforeUnmount, onMounted, ref } from 'vue'

const stats = ref({})
const statCards = ref([])

let charts = []
const lineChartRef = ref(null)
const pieChartRef = ref(null)
const barChartRef = ref(null)

const fetchStats = async () => {
  try {
    const res = await adminApi.getStatistics()
    if (res.code === 200) {
      stats.value = res.data || {}
      updateStatCards()
    }
  } catch (err) {
    console.error('获取统计数据失败:', err)
  }
}

const updateStatCards = () => {
  statCards.value = [
    { label: '今日票房（元）', value: (stats.value.todayRevenue || 0).toLocaleString(), icon: markRaw(Money), color: '#e8b84b', bg: 'rgba(232,184,75,0.15)' },
    { label: '今日订单量', value: stats.value.todayOrders || 0, icon: markRaw(List), color: '#4caf82', bg: 'rgba(76,175,130,0.15)' },
    { label: '平台用户数', value: (stats.value.totalUsers || 0).toLocaleString(), icon: markRaw(User), color: '#4a9ff5', bg: 'rgba(74,159,245,0.15)' },
    { label: '电影总数', value: stats.value.totalMovies || 0, icon: markRaw(Film), color: '#e05c5c', bg: 'rgba(224,92,92,0.15)' },
  ]
}

const initCharts = () => {
  const lineChart = echarts.init(lineChartRef.value)
  const pieChart = echarts.init(pieChartRef.value)
  const barChart = echarts.init(barChartRef.value)

  const revenueChart = stats.value.revenueChart || []
  const lineDates = revenueChart.map(d => d.date)
  const lineValues = revenueChart.map(d => d.revenue)

  lineChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: { type: 'category', data: lineDates, axisLine: { lineStyle: { color: '#333' } }, axisLabel: { color: '#888' } },
    yAxis: { type: 'value', axisLine: { lineStyle: { color: '#333' } }, axisLabel: { color: '#888' }, splitLine: { lineStyle: { color: '#222' } } },
    series: [{ data: lineValues, type: 'line', smooth: true, itemStyle: { color: '#e8b84b' }, areaStyle: { color: 'rgba(232,184,75,0.1)' } }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  const genreData = stats.value.genreChart || []

  pieChart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: { bottom: 0, textStyle: { color: '#888' } },
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      center: ['50%', '45%'],
      data: genreData,
      itemStyle: { borderRadius: 6, borderColor: '#1a1a1a', borderWidth: 2 },
      label: { color: '#fff' }
    }]
  })

  const barData = stats.value.movieRankChart || []

  barChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: { type: 'category', data: barData.map(d => d.name || d.title), axisLine: { lineStyle: { color: '#333' } }, axisLabel: { color: '#888' } },
    yAxis: { type: 'value', axisLine: { lineStyle: { color: '#333' } }, axisLabel: { color: '#888' }, splitLine: { lineStyle: { color: '#222' } } },
    series: [{ data: barData.map(d => d.value || d.revenue), type: 'bar', barWidth: '50%', itemStyle: { color: '#e8b84b', borderRadius: [4, 4, 0, 0] } }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  charts = [lineChart, pieChart, barChart]
  window.addEventListener('resize', () => charts.forEach(c => c.resize()))
}

onMounted(async () => {
  await fetchStats()
  initCharts()
})

onBeforeUnmount(() => {
  charts.forEach(c => c.dispose())
  window.removeEventListener('resize', () => {})
})
</script>

<style scoped>
.dashboard-page { padding-bottom: 40px; }
.stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px; }
.stat-card { display: flex; align-items: center; gap: 16px; padding: 20px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); }
.stat-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.stat-label { font-size: 13px; color: var(--color-text-muted); margin-bottom: 4px; }
.stat-value { font-size: 24px; font-weight: 700; color: var(--color-text); }
.charts-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
.chart-card { background: var(--color-surface) !important; border: 1px solid var(--color-border) !important; }
.chart-card--wide { grid-column: span 2; }
.chart-title { font-size: 14px; font-weight: 600; color: var(--color-text); }
.chart-box { height: 280px; }
</style>
