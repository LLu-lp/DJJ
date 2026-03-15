<template>
  <div class="orders-page">
    <div class="page-header">
      <h1 class="page-title">我的订单</h1>
      <el-input
        v-model="searchOrderId"
        placeholder="输入订单号查询"
        style="width:240px"
        clearable
        @change="searchOrder"
      >
        <template #prefix><el-icon><Search /></el-icon></template>
      </el-input>
    </div>

    <div class="status-tabs">
      <button
        v-for="tab in statusTabs"
        :key="tab.value"
        class="status-tab"
        :class="{ active: activeStatus === tab.value }"
        @click="activeStatus = tab.value"
      >
        {{ tab.label }}
      </button>
    </div>

    <div class="orders-list" v-loading="loading">
      <div v-for="order in filteredOrders" :key="order.id" class="order-card">
        <div class="order-header">
          <span class="order-id">订单号：{{ order.orderNo }}</span>
          <el-tag :type="statusTagType(order.status)" size="small">{{ statusLabel(order.status) }}</el-tag>
          <span class="order-time">{{ order.createdAt }}</span>
        </div>
        <div class="order-body">
          <div class="order-info">
            <h3 class="order-movie">{{ order.movieTitle }}</h3>
            <p class="order-meta">{{ order.cinemaName }} · {{ order.hallName }}</p>
            <p class="order-meta">{{ order.showTime }}</p>
            <div class="order-seats">
              <el-tag v-for="seat in order.seats" :key="seat.seatLabel" size="small" style="margin-right:4px">{{ seat.seatLabel }}</el-tag>
            </div>
          </div>
          <div class="order-price-section">
            <span class="order-price">¥{{ order.payAmount || order.totalAmount }}</span>
            <div class="order-actions">
              <el-button
                v-if="order.status === 0"
                size="small"
                type="primary"
                @click="payOrder(order)"
              >去支付</el-button>
              <el-button
                v-if="order.status === 0"
                size="small"
                type="danger"
                plain
                @click="cancelOrder(order)"
              >取消订单</el-button>
              <el-button v-if="order.status === 1" size="small" type="primary" @click="viewTicket(order)">
                查看票券
              </el-button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <el-empty v-if="filteredOrders.length === 0 && !loading" description="暂无订单记录" />

    <!-- 票券弹窗 -->
    <el-dialog v-model="ticketVisible" width="360px" :show-close="true" center class="ticket-dialog">
      <template #header>
        <div class="ticket-dialog-title">电子票券</div>
      </template>
      <div v-if="currentTicket" class="ticket-wrap">
        <div class="ticket-movie">{{ currentTicket.movieTitle }}</div>
        <div class="ticket-meta">
          <span>{{ currentTicket.cinemaName }}</span>
          <span>{{ currentTicket.hallName }}</span>
        </div>
        <div class="ticket-showtime">{{ currentTicket.showTime }}</div>
        <div class="ticket-qr-wrap">
          <canvas ref="qrCanvas" class="ticket-qr"></canvas>
        </div>
        <div class="ticket-code-label">核销码</div>
        <div class="ticket-code">{{ currentTicket.orderNo }}</div>
        <div class="ticket-tip">请在入场时出示此二维码或核销码</div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { orderApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import QRCode from 'qrcode'
import { computed, nextTick, onMounted, ref } from 'vue'

const authStore = useAuthStore()
const loading = ref(false)
const searchOrderId = ref('')
const activeStatus = ref('')
const orders = ref([])
const ticketVisible = ref(false)
const currentTicket = ref(null)
const qrCanvas = ref(null)

const statusTabs = [
  { label: '全部', value: '' },
  { label: '待支付', value: 0 },
  { label: '已支付', value: 1 },
  { label: '已取消', value: 2 },
  { label: '已退款', value: 3 },
]

const filteredOrders = computed(() => {
  let list = orders.value
  if (activeStatus.value !== '') list = list.filter(o => o.status === activeStatus.value)
  if (searchOrderId.value) list = list.filter(o => o.orderNo?.includes(searchOrderId.value))
  return list
})

function statusLabel(status) {
  const map = { 0: '待支付', 1: '已支付', 2: '已取消', 3: '已退款', 4: '已核销' }
  return map[status] || status
}

function statusTagType(status) {
  const map = { 0: 'warning', 1: 'success', 2: 'danger', 3: 'info', 4: 'success' }
  return map[status] || ''
}

const fetchOrders = async () => {
  loading.value = true
  try {
    const res = await orderApi.getMyOrders({ size: 50 })
    if (res.code === 200) {
      orders.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取订单列表失败:', err)
  } finally {
    loading.value = false
  }
}

function searchOrder() {}

function cancelOrder(order) {
  ElMessageBox.confirm('确认取消该订单？', '取消订单', { type: 'warning' }).then(async () => {
    try {
      const res = await orderApi.cancel(order.id)
      if (res.code === 200) {
        order.status = 2
        ElMessage.success('订单已取消')
      }
    } catch (err) {
      console.error('取消订单失败:', err)
    }
  }).catch(() => {})
}

function payOrder(order) {
  ElMessageBox.confirm(
    `<div style="margin-bottom:12px">请选择支付方式：</div>
     <div id="pay-type-select" style="display:flex;gap:12px;justify-content:center">
       <label style="cursor:pointer"><input type="radio" name="payType" value="balance" checked="checked"> 余额支付</label>
       <label style="cursor:pointer"><input type="radio" name="payType" value="wechat"> 微信支付</label>
       <label style="cursor:pointer"><input type="radio" name="payType" value="alipay"> 支付宝</label>
     </div>`,
    '支付订单',
    {
    confirmButtonText: '确认支付',
    cancelButtonText: '取消',
      dangerouslyUseHTMLString: true,
    }
  ).then(async () => {
    const checked = document.querySelector('input[name="payType"]:checked')
    const payType = checked?.value || 'balance'
    try {
      const res = await orderApi.pay(order.id, { payType })
      if (res.code === 200) {
        order.status = 1
        order.payType = payType
        order.payTime = new Date().toLocaleString()
        ElMessage.success('支付成功')
      }
    } catch (err) {
      ElMessage.error(err.response?.data?.message || '支付失败')
      console.error('支付失败:', err)
    }
  }).catch(() => {})
}

async function viewTicket(order) {
  currentTicket.value = order
  ticketVisible.value = true
  await nextTick()
  if (qrCanvas.value) {
    const qrContent = order.qrCode || order.orderNo
    await QRCode.toCanvas(qrCanvas.value, qrContent, {
      width: 200,
      margin: 2,
      color: { dark: '#1a1a1a', light: '#ffffff' }
    })
  }
}

onMounted(() => {
  if (authStore.isLoggedIn) {
    fetchOrders()
  }
})
</script>

<style scoped>
.orders-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); }
.status-tabs { display: flex; gap: 4px; margin-bottom: 20px; }
.status-tab { padding: 6px 16px; border-radius: 20px; border: 1px solid var(--color-border); background: var(--color-surface); color: var(--color-text-muted); cursor: pointer; font-size: 13px; transition: all .2s; }
.status-tab:hover { border-color: var(--color-primary); color: var(--color-text); }
.status-tab.active { background: var(--color-primary); border-color: var(--color-primary); color: #1a1a1a; font-weight: 600; }
.orders-list { display: flex; flex-direction: column; gap: 16px; }
.order-card { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); overflow: hidden; }
.order-header { display: flex; align-items: center; gap: 12px; padding: 12px 16px; border-bottom: 1px solid var(--color-border); background: var(--color-surface-2); }
.order-id { font-size: 13px; color: var(--color-text-muted); flex: 1; }
.order-time { font-size: 12px; color: var(--color-text-muted); }
.order-body { display: flex; align-items: flex-start; justify-content: space-between; padding: 16px; gap: 20px; }
.order-info { flex: 1; }
.order-movie { font-size: 16px; font-weight: 700; color: var(--color-text); margin-bottom: 6px; }
.order-meta { font-size: 13px; color: var(--color-text-muted); margin-bottom: 4px; }
.order-seats { margin: 8px 0; }
.order-price-section { display: flex; flex-direction: column; align-items: flex-end; gap: 10px; }
.order-price { font-size: 22px; font-weight: 700; color: var(--color-primary); }
.order-actions { display: flex; gap: 8px; }

