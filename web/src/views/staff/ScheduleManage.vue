<template>
  <div class="schedule-manage-page">
    <div class="page-header">
      <h2 class="page-title">排片管理</h2>
      <el-button type="primary" @click="openCreateDialog()">
        <el-icon><Plus /></el-icon> 新增场次
      </el-button>
    </div>

    <div class="filters">
      <el-date-picker
        v-model="filterDate"
        type="date"
        value-format="YYYY-MM-DD"
        placeholder="选择日期"
        @change="fetchSchedules"
        style="width: 180px"
      />
      <el-select v-model="filterHall" placeholder="选择影厅" clearable style="width: 150px" @change="fetchSchedules">
        <el-option v-for="hall in halls" :key="hall.id" :label="hall.name" :value="hall.id" />
      </el-select>
      <el-select v-model="filterMovie" placeholder="选择电影" clearable style="width: 200px" @change="fetchSchedules">
        <el-option v-for="movie in movies" :key="movie.id" :label="movie.title" :value="movie.id" />
      </el-select>
    </div>

    <el-table :data="schedules" v-loading="loading" style="width: 100%">
      <el-table-column label="电影" min-width="150" prop="movieTitle" />
      <el-table-column label="影厅" width="100" prop="hallName" />
      <el-table-column label="放映日期" width="120">
        <template #default="{ row }">{{ row.showDate }}</template>
      </el-table-column>
      <el-table-column label="放映时间" width="100">
        <template #default="{ row }">{{ row.startTime }}</template>
      </el-table-column>
      <el-table-column label="票价" width="100" align="right">
        <template #default="{ row }">
          <span>¥{{ row.price }}</span>
          <span v-if="row.vipPrice" style="color: var(--color-text-muted); font-size: 12px">
            / ¥{{ row.vipPrice }}
          </span>
        </template>
      </el-table-column>
      <el-table-column label="上座率" width="120">
        <template #default="{ row }">
          <el-progress
            :percentage="Math.round((row.soldSeats || 0) / (row.totalSeats || 100) * 100)"
            :stroke-width="6"
            :color="getProgressColor"
          />
        </template>
      </el-table-column>
      <el-table-column label="已售/总座" width="100" align="center">
        <template #default="{ row }">
          {{ row.soldSeats || 0 }} / {{ row.totalSeats || 0 }}
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'info'">
            {{ row.status === 1 ? '售票中' : '已结束' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openEditDialog(row)">编辑</el-button>
          <el-button size="small" type="warning" text @click="viewSeats(row)">座位图</el-button>
          <el-button size="small" type="danger" text @click="deleteSchedule(row)" v-if="row.soldSeats === 0">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑场次对话框 -->
    <el-dialog v-model="scheduleDialogVisible" :title="editingSchedule ? '编辑场次' : '新增场次'" width="600px">
      <el-form :model="scheduleForm" label-width="100px">
        <el-form-item label="电影" required>
          <el-select v-model="scheduleForm.movieId" placeholder="选择电影" style="width: 100%">
            <el-option v-for="movie in movies" :key="movie.id" :label="movie.title" :value="movie.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="影厅" required>
          <el-select v-model="scheduleForm.hallId" placeholder="选择影厅" style="width: 100%">
            <el-option v-for="hall in halls" :key="hall.id" :label="hall.name" :value="hall.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="放映日期" required>
          <el-date-picker
            v-model="scheduleForm.showDate"
            type="date"
            value-format="YYYY-MM-DD"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="开始时间" required>
          <el-time-picker
            v-model="scheduleForm.startTime"
            format="HH:mm"
            value-format="HH:mm"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="普通票价" required>
          <el-input-number v-model="scheduleForm.price" :min="1" :step="5" style="width: 100%" />
        </el-form-item>
        <el-form-item label="VIP票价">
          <el-input-number v-model="scheduleForm.vipPrice" :min="1" :step="5" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="scheduleDialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="savingSchedule" @click="saveSchedule">确定</el-button>
      </template>
    </el-dialog>

    <!-- 座位图预览对话框 -->
    <el-dialog v-model="seatDialogVisible" :title="`${currentSchedule?.movieTitle} - 座位图`" width="720px">
      <div v-if="currentSchedule" class="seat-preview">
        <div class="screen-label">银幕</div>
        <div class="seat-grid">
          <div v-for="(row, rowIdx) in seatMap" :key="rowIdx" class="seat-row">
            <span class="row-label">{{ String.fromCharCode(65 + rowIdx) }}</span>
            <div
              v-for="(seat, colIdx) in row"
              :key="colIdx"
              class="seat-item"
              :class="{ 'is-available': seat === 0, 'is-sold': seat === 1 }"
            >
              {{ colIdx + 1 }}
            </div>
          </div>
        </div>
        <div class="seat-legend">
          <span class="legend-item"><span class="seat-item is-available"></span> 可选</span>
          <span class="legend-item"><span class="seat-item is-sold"></span> 已售</span>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { movieApi, scheduleApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const savingSchedule = ref(false)
const scheduleDialogVisible = ref(false)
const seatDialogVisible = ref(false)
const editingSchedule = ref(null)
const currentSchedule = ref(null)

const filterDate = ref(new Date().toISOString().split('T')[0])
const filterHall = ref(null)
const filterMovie = ref(null)

const schedules = ref([])
const movies = ref([])
const halls = ref([
  { id: 1, name: '1号厅' },
  { id: 2, name: '2号厅' },
  { id: 3, name: '3号厅' },
  { id: 4, name: '4号厅' }
])
const seatMap = ref([])

const defaultScheduleForm = () => ({
  movieId: null,
  hallId: null,
  showDate: new Date().toISOString().split('T')[0],
  startTime: '10:00',
  price: 60,
  vipPrice: 80
})

const scheduleForm = ref(defaultScheduleForm())

const getProgressColor = (percentage) => {
  if (percentage < 30) return '#67c23a'
  if (percentage < 70) return '#e6a23c'
  return '#f56c6c'
}

const fetchMovies = async () => {
  try {
    const res = await movieApi.getPage({ size: 100, status: 2 })
    if (res.code === 200) {
      movies.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取电影列表失败:', err)
  }
}

const fetchSchedules = async () => {
  loading.value = true
  try {
    const params = {
      showDate: filterDate.value,
      size: 50
    }
    if (filterHall.value) params.hallId = filterHall.value
    if (filterMovie.value) params.movieId = filterMovie.value

    const res = await scheduleApi.getPage(params)
    if (res.code === 200) {
      schedules.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取场次列表失败:', err)
    ElMessage.error('获取场次列表失败')
  } finally {
    loading.value = false
  }
}

function openCreateDialog() {
  editingSchedule.value = null
  scheduleForm.value = defaultScheduleForm()
  scheduleDialogVisible.value = true
}

function openEditDialog(schedule) {
  editingSchedule.value = schedule
  scheduleForm.value = {
    movieId: schedule.movieId,
    hallId: schedule.hallId,
    showDate: schedule.showDate,
    startTime: schedule.startTime,
    price: schedule.price,
    vipPrice: schedule.vipPrice
  }
  scheduleDialogVisible.value = true
}

async function saveSchedule() {
  if (!scheduleForm.value.movieId) {
    ElMessage.warning('请选择电影')
    return
  }
  if (!scheduleForm.value.hallId) {
    ElMessage.warning('请选择影厅')
    return
  }

  savingSchedule.value = true
  try {
    let res
    if (editingSchedule.value) {
      res = await scheduleApi.update(editingSchedule.value.id, scheduleForm.value)
    } else {
      res = await scheduleApi.create(scheduleForm.value)
    }

    if (res.code === 200) {
      ElMessage.success(editingSchedule.value ? '修改成功' : '新增成功')
      scheduleDialogVisible.value = false
      fetchSchedules()
    }
  } catch (err) {
    console.error('保存场次失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    savingSchedule.value = false
  }
}

function viewSeats(schedule) {
  currentSchedule.value = schedule
  // 生成座位图（模拟数据）
  const rows = 8
  const cols = 10
  seatMap.value = Array.from({ length: rows }, () =>
    Array.from({ length: cols }, () => Math.random() < 0.3 ? 1 : 0)
  )
  seatDialogVisible.value = true
}

function deleteSchedule(schedule) {
  ElMessageBox.confirm('确定删除该场次？', '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await scheduleApi.delete(schedule.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchSchedules()
      }
    } catch (err) {
      console.error('删除场次失败:', err)
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchMovies()
  fetchSchedules()
})
</script>

<style scoped>
.schedule-manage-page {
  padding-bottom: 40px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.filters {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

.seat-preview {
  padding: 20px;
}

.screen-label {
  text-align: center;
  background: #ddd;
  padding: 6px;
  border-radius: 4px;
  margin-bottom: 20px;
  font-size: 13px;
  color: #666;
}

.seat-grid {
  display: flex;
  flex-direction: column;
  gap: 6px;
  align-items: center;
  margin-bottom: 20px;
}

.seat-row {
  display: flex;
  gap: 6px;
  align-items: center;
}

.row-label {
  width: 20px;
  text-align: center;
  font-size: 12px;
  color: #999;
}

.seat-item {
  width: 28px;
  height: 24px;
  border-radius: 4px 4px 0 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 11px;
  cursor: pointer;
}

.seat-item.is-available {
  background: #67c23a;
}

.seat-item.is-sold {
  background: #ddd;
  color: #999;
}

.seat-legend {
  display: flex;
  gap: 16px;
  justify-content: center;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #666;
}
</style>

