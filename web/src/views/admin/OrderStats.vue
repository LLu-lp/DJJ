<template>
  <div class="admin-order-stats-page">
    <div class="page-header">
      <h2 class="page-title">订单统计分析</h2>
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
        <el-select v-model="selectedCinema" placeholder="选择影院" clearable style="width: 150px" @change="fetchStats">
          <el-option label="全部影院" :value="null" />
          <el-option label="朝阳店" :value="1" />
          <el-option label="海淀店" :value="2" />
          <el-option label="东城店" :value="3" />
        </el-select>
        <el-button @click="exportData">
          <el-icon><Download /></el-icon> 导出
        </el-button>
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
          <p class="stat-change" :style="{ color: orderChange >= 0 ? '#10b981' : '#ef4444' }">
            {{ orderChange >= 0 ? '+' : '' }}{{ orderChange }}%
          </p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(16, 185, 129, 0.15); color: #10b981">
          <el-icon><Money /></el-icon>
        </div>
        <div>
          <p class="stat-label">销售总额</p>
          <p class="stat-value">¥{{ totalRevenue }}</p>
          <p class="stat-change" :style="{ color: revenueChange >= 0 ? '#10b981' : '#ef4444' }">
            {{ revenueChange >= 0 ? '+' : '' }}{{ revenueChange }}%
          </p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(245, 158, 11, 0.15); color: #f59e0b">
          <el-icon><Tickets /></el-icon>
        </div>
        <div>
          <p class="stat-label">售票总数</p>
          <p class="stat-value">{{ totalTickets }}</p>
          <p class="stat-change" :style="{ color: ticketChange >= 0 ? '#10b981' : '#ef4444' }">
            {{ ticketChange >= 0 ? '+' : '' }}{{ ticketChange }}%
          </p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon" style="background: rgba(239, 68, 68, 0.15); color: #ef4444">
          <el-icon><Percent /></el-icon>
        </div>
        <div>
          <p class="stat-label">平均票价</p>
          <p class="stat-value">¥{{ avgPrice }}</p>
          <p class="stat-change" :style="{ color: priceChange >= 0 ? '#10b981' : '#ef4444' }">
            {{ priceChange >= 0 ? '+' : '' }}{{ priceChange }}%
          </p>
        </div>
      </div>
    </div>

    <!-- 图表 -->
    <div class="charts-grid">
      <el-card class="chart-card">
        <template #header>
          <span class="chart-title">销售额趋势</span>
        </template>
        <div ref="revenueChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card">
        <template #header>
          <span class="chart-title">订单数趋势</span>
        </template>
        <div ref="orderChartRef" class="chart-box"></div>
      </el-card>

      <el-card class="chart-card chart-card--wide">
        <template #header>
          <span class="chart-title">影院对比分析</span>
        </template>
        <div ref="cinemaChartRef" class="chart-box"></div>
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
        <span class="chart-title">影院详细数据</span>
      </template>
      <el-table :data="cinemaData" v-loading="loading" style="width: 100%">
        <el-table-column label="影院名称" min-width="150" prop="cinemaName" />
        <el-table-column label="订单数" width="100" align="center" prop="orderCount" />
        <el-table-column label="销售额" width="120" align="right">
          <template #default="{ row }">
            <span style="color: var(--color-primary); font-weight: 600">¥{{ row.revenue }}</span>
          </template>
        </el-table-column>
        <el-table-column label="售票数" width="100" align="center" prop="ticketCount" />
        <el-table-column label="平均票价" width="120" align="right">
          <template #default="{ row }">
            ¥{{ row.avgPrice }}
          </template>
        </el-table-column>
        <el-table-column label="上座率" width="120">
          <template #default="{ row }">
            <el-progress :percentage="row.occupancy" :stroke-width="6" />
          </template>
        </el-table-column>
        <el-table-column label="环比增长" width="120" align="right">
          <template #default="{ row }">
            <span :style="{ color: row.growth >= 0 ? '#10b981' : '#ef4444' }">
              {{ row.growth >= 0 ? '+' : '' }}{{ row.growth }}%
            </span>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { Download, Money, Percent, ShoppingCart, Tickets } from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { ElMessage } from 'element-plus'
import { onBeforeUnmount, onMounted, ref } from 'vue'