/* 票券弹窗 */
.ticket-dialog-title { font-size: 16px; font-weight: 700; text-align: center; color: var(--color-text); }
.ticket-wrap { display: flex; flex-direction: column; align-items: center; padding: 8px 0 16px; }
.ticket-movie { font-size: 20px; font-weight: 700; color: var(--color-text); margin-bottom: 6px; text-align: center; }
.ticket-meta { font-size: 13px; color: var(--color-text-muted); margin-bottom: 2px; display: flex; gap: 8px; }
.ticket-showtime { font-size: 13px; color: var(--color-text-muted); margin-bottom: 4px; }
.ticket-qr-wrap { margin: 16px 0 12px; padding: 12px; background: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15); }
.ticket-qr { display: block; }
.ticket-code-label { font-size: 11px; color: var(--color-text-muted); margin-bottom: 6px; letter-spacing: 2px; text-transform: uppercase; }
.ticket-code { font-size: 16px; font-weight: 700; color: var(--color-text); letter-spacing: 2px; font-family: 'Courier New', monospace; background: var(--color-surface-2); padding: 8px 20px; border-radius: 8px; border: 1px dashed var(--color-border); margin-bottom: 14px; }
.ticket-tip { font-size: 12px; color: var(--color-text-muted); text-align: center; }
</style>
