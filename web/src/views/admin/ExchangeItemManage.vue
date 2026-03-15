<template>
  <div class="exchange-manage-page">
    <div class="page-header">
      <h2 class="page-title">积分兑换项管理</h2>
      <el-button type="primary" @click="openDialog()">
        <el-icon><Plus /></el-icon> 新增兑换项
      </el-button>
    </div>

    <el-table :data="items" v-loading="loading" style="width: 100%">
      <el-table-column label="兑换项名称" min-width="180" prop="name" />
      <el-table-column label="描述" min-width="200" prop="description" />
      <el-table-column label="所需积分" width="120" align="center">
        <template #default="{ row }">
          <span style="color: var(--color-primary); font-weight: 600">{{ row.points }}</span>
        </template>
      </el-table-column>
      <el-table-column label="库存" width="100" align="center">
        <template #default="{ row }">
          <el-tag :type="row.stock > 10 ? 'success' : row.stock > 0 ? 'warning' : 'danger'">
            {{ row.stock }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="已兑换" width="100" align="center" prop="exchangedCount" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'danger'">
            {{ row.status === 1 ? '启用' : '禁用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="160" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
          <el-button size="small" type="danger" text @click="deleteItem(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="editingItem ? '编辑兑换项' : '新增兑换项'" width="520px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="项目名称" required>
          <el-input v-model="form.name" placeholder="如：爆米花券" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="2" placeholder="项目描述" />
        </el-form-item>
        <el-form-item label="所需积分" required>
          <el-input-number v-model="form.points" :min="1" :step="10" style="width: 100%" />
        </el-form-item>
        <el-form-item label="库存" required>
          <el-input-number v-model="form.stock" :min="0" :step="10" style="width: 100%" />
        </el-form-item>
        <el-form-item label="图标/表情">
          <el-input v-model="form.icon" placeholder="如：🍿" maxlength="2" />
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
import { adminApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const dialogVisible = ref(false)
const editingItem = ref(null)
const items = ref([])

const defaultForm = () => ({
  name: '',
  description: '',
  points: 100,
  stock: 100,
  icon: '🎁',
  sort: 1,
  status: 1
})

const form = ref(defaultForm())

const fetchItems = async () => {
  loading.value = true
  try {
    const res = await adminApi.getExchangeItems({ size: 100 })
    if (res.code === 200) {
      items.value = res.data?.records || res.data || []
    }
  } catch (err) {
    console.error('获取兑换项失败:', err)
    ElMessage.error('获取兑换项失败')
  } finally {
    loading.value = false
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
  if (!form.value.name.trim()) {
    ElMessage.warning('请输入项目名称')
    return
  }

  saving.value = true
  try {
    let res
    if (editingItem.value) {
      res = await adminApi.updateExchangeItem(editingItem.value.id, form.value)
    } else {
      res = await adminApi.addExchangeItem(form.value)
    }

    if (res.code === 200) {
      ElMessage.success(editingItem.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchItems()
    }
  } catch (err) {
    console.error('保存兑换项失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

function deleteItem(item) {
  ElMessageBox.confirm(`确定删除兑换项「${item.name}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await adminApi.deleteExchangeItem(item.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchItems()
      }
    } catch (err) {
      console.error('删除兑换项失败:', err)
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchItems()
})
</script>

<style scoped>
.exchange-manage-page {
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
</style>

