<template>
  <div class="page-container">
    <div class="page-header">
      <h2>订单管理</h2>
      <div style="display:flex;align-items:center;gap:8px">
      <el-button :icon="Download" @click="exportOrders">导出</el-button>
      </div>
    </div>

    <el-card class="search-card">
      <el-row :gutter="16" align="middle">
        <el-col :span="6">
          <el-input v-model="query.keyword" placeholder="订单号/用户名" :prefix-icon="Search" clearable @keyup.enter="fetchOrders" />
        </el-col>
        <el-col :span="5">
          <el-select v-model="query.status" placeholder="订单状态" clearable style="width:100%">
            <el-option label="待支付" :value="0" />
            <el-option label="已支付" :value="1" />
            <el-option label="已退款" :value="2" />
            <el-option label="已取消" :value="3" />
          </el-select>
        </el-col>
        <el-col :span="8">
          <el-date-picker
            v-model="query.dateRange"
            type="daterange"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            value-format="YYYY-MM-DD"
            style="width:100%"
          />
        </el-col>
        <el-col :span="5">
          <el-button type="primary" :icon="Search" @click="fetchOrders">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <el-card>
      <el-table :data="orders" v-loading="loading">
        <el-table-column prop="orderNo" label="订单号" width="180" />
        <el-table-column label="用户" width="100">
          <template #default="{ row }">{{ row.username || `用户${row.userId}` }}</template>
        </el-table-column>
        <el-table-column prop="movieTitle" label="电影" min-width="120" />
        <el-table-column label="场次" width="150">
          <template #default="{ row }">{{ row.showTime || '--' }}</template>
        </el-table-column>
        <el-table-column label="座位" width="120">
          <template #default="{ row }">
            <span v-if="row.seats && row.seats.length">{{ row.seats.map(s => s.seatNo).join(', ') }}</span>
            <span v-else>--</span>
          </template>
        </el-table-column>
        <el-table-column prop="totalAmount" label="金额" width="90">
          <template #default="{ row }">
            <span class="price-text">¥{{ row.totalAmount }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="payType" label="支付方式" width="100">
          <template #default="{ row }">{{ payTypeLabel(row.payType) }}</template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="statusType(row.status)" size="small">{{ statusLabel(row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="下单时间" width="160" />
        <el-table-column label="操作" width="130" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="primary" text @click="viewDetail(row)">详情</el-button>
            <el-button v-if="row.status === 1" size="small" type="warning" text @click="handleRefund(row)">退款</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-model:current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        layout="total, prev, pager, next"
        class="mt-16"
        @current-change="fetchOrders"
      />
    </el-card>

    <!-- 订单详情 -->
    <el-drawer v-model="drawerVisible" title="订单详情" size="420px">
      <template v-if="currentOrder">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="订单号">{{ currentOrder.orderNo }}</el-descriptions-item>
          <el-descriptions-item label="用户">{{ currentOrder.username || `用户${currentOrder.userId}` }}</el-descriptions-item>
          <el-descriptions-item label="电影">{{ currentOrder.movieTitle }}</el-descriptions-item>
          <el-descriptions-item label="影院">{{ currentOrder.cinemaName || '--' }}</el-descriptions-item>
          <el-descriptions-item label="影厅">{{ currentOrder.hallName || '--' }}</el-descriptions-item>
          <el-descriptions-item label="场次">{{ currentOrder.showTime || '--' }}</el-descriptions-item>
          <el-descriptions-item label="座位">
            <span v-if="currentOrder.seats && currentOrder.seats.length">{{ currentOrder.seats.map(s => s.seatNo).join(', ') }}</span>
            <span v-else>--</span>
          </el-descriptions-item>
          <el-descriptions-item label="票价">¥{{ currentOrder.ticketAmount || 0 }}</el-descriptions-item>
          <el-descriptions-item label="小食">¥{{ currentOrder.snackAmount || 0 }}</el-descriptions-item>
          <el-descriptions-item label="优惠">-¥{{ currentOrder.discountAmount || 0 }}</el-descriptions-item>
          <el-descriptions-item label="实付金额">
            <span style="color:#e8b84b;font-weight:700">¥{{ currentOrder.totalAmount }}</span>
          </el-descriptions-item>
          <el-descriptions-item label="支付方式">{{ payTypeLabel(currentOrder.payType) }}</el-descriptions-item>
          <el-descriptions-item label="状态">
            <el-tag :type="statusType(currentOrder.status)">{{ statusLabel(currentOrder.status) }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="下单时间">{{ currentOrder.createdAt }}</el-descriptions-item>
          <el-descriptions-item v-if="currentOrder.payTime" label="支付时间">{{ currentOrder.payTime }}</el-descriptions-item>
        </el-descriptions>
      </template>
    </el-drawer>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { Download, Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'

const loading = ref(false)
const query = reactive({ keyword: '', status: null, dateRange: [] })
const pagination = reactive({ page: 1, size: 10, total: 0 })
const drawerVisible = ref(false)
const currentOrder = ref(null)
const orders = ref([])

onMounted(() => {
  fetchOrders()
})

const fetchOrders = async () => {
  loading.value = true
  try {
    const params = {
      keyword: query.keyword || undefined,
      status: query.status !== null ? query.status : undefined,
      startDate: query.dateRange?.[0] || undefined,
      endDate: query.dateRange?.[1] || undefined,
      page: pagination.page,
      size: pagination.size
    }
    const res = await adminApi.getOrders(params)
    if (res.code === 200) {
      orders.value = res.data?.records || []
      pagination.total = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取订单列表失败:', err)
  } finally {
    loading.value = false
  }
}

const resetQuery = () => {
  Object.assign(query, { keyword: '', status: null, dateRange: [] })
  pagination.page = 1
  fetchOrders()
}

const statusType = (s) => ({ 0: 'warning', 1: 'success', 2: 'info', 3: 'danger' }[s] || '')
const statusLabel = (s) => ({ 0: '待支付', 1: '已支付', 2: '已退款', 3: '已取消' }[s] || '未知')
const payTypeLabel = (t) => ({
  'wechat': '微信支付', 'alipay': '支付宝', 'balance': '余额支付',
  'card': '银行卡', 'memberCard': '会员卡',
  '1': '余额支付', '2': '微信支付', '3': '支付宝'
}[String(t)] || t || '--')

const viewDetail = async (row) => {
  try {
    const res = await adminApi.getOrderDetail(row.id)
    if (res.code === 200) {
      currentOrder.value = res.data
      drawerVisible.value = true
    }
  } catch (err) {
    console.error('获取订单详情失败:', err)
    currentOrder.value = row
    drawerVisible.value = true
  }
}

const handleRefund = (row) => {
  ElMessageBox.confirm(`确定对订单 ${row.orderNo} 执行退款操作？`, '退款确认', { type: 'warning' }).then(async () => {
    try {
      const res = await adminApi.refundOrder(row.id)
      if (res.code === 200) {
        row.status = 2
        ElMessage.success('退款成功')
      }
    } catch (err) {
      console.error('退款失败:', err)
      ElMessage.error(err.response?.data?.message || '退款失败')
    }
  }).catch(() => {})
}

const exportOrders = async () => {
  try {
    const res = await adminApi.exportOrders({
      startDate: query.dateRange?.[0],
      endDate: query.dateRange?.[1],
      status: query.status
    })
    const url = window.URL.createObjectURL(new Blob([res]))
    const link = document.createElement('a')
    link.href = url
    link.setAttribute('download', `orders_${Date.now()}.xlsx`)
    document.body.appendChild(link)
    link.click()
    link.remove()
    ElMessage.success('导出成功')
  } catch (err) {
    console.error('导出失败:', err)
    ElMessage.info('导出功能暂不可用')
  }
}
</script>

<style scoped>
.mt-16 { margin-top: 16px; }
.price-text { color: #e50914; font-weight: 600; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
</style>
