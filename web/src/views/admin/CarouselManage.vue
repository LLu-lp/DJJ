<template>
  <div class="carousel-manage-page">
    <div class="page-header">
      <h2 class="page-title">轮播图管理</h2>
      <el-button type="primary" @click="openDialog()">
        <el-icon><Plus /></el-icon> 新增轮播图
      </el-button>
    </div>

    <div class="carousel-preview">
      <h3>轮播图预览</h3>
      <el-carousel height="300px" :interval="4000" arrow="always">
        <el-carousel-item v-for="item in items.filter(i => i.status === 1)" :key="item.id">
          <img :src="item.imageUrl" :alt="item.title" style="width: 100%; height: 100%; object-fit: cover" />
          <div class="carousel-text">
            <h4>{{ item.title }}</h4>
            <p>{{ item.description }}</p>
          </div>
        </el-carousel-item>
      </el-carousel>
    </div>

    <el-table :data="items" v-loading="loading" style="width: 100%; margin-top: 24px">
      <el-table-column label="排序" width="80" align="center">
        <template #default="{ row }">
          <span style="font-weight: 600">{{ row.sort }}</span>
        </template>
      </el-table-column>
      <el-table-column label="标题" min-width="150" prop="title" />
      <el-table-column label="描述" min-width="200" prop="description" />
      <el-table-column label="图片" width="120">
        <template #default="{ row }">
          <el-image
            :src="row.imageUrl"
            :preview-src-list="[row.imageUrl]"
            style="width: 100px; height: 60px"
            fit="cover"
          />
        </template>
      </el-table-column>
      <el-table-column label="链接" min-width="150">
        <template #default="{ row }">
          <el-link type="primary" :href="row.linkUrl" target="_blank" v-if="row.linkUrl">
            {{ row.linkUrl }}
          </el-link>
          <span v-else style="color: var(--color-text-muted)">无</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'danger'">
            {{ row.status === 1 ? '启用' : '禁用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
          <el-button size="small" type="warning" text @click="moveUp(row)" v-if="row.sort > 1">上移</el-button>
          <el-button size="small" type="warning" text @click="moveDown(row)" v-if="row.sort < items.length">下移</el-button>
          <el-button size="small" type="danger" text @click="deleteItem(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="editingItem ? '编辑轮播图' : '新增轮播图'" width="600px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="标题" required>
          <el-input v-model="form.title" placeholder="轮播图标题" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="2" placeholder="轮播图描述" />
        </el-form-item>
        <el-form-item label="图片" required>
          <el-input v-model="form.imageUrl" placeholder="请输入图片URL，如 https://picsum.photos/seed/xxx/1920/300" />
          <div v-if="form.imageUrl" style="margin-top:8px">
            <el-image :src="form.imageUrl" style="width:200px;height:60px" fit="cover" />
          </div>
          <p style="font-size:12px;color:var(--color-text-muted);margin-top:4px">建议尺寸：1920x300px</p>
        </el-form-item>
        <el-form-item label="链接">
          <el-input v-model="form.linkUrl" placeholder="点击轮播图跳转的链接（可选）" />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" :min="1" style="width: 100%" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="saveItem">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { carouselApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const dialogVisible = ref(false)
const editingItem = ref(null)
const items = ref([])

const defaultForm = () => ({
  title: '',
  description: '',
  imageUrl: '',
  linkUrl: '',
  sort: 1,
  status: 1
})

const form = ref(defaultForm())

const fetchItems = async () => {
  loading.value = true
  try {
    const res = await carouselApi.getList()
    if (res.code === 200) {
      items.value = res.data || []
    }
  } catch (err) {
    console.error('获取轮播图失败:', err)
    ElMessage.error('获取轮播图失败')
  } finally {
    loading.value = false
  }
}

function handleImageChange(file) {
  if (file.raw) {
    const reader = new FileReader()
    reader.onload = (e) => {
      form.value.imageUrl = e.target.result
    }
    reader.readAsDataURL(file.raw)
  }
}

function openDialog(item = null) {
  editingItem.value = item
  if (item) {
    form.value = { ...item }
  } else {
    form.value = defaultForm()
  }
  dialogVisible.value = true
}

async function saveItem() {
  if (!form.value.title.trim()) {
    ElMessage.warning('请输入标题')
    return
  }
  if (!form.value.imageUrl) {
    ElMessage.warning('请输入图片URL')
    return
  }

  saving.value = true
  try {
    let res
    if (editingItem.value) {
      res = await carouselApi.update(editingItem.value.id, form.value)
    } else {
      res = await carouselApi.create(form.value)
    }
    if (res.code === 200) {
      ElMessage.success(editingItem.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchItems()
    }
  } catch (err) {
    console.error('保存轮播图失败:', err)
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}

async function moveUp(row) {
  const idx = items.value.findIndex(i => i.id === row.id)
  if (idx > 0) {
    const prev = items.value[idx - 1]
    const newSort = prev.sort
    const oldSort = row.sort
    await carouselApi.update(row.id, { ...row, sort: newSort })
    await carouselApi.update(prev.id, { ...prev, sort: oldSort })
    fetchItems()
    ElMessage.success('已上移')
  }
}

async function moveDown(row) {
  const idx = items.value.findIndex(i => i.id === row.id)
  if (idx < items.value.length - 1) {
    const next = items.value[idx + 1]
    const newSort = next.sort
    const oldSort = row.sort
    await carouselApi.update(row.id, { ...row, sort: newSort })
    await carouselApi.update(next.id, { ...next, sort: oldSort })
    fetchItems()
    ElMessage.success('已下移')
  }
}

function deleteItem(item) {
  ElMessageBox.confirm(`确定删除轮播图「${item.title}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await carouselApi.delete(item.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchItems()
      }
    } catch (err) {
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchItems()
})
</script>

<style scoped>
.carousel-manage-page {
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

.carousel-preview {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 16px;
  margin-bottom: 24px;
}

.carousel-preview h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 12px;
}

.carousel-text {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
  color: white;
  padding: 20px;
}

.carousel-text h4 {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 4px;
}

.carousel-text p {
  font-size: 14px;
  margin: 0;
  opacity: 0.9;
}
</style>