const loading = ref(false)
const dateRange = ref([])
const selectedCinema = ref(null)

const totalOrders = ref(0)
const totalRevenue = ref(0)
const totalTickets = ref(0)
const avgPrice = ref(0)
const orderChange = ref(0)
const revenueChange = ref(5.2)
const ticketChange = ref(3.8)
const priceChange = ref(1.2)
const cinemaData = ref([])

let charts = []
const revenueChartRef = ref(null)
const orderChartRef = ref(null)
const cinemaChartRef = ref(null)
const movieChartRef = ref(null)

const fetchStats = async () => {
  loading.value = true
  try {
    // 模拟数据
    const mockCinemaData = [
      { cinemaName: '朝阳店', orderCount: 285, revenue: 17100, ticketCount: 570, avgPrice: 60, occupancy: 85, growth: 8.5 },
      { cinemaName: '海淀店', orderCount: 198, revenue: 11880, ticketCount: 396, avgPrice: 60, occupancy: 72, growth: 3.2 },
      { cinemaName: '东城店', orderCount: 156, revenue: 9360, ticketCount: 312, avgPrice: 60, occupancy: 68, growth: -1.5 }
    ]

    cinemaData.value = mockCinemaData

    // 计算统计数据
    totalOrders.value = mockCinemaData.reduce((sum, d) => sum + d.orderCount, 0)
    totalRevenue.value = mockCinemaData.reduce((sum, d) => sum + d.revenue, 0).toFixed(2)
    totalTickets.value = mockCinemaData.reduce((sum, d) => sum + d.ticketCount, 0)
    avgPrice.value = (totalRevenue.value / totalTickets.value).toFixed(2)

    // 初始化图表
    initCharts(mockCinemaData)
  } catch (err) {
    console.error('获取统计数据失败:', err)
  } finally {
    loading.value = false
  }
}

const initCharts = (cinemaData) => {
  const dates = ['2025-01-08', '2025-01-09', '2025-01-10', '2025-01-11', '2025-01-12', '2025-01-13', '2025-01-14']
  const revenueData = [12000, 13500, 15200, 14800, 16500, 18200, 19340]
  const orderData = [200, 225, 253, 247, 275, 303, 318]

  // 销售额趋势
  const revenueChart = echarts.init(revenueChartRef.value)
  revenueChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: dates,
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
      data: revenueData,
      type: 'bar',
      itemStyle: { color: '#10b981', borderRadius: [4, 4, 0, 0] }
    }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  // 订单数趋势
  const orderChart = echarts.init(orderChartRef.value)
  orderChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: dates,
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
      data: orderData,
      type: 'line',
      smooth: true,
      itemStyle: { color: '#3b82f6' },
      areaStyle: { color: 'rgba(59, 130, 246, 0.1)' }
    }],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  // 影院对比
  const cinemaChart = echarts.init(cinemaChartRef.value)
  cinemaChart.setOption({
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: cinemaData.map(d => d.cinemaName),
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#333' } },
      axisLabel: { color: '#888' },
      splitLine: { lineStyle: { color: '#222' } }
    },
    series: [
      {
        name: '销售额',
        data: cinemaData.map(d => d.revenue),
        type: 'bar',
        itemStyle: { color: '#3b82f6', borderRadius: [4, 4, 0, 0] }
      },
      {
        name: '订单数',
        data: cinemaData.map(d => d.orderCount),
        type: 'bar',
        itemStyle: { color: '#10b981', borderRadius: [4, 4, 0, 0] }
      }
    ],
    grid: { top: 20, right: 20, bottom: 30, left: 50 }
  })

  // 电影销售排行
  const movieChart = echarts.init(movieChartRef.value)
  const movieData = [
    { name: '流浪地球2', value: 8500 },
    { name: '哪吒之魔童降世', value: 5200 },
    { name: '长津湖', value: 4100 },
    { name: '封神第一部', value: 3200 },
    { name: '热辣滚烫', value: 2400 }
  ]
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

  charts = [revenueChart, orderChart, cinemaChart, movieChart]
  window.addEventListener('resize', () => charts.forEach(c => c.resize()))
}

const exportData = () => {
  ElMessage.info('导出功能开发中...')
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
.admin-order-stats-page {
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
  margin-bottom: 4px;
}

.stat-change {
  font-size: 12px;
  font-weight: 600;
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

