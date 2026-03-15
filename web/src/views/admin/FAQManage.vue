<template>
  <div class="faq-manage">
    <div class="page-header">
      <h1>常见问题管理</h1>
      <el-button type="primary" @click="showDialog = true">
        <el-icon><Plus /></el-icon>
        新增 FAQ
      </el-button>
    </div>

    <!-- 搜索和筛选 -->
    <div class="search-bar">
      <el-input
        v-model="searchText"
        placeholder="搜索问题..."
        style="width: 200px"
        clearable
      />
      <el-select
        v-model="selectedCategory"
        placeholder="选择分类"
        style="width: 150px; margin-left: 12px"
        clearable
      >
        <el-option label="购票" value="booking" />
        <el-option label="退票" value="refund" />
        <el-option label="会员" value="member" />
        <el-option label="积分" value="points" />
        <el-option label="支付" value="payment" />
        <el-option label="其他" value="other" />
      </el-select>
      <el-button @click="loadFAQs" style="margin-left: 12px">查询</el-button>
    </div>

    <!-- FAQ 列表 -->
    <el-table :data="faqList" stripe style="width: 100%; margin-top: 20px">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="question" label="问题" min-width="300" />
      <el-table-column prop="category" label="分类" width="100">
        <template #default="{ row }">
          <el-tag>{{ getCategoryLabel(row.category) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="sort" label="排序" width="80" />
      <el-table-column prop="enabled" label="状态" width="100">
        <template #default="{ row }">
          <el-switch
            v-model="row.enabled"
            @change="updateFAQ(row)"
            active-text="启用"
            inactive-text="禁用"
          />
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" @click="editFAQ(row)">编辑</el-button>
          <el-button link type="danger" @click="deleteFAQ(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="showDialog"
      :title="editingFAQ ? '编辑 FAQ' : '新增 FAQ'"
      width="600px"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="问题" prop="question">
          <el-input
            v-model="formData.question"
            type="textarea"
            :rows="3"
            placeholder="请输入问题"
          />
        </el-form-item>
        <el-form-item label="答案" prop="answer">
          <el-input
            v-model="formData.answer"
            type="textarea"
            :rows="5"
            placeholder="请输入答案"
          />
        </el-form-item>
        <el-form-item label="分类" prop="category">
          <el-select v-model="formData.category" placeholder="选择分类">
            <el-option label="购票" value="booking" />
            <el-option label="退票" value="refund" />
            <el-option label="会员" value="member" />
            <el-option label="积分" value="points" />
            <el-option label="支付" value="payment" />
            <el-option label="其他" value="other" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="formData.sort" :min="0" />
        </el-form-item>
        <el-form-item label="启用" prop="enabled">
          <el-switch v-model="formData.enabled" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showDialog = false">取消</el-button>
        <el-button type="primary" @click="saveFAQ">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const faqList = ref([])
const showDialog = ref(false)
const editingFAQ = ref(null)
const searchText = ref('')
const selectedCategory = ref('')
const formRef = ref(null)
const formData = ref({
  question: '',
  answer: '',
  category: '',
  sort: 0,
  enabled: true
})

const rules = {
  question: [{ required: true, message: '请输入问题', trigger: 'blur' }],
  answer: [{ required: true, message: '请输入答案', trigger: 'blur' }],
  category: [{ required: true, message: '请选择分类', trigger: 'change' }]
}

const getCategoryLabel = (category) => {
  const labels = {
    booking: '购票',
    refund: '退票',
    member: '会员',
    points: '积分',
    payment: '支付',
    other: '其他'
  }
  return labels[category] || category
}

const loadFAQs = async () => {
  try {
    // 模拟数据加载
    faqList.value = [
      {
        id: 1,
        question: '如何购票？',
        answer: '1. 登录账号\n2. 选择电影和场次\n3. 选择座位\n4. 支付订单\n5. 获取电子票券',
        category: 'booking',
        sort: 1,
        enabled: true
      },
      {
        id: 2,
        question: '如何退票？',
        answer: '放映前24小时可申请全额退款\n放映前2小时可申请90%退款\n放映前1小时可申请80%退款',
        category: 'refund',
        sort: 2,
        enabled: true
      },
      {
        id: 3,
        question: '会员有什么权益？',
        answer: '普通会员：基础权益\n白银会员：95折优惠\n黄金会员：90折优惠\n钻石会员：85折优惠',
        category: 'member',
        sort: 3,
        enabled: true
      }
    ]
  } catch (err) {
    console.error('加载 FAQ 失败:', err)
    ElMessage.error('加载 FAQ 失败')
  }
}

const editFAQ = (faq) => {
  editingFAQ.value = faq
  formData.value = { ...faq }
  showDialog.value = true
}

const saveFAQ = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    // 模拟保存
    if (editingFAQ.value) {
      const index = faqList.value.findIndex(f => f.id === editingFAQ.value.id)
      if (index > -1) {
        faqList.value[index] = { ...formData.value }
      }
      ElMessage.success('更新成功')
    } else {
      formData.value.id = Date.now()
      faqList.value.push({ ...formData.value })
      ElMessage.success('新增成功')
    }
    showDialog.value = false
    resetForm()
  } catch (err) {
    console.error('保存失败:', err)
  }
}

const updateFAQ = async (faq) => {
  try {
    // 模拟更新
    ElMessage.success('更新成功')
  } catch (err) {
    console.error('更新失败:', err)
    ElMessage.error('更新失败')
  }
}

const deleteFAQ = (id) => {
  ElMessageBox.confirm('确定删除此 FAQ 吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    faqList.value = faqList.value.filter(f => f.id !== id)
    ElMessage.success('删除成功')
  }).catch(() => {})
}

const resetForm = () => {
  editingFAQ.value = null
  formData.value = {
    question: '',
    answer: '',
    category: '',
    sort: 0,
    enabled: true
  }
}

onMounted(() => {
  loadFAQs()
})
</script>

<style scoped>
.faq-manage {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h1 {
  font-size: 24px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.search-bar {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
}
</style>

