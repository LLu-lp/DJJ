<template>
  <div class="page-container">
    <div class="page-header">
      <h2>排片管理</h2>
      <el-button type="primary" :icon="Plus" @click="openDialog()">新增排片</el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-row :gutter="16" align="middle">
        <el-col :span="6">
          <el-select v-model="query.cinemaId" placeholder="选择影院" clearable style="width:100%" @change="fetchHalls">
            <el-option v-for="c in cinemas" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-select v-model="query.movieId" placeholder="选择电影" clearable style="width:100%">
            <el-option v-for="m in movies" :key="m.id" :label="m.title" :value="m.id" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-date-picker v-model="query.date" type="date" placeholder="选择日期" style="width:100%" value-format="YYYY-MM-DD" />
        </el-col>
        <el-col :span="6">
          <el-button type="primary" :icon="Search" @click="fetchSchedules">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 表格 -->
    <el-card>
      <el-table :data="schedules" v-loading="loading">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="movieTitle" label="电影" min-width="120" />
        <el-table-column prop="cinemaName" label="影院" min-width="120" />
        <el-table-column prop="hallName" label="影厅" width="100" />
        <el-table-column prop="showDate" label="日期" width="110" />
        <el-table-column prop="startTime" label="开始时间" width="100" />
        <el-table-column prop="endTime" label="结束时间" width="100" />
        <el-table-column prop="price" label="票价(元)" width="90">
          <template #default="{ row }">
            <span class="price-text">¥{{ row.price }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="soldSeats" label="已售/总座位" width="110">
          <template #default="{ row }">{{ row.soldSeats || 0 }}/{{ row.totalSeats || 0 }}</template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
              {{ row.status === 1 ? '售票中' : '已结束' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="140" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
            <el-button size="small" type="danger" text @click="handleDelete(row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.size"
        :total="pagination.total"
        layout="total, prev, pager, next"
        class="mt-16"
        @current-change="fetchSchedules"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="editingId ? '编辑排片' : '新增排片'" width="560px">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="电影" prop="movieId">
          <el-select v-model="form.movieId" placeholder="选择电影" style="width:100%">
            <el-option v-for="m in movies" :key="m.id" :label="m.title" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="影院" prop="cinemaId">
          <el-select v-model="form.cinemaId" placeholder="选择影院" style="width:100%" @change="fetchHalls">
            <el-option v-for="c in cinemas" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="影厅" prop="hallId">
          <el-select v-model="form.hallId" placeholder="选择影厅" style="width:100%">
            <el-option v-for="h in halls" :key="h.id" :label="h.name" :value="h.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="放映日期" prop="showDate">
          <el-date-picker v-model="form.showDate" type="date" value-format="YYYY-MM-DD" style="width:100%" />
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <el-time-picker v-model="form.startTime" format="HH:mm" value-format="HH:mm:ss" style="width:100%" />
        </el-form-item>
        <el-form-item label="票价" prop="price">
          <el-input-number v-model="form.price" :min="10" :max="300" :step="5" style="width:100%" />
        </el-form-item>
        <el-form-item label="VIP票价">
          <el-input-number v-model="form.vipPrice" :min="10" :max="500" :step="5" style="width:100%" />
        </el-form-item>
        <el-form-item label="语言版本" prop="language">
          <el-select v-model="form.language" style="width:100%">
            <el-option label="国语" value="国语" />
            <el-option label="粤语" value="粤语" />
            <el-option label="原声" value="原声" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { cinemaApi, movieApi, scheduleApi } from '@/api'
import { Plus, Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const query = reactive({ cinemaId: '', movieId: '', date: '' })
const pagination = reactive({ page: 1, size: 10, total: 0 })
const dialogVisible = ref(false)
const editingId = ref(null)
const formRef = ref()

const movies = ref([])
const cinemas = ref([])
const halls = ref([])
const schedules = ref([])

const form = reactive({ movieId: '', cinemaId: '', hallId: '', showDate: '', startTime: '', price: 50, vipPrice: 80, language: '国语' })

const rules = {
  movieId: [{ required: true, message: '请选择电影' }],
  cinemaId: [{ required: true, message: '请选择影院' }],
  hallId: [{ required: true, message: '请选择影厅' }],
  showDate: [{ required: true, message: '请选择日期' }],
  startTime: [{ required: true, message: '请选择时间' }],
  price: [{ required: true, message: '请设置票价' }]
}

onMounted(async () => {
  await Promise.all([fetchMovies(), fetchCinemas()])
  await fetchSchedules()
})

const fetchMovies = async () => {
  try {
    const res = await movieApi.getPage({ size: 100 })
    if (res.code === 200) {
      movies.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取电影列表失败:', err)
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

const fetchHalls = async () => {
  if (!form.cinemaId && !query.cinemaId) return
  try {
    const cinemaId = form.cinemaId || query.cinemaId
    const res = await cinemaApi.getHalls(cinemaId)
    if (res.code === 200) {
      halls.value = res.data || []
    }
  } catch (err) {
    console.error('获取影厅列表失败:', err)
  }
}

const fetchSchedules = async () => {
  loading.value = true
  try {
    const res = await scheduleApi.getPage({
      cinemaId: query.cinemaId || undefined,
      movieId: query.movieId || undefined,
      showDate: query.date || undefined,
      page: pagination.page,
      size: pagination.size
    })
    if (res.code === 200) {
      schedules.value = res.data?.records || []
      pagination.total = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取排片列表失败:', err)
  } finally {
    loading.value = false
  }
}

const resetQuery = () => {
  Object.assign(query, { cinemaId: '', movieId: '', date: '' })
  pagination.page = 1
  fetchSchedules()
}

const openDialog = async (row = null) => {
  editingId.value = row?.id || null
  if (row) {
    form.movieId = row.movieId
    form.cinemaId = row.cinemaId
    form.hallId = row.hallId
    form.showDate = row.showDate
    form.startTime = row.startTime
    form.price = row.price
    form.vipPrice = row.vipPrice || 80
    form.language = row.language || '国语'
    await fetchHalls()
  } else {
    Object.assign(form, { movieId: '', cinemaId: '', hallId: '', showDate: '', startTime: '', price: 50, vipPrice: 80, language: '国语' })
    halls.value = []
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  
  saving.value = true
  try {
    const data = { ...form }
    if (editingId.value) {
      const res = await scheduleApi.update(editingId.value, data)
      if (res.code === 200) {
        ElMessage.success('修改成功')
        dialogVisible.value = false
        fetchSchedules()
      }
    } else {
      const res = await scheduleApi.create(data)
      if (res.code === 200) {
        ElMessage.success('新增成功')
        dialogVisible.value = false
        fetchSchedules()
      }
    }
  } catch (err) {
    console.error('保存排片失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

const handleDelete = (id) => {
  ElMessageBox.confirm('确定删除该场次？', '提示', { type: 'warning' }).then(async () => {
    try {
      const res = await scheduleApi.delete(id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchSchedules()
      }
    } catch (err) {
      console.error('删除排片失败:', err)
      ElMessage.error(err.response?.data?.message || '删除失败')
    }
  }).catch(() => {})
}
</script>

<style scoped>
.mt-16 { margin-top: 16px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.price-text { color: #e50914; font-weight: 600; }
</style>
