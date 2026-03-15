<template>
  <div class="page-container">
    <div class="page-header">
      <h2>商品管理</h2>
      <el-button type="primary" @click="openDialog()">
        <el-icon><Plus /></el-icon> 新增商品
      </el-button>
    </div>

    <el-card>
      <el-table :data="snacks" v-loading="loading">
      <el-table-column label="商品" min-width="250">
        <template #default="{ row }">
          <div style="display:flex;align-items:center;gap:12px">
            <img :src="row.image || `/placeholder.svg`" :alt="row.name" style="width:60px;height:60px;object-fit:cover;border-radius:8px;border:1px solid var(--color-border)" />
            <div>
              <div style="font-weight:600;font-size:14px;margin-bottom:4px">{{ row.name }}</div>
              <div style="font-size:12px;color:var(--color-text-muted)">{{ categoryLabel(row.category) }}</div>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="price" label="价格" width="120">
        <template #default="{ row }">
          <span style="color:#e8b84b;font-weight:600;font-size:15px">¥{{ row.price }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="stock" label="库存" width="100" />
      <el-table-column prop="sales" label="销量" width="100" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">
            {{ row.status === 1 ? '上架' : '下架' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
          <el-button size="small" type="success" text @click="updateStock(row)">入库</el-button>
          <el-button size="small" type="danger" text @click="deleteSnack(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    </el-card>

    <el-dialog v-model="dialogVisible" :title="editingId ? '编辑商品' : '新增商品'" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="商品名称" required>
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="form.category" style="width:100%">
            <el-option label="爆米花" value="popcorn" />
            <el-option label="饮料" value="drink" />
            <el-option label="套餐" value="combo" />
            <el-option label="零食" value="snack" />
          </el-select>
        </el-form-item>
        <el-form-item label="价格">
          <el-input-number v-model="form.price" :min="0" :precision="2" style="width:100%" />
        </el-form-item>
        <el-form-item label="库存">
          <el-input-number v-model="form.stock" :min="0" style="width:100%" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="2" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="form.status" :active-value="1" :inactive-value="0" active-text="上架" inactive-text="下架" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveSnack" :loading="saving">保存</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="stockDialogVisible" title="商品入库" width="400px">
      <el-form label-width="80px">
        <el-form-item label="商品名称">
          <el-input :value="stockItem?.name" disabled />
        </el-form-item>
        <el-form-item label="当前库存">
          <el-input :value="stockItem?.stock" disabled />
        </el-form-item>
        <el-form-item label="入库数量">
          <el-input-number v-model="stockAmount" :min="1" style="width:100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="stockDialogVisible = false">取消</el-button>
        <el-button type="success" @click="confirmStock">确认入库</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { snackApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const snacks = ref([])
const dialogVisible = ref(false)
const stockDialogVisible = ref(false)
const editingId = ref(null)
const stockItem = ref(null)
const stockAmount = ref(50)

const defaultForm = () => ({
  name: '', category: 'popcorn', price: 0, stock: 0, description: '', status: 1
})
const form = ref(defaultForm())

const categoryLabel = (c) => ({ popcorn: '爆米花', drink: '饮料', combo: '套餐', snack: '零食' }[c] || c)

const fetchSnacks = async () => {
  loading.value = true
  try {
    const res = await snackApi.getList({ size: 100 })
    if (res.code === 200) {
      snacks.value = res.data?.records || res.data || []
    }
  } catch (err) {
    console.error('获取商品列表失败:', err)
  } finally {
    loading.value = false
  }
}

const openDialog = (item = null) => {
  editingId.value = item?.id || null
  form.value = item ? { ...item } : defaultForm()
  dialogVisible.value = true
}

const saveSnack = async () => {
  if (!form.value.name) return ElMessage.warning('请输入商品名称')
  saving.value = true
  try {
    let res
    if (editingId.value) {
      res = await snackApi.update(editingId.value, form.value)
    } else {
      res = await snackApi.create(form.value)
    }
    if (res.code === 200) {
      ElMessage.success(editingId.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchSnacks()
    }
  } catch (err) {
    console.error('保存商品失败:', err)
  } finally {
    saving.value = false
  }
}

const updateStock = (item) => {
  stockItem.value = item
  stockAmount.value = 50
  stockDialogVisible.value = true
}

const confirmStock = async () => {
  try {
    const res = await snackApi.update(stockItem.value.id, { 
      ...stockItem.value,
      stock: (stockItem.value.stock || 0) + stockAmount.value 
    })
    if (res.code === 200) {
      ElMessage.success('入库成功')
      stockDialogVisible.value = false
      fetchSnacks()
    }
  } catch (err) {
    console.error('入库失败:', err)
  }
}

const deleteSnack = (item) => {
  ElMessageBox.confirm(`确认删除商品「${item.name}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await snackApi.delete(item.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchSnacks()
      }
    } catch (err) {
      console.error('删除商品失败:', err)
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchSnacks()
})
</script>

<style scoped>
.page-container { padding: 20px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
</style>
