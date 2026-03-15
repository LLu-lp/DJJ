<template>
  <div class="system-page">
    <div class="page-header">
      <h2>系统管理</h2>
    </div>

    <el-tabs v-model="activeTab">
      <!-- 公告管理 -->
      <el-tab-pane label="公告管理" name="announcements">
        <el-card>
          <div style="margin-bottom:16px;display:flex;justify-content:flex-end">
            <el-button type="primary" :icon="Plus" @click="openAnnouncementDialog()">发布公告</el-button>
          </div>
          <el-table :data="announcements" v-loading="loadingAnnouncements">
            <el-table-column prop="title" label="标题" min-width="200" />
            <el-table-column label="类型" width="100">
              <template #default="{ row }">
                <el-tag :type="row.type === 1 ? 'danger' : row.type === 2 ? 'warning' : 'info'" size="small">
                  {{ announcementTypeLabel(row.type) }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="置顶" width="80">
              <template #default="{ row }">
                <el-tag v-if="row.isTop === 1" type="danger" size="small">置顶</el-tag>
                <span v-else style="color:var(--color-text-muted)">否</span>
              </template>
            </el-table-column>
            <el-table-column label="状态" width="90">
              <template #default="{ row }">
                <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">{{ row.status === 1 ? '已发布' : '草稿' }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="viewCount" label="浏览" width="80" />
            <el-table-column label="发布时间" width="160">
              <template #default="{ row }">{{ formatDateTime(row.publishTime) }}</template>
            </el-table-column>
            <el-table-column label="操作" width="140" fixed="right">
              <template #default="{ row }">
                <el-button size="small" type="primary" text @click="openAnnouncementDialog(row)">编辑</el-button>
                <el-button size="small" type="danger" text @click="deleteAnnouncement(row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
            v-model:current-page="announcementPagination.page"
            :total="announcementPagination.total"
            :page-size="announcementPagination.size"
            layout="total, prev, pager, next"
            class="mt-16"
            @current-change="fetchAnnouncements"
          />
        </el-card>
      </el-tab-pane>

      <!-- 基础配置 -->
      <el-tab-pane label="基础配置" name="basic">
        <el-card>
          <el-form :model="configForm" label-width="140px" v-loading="loading">
            <el-form-item label="影院名称">
              <el-input v-model="configForm.cinemaName" style="width:360px" />
            </el-form-item>
            <el-form-item label="联系电话">
              <el-input v-model="configForm.contactPhone" style="width:360px" />
            </el-form-item>
            <el-form-item label="营业时间">
              <el-input v-model="configForm.businessHours" style="width:360px" placeholder="如: 09:00-23:00" />
            </el-form-item>
            <el-form-item label="地址">
              <el-input v-model="configForm.address" style="width:360px" />
            </el-form-item>
            <el-form-item label="订单超时时间">
              <el-input-number v-model="configForm.orderTimeout" :min="5" :max="60" style="width:180px" />
              <span style="margin-left:8px;color:var(--color-text-muted)">分钟</span>
            </el-form-item>
            <el-form-item label="最大选座数">
              <el-input-number v-model="configForm.maxSeatCount" :min="1" :max="10" style="width:180px" />
              <span style="margin-left:8px;color:var(--color-text-muted)">个</span>
            </el-form-item>
            <el-form-item label="积分规则">
              <el-input v-model="configForm.pointRule" type="textarea" :rows="3" style="width:360px" placeholder="每消费1元获得X积分" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" :loading="saving" @click="saveConfig">保存配置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-tab-pane>

      <!-- 操作日志 -->
      <el-tab-pane label="操作日志" name="logs">
        <el-card>
          <div style="margin-bottom:16px">
            <el-date-picker
              v-model="logDateRange"
              type="daterange"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              value-format="YYYY-MM-DD"
              @change="fetchLogs"
            />
          </div>
          <el-table :data="logs" v-loading="loadingLogs">
            <el-table-column label="时间" width="180">
              <template #default="{ row }">{{ formatDateTime(row.createdAt) }}</template>
            </el-table-column>
            <el-table-column prop="username" label="操作人" width="120" />
            <el-table-column prop="operation" label="操作" min-width="180" />
            <el-table-column prop="module" label="模块" width="100" />
            <el-table-column prop="method" label="请求方式" width="100" />
            <el-table-column prop="ip" label="IP地址" width="130" />
            <el-table-column label="结果" width="80">
              <template #default="{ row }">
                <el-tag :type="row.result === 1 ? 'success' : 'danger'" size="small">
                  {{ row.result === 1 ? '成功' : '失败' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="duration" label="耗时(ms)" width="100" />
          </el-table>
          <el-pagination
            v-model:current-page="logPagination.page"
            :total="logPagination.total"
            :page-size="logPagination.size"
            layout="total, prev, pager, next"
            class="mt-16"
            @current-change="fetchLogs"
          />
        </el-card>
      </el-tab-pane>
    </el-tabs>

    <!-- 公告编辑弹窗 -->
    <el-dialog
      v-model="announcementDialogVisible"
      :title="announcementForm.id ? '编辑公告' : '发布公告'"
      width="640px"
    >
      <el-form :model="announcementForm" label-width="80px">
        <el-form-item label="标题">
          <el-input v-model="announcementForm.title" placeholder="请输入公告标题" />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="announcementForm.type" style="width:200px">
            <el-option label="普通公告" :value="0" />
            <el-option label="活动公告" :value="1" />
            <el-option label="系统通知" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="置顶">
          <el-switch v-model="announcementForm.isTop" :active-value="1" :inactive-value="0" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="announcementForm.status">
            <el-radio :label="1">立即发布</el-radio>
            <el-radio :label="0">保存草稿</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="内容">
          <el-input
            v-model="announcementForm.content"
            type="textarea"
            :rows="8"
            placeholder="请输入公告内容"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="announcementDialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="savingAnnouncement" @click="saveAnnouncement">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { adminApi, announcementApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref, watch } from 'vue'

const activeTab = ref('announcements')
const loading = ref(false)
const saving = ref(false)
const loadingLogs = ref(false)
const loadingAnnouncements = ref(false)
const savingAnnouncement = ref(false)
const announcementDialogVisible = ref(false)

// 公告
const announcements = ref([])
const announcementPagination = reactive({ page: 1, size: 10, total: 0 })
const announcementForm = reactive({
  id: null, title: '', content: '', type: 0, isTop: 0, status: 1
})

// 日志
const getDefaultDateRange = () => {
  const end = new Date()
  const start = new Date()
  start.setDate(start.getDate() - 7)
  return [start.toISOString().split('T')[0], end.toISOString().split('T')[0]]
}
const logDateRange = ref(getDefaultDateRange())
const logs = ref([])
const logPagination = reactive({ page: 1, size: 20, total: 0 })

// 配置
const configForm = reactive({
  cinemaName: '', contactPhone: '', businessHours: '',
  address: '', orderTimeout: 15, maxSeatCount: 4, pointRule: ''
})

onMounted(() => {
  fetchAnnouncements()
  fetchConfig()
})

watch(activeTab, (newTab) => {
  if (newTab === 'logs' && logs.value.length === 0) fetchLogs()
})

// 公告相关
const fetchAnnouncements = async () => {
  loadingAnnouncements.value = true
  try {
    const res = await announcementApi.getPage({
      page: announcementPagination.page,
      size: announcementPagination.size
    })
    if (res.code === 200) {
      announcements.value = res.data?.records || []
      announcementPagination.total = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取公告失败:', err)
  } finally {
    loadingAnnouncements.value = false
  }
}

function announcementTypeLabel(type) {
  return { 0: '普通公告', 1: '活动公告', 2: '系统通知' }[type] || '公告'
}

function openAnnouncementDialog(row) {
  if (row) {
    Object.assign(announcementForm, {
      id: row.id, title: row.title, content: row.content,
      type: row.type, isTop: row.isTop, status: row.status
    })
  } else {
    Object.assign(announcementForm, { id: null, title: '', content: '', type: 0, isTop: 0, status: 1 })
  }
  announcementDialogVisible.value = true
}

async function saveAnnouncement() {
  if (!announcementForm.title.trim()) return ElMessage.warning('请输入公告标题')
  if (!announcementForm.content.trim()) return ElMessage.warning('请输入公告内容')
  savingAnnouncement.value = true
  try {
    const data = {
      title: announcementForm.title,
      content: announcementForm.content,
      type: announcementForm.type,
      isTop: announcementForm.isTop,
      status: announcementForm.status
    }
    let res
    if (announcementForm.id) {
      res = await announcementApi.update(announcementForm.id, data)
    } else {
      res = await announcementApi.create(data)
    }
    if (res.code === 200) {
      ElMessage.success(announcementForm.id ? '公告已更新' : '公告已发布')
      announcementDialogVisible.value = false
      fetchAnnouncements()
    }
  } catch (err) {
    ElMessage.error(err.response?.data?.message || '操作失败')
  } finally {
    savingAnnouncement.value = false
  }
}

async function deleteAnnouncement(row) {
  await ElMessageBox.confirm(`确定删除公告「${row.title}」？`, '删除公告', { type: 'warning' })
  try {
    const res = await announcementApi.delete(row.id)
    if (res.code === 200) {
      ElMessage.success('公告已删除')
      fetchAnnouncements()
    }
  } catch (err) {
    ElMessage.error('删除失败')
  }
}

// 配置相关
const fetchConfig = async () => {
  loading.value = true
  try {
    const res = await adminApi.getConfig()
    if (res.code === 200 && res.data) {
      Object.keys(configForm).forEach(key => {
        if (res.data[key] !== undefined) {
          configForm[key] = (key === 'orderTimeout' || key === 'maxSeatCount')
            ? (parseInt(res.data[key]) || 0)
            : res.data[key]
        }
      })
    }
  } catch (err) {
    console.error('获取系统配置失败:', err)
  } finally {
    loading.value = false
  }
}

async function saveConfig() {
  saving.value = true
  try {
    const configData = {}
    Object.keys(configForm).forEach(key => { configData[key] = String(configForm[key]) })
    const res = await adminApi.updateConfig(configData)
    if (res.code === 200) ElMessage.success('配置保存成功')
  } catch (err) {
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

// 日志相关
const fetchLogs = async () => {
  loadingLogs.value = true
  try {
    const res = await adminApi.getSystemLogs({
      startDate: logDateRange.value?.[0],
      endDate: logDateRange.value?.[1],
      page: logPagination.page,
      size: logPagination.size
    })
    if (res.code === 200) {
      logs.value = res.data?.records || []
      logPagination.total = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取操作日志失败:', err)
  } finally {
    loadingLogs.value = false
  }
}

const formatDateTime = (dt) => {
  if (!dt) return '--'
  return typeof dt === 'string' ? dt.replace('T', ' ').slice(0, 19) : dt
}
</script>

<style scoped>
.system-page { padding-bottom: 40px; }
.page-header { margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.mt-16 { margin-top: 16px; }
</style>
