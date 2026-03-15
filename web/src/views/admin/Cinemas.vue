<template>
  <div class="admin-cinemas">
    <div class="page-header">
      <h2 class="page-title">影院管理</h2>
      <el-button type="primary" @click="openDialog()">
        <el-icon><Plus /></el-icon> 新增影院
      </el-button>
    </div>

    <el-table :data="cinemas" v-loading="loading">
      <el-table-column label="影院名称" prop="name" min-width="180" />
      <el-table-column label="城市" prop="city" width="100" />
      <el-table-column label="地址" prop="address" min-width="220" />
      <el-table-column label="联系电话" prop="phone" width="150" />
      <el-table-column label="营业时间" prop="businessHours" width="120" />
      <el-table-column label="设施" min-width="160">
        <template #default="{ row }">
          <el-tag v-for="f in row.facilities?.split(',')" :key="f" size="small" type="success" style="margin-right:4px">{{ f }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="80">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">{{ row.status === 1 ? '营业中' : '已关闭' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button link size="small" type="primary" @click="openDialog(row)">编辑</el-button>
          <el-button link size="small" @click="manageHalls(row)">放映厅</el-button>
          <el-button link size="small" type="danger" @click="deleteCinema(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑影院弹窗 -->
    <el-dialog v-model="dialogVisible" :title="editingCinema ? '编辑影院' : '新增影院'" width="520px">
      <el-form :model="cinemaForm" label-width="90px">
        <el-form-item label="影院名称" required><el-input v-model="cinemaForm.name" /></el-form-item>
        <el-form-item label="城市"><el-input v-model="cinemaForm.city" /></el-form-item>
        <el-form-item label="地址"><el-input v-model="cinemaForm.address" /></el-form-item>
        <el-form-item label="联系电话"><el-input v-model="cinemaForm.phone" /></el-form-item>
        <el-form-item label="营业时间"><el-input v-model="cinemaForm.businessHours" placeholder="如: 09:00-23:00" /></el-form-item>
        <el-form-item label="设施">
          <el-input v-model="cinemaForm.facilities" placeholder="多个设施用逗号分隔" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="cinemaForm.status">
            <el-radio :value="1">营业中</el-radio>
            <el-radio :value="0">已关闭</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="saveCinema">确认保存</el-button>
      </template>
    </el-dialog>

    <!-- 放映厅管理弹窗 -->
    <el-dialog v-model="hallsDialogVisible" :title="`${currentCinema?.name} - 放映厅管理`" width="700px">
      <div style="margin-bottom:12px">
        <el-button type="primary" size="small" @click="addHall">
          <el-icon><Plus /></el-icon> 添加放映厅
        </el-button>
      </div>
      <el-table :data="currentHalls" v-loading="loadingHalls">
        <el-table-column label="厅名" prop="name" width="120" />
        <el-table-column label="类型" prop="type" width="100">
          <template #default="{ row }">
            <el-tag size="small" type="info">{{ row.type }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="排数" prop="rows" width="80" />
        <el-table-column label="列数" prop="cols" width="80" />
        <el-table-column label="总座位数" prop="totalSeats" width="100" align="center" />
        <el-table-column label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">{{ row.status === 1 ? '正常' : '关闭' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="140">
          <template #default="{ row }">
            <el-button link size="small" type="primary" @click="editHall(row)">编辑</el-button>
            <el-button link size="small" type="danger" @click="deleteHall(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>

    <!-- 添加/编辑放映厅对话框 -->
    <el-dialog v-model="hallDialogVisible" :title="editingHall ? '编辑放映厅' : '添加放映厅'" width="450px">
      <el-form :model="hallForm" label-width="90px">
        <el-form-item label="厅名" required><el-input v-model="hallForm.name" /></el-form-item>
        <el-form-item label="类型">
          <el-select v-model="hallForm.type" style="width:100%">
            <el-option label="普通" value="普通" />
            <el-option label="IMAX" value="IMAX" />
            <el-option label="4DX" value="4DX" />
            <el-option label="杜比" value="杜比" />
            <el-option label="VIP" value="VIP" />
          </el-select>
        </el-form-item>
        <el-form-item label="排数"><el-input-number v-model="hallForm.rows" :min="1" :max="30" style="width:100%" /></el-form-item>
        <el-form-item label="列数"><el-input-number v-model="hallForm.cols" :min="1" :max="30" style="width:100%" /></el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="hallForm.status">
            <el-radio :value="1">正常</el-radio>
            <el-radio :value="0">关闭</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="hallDialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="savingHall" @click="saveHall">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { cinemaApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const loadingHalls = ref(false)
const savingHall = ref(false)
const cinemas = ref([])
const dialogVisible = ref(false)
const hallsDialogVisible = ref(false)
const hallDialogVisible = ref(false)
const editingCinema = ref(null)
const currentCinema = ref(null)
const editingHall = ref(null)
const currentHalls = ref([])

const defaultForm = () => ({ name: '', city: '', address: '', phone: '', businessHours: '', facilities: '', status: 1 })
const cinemaForm = ref(defaultForm())

const hallForm = ref({ name: '', type: '普通', rows: 10, cols: 12, status: 1 })

onMounted(() => {
  fetchCinemas()
})

const fetchCinemas = async () => {
  loading.value = true
  try {
    const res = await cinemaApi.getPage({ size: 100 })
    if (res.code === 200) {
      cinemas.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取影院列表失败:', err)
  } finally {
    loading.value = false
  }
}

function openDialog(cinema = null) {
  editingCinema.value = cinema
  cinemaForm.value = cinema ? { ...cinema } : defaultForm()
  dialogVisible.value = true
}

async function saveCinema() {
  if (!cinemaForm.value.name) return ElMessage.warning('请输入影院名称')
  saving.value = true
  try {
    if (editingCinema.value) {
      const res = await cinemaApi.update(editingCinema.value.id, cinemaForm.value)
      if (res.code === 200) {
        ElMessage.success('修改成功')
        dialogVisible.value = false
        fetchCinemas()
      }
    } else {
      const res = await cinemaApi.create(cinemaForm.value)
      if (res.code === 200) {
        ElMessage.success('新增成功')
        dialogVisible.value = false
        fetchCinemas()
      }
    }
  } catch (err) {
    console.error('保存影院失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

function deleteCinema(cinema) {
  ElMessageBox.confirm(`确认删除影院「${cinema.name}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await cinemaApi.delete(cinema.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchCinemas()
      }
    } catch (err) {
      console.error('删除影院失败:', err)
      ElMessage.error(err.response?.data?.message || '删除失败')
    }
  }).catch(() => {})
}

async function manageHalls(cinema) {
  currentCinema.value = cinema
  await fetchHalls(cinema.id)
  hallsDialogVisible.value = true
}

const fetchHalls = async (cinemaId) => {
  loadingHalls.value = true
  try {
    const res = await cinemaApi.getHalls(cinemaId)
    if (res.code === 200) {
      currentHalls.value = res.data || []
    }
  } catch (err) {
    console.error('获取放映厅列表失败:', err)
  } finally {
    loadingHalls.value = false
  }
}

function addHall() {
  editingHall.value = null
  hallForm.value = { name: '', type: '普通', rows: 10, cols: 12, status: 1 }
  hallDialogVisible.value = true
}

function editHall(hall) {
  editingHall.value = hall
  hallForm.value = { ...hall }
  hallDialogVisible.value = true
}

async function saveHall() {
  if (!hallForm.value.name) return ElMessage.warning('请输入厅名')
  savingHall.value = true
  try {
    const data = { ...hallForm.value, totalSeats: hallForm.value.rows * hallForm.value.cols, cinemaId: currentCinema.value.id }
    if (editingHall.value) {
      const res = await cinemaApi.updateHall(editingHall.value.id, data)
      if (res.code === 200) {
        ElMessage.success('修改成功')
        hallDialogVisible.value = false
        fetchHalls(currentCinema.value.id)
      }
    } else {
      const res = await cinemaApi.createHall(data)
      if (res.code === 200) {
        ElMessage.success('添加成功')
        hallDialogVisible.value = false
        fetchHalls(currentCinema.value.id)
      }
    }
  } catch (err) {
    console.error('保存放映厅失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    savingHall.value = false
  }
}

function deleteHall(hall) {
  ElMessageBox.confirm(`删除放映厅「${hall.name}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await cinemaApi.deleteHall(hall.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchHalls(currentCinema.value.id)
      }
    } catch (err) {
      console.error('删除放映厅失败:', err)
      ElMessage.error(err.response?.data?.message || '删除失败')
    }
  }).catch(() => {})
}
</script>

<style scoped>
.admin-cinemas { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-title { font-size: 18px; font-weight: 700; color: var(--color-text); }
</style>
