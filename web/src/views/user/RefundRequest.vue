<template>
  <div class="refund-page">
    <div class="page-header">
      <h1 class="page-title">退款申请</h1>
      <p class="page-desc">申请退款前，请确保订单符合退款条件</p>
    </div>

    <div class="refund-container">
      <!-- 左侧：订单选择 -->
      <div class="order-section">
        <h2 class="section-title">选择要退款的订单</h2>
        
        <div class="filters">
          <el-input
            v-model="searchOrderNo"
            placeholder="输入订单号..."
            style="width: 200px"
            clearable
            @keyup.enter="fetchOrders"
          >
            <template #prefix><el-icon><Search /></el-icon></template>
          </el-input>
          <el-select v-model="filterStatus" placeholder="订单状态" clearable style="width: 150px" @change="fetchOrders">
            <el-option label="待支付" :value="0" />
            <el-option label="已支付" :value="1" />
            <el-option label="已取消" :value="2" />
          </el-select>
        </div>

        <div class="orders-list" v-loading="loading">
          <div
            v-for="order in filteredOrders"
            :key="order.id"
            class="order-item"
            :class="{ selected: selectedOrder?.id === order.id }"
            @click="selectOrder(order)"
          >
            <div class="order-header">
              <span class="order-no">{{ order.orderNo }}</span>
              <el-tag :type="getStatusType(order.status)" size="small">
                {{ getStatusLabel(order.status) }}
              </el-tag>
            </div>
            <div class="order-info">
              <p>{{ order.movieTitle }}</p>
              <p class="order-meta">{{ order.showTime }}</p>
            </div>
            <div class="order-amount">¥{{ order.payAmount }}</div>
          </div>
        </div>

        <el-empty v-if="filteredOrders.length === 0 && !loading" description="暂无可退款订单" />
      </div>

      <!-- 右侧：退款信息 -->
      <div class="refund-info-section">
        <el-card class="refund-card">
          <template #header>
            <div class="card-header">退款信息</div>
          </template>

          <div v-if="selectedOrder" class="refund-content">
            <!-- 订单信息 -->
            <div class="info-group">
              <h4>订单信息</h4>
              <div class="info-item">
                <span class="label">订单号</span>
                <span class="value">{{ selectedOrder.orderNo }}</span>
              </div>
              <div class="info-item">
                <span class="label">电影</span>
                <span class="value">{{ selectedOrder.movieTitle }}</span>
              </div>
              <div class="info-item">
                <span class="label">放映时间</span>
                <span class="value">{{ selectedOrder.showTime }}</span>
              </div>
              <div class="info-item">
                <span class="label">座位</span>
                <span class="value">{{ selectedOrder.seats }}</span>
              </div>
            </div>

            <!-- 退款金额 -->
            <div class="info-group">
              <h4>退款金额</h4>
              <div class="info-item">
                <span class="label">原支付金额</span>
                <span class="value">¥{{ selectedOrder.payAmount }}</span>
              </div>
              <div class="info-item">
                <span class="label">退款手续费</span>
                <span class="value" style="color: #ef4444">-¥{{ refundFee }}</span>
              </div>
              <div class="info-item total">
                <span class="label">实际退款金额</span>
                <span class="value">¥{{ actualRefund }}</span>
              </div>
            </div>

            <!-- 退款原因 -->
            <div class="info-group">
              <h4>退款原因</h4>
              <el-select v-model="refundForm.reason" placeholder="选择退款原因" style="width: 100%">
                <el-option label="无法按时观影" value="无法按时观影" />
                <el-option label="电影质量不满意" value="电影质量不满意" />
                <el-option label="个人原因" value="个人原因" />
                <el-option label="其他" value="其他" />
              </el-select>
            </div>

            <!-- 退款说明 -->
            <div class="info-group">
              <h4>退款说明</h4>
              <el-input
                v-model="refundForm.remark"
                type="textarea"
                :rows="3"
                placeholder="请详细说明退款原因（可选）"
                maxlength="200"
                show-word-limit
              />
            </div>

            <!-- 退款条件 -->
            <div class="refund-conditions">
              <h4>退款条件</h4>
              <ul>
                <li>✓ 放映前24小时可申请全额退款</li>
                <li>✓ 放映前2小时可申请90%退款</li>
                <li>✓ 放映前1小时可申请80%退款</li>
                <li>✗ 放映开始后不可退款</li>
              </ul>
            </div>

            <!-- 提交按钮 -->
            <el-button
              type="primary"
              size="large"
              style="width: 100%; margin-top: 20px"
              :loading="submitting"
              :disabled="!canSubmit"
              @click="submitRefund"
            >
              申请退款
            </el-button>

            <p class="agreement">
              <el-checkbox v-model="refundForm.agree" />
              我已阅读并同意
              <el-link type="primary">《退款协议》</el-link>
            </p>
          </div>

          <el-empty v-else description="请选择要退款的订单" />
        </el-card>
      </div>
    </div>

    <!-- 退款记录 -->
    <el-card style="margin-top: 24px">
      <template #header>
        <div class="card-header">退款记录</div>
      </template>
      <el-table :data="refundRecords" v-loading="loadingRecords" style="width: 100%">
        <el-table-column label="订单号" min-width="150" prop="orderNo" />
        <el-table-column label="电影" min-width="150" prop="movieTitle" />
        <el-table-column label="申请时间" width="160">
          <template #default="{ row }">
            {{ formatDateTime(row.applyTime) }}
          </template>
        </el-table-column>
        <el-table-column label="退款金额" width="120" align="right">
          <template #default="{ row }">
            <span style="color: var(--color-primary); font-weight: 600">¥{{ row.refundAmount }}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="120">
          <template #default="{ row }">
            <el-tag :type="getRefundStatusType(row.status)">
              {{ getRefundStatusLabel(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template #default="{ row }">
            <el-button link size="small" type="primary" @click="viewDetail(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { orderApi } from '@/api'
import { Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref } from 'vue'

const loading = ref(false)
const loadingRecords = ref(false)
const submitting = ref(false)
const searchOrderNo = ref('')
const filterStatus = ref(null)
const orders = ref([])
const selectedOrder = ref(null)
const refundRecords = ref([])

const refundForm = ref({
  reason: '',
  remark: '',
  agree: false
})

const refundFee = computed(() => {
  if (!selectedOrder.value) return 0
  return (selectedOrder.value.payAmount * 0.05).toFixed(2)
})

const actualRefund = computed(() => {
  if (!selectedOrder.value) return 0
  return (selectedOrder.value.payAmount - refundFee.value).toFixed(2)
})

const canSubmit = computed(() => {
  return selectedOrder.value &&
    refundForm.value.reason &&
    refundForm.value.agree
})

const filteredOrders = computed(() => {
  let list = orders.value
  if (filterStatus.value !== null) {
    list = list.filter(o => o.status === filterStatus.value)
  }
  if (searchOrderNo.value) {
    list = list.filter(o => o.orderNo.includes(searchOrderNo.value))
  }
  return list
})

const getStatusLabel = (status) => {
  const map = { 0: '待支付', 1: '已支付', 2: '已取消', 3: '已退款' }
  return map[status] || status
}

const getStatusType = (status) => {
  const map = { 0: 'warning', 1: 'success', 2: 'danger', 3: 'info' }
  return map[status] || 'info'
}

const getRefundStatusLabel = (status) => {
  const map = { 0: '待审核', 1: '已批准', 2: '已拒绝', 3: '已完成' }
  return map[status] || status
}

const getRefundStatusType = (status) => {
  const map = { 0: 'warning', 1: 'success', 2: 'danger', 3: 'info' }
  return map[status] || 'info'
}

const formatDateTime = (dt) => {
  if (!dt) return '--'
  return typeof dt === 'string' ? dt.replace('T', ' ').slice(0, 19) : dt
}

const fetchOrders = async () => {
  loading.value = true
  try {
    const res = await orderApi.getMyOrders({ size: 50 })
    if (res.code === 200) {
      // 只显示已支付的订单
      orders.value = (res.data?.records || []).filter(o => o.status === 1)
    }
  } catch (err) {
    console.error('获取订单列表失败:', err)
    ElMessage.error('获取订单列表失败')
  } finally {
    loading.value = false
  }
}

const fetchRefundRecords = async () => {
  loadingRecords.value = true
  try {
    // 模拟数据
    const mockData = [
      {
        id: 1,
        orderNo: 'JY202501010001',
        movieTitle: '流浪地球2',
        applyTime: '2025-01-10 14:30:00',
        refundAmount: 85.50,
        status: 3
      },
      {
        id: 2,
        orderNo: 'JY202501010002',
        movieTitle: '哪吒之魔童降世',
        applyTime: '2025-01-09 10:15:00',
        refundAmount: 64.60,
        status: 1
      }
    ]
    refundRecords.value = mockData
  } catch (err) {
    console.error('获取退款记录失败:', err)
  } finally {
    loadingRecords.value = false
  }
}

const selectOrder = (order) => {
  selectedOrder.value = order
  refundForm.value = { reason: '', remark: '', agree: false }
}

const submitRefund = async () => {
  if (!canSubmit.value) {
    ElMessage.warning('请完成所有必填项')
    return
  }

  submitting.value = true
  try {
    const res = await orderApi.refund(selectedOrder.value.id)
    if (res.code === 200) {
      ElMessage.success('退款申请已提交，请等待审核')
      selectedOrder.value = null
      fetchOrders()
      fetchRefundRecords()
    }
  } catch (err) {
    console.error('提交退款申请失败:', err)
    ElMessage.error(err.response?.data?.message || '提交失败')
  } finally {
    submitting.value = false
  }
}

const viewDetail = (record) => {
  ElMessage.info(`订单 ${record.orderNo} 的退款详情`)
}

onMounted(() => {
  fetchOrders()
  fetchRefundRecords()
})
</script>

<style scoped>
.refund-page {
  padding-bottom: 40px;
}

.page-header {
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 8px;
}

.page-desc {
  font-size: 14px;
  color: var(--color-text-muted);
}

.refund-container {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 24px;
  margin-bottom: 24px;
}

.order-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 20px;
}

.section-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 16px;
}

.filters {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}

.orders-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-height: 500px;
  overflow-y: auto;
}

