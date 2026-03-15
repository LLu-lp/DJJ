<template>
  <div class="order-stats-page">
    <div class="page-header">
      <h2 class="page-title">订单统计</h2>
      <div class="header-actions">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="YYYY-MM-DD"
          @change="fetchStats"
          style="width: 280px"
        />
        <el-select v-model="statType" placeholder="统计类型" style="width: 140px" @change="fetchStats">
          <el-option label="日统计" value="day" />
          <el-option label="周统计" value="week" />
          <el-option label="月统计" value="month" />
        </el-select>
      </div>
    </div>

    <!-- 统计卡片 -->
    <div class="stats-cards">
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(59, 130, 246, 0.15); color: #3b82f6">
          <el-icon><ShoppingCart /></el-icon>
        </div>
        <div>
          <p class="stat-label">订单总数</p>
          <p class="stat-value">{{ totalOrders }}</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(16, 185, 129, 0.15); color: #10b981">
          <el-icon><Money /></el-icon>
        </div>
        <div>
          <p class="stat-label">销售总额</p>
          <p class="stat-value">¥{{ totalRevenue }}</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(245, 158, 11, 0.15); color: #f59e0b">
          <el-icon><Tickets /></el-icon>
        </div>
        <div>
          <p class="stat-label">售票总数</p>
          <p class="stat-value">{{ totalTickets }}</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(239, 68, 68, 0.15); color: #ef4444">
          <el-icon><Percent /></el-icon>
        </div>
        <div>
          <p class="stat-label">平均上座率</p>
          <p class="stat-value">{{ avgOccupancy }}%</p>
        </div>
      </div>
    </div>

    <!-- 图表 -->
    <div class="charts-grid">
      <el-card class="chart-card">
        <template #header>
          <span class="chart-title">订单趋势</span>
        </template>
        <div ref="orderChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card">
        <template #header>
          <span class="chart-title">销售额趋势</span>
        </template>
        <div ref="revenueChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card chart-card--wide">
        <template #header>
          <span class="chart-title">电影销售排行</span>
        </template>
        <div ref="movieChartRef" class="chart-box"></div>
      </el-card>
    </div>

    <!-- 详细数据表 -->
    <el-card style="margin-top: 24px">
      <template #header>
        <span class="chart-title">详细数据</span>
      </template>
      <el-table :data="detailData" v-loading="loading" style="width: 100%">
        <el-table-column label="日期" width="120" prop="date" />
        <el-table-column label="订单数" width="100" align="center" prop="orderCount" />
        <el-table-column label="销售额" width="120" align="right">
          <template #default="{ row }">
            <span style="color: var(--color-primary); font-weight: 600">¥{{ row.revenue }}</span>
          </template>
        </el-table-column>
        <el-table-column label="售票数" width="100" align="center" prop="ticketCount" />
        <el-table-column label="上座率" width="120">
          <template #default="{ row }">
            <el-progress :percentage="row.occupancy" :stroke-width="6" />
          </template>
        </el-table-column>
        <el-table-column label="平均票价" width="120" align="right">
          <template #default="{ row }">
            ¥{{ row.avgPrice }}
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { Money, Percent, ShoppingCart, Tickets } from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { markRaw, onBeforeUnmount, onMounted, ref } from 'vue'

const loading = ref(false)
const dateRange = ref([])
const statType = ref('day')

const totalOrders = ref(0)
const totalRevenue = ref(0)
const totalTickets = ref(0)
const avgOccupancy = ref(0)
const detailData = ref([])

let charts = []
const orderChartRef = ref(null)
const revenueChartRef = ref(null)
const movieChartRef = ref(null)

const fetchStats = async () => {
  loading.value = true
  try {
    const params = {}
    if (dateRange.value && dateRange.value[0]) {
      params.startDate = dateRange.value[0]
      params.endDate = dateRange.value[1]
    }
    const res = await adminApi.getOrderStats(params)
    if (res.code === 200) {
      const data = res.data || {}
      const daily = data.dailyData || []

      totalOrders.value = data.totalOrders || 0
      totalRevenue.value = Number(data.totalRevenue || 0).toFixed(2)
      totalTickets.value = data.totalTickets || 0
      avgOccupancy.value = 0

      detailData.value = daily.map(d => ({
        date: d.date,
        orderCount: d.orderCount || 0,
        revenue: d.revenue || 0,
        ticketCount: d.orderCount || 0,
        occupancy: 0,
        avgPrice: d.orderCount > 0 ? Math.round(d.revenue / d.orderCount) : 0
      }))

      initCharts(daily, data.movieRankChart || [])
    }
  } catch (err) {
    console.error('获取统计数据失败:', err)
  } finally {
    loading.value = false
  }
}

const initCharts = (data, movieRank) => {
  // 订单趋势图
  const orderChart = echarts.init(orderChartRef.value)
  orderChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: data.map(d => d.date),
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' },
      splitLine: { lineStyle: { color: '#222' } }
    },
    series: [{
      data: data.map(d => d.orderCount),
      type: 'line',
      smooth: true,
      itemStyle: { color: '#3b82f6' },
      areaStyle: { color: 'rgba(59, 130, 246, 0.1)' }
    }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  // 销售额趋势图
  const revenueChart = echarts.init(revenueChartRef.value)
  revenueChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: data.map(d => d.date),
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' },
      splitLine: { lineStyle: { color: '#222' } }
    },
    series: [{
      data: data.map(d => d.revenue),
      type: 'bar',
      itemStyle: { color: '#10b981', borderRadius: [4, 4, 0, 0] }
    }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  // 电影销售排行
  const movieChart = echarts.init(movieChartRef.value)
  const movieData = movieRank.length > 0 ? movieRank : []
  movieChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: movieData.map(d => d.name),
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' },
      splitLine: { lineStyle: { color: '#222' } }
    },
    series: [{
      data: movieData.map(d => d.value),
      type: 'bar',
      itemStyle: { color: '#f59e0b', borderRadius: [4, 4, 0, 0] }
    }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  charts = [orderChart, revenueChart, movieChart]
  window.addEventListener('resize', () => charts.forEach(c => c.resize()))
}

onMounted(() => {
  const end = new Date()
  const start = new Date()
  start.setDate(start.getDate() - 7)
  dateRange.value = [
    start.toISOString().split('T')[0],
    end.toISOString().split('T')[0]
  ]
  fetchStats()
})

onBeforeUnmount(() => {
  charts.forEach(c => c.dispose())
  window.removeEventListener('resize', () => {})
})
</script>

<style scoped>
.order-stats-page {
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
  font-size: 18px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.stats-cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
}

.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-label {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: 4px;
}

.stat-value {
  font-size: 24px;
  font-weight: 700;
  color: var(--color-text);
}

.charts-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 24px;
}

.chart-card {
  background: var(--color-surface) !important;
  border: 1px solid var(--color-border) !important;
}

.chart-card--wide {
  grid-column: span 2;
}

.chart-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
}

.chart-box {
  height: 280px;
}

@media (max-width: 1024px) {
  .stats-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  .charts-grid {
    grid-template-columns: 1fr;
  }

  .chart-card--wide {
    grid-column: span 1;
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .header-actions {
    width: 100%;
    flex-direction: column;
  }
}
</style>

