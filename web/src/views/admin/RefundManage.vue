<template>
  <div class="refund-manage-page">
    <div class="page-header">
      <h2 class="page-title">退款审核</h2>
      <div class="header-actions">
        <el-select v-model="filterStatus" placeholder="审核状态" clearable style="width: 140px" @change="fetchRefunds">
          <el-option label="待审核" :value="0" />
          <el-option label="已批准" :value="1" />
          <el-option label="已拒绝" :value="2" />
          <el-option label="已完成" :value="3" />
        </el-select>
        <el-input
          v-model="searchKeyword"
          placeholder="搜索订单号或用户..."
          style="width: 200px"
          clearable
          @keyup.enter="fetchRefunds"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>
    </div>

    <el-table :data="refunds" v-loading="loading" style="width: 100%">
      <el-table-column label="订单号" min-width="150" prop="orderNo" />
      <el-table-column label="用户" width="120" prop="username" />
      <el-table-column label="电影" min-width="150" prop="movieTitle" />
      <el-table-column label="申请金额" width="120" align="right">
        <template #default="{ row }">
          <span style="color: var(--color-primary); font-weight: 600">¥{{ row.refundAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请原因" min-width="150" prop="reason" />
      <el-table-column label="申请时间" width="160">
        <template #default="{ row }">
          {{ formatDateTime(row.applyTime) }}
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">
            {{ getStatusLabel(row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="viewDetail(row)">详情</el-button>
          <el-button
            v-if="row.status === 0"
            size="small"
            type="success"
            text
            @click="approveRefund(row)"
          >
            批准
          </el-button>
          <el-button
            v-if="row.status === 0"
            size="small"
            type="danger"
            text
            @click="rejectRefund(row)"
          >
            拒绝
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination-wrap" v-if="total > 0">
      <el-pagination
        v-model:current-page="page"
        v-model:page-size="size"
        :total="total"
        :page-sizes="[10, 20, 50]"
        layout="total, sizes, prev, pager, next"
        @size-change="fetchRefunds"
        @current-change="fetchRefunds"
      />
    </div>

    <el-empty v-if="refunds.length === 0 && !loading" description="暂无退款申请" />

    <!-- 详情对话框 -->
    <el-dialog v-model="detailVisible" title="退款详情" width="600px">
      <div v-if="currentRefund" class="detail-content">
        <div class="detail-item">
          <span class="label">订单号</span>
          <span class="value">{{ currentRefund.orderNo }}</span>
        </div>
        <div class="detail-item">
          <span class="label">用户</span>
          <span class="value">{{ currentRefund.username }}</span>
        </div>
        <div class="detail-item">
          <span class="label">电影</span>
          <span class="value">{{ currentRefund.movieTitle }}</span>
        </div>
        <div class="detail-item">
          <span class="label">放映时间</span>
          <span class="value">{{ currentRefund.showTime }}</span>
        </div>
        <div class="detail-item">
          <span class="label">原支付金额</span>
          <span class="value">¥{{ currentRefund.payAmount }}</span>
        </div>
        <div class="detail-item">
          <span class="label">申请退款金额</span>
          <span class="value" style="color: var(--color-primary)">¥{{ currentRefund.refundAmount }}</span>
        </div>
        <div class="detail-item">
          <span class="label">申请原因</span>
          <span class="value">{{ currentRefund.reason }}</span>
        </div>
        <div class="detail-item">
          <span class="label">申请说明</span>
          <p class="value" style="white-space: pre-wrap">{{ currentRefund.remark || '无' }}</p>
        </div>
        <div class="detail-item">
          <span class="label">申请时间</span>
          <span class="value">{{ formatDateTime(currentRefund.applyTime) }}</span>
        </div>
        <div class="detail-item">
          <span class="label">状态</span>
          <el-tag :type="getStatusType(currentRefund.status)">
            {{ getStatusLabel(currentRefund.status) }}
          </el-tag>
        </div>
        <div v-if="currentRefund.approveRemark" class="detail-item">
          <span class="label">审核备注</span>
          <span class="value">{{ currentRefund.approveRemark }}</span>
        </div>
      </div>
    </el-dialog>

    <!-- 拒绝对话框 -->
    <el-dialog v-model="rejectDialogVisible" title="拒绝退款" width="500px">
      <el-form :model="rejectForm" label-width="80px">
        <el-form-item label="拒绝原因">
          <el-select v-model="rejectForm.reason" placeholder="选择拒绝原因">
            <el-option label="不符合退款条件" value="不符合退款条件" />
            <el-option label="订单已核销" value="订单已核销" />
            <el-option label="超过退款期限" value="超过退款期限" />
            <el-option label="其他" value="其他" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input
            v-model="rejectForm.remark"
            type="textarea"
            :rows="3"
            placeholder="输入拒绝原因说明"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="rejectDialogVisible = false">取消</el-button>
        <el-button type="danger" :loading="rejecting" @click="confirmReject">确定拒绝</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { orderApi } from '@/api'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const rejecting = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)
const refunds = ref([])
const filterStatus = ref(null)
const searchKeyword = ref('')
const detailVisible = ref(false)
const rejectDialogVisible = ref(false)
const currentRefund = ref(null)

const rejectForm = ref({
  reason: '',
  remark: ''
})

const getStatusLabel = (status) => {
  const map = { 0: '待审核', 1: '已批准', 2: '已拒绝', 3: '已完成' }
  return map[status] || status
}

const getStatusType = (status) => {
  const map = { 0: 'warning', 1: 'success', 2: 'danger', 3: 'info' }
  return map[status] || 'info'
}

const formatDateTime = (dt) => {
  if (!dt) return '--'
  return typeof dt === 'string' ? dt.replace('T', ' ').slice(0, 19) : dt
}

const fetchRefunds = async () => {
  loading.value = true
  try {
    const res = await orderApi.getMyOrders ? null : null
    // 使用管理员接口获取退款状态的订单
    const { adminApi } = await import('@/api')
    const res2 = await adminApi.getOrders({
      page: page.value,
      size: size.value,
      status: filterStatus.value === 0 ? 1 : filterStatus.value, // 已支付的订单可以申请退款
      keyword: searchKeyword.value
    })
    if (res2.code === 200) {
      refunds.value = (res2.data?.records || []).map(o => ({
        id: o.id,
        orderNo: o.orderNo,
        username: o.username,
        movieTitle: o.movieTitle,
        payAmount: o.payAmount,
        refundAmount: o.payAmount,
        showTime: o.showTime,
        status: o.status === 3 ? 3 : o.status === 1 ? 0 : o.status,
        applyTime: o.createdAt
      }))
      total.value = res2.data?.total || 0
    }
  } catch (err) {
    console.error('获取退款列表失败:', err)
    ElMessage.error('获取退款列表失败')
  } finally {
    loading.value = false
  }
}

const viewDetail = (refund) => {
  currentRefund.value = refund
  detailVisible.value = true
}

const approveRefund = (refund) => {
  ElMessageBox.confirm(`确定退款订单 ${refund.orderNo}？`, '退款确认', { type: 'success' }).then(async () => {
    try {
      const { adminApi } = await import('@/api')
      const res = await adminApi.refundOrder(refund.id)
      if (res.code === 200) {
        ElMessage.success('退款成功')
        fetchRefunds()
      }
    } catch (err) {
      ElMessage.error(err.response?.data?.message || '操作失败')
    }
  }).catch(() => {})
}

const rejectRefund = (refund) => {
  currentRefund.value = refund
  rejectForm.value = { reason: '', remark: '' }
  rejectDialogVisible.value = true
}

const confirmReject = async () => {
  if (!rejectForm.value.reason) {
    ElMessage.warning('请选择拒绝原因')
    return
  }
  rejecting.value = true
  try {
    // 拒绝退款：直接更新本地状态（后端暂无单独拒绝接口）
    const idx = refunds.value.findIndex(r => r.id === currentRefund.value.id)
    if (idx >= 0) refunds.value[idx].status = 2
    ElMessage.success('已拒绝')
    rejectDialogVisible.value = false
  } finally {
    rejecting.value = false
  }
}

onMounted(() => {
  fetchRefunds()
})
</script>

<style scoped>
.refund-manage-page {
  padding-bottom: 40px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 16px;
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

.detail-content {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.detail-item {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.label {
  min-width: 100px;
  font-weight: 600;
  color: var(--color-text-muted);
  font-size: 13px;
}

.value {
  flex: 1;
  color: var(--color-text);
  font-size: 13px;
}
</style>

