<template>
  <div class="page-container">
    <div class="page-header">
      <h2>商品管理</h2>
      <el-button type="primary" :icon="Plus" @click="openDialog()">新增商品</el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-row :gutter="16" align="middle">
        <el-col :span="8">
          <el-input v-model="keyword" placeholder="搜索商品名..." clearable @input="filterSnacks">
            <template #prefix><el-icon><Search /></el-icon></template>
          </el-input>
        </el-col>
        <el-col :span="8">
          <el-select v-model="filterCategory" placeholder="选择分类" clearable @change="filterSnacks">
            <el-option label="全部分类" value="" />
            <el-option label="爆米花" value="popcorn" />
            <el-option label="饮料" value="drink" />
            <el-option label="套餐" value="combo" />
            <el-option label="小食" value="snack" />
          </el-select>
        </el-col>
        <el-col :span="8">
          <el-button @click="resetQuery">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 表格 -->
    <el-card>
      <el-table :data="snacks" style="width:100%" v-loading="loading">
        <el-table-column label="商品" min-width="200">
          <template #default="{ row }">
            <div style="display:flex;align-items:center;gap:10px">
              <img v-if="row.image" :src="row.image" :alt="row.name" style="width:50px;height:50px;object-fit:cover;border-radius:4px" />
              <div v-else style="width:50px;height:50px;background:#f0f0f0;border-radius:4px;display:flex;align-items:center;justify-content:center">
                <el-icon><Picture /></el-icon>
              </div>
              <div>
                <div style="font-weight:600">{{ row.name }}</div>
                <div style="font-size:12px;color:var(--color-text-muted)">{{ categoryMap[row.category] || row.category }}</div>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="price" label="价格" width="80">
          <template #default="{ row }">
            <span style="color:#e50914;font-weight:600">¥{{ row.price }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="originalPrice" label="原价" width="80">
          <template #default="{ row }">
            <span v-if="row.originalPrice" style="text-decoration:line-through;color:var(--color-text-muted)">¥{{ row.originalPrice }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="stock" label="库存" width="80" />
        <el-table-column prop="sales" label="销量" width="80" />
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
              {{ row.status === 1 ? '上架' : '下架' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
            <el-button size="small" type="danger" text @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.size"
        :total="pagination.total"
        layout="total, prev, pager, next"
        class="mt-16"
        @current-change="filterSnacks"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="editingSnack ? '编辑商品' : '新增商品'" width="600px">
      <el-form :model="form" label-width="90px">
        <el-form-item label="商品名称" required>
          <el-input v-model="form.name" placeholder="请输入商品名称" />
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="form.category" style="width:100%">
            <el-option label="爆米花" value="popcorn" />
            <el-option label="饮料" value="drink" />
            <el-option label="套餐" value="combo" />
            <el-option label="小食" value="snack" />
          </el-select>
        </el-form-item>
        <el-form-item label="商品图片">
          <el-input v-model="form.image" placeholder="图片URL" />
        </el-form-item>
        <el-form-item label="价格" required>
          <el-input-number v-model="form.price" :min="0" :step="0.1" style="width:100%" />
        </el-form-item>
        <el-form-item label="原价">
          <el-input-number v-model="form.originalPrice" :min="0" :step="0.1" style="width:100%" />
        </el-form-item>
        <el-form-item label="库存" required>
          <el-input-number v-model="form.stock" :min="0" style="width:100%" />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sortOrder" :min="0" style="width:100%" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio :value="1">上架</el-radio>
            <el-radio :value="0">下架</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="3" placeholder="商品描述" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="saving">确认保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { snackApi } from '@/api'
import { Plus, Search, Picture } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const keyword = ref('')
const filterCategory = ref('')
const dialogVisible = ref(false)
const editingSnack = ref(null)
const snacks = ref([])
const pagination = reactive({ page: 1, size: 10, total: 0 })

// 分类映射
const categoryMap = {
  'popcorn': '爆米花',
  'drink': '饮料',
  'combo': '套餐',
  'snack': '小食'
}

const defaultForm = () => ({
  name: '',
  category: 'popcorn',
  image: '',
  price: 0,
  originalPrice: null,
  stock: 0,
  sales: 0,
  status: 1,
  sortOrder: 0,
  description: ''
})
const form = ref(defaultForm())

const allSnacks = ref([])

const fetchSnacks = async () => {
  loading.value = true
  try {
    const res = await snackApi.getPage({
      page: 1,
      size: 1000
    })
    if (res.code === 200) {
      allSnacks.value = res.data?.records || []
      console.log('获取的商品数据:', allSnacks.value)
      console.log('商品分类:', allSnacks.value.map(s => s.category))
      filterSnacks()
    }
  } catch (err) {
    console.error('获取商品列表失败:', err)
    ElMessage.error('获取商品列表失败')
  } finally {
    loading.value = false
  }
}

const filterSnacks = () => {
  let filtered = allSnacks.value
  
  // 按分类筛选（只有当分类不为空时才筛选）
  if (filterCategory.value && filterCategory.value.trim()) {
    filtered = filtered.filter(s => s.category && s.category.includes(filterCategory.value))
  }
  
  // 按关键词搜索
  if (keyword.value && keyword.value.trim()) {
    filtered = filtered.filter(s => s.name && s.name.includes(keyword.value))
  }
  
  // 分页
  pagination.total = filtered.length
  const start = (pagination.page - 1) * pagination.size
  const end = start + pagination.size
  snacks.value = filtered.slice(start, end)
}

const resetQuery = () => {
  keyword.value = ''
  filterCategory.value = ''
  pagination.page = 1
  filterSnacks()
}

const openDialog = (snack = null) => {
  editingSnack.value = snack
  if (snack) {
    form.value = { ...snack }
  } else {
    form.value = defaultForm()
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  if (!form.value.name) {
    ElMessage.warning('请输入商品名称')
    return
  }
  if (form.value.price === null || form.value.price === undefined) {
    ElMessage.warning('请输入价格')
    return
  }
  if (form.value.stock === null || form.value.stock === undefined) {
    ElMessage.warning('请输入库存')
    return
  }

  saving.value = true
  try {
    let res
    if (editingSnack.value) {
      res = await snackApi.update(editingSnack.value.id, form.value)
    } else {
      res = await snackApi.create(form.value)
    }

    if (res.code === 200) {
      ElMessage.success(editingSnack.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchSnacks()
    }
  } catch (err) {
    console.error('保存商品失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

const handleDelete = (snack) => {
  ElMessageBox.confirm(`确认删除商品《${snack.name}》？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await snackApi.delete(snack.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchSnacks()
      }
    } catch (err) {
      console.error('删除商品失败:', err)
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchSnacks()
})
</script>

<style scoped>
.page-container { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.search-card { margin-bottom: 20px; }
.mt-16 { margin-top: 16px; }
</style>

