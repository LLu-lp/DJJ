<template>
  <div class="coupon-manage-page">
    <div class="page-header">
      <h1 class="page-title">优惠券管理</h1>
      <el-button type="primary" @click="showDialog = true">新增优惠券</el-button>
    </div>

    <el-table :data="coupons" v-loading="loading" stripe style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" label="优惠券名称" min-width="150" />
      <el-table-column label="优惠类型" width="100">
        <template #default="{ row }">
          <el-tag v-if="row.discountType === 1" type="success">满减</el-tag>
          <el-tag v-else type="info">折扣</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="优惠金额/折扣" width="120">
        <template #default="{ row }">
          <span v-if="row.discountType === 1">¥{{ row.discountValue }}</span>
          <span v-else>{{ (row.discountValue * 10).toFixed(1) }}折</span>
        </template>
      </el-table-column>
      <el-table-column prop="minAmount" label="最低消费" width="100" />
      <el-table-column prop="validDays" label="有效期(天)" width="100" />
      <el-table-column prop="totalCount" label="总数量" width="80" />
      <el-table-column prop="receivedCount" label="已领取" width="80" />
      <el-table-column label="状态" width="80">
        <template #default="{ row }">
          <el-tag v-if="row.status === 1" type="success">启用</el-tag>
          <el-tag v-else type="danger">禁用</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="150" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" size="small" @click="editCoupon(row)">编辑</el-button>
          <el-button link type="danger" size="small" @click="deleteCoupon(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :page-sizes="[10, 20, 50]"
      :total="total"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px; text-align: right"
      @change="loadCoupons"
    />

    <!-- 编辑对话框 -->
    <el-dialog v-model="showDialog" :title="editingId ? '编辑优惠券' : '新增优惠券'" width="500px">
      <el-form :model="form" label-width="100px">
        <el-form-item label="优惠券名称">
          <el-input v-model="form.name" placeholder="请输入优惠券名称" />
        </el-form-item>
        <el-form-item label="优惠类型">
          <el-radio-group v-model="form.discountType">
            <el-radio :label="1">满减</el-radio>
            <el-radio :label="2">折扣</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="优惠金额/折扣">
          <el-input-number
            v-model="form.discountValue"
            :min="0"
            :step="form.discountType === 1 ? 1 : 0.1"
            :placeholder="form.discountType === 1 ? '请输入优惠金额' : '请输入折扣(0-1)'"
          />
          <span style="margin-left: 10px; color: #999">
            {{ form.discountType === 1 ? '元' : '(0.1-1.0)' }}
          </span>
        </el-form-item>
        <el-form-item label="最低消费">
          <el-input-number v-model="form.minAmount" :min="0" placeholder="请输入最低消费金额" />
        </el-form-item>
        <el-form-item label="有效期">
          <el-input-number v-model="form.validDays" :min="1" placeholder="请输入有效期(天)" />
        </el-form-item>
        <el-form-item label="开始时间">
          <el-date-picker v-model="form.startTime" type="datetime" placeholder="选择开始时间" />
        </el-form-item>
        <el-form-item label="结束时间">
          <el-date-picker v-model="form.endTime" type="datetime" placeholder="选择结束时间" />
        </el-form-item>
        <el-form-item label="总数量">
          <el-input-number v-model="form.totalCount" :min="1" placeholder="请输入总数量" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="3" placeholder="请输入优惠券描述" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showDialog = false">取消</el-button>
        <el-button type="primary" @click="saveCoupon" :loading="submitting">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const submitting = ref(false)
const coupons = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const showDialog = ref(false)
const editingId = ref(null)

const form = ref({
  name: '',
  type: 1,
  discountType: 1,
  discountValue: 0,
  minAmount: 0,
  validDays: 30,
  totalCount: 100,
  description: '',
  status: 1,
  startTime: new Date(),
  endTime: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
})

const loadCoupons = async () => {
  loading.value = true
  try {
    const res = await adminApi.getCoupons(currentPage.value, pageSize.value)
    if (res.code === 200) {
      coupons.value = res.data?.records || []
      total.value = res.data?.total || 0
    }
  } catch (err) {
    console.error('加载优惠券失败:', err)
    ElMessage.error('加载优惠券失败')
  } finally {
    loading.value = false
  }
}

const editCoupon = (coupon) => {
  editingId.value = coupon.id
  form.value = { ...coupon }
  showDialog.value = true
}

const saveCoupon = async () => {
  submitting.value = true
  try {
    if (editingId.value) {
      const res = await adminApi.updateCoupon(editingId.value, form.value)
      if (res.code === 200) {
        ElMessage.success('更新成功')
      }
    } else {
      const res = await adminApi.createCoupon(form.value)
      if (res.code === 200) {
        ElMessage.success('创建成功')
      }
    }
    showDialog.value = false
    editingId.value = null
    await loadCoupons()
  } catch (err) {
    console.error('保存失败:', err)
    ElMessage.error(err.response?.data?.message || '保存失败')
  } finally {
    submitting.value = false
  }
}

const deleteCoupon = (id) => {
  ElMessageBox.confirm('确定删除该优惠券吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    try {
      const res = await adminApi.deleteCoupon(id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        await loadCoupons()
      }
    } catch (err) {
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

onMounted(() => {
  loadCoupons()
})
</script>

<style scoped>
.coupon-manage-page {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--color-text);
}
</style>

