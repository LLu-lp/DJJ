<template>
  <div class="page-container">
    <div class="page-header">
      <h2>今日场次</h2>
      <el-date-picker v-model="selectedDate" type="date" value-format="YYYY-MM-DD" @change="fetchSchedules" style="width: 180px" />
    </div>

    <el-row :gutter="16">
      <el-col v-for="schedule in schedules" :key="schedule.id" :span="8" style="margin-bottom: 16px">
        <el-card class="schedule-card" :class="{ 'is-current': schedule.status === 1 }">
          <div class="schedule-header">
            <div class="movie-info">
              <h3>{{ schedule.movieTitle || schedule.movie?.title }}</h3>
              <el-tag size="small" :type="schedule.status === 1 ? 'success' : 'info'">
                {{ schedule.status === 1 ? '售票中' : '已结束' }}
              </el-tag>
            </div>
            <div class="time-info">
              <span class="time">{{ schedule.startTime || schedule.showTime }}</span>
              <span class="duration">{{ schedule.duration }}分钟</span>
            </div>
          </div>
          <div class="schedule-body">
            <div class="info-row">
              <span class="label">影厅</span>
              <span>{{ schedule.hallName }}</span>
            </div>
            <div class="info-row">
              <span class="label">票价</span>
              <span class="price">¥{{ schedule.price }}</span>
            </div>
            <div class="info-row">
              <span class="label">上座率</span>
              <el-progress :percentage="Math.round((schedule.soldSeats || 0) / (schedule.totalSeats || 100) * 100)" :stroke-width="8" />
            </div>
            <div class="info-row">
              <span class="label">已售/总座</span>
              <span>{{ schedule.soldSeats || 0 }} / {{ schedule.totalSeats || 0 }}</span>
            </div>
          </div>
          <div class="schedule-footer">
            <el-button size="small" type="primary" plain @click="viewSeats(schedule)">查看座位图</el-button>
            <el-button size="small" type="success" plain @click="quickTicket(schedule)">快速出票</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-dialog v-model="seatDialogVisible" :title="currentSchedule?.movieTitle + ' - 座位图'" width="720px">
      <div v-if="currentSchedule" class="seat-preview">
        <div class="screen-label">银幕</div>
        <div class="seat-grid">
          <div v-for="(row, rowIdx) in seatMap" :key="rowIdx" class="seat-row">
            <span class="row-label">{{ String.fromCharCode(65 + rowIdx) }}</span>
            <div v-for="(seat, colIdx) in row" :key="colIdx"
                 class="seat-item"
                 :class="{ 'is-available': seat === 0, 'is-sold': seat === 1, 'is-locked': seat === 2 }">
              {{ colIdx + 1 }}
            </div>
          </div>
        </div>
        <div class="seat-legend">
          <span class="legend-item"><span class="seat-item is-available"></span> 可选</span>
          <span class="legend-item"><span class="seat-item is-sold"></span> 已售</span>
          <span class="legend-item"><span class="seat-item is-locked"></span> 锁定</span>
        </div>
      </div>
    </el-dialog>

    <el-dialog v-model="ticketDialogVisible" title="快速出票" width="400px">
      <el-form label-width="100px">
        <el-form-item label="订单号/手机号">
          <el-input v-model="ticketForm.keyword" placeholder="输入订单号或手机号" @keyup.enter="lookupOrder" />
        </el-form-item>
        <el-button type="primary" @click="lookupOrder" style="width: 100%">查询订单</el-button>
      </el-form>
      <div v-if="foundOrder" class="found-order">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="用户">{{ foundOrder.username }}</el-descriptions-item>
          <el-descriptions-item label="电影">{{ foundOrder.movieTitle }}</el-descriptions-item>
          <el-descriptions-item label="座位">{{ foundOrder.seats }}</el-descriptions-item>
        </el-descriptions>
        <el-button type="success" @click="confirmTicket" :disabled="foundOrder.ticketed" style="width: 100%; margin-top: 12px">
          {{ foundOrder.ticketed ? '已出票' : '确认出票' }}
        </el-button>
      </div>
      <template #footer>
        <el-button @click="ticketDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { scheduleApi, staffApi } from '@/api'
import { ElMessage } from 'element-plus'
import { onMounted, ref } from 'vue'

const selectedDate = ref(new Date().toISOString().split('T')[0])
const schedules = ref([])
const seatDialogVisible = ref(false)
const ticketDialogVisible = ref(false)
const currentSchedule = ref(null)
const ticketForm = ref({ keyword: '' })
const foundOrder = ref(null)