.order-item {
  padding: 12px;
  background: var(--color-surface-2);
  border: 2px solid var(--color-border);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.order-item:hover {
  border-color: var(--color-primary);
}

.order-item.selected {
  border-color: var(--color-primary);
  background: var(--color-primary-light);
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.order-no {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
}

.order-info {
  margin-bottom: 8px;
}

.order-info p {
  font-size: 13px;
  color: var(--color-text);
  margin: 0;
}

.order-meta {
  color: var(--color-text-muted);
  font-size: 12px;
}

.order-amount {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-primary);
}

.refund-info-section {
  position: sticky;
  top: 80px;
}

.refund-card {
  background: var(--color-surface) !important;
  border: 1px solid var(--color-border) !important;
}

.card-header {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
}

.refund-content {
  padding: 16px 0;
}

.info-group {
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid var(--color-border);
}

.info-group h4 {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 12px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  font-size: 13px;
}

.info-item .label {
  color: var(--color-text-muted);
}

.info-item .value {
  color: var(--color-text);
  font-weight: 600;
}

.info-item.total {
  padding: 12px;
  background: var(--color-primary-light);
  border-radius: 6px;
  margin-top: 8px;
}

.info-item.total .value {
  font-size: 16px;
  color: var(--color-primary);
}

.refund-conditions {
  padding: 12px;
  background: rgba(59, 130, 246, 0.05);
  border-left: 3px solid var(--color-primary);
  border-radius: 4px;
  margin-bottom: 16px;
}

.refund-conditions h4 {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

.refund-conditions ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.refund-conditions li {
  font-size: 12px;
  color: var(--color-text-muted);
  line-height: 1.8;
}

.agreement {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-top: 12px;
  display: flex;
  align-items: center;
  gap: 6px;
}

@media (max-width: 1024px) {
  .refund-container {
    grid-template-columns: 1fr;
  }

  .refund-info-section {
    position: static;
  }
}
</style>

