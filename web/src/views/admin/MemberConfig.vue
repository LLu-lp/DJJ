<template>
  <div class="member-config-page">
    <div class="page-header">
      <h2>会员等级配置</h2>
      <el-button type="primary" :icon="Plus" @click="openDialog()">新增等级</el-button>
    </div>

    <el-table :data="levels" v-loading="loading">
      <el-table-column prop="level" label="等级" width="80" />
      <el-table-column prop="levelName" label="等级名称" width="120" />
      <el-table-column prop="minSpent" label="所需消费额" width="120" />
      <el-table-column label="折扣" width="100">
        <template #default="{ row }">{{ (row.discount * 10).toFixed(1) }}折</template>
      </el-table-column>
      <el-table-column label="积分倍率" width="100">
        <template #default="{ row }">{{ row.pointsRate }}倍</template>
      </el-table-column>
      <el-table-column prop="benefits" label="权益说明" min-width="200" />
      <el-table-column label="操作" width="140" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
          <el-button size="small" type="danger" text @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="editingLevel ? '编辑等级' : '新增等级'" width="480px">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="等级" prop="level">
          <el-input-number v-model="form.level" :min="1" :max="10" style="width:100%" :disabled="!!editingLevel" />
        </el-form-item>
        <el-form-item label="等级名称" prop="levelName">
          <el-input v-model="form.levelName" placeholder="如: 黄金会员" />
        </el-form-item>
        <el-form-item label="等级代码" prop="levelCode">
          <el-input v-model="form.levelCode" placeholder="如: GOLD" />
        </el-form-item>
        <el-form-item label="所需消费额" prop="minSpent">
          <el-input-number v-model="form.minSpent" :min="0" :step="100" style="width:100%" />
        </el-form-item>
        <el-form-item label="折扣" prop="discount">
          <el-input-number v-model="form.discount" :min="0.5" :max="1" :precision="2" :step="0.05" style="width:100%" />
          <span style="margin-left:8px;color:var(--color-text-muted)">{{ (form.discount * 10).toFixed(1) }}折</span>
        </el-form-item>
        <el-form-item label="积分倍率" prop="pointsRate">
          <el-input-number v-model="form.pointsRate" :min="1" :max="5" :precision="2" :step="0.1" style="width:100%" />
        </el-form-item>
        <el-form-item label="权益说明">
          <el-input v-model="form.benefits" type="textarea" :rows="2" />
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
import { adminApi } from '@/api'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const dialogVisible = ref(false)
const editingLevel = ref(null)
const formRef = ref()
const levels = ref([])

const defaultForm = () => ({ 
  level: 1, 
  levelName: '', 
  levelCode: '', 
  minSpent: 0, 
  discount: 1.00, 
  pointsRate: 1.00, 
  benefits: '' 
})
const form = reactive(defaultForm())

const rules = {
  level: [{ required: true, message: '请输入等级' }],
  levelName: [{ required: true, message: '请输入等级名称' }],
  levelCode: [{ required: true, message: '请输入等级代码' }],
  minSpent: [{ required: true, message: '请输入所需消费额' }],
  discount: [{ required: true, message: '请输入折扣' }],
  pointsRate: [{ required: true, message: '请输入积分倍率' }]
}

onMounted(() => {
  fetchLevels()
})

const fetchLevels = async () => {
  loading.value = true
  try {
    const res = await adminApi.getMemberLevels()
    if (res.code === 200) {
      levels.value = res.data || []
    }
  } catch (err) {
    console.error('获取会员等级失败:', err)
  } finally {
    loading.value = false
  }
}

function openDialog(row = null) {
  editingLevel.value = row
  if (row) {
    Object.assign(form, row)
  } else {
    Object.assign(form, defaultForm())
  }
  dialogVisible.value = true
}

async function handleSubmit() {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  
  saving.value = true
  try {
    if (editingLevel.value) {
      const res = await adminApi.updateMemberLevel(form.level, form)
      if (res.code === 200) {
        ElMessage.success('修改成功')
        dialogVisible.value = false
        fetchLevels()
      }
    } else {
      const res = await adminApi.addMemberLevel(form)
      if (res.code === 200) {
        ElMessage.success('新增成功')
        dialogVisible.value = false
        fetchLevels()
      }
    }
  } catch (err) {
    console.error('保存会员等级失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm(`确定删除等级「${row.levelName}」？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await adminApi.deleteMemberLevel(row.level)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchLevels()
      }
    } catch (err) {
      console.error('删除会员等级失败:', err)
      ElMessage.error(err.response?.data?.message || '删除失败')
    }
  }).catch(() => {})
}
</script>

<style scoped>
.member-config-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
</style>
