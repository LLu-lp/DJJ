<template>
  <div class="page-container">
    <div class="page-header">
      <h2>公告管理</h2>
      <el-button type="danger" :icon="Plus" @click="openDialog()">发布公告</el-button>
    </div>

    <el-row :gutter="20">
      <el-col v-for="item in announcements" :key="item.id" :span="12" style="margin-bottom:16px">
        <el-card class="announcement-card" :class="{ 'is-pinned': item.isTop }">
          <div class="ann-header">
            <div class="ann-title">
              <el-icon v-if="item.isTop" color="#e50914"><Top /></el-icon>
              <span>{{ item.title }}</span>
              <el-tag :type="typeTag(item.type)" size="small">{{ typeLabel(item.type) }}</el-tag>
            </div>
            <div class="ann-actions">
              <el-button size="small" type="primary" text @click="openDialog(item)">编辑</el-button>
              <el-button size="small" type="danger" text @click="handleDelete(item.id)">删除</el-button>
            </div>
          </div>
          <p class="ann-content">{{ item.content }}</p>
          <div class="ann-footer">
            <span>{{ item.createdAt }}</span>
            <span>发布人：{{ item.author || '管理员' }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-empty v-if="announcements.length === 0 && !loading" description="暂无公告" />

    <el-dialog v-model="dialogVisible" :title="editingId ? '编辑公告' : '发布公告'" width="560px">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="公告标题" prop="title">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="公告类型" prop="type">
          <el-select v-model="form.type" style="width:100%">
            <el-option v-for="opt in typeOptions" :key="opt.value" :label="opt.label" :value="opt.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="公告内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="4" />
        </el-form-item>
        <el-form-item label="置顶">
          <el-switch v-model="form.pinned" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="danger" :loading="saving" @click="handleSubmit">发布</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { announcementApi } from '@/api'
import { Plus, Top } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const formRef = ref()
const announcements = ref([])

const form = reactive({ title: '', type: 0, content: '', pinned: 0 })

const rules = {
  title: [{ required: true, message: '请输入标题' }],
  type: [{ required: true, message: '请选择类型' }],
  content: [{ required: true, message: '请输入内容' }]
}

const typeOptions = [
  { label: '通知', value: 0 },
  { label: '活动', value: 1 },
  { label: '系统', value: 2 }
]

const typeLabel = (t) => typeOptions.find(o => o.value === t)?.label || '通知'
const typeTag = (t) => ({ 0: 'info', 1: 'danger', 2: '' }[t] || 'info')

onMounted(() => {
  fetchAnnouncements()
})

const fetchAnnouncements = async () => {
  loading.value = true
  try {
    const res = await announcementApi.getList({ size: 50 })
    if (res.code === 200) {
      announcements.value = res.data?.records || res.data || []
    }
  } catch (err) {
    console.error('获取公告列表失败:', err)
  } finally {
    loading.value = false
  }
}

const openDialog = (item = null) => {
  editingId.value = item?.id || null
  if (item) {
    Object.assign(form, { 
      title: item.title, 
      type: item.type, 
      content: item.content, 
      pinned: item.isTop || 0 
    })
  } else {
    Object.assign(form, { title: '', type: 0, content: '', pinned: 0 })
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  
  saving.value = true
  try {
    const payload = {
      title: form.title,
      type: form.type,
      content: form.content,
      isTop: form.pinned,
      status: 1
    }
    
    let res
    if (editingId.value) {
      res = await announcementApi.update(editingId.value, payload)
    } else {
      res = await announcementApi.create(payload)
    }
    if (res.code === 200) {
      ElMessage.success(editingId.value ? '修改成功' : '发布成功')
      dialogVisible.value = false
      fetchAnnouncements()
    }
  } catch (err) {
    console.error('保存公告失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

const handleDelete = (id) => {
  ElMessageBox.confirm('确定删除该公告？', '提示', { type: 'warning' }).then(async () => {
    try {
      const res = await announcementApi.delete(id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchAnnouncements()
      }
    } catch (err) {
      console.error('删除公告失败:', err)
      ElMessage.error(err.response?.data?.message || '删除失败')
    }
  }).catch(() => {})
}
</script>

<style scoped>
.page-container { padding: 20px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.announcement-card { border-left: 3px solid transparent; }
.announcement-card.is-pinned { border-left-color: #e50914; }
.ann-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.ann-title { display: flex; align-items: center; gap: 8px; font-size: 15px; font-weight: 600; }
.ann-content { color: #666; font-size: 13px; line-height: 1.6; margin: 8px 0; }
.ann-footer { display: flex; justify-content: space-between; font-size: 12px; color: #999; }
</style>
