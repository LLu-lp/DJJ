<template>
  <div class="digital-tickets-page">
    <div class="page-header">
      <h1 class="page-title">数字纪念票</h1>
      <p class="page-subtitle">每一张票，都是一段专属的观影记忆</p>
    </div>

    <div class="tickets-grid" v-loading="loading">
      <div
        v-for="ticket in tickets"
        :key="ticket.id"
        class="ticket-card"
        @click="viewTicket(ticket)"
      >
        <div class="ticket-poster-wrap">
          <img
            :src="ticket.moviePoster || `https://picsum.photos/seed/${ticket.id}/400/600`"
            :alt="ticket.movieTitle"
            class="ticket-poster"
          />
          <div class="ticket-stamp">
            <span class="stamp-text">已观影</span>
          </div>
          <div class="ticket-shine"></div>
        </div>
        <div class="ticket-body">
          <div class="ticket-perforations">
            <span v-for="n in 8" :key="n" class="perforation"></span>
          </div>
          <div class="ticket-info">
            <h3 class="ticket-movie">{{ ticket.movieTitle }}</h3>
            <div class="ticket-details">
              <div class="detail-row">
                <span class="detail-label">影院</span>
                <span class="detail-value">{{ ticket.cinemaName || '佳悦影院' }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">时间</span>
                <span class="detail-value">{{ ticket.showTime || '-' }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">座位</span>
                <span class="detail-value">{{ formatSeats(ticket.seats) }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">订单</span>
                <span class="detail-value order-no">{{ ticket.orderNo }}</span>
              </div>
            </div>
          </div>
          <div class="ticket-footer">
            <div class="ticket-date">{{ formatDate(ticket.payTime || ticket.createdAt) }}</div>
            <el-button size="small" type="primary" plain @click.stop="viewTicket(ticket)">
              查看详情
            </el-button>
          </div>
        </div>
      </div>
    </div>

    <el-empty
      v-if="tickets.length === 0 && !loading"
      description="暂无数字纪念票，快去购票观影吧"
    />

    <!-- 纪念票详情弹窗 -->
    <el-dialog
      v-model="dialogVisible"
      width="400px"
      :show-close="true"
      center
    >
      <template #header>
        <div class="dialog-title">✦ 数字纪念票 ✦</div>
      </template>
      <div v-if="currentTicket" class="ticket-detail">
        <div class="detail-poster-wrap">
          <img
            :src="currentTicket.moviePoster || `https://picsum.photos/seed/${currentTicket.id}/400/600`"
            :alt="currentTicket.movieTitle"
            class="detail-poster"
          />
          <div class="detail-overlay">
            <h2 class="detail-movie-title">{{ currentTicket.movieTitle }}</h2>
          </div>
        </div>
        <div class="detail-perforations">
          <span v-for="n in 12" :key="n" class="perforation"></span>
        </div>
        <div class="detail-info">
          <div class="detail-row">
            <span class="detail-label">影院</span>
            <span class="detail-value">{{ currentTicket.cinemaName || '佳悦影院' }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">影厅</span>
            <span class="detail-value">{{ currentTicket.hallName || '-' }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">场次</span>
            <span class="detail-value">{{ currentTicket.showTime || '-' }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">座位</span>
            <span class="detail-value">{{ formatSeats(currentTicket.seats) }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">票价</span>
            <span class="detail-value price">¥{{ currentTicket.ticketAmount }}</span>
          </div>
        </div>
        <div class="detail-qr-section">
          <canvas ref="qrCanvas" class="detail-qr"></canvas>
          <div class="detail-order-no">{{ currentTicket.orderNo }}</div>
        </div>
        <div class="detail-footer">
          <span class="detail-date">{{ formatDate(currentTicket.payTime || currentTicket.createdAt) }}</span>
          <span class="detail-badge">JIAYUE CINEMA</span>
        </div>
      </div>
      <template #footer>
        <div style="display:flex;gap:8px;justify-content:center">
          <el-button @click="dialogVisible = false">关闭</el-button>
          <el-button type="primary" @click="shareTicket">分享纪念票</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { orderApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { ElMessage } from 'element-plus'
import QRCode from 'qrcode'
import { nextTick, onMounted, ref } from 'vue'

const authStore = useAuthStore()
const loading = ref(false)
const tickets = ref([])
const dialogVisible = ref(false)
const currentTicket = ref(null)
const qrCanvas = ref(null)

const fetchTickets = async () => {
  loading.value = true
  try {
    const res = await orderApi.getMyOrders({ size: 100, status: 1 })
    if (res.code === 200) {
      const allOrders = res.data?.records || []
      // 只取已支付且有座位的订单作为纪念票（排除纯小吃订单）
      tickets.value = allOrders.filter(o => o.status === 1 && o.seats && o.seats.length > 0)
    }
  } catch (err) {
    console.error('获取纪念票失败:', err)
    ElMessage.error('获取纪念票失败')
  } finally {
    loading.value = false
  }
}

const viewTicket = async (ticket) => {
  currentTicket.value = ticket
  dialogVisible.value = true
  await nextTick()
  if (qrCanvas.value) {
    try {
      await QRCode.toCanvas(qrCanvas.value, ticket.orderNo, {
        width: 160,
        margin: 1,
        color: { dark: '#1a1a1a', light: '#ffffff' }
      })
    } catch (e) {
      console.error('生成二维码失败:', e)
    }
  }
}

const shareTicket = () => {
  const text = `我在佳悦影院观看了《${currentTicket.value?.movieTitle}》！订单号：${currentTicket.value?.orderNo}`
  if (navigator.share) {
    navigator.share({
      title: `${currentTicket.value?.movieTitle} - 数字纪念票`,
      text,
      url: window.location.href
    }).catch(() => {})
  } else {
    navigator.clipboard.writeText(text).then(() => {
      ElMessage.success('纪念票信息已复制到剪贴板')
    }).catch(() => {
      ElMessage.info('请截图保存您的纪念票')
    })
  }
}

const formatSeats = (seats) => {
  if (!seats || seats.length === 0) return '-'
  return seats.map(s => s.seatLabel).join('、')
}

const formatDate = (dateStr) => {
  if (!dateStr) return ''
  const d = new Date(dateStr)
  if (isNaN(d.getTime())) return dateStr
  return `${d.getFullYear()}.${String(d.getMonth() + 1).padStart(2, '0')}.${String(d.getDate()).padStart(2, '0')}`
}

onMounted(() => {
  if (authStore.isLoggedIn) fetchTickets()
})
</script>

<style scoped>
.digital-tickets-page {
  padding-bottom: 60px;
}

.page-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 24px 0 0;
}

.page-title {
  font-size: 26px;
  font-weight: 800;
  color: var(--color-text);
  margin-bottom: 8px;
  letter-spacing: 3px;
}

.page-subtitle {
  font-size: 13px;
  color: var(--color-text-muted);
  letter-spacing: 1px;
}

.tickets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 24px;
}

.ticket-card {
  border-radius: 16px;
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
  box-shadow: 0 4px 24px rgba(0,0,0,0.15);
  background: #16213e;
}

.ticket-card:hover {
  transform: translateY(-6px) rotate(-0.8deg);
  box-shadow: 0 16px 48px rgba(0,0,0,0.28);
}

.ticket-poster-wrap {
  position: relative;
  height: 190px;
  overflow: hidden;
}

.ticket-poster {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s;
}

.ticket-card:hover .ticket-poster {
  transform: scale(1.06);
}

.ticket-stamp {
  position: absolute;
  top: 14px;
  right: 14px;
  width: 52px;
  height: 52px;
  border: 2.5px solid rgba(255, 80, 80, 0.9);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: rotate(-15deg);
  background: rgba(255, 80, 80, 0.12);
  backdrop-filter: blur(4px);
}

.stamp-text {
  font-size: 9px;
  font-weight: 800;
  color: rgba(255, 90, 90, 0.95);
  letter-spacing: 0.5px;
  text-align: center;
}

.ticket-shine {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, transparent 55%);
  pointer-events: none;
}

.ticket-body {
  background: #16213e;
  padding-bottom: 16px;
}

.ticket-perforations {
  display: flex;
  justify-content: space-between;
  padding: 0 -6px;
  margin: 0 -6px 14px;
  position: relative;
}

.ticket-perforations::before,
.detail-perforations::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 8px;
  right: 8px;
  border-top: 1.5px dashed rgba(255,255,255,0.12);
  transform: translateY(-50%);
}

.perforation {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--color-bg, #f0f2f5);
  flex-shrink: 0;
  position: relative;
  z-index: 1;
}

.ticket-info {
  padding: 0 16px;
}

.ticket-movie {
  font-size: 16px;
  font-weight: 700;
  color: #f0e6d3;
  margin-bottom: 10px;
  letter-spacing: 0.5px;
}

.ticket-details {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.detail-row {
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.detail-label {
  font-size: 10px;
  color: rgba(240, 230, 211, 0.4);
  letter-spacing: 1px;
  width: 28px;
  flex-shrink: 0;
}

.detail-value {
  font-size: 12px;
  color: rgba(240, 230, 211, 0.75);
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.order-no {
  font-family: 'Courier New', monospace;
  font-size: 10px;
  color: rgba(240, 230, 211, 0.4);
}

.ticket-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px 0;
  margin-top: 10px;
  border-top: 1px dashed rgba(255,255,255,0.08);
}

.ticket-date {
  font-size: 10px;
  color: rgba(240, 230, 211, 0.35);
  letter-spacing: 1px;
}

/* 弹窗 */
.dialog-title {
  font-size: 16px;
  font-weight: 700;
  text-align: center;
  letter-spacing: 4px;
  color: var(--color-text);
}

.ticket-detail {
  background: #16213e;
  border-radius: 12px;
  overflow: hidden;
  color: #f0e6d3;
}

.detail-poster-wrap {
  position: relative;
  height: 160px;
  overflow: hidden;
}

.detail-poster {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.detail-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(22,33,62,0.96) 0%, transparent 50%);
  display: flex;
  align-items: flex-end;
  padding: 14px 16px;
}

.detail-movie-title {
  font-size: 18px;
  font-weight: 800;
  color: #f0e6d3;
  margin: 0;
}

.detail-perforations {
  display: flex;
  justify-content: space-between;
  margin: 0 -6px;
  position: relative;
}

.detail-info {
  padding: 14px 20px;
  display: flex;
  flex-direction: column;
  gap: 7px;
}

.detail-info .detail-label {
  width: 34px;
  font-size: 11px;
}

.detail-info .detail-value {
  font-size: 13px;
  color: rgba(240, 230, 211, 0.85);
}

.detail-info .price {
  color: #f5c842;
  font-weight: 700;
  font-size: 15px;
}

.detail-qr-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 12px 0 8px;
  border-top: 1px dashed rgba(255,255,255,0.1);
  margin: 0 16px;
}

.detail-qr {
  border-radius: 8px;
  display: block;
}

.detail-order-no {
  font-family: 'Courier New', monospace;
  font-size: 11px;
  color: rgba(240, 230, 211, 0.4);
  margin-top: 6px;
  letter-spacing: 1.5px;
}

.detail-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px 16px;
}

.detail-date {
  font-size: 11px;
  color: rgba(240, 230, 211, 0.35);
  letter-spacing: 1px;
}

.detail-badge {
  font-size: 10px;
  font-weight: 700;
  color: rgba(240, 230, 211, 0.3);
  letter-spacing: 2px;
}

@media (max-width: 768px) {
  .tickets-grid {
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 16px;
  }
}
</style>