const seatMap = ref([])

const fetchSchedules = async () => {
  try {
    const res = await scheduleApi.getPage({
      showDate: selectedDate.value,
      size: 50
    })
    if (res.code === 200) {
      schedules.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取场次列表失败:', err)
  }
}

const fetchSeats = async (scheduleId) => {
  try {
    const res = await scheduleApi.getSeats(scheduleId)
    if (res.code === 200) {
      const seats = res.data || []
      
      // 计算行数和列数
      const maxRow = Math.max(...seats.map(s => s.rowNum), 0)
      const maxCol = Math.max(...seats.map(s => s.colNum), 0)
      
      // 构建座位图：0=可选，1=已售，2=锁定
      seatMap.value = Array.from({ length: maxRow }, (_, rowIdx) =>
        Array.from({ length: maxCol }, (_, colIdx) => {
          const seat = seats.find(s => s.rowNum === rowIdx + 1 && s.colNum === colIdx + 1)
          return seat?.status || 0
        })
      )
    }
  } catch (err) {
    console.error('获取座位图失败:', err)
  }
}

const viewSeats = async (schedule) => {
  currentSchedule.value = schedule
  await fetchSeats(schedule.id)
  seatDialogVisible.value = true
}

const quickTicket = (schedule) => {
  currentSchedule.value = schedule
  ticketForm.value.keyword = ''
  foundOrder.value = null
  ticketDialogVisible.value = true
}

const lookupOrder = async () => {
  if (!ticketForm.value.keyword.trim()) return
  try {
    const res = await staffApi.getOrders({ 
      keyword: ticketForm.value.keyword,
      scheduleId: currentSchedule.value?.id
    })
    if (res.code === 200 && res.data?.records?.length > 0) {
      const order = res.data.records[0]
      foundOrder.value = {
        id: order.id,
        orderNo: order.orderNo,
        username: order.username,
        movieTitle: order.movieTitle,
        seats: order.seats?.map(s => s.seatLabel).join(',') || '',
        ticketed: order.ticketed === 1
      }
    } else {
      ElMessage.warning('未找到订单')
      foundOrder.value = null
    }
  } catch (err) {
    console.error('查询订单失败:', err)
    ElMessage.error('查询订单失败')
  }
}

const confirmTicket = async () => {
  if (!foundOrder.value) return
  try {
    const res = await staffApi.verifyTicket({ code: foundOrder.value.orderNo })
    if (res.code === 200) {
      foundOrder.value.ticketed = true
      ElMessage.success('出票成功')
      setTimeout(() => {
        ticketDialogVisible.value = false
      }, 1000)
    }
  } catch (err) {
    console.error('出票失败:', err)
    ElMessage.error(err.response?.data?.message || '出票失败')
  }
}

onMounted(() => {
  fetchSchedules()
})
</script>

<style scoped>
.schedule-card { transition: transform 0.2s; }
.schedule-card:hover { transform: translateY(-2px); }
.schedule-card.is-current { border-color: #67c23a; }

.schedule-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; }
.movie-info h3 { margin: 0 0 6px; font-size: 16px; }
.time-info { text-align: right; }
.time { display: block; font-size: 22px; font-weight: 700; color: #e50914; }
.duration { font-size: 12px; color: #999; }

.info-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; font-size: 13px; }
.label { color: #999; }
.price { color: #e50914; font-weight: 600; }

.schedule-footer { display: flex; gap: 8px; margin-top: 12px; }

.screen-label { text-align: center; background: #ddd; padding: 6px; border-radius: 4px; margin-bottom: 20px; font-size: 13px; color: #666; }
.seat-grid { display: flex; flex-direction: column; gap: 6px; align-items: center; }
.seat-row { display: flex; gap: 6px; align-items: center; }
.row-label { width: 20px; text-align: center; font-size: 12px; color: #999; }
.seat-item { width: 28px; height: 24px; border-radius: 4px 4px 0 0; display: flex; align-items: center; justify-content: center; font-size: 11px; cursor: pointer; }
.seat-item.is-available { background: #67c23a; }
.seat-item.is-sold { background: #ddd; color: #999; }
.seat-item.is-locked { background: #ffc069; color: #666; }
.seat-legend { display: flex; gap: 16px; justify-content: center; margin-top: 16px; }
.legend-item { display: flex; align-items: center; gap: 6px; font-size: 12px; color: #666; }

.found-order { padding: 16px; background: var(--color-surface-2); border-radius: 8px; margin-top: 16px; }
</style>
