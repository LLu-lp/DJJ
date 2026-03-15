<template>
  <div class="seat-page">
    <div class="seat-header">
      <el-button link @click="$router.back()" style="color:var(--color-text-muted)">
        <el-icon><ArrowLeft /></el-icon> 返回
      </el-button>
      <div class="show-info">
        <h2>{{ scheduleInfo.movieTitle }}</h2>
        <span>{{ scheduleInfo.cinemaName }} · {{ scheduleInfo.hallName }} · {{ scheduleInfo.showDate }} {{ scheduleInfo.startTime }}</span>
      </div>
    </div>

    <div class="seat-container">
      <!-- 座位区 -->
      <div class="seat-area">
        <!-- 屏幕 -->
        <div class="screen-wrap">
          <div class="screen">
            <span>— 银 幕 —</span>
          </div>
        </div>
        <!-- 图例 -->
        <div class="legend">
          <span class="legend-item"><span class="seat-demo available"></span>可选</span>
          <span class="legend-item"><span class="seat-demo selected"></span>已选</span>
          <span class="legend-item"><span class="seat-demo sold"></span>已售</span>
          <span class="legend-item"><span class="seat-demo vip"></span>VIP</span>
        </div>
        <!-- 座位图 -->
        <div class="seat-grid" v-loading="loadingSeats">
          <div v-for="(row, ri) in seatMap" :key="ri" class="seat-row">
            <span class="row-label">{{ String.fromCharCode(65 + ri) }}</span>
            <div
              v-for="(seat, ci) in row"
              :key="`${ri}-${ci}`"
              class="seat"
              :class="[seat ? seat.status : 'empty', seat ? seat.type : '', { selected: seat && isSelected(ri, ci) }]"
              @click="seat && selectSeat(ri, ci, seat)"
            >
              <span class="seat-number" v-if="seat">{{ ci + 1 }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧订单面板 -->
      <div class="order-panel">
        <h3 class="panel-title">购票信息</h3>
        <div class="panel-info">
          <p class="info-row"><span>影片</span><strong>{{ scheduleInfo.movieTitle }}</strong></p>
          <p class="info-row"><span>影院</span><span>{{ scheduleInfo.cinemaName }}</span></p>
          <p class="info-row"><span>影厅</span><span>{{ scheduleInfo.hallName }}</span></p>
          <p class="info-row"><span>场次</span><span>{{ scheduleInfo.showDate }} {{ scheduleInfo.startTime }}</span></p>
          <p class="info-row"><span>票价</span><strong style="color:var(--color-primary)">¥{{ scheduleInfo.price }}/张</strong></p>
        </div>

        <!-- 已选座位 -->
        <div class="selected-seats">
          <p class="selected-label">已选座位（{{ selectedSeats.length }}/4）</p>
          <div class="seat-tags">
            <el-tag
              v-for="s in selectedSeats"
              :key="s.seatNo"
              closable
              @close="removeSelected(s)"
              class="seat-tag"
            >
              {{ s.seatNo }}
            </el-tag>
            <span v-if="selectedSeats.length === 0" class="no-seat">点击左侧选座</span>
          </div>
        </div>

        <!-- 小吃选购 -->
        <div class="snack-section">
          <p class="selected-label">添加小吃</p>
          <div class="snack-items">
            <div v-for="snack in snacks" :key="snack.id" class="snack-item">
              <span class="snack-name">{{ snack.name }}</span>
              <span class="snack-price">¥{{ snack.price }}</span>
              <el-input-number v-model="snack.qty" :min="0" :max="5" size="small" style="width:90px" />
            </div>
          </div>
        </div>

        <!-- 优惠券选择 -->
        <div class="coupon-section">
          <p class="selected-label">优惠券</p>
          <el-select 
            v-model="selectedCouponId" 
            placeholder="选择优惠券" 
            clearable 
            style="width:100%"
            size="small"
            @change="calculateDiscount"
          >
            <el-option
              v-for="coupon in availableCoupons"
              :key="coupon.id"
              :label="`${coupon.couponName} - ${coupon.discountType === 1 ? '¥' + coupon.discountValue : (coupon.discountValue * 10).toFixed(1) + '折'}`"
              :value="coupon.id"
              :disabled="originalAmount < coupon.minAmount"
            >
              <div style="display:flex;justify-content:space-between;align-items:center">
                <span>{{ coupon.couponName }}</span>
                <span style="color:var(--color-primary);font-size:12px">
                  {{ coupon.discountType === 1 ? '¥' + coupon.discountValue : (coupon.discountValue * 10).toFixed(1) + '折' }}
                </span>
              </div>
              <div style="font-size:11px;color:var(--color-text-muted)">
                满{{ coupon.minAmount }}元可用
              </div>
            </el-option>
          </el-select>
        </div>

        <!-- 总价 -->
        <div class="total-section">
          <div class="price-detail">
            <div class="price-row">
              <span>原价</span>
              <span>¥{{ originalAmount }}</span>
            </div>
            <div class="price-row" v-if="discountAmount > 0">
              <span style="color:var(--color-primary)">优惠</span>
              <span style="color:var(--color-primary)">-¥{{ discountAmount }}</span>
            </div>
          </div>
          <div class="final-price">
            <span>实付</span>
            <span class="total-amount">¥{{ finalAmount }}</span>
          </div>
        </div>

        <el-button
          type="primary"
          size="large"
          style="width:100%"
          :disabled="selectedSeats.length === 0"
          :loading="submitting"
          @click="submitOrder"
        >
          确认下单
        </el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { orderApi, scheduleApi, snackApi, couponApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const loadingSeats = ref(false)
const submitting = ref(false)
const scheduleInfo = ref({})
const selectedSeats = ref([])
const snacks = ref([])
const seatMap = ref([])
const availableCoupons = ref([])
const selectedCouponId = ref(null)
const discountAmount = ref(0)

// 原价（票价+小吃）
const originalAmount = computed(() => {
  const ticketTotal = selectedSeats.value.reduce((sum, s) => sum + (s.price || scheduleInfo.value.price || 0), 0)
  const snackTotal = snacks.value.reduce((sum, s) => sum + s.qty * s.price, 0)
  return (ticketTotal + snackTotal).toFixed(2)
})

// 实付金额
const finalAmount = computed(() => {
  return (originalAmount.value - discountAmount.value).toFixed(2)
})

// 监听原价变化，重新计算优惠
watch(originalAmount, () => {
  if (selectedCouponId.value) {
    calculateDiscount()
  }
})

onMounted(async () => {
  const scheduleId = route.params.scheduleId
  await fetchScheduleDetail(scheduleId)
  await fetchSeats(scheduleId)
  await fetchSnacks()
  await fetchAvailableCoupons()
})

const fetchScheduleDetail = async (scheduleId) => {
  try {
    const res = await scheduleApi.getDetail(scheduleId)
    if (res.code === 200) {
      scheduleInfo.value = res.data || {}
    }
  } catch (err) {
    console.error('获取场次详情失败:', err)
  }
}

const fetchSeats = async (scheduleId) => {
  loadingSeats.value = true
  try {
    const res = await scheduleApi.getSeats(scheduleId)
    if (res.code === 200) {
      const seats = res.data || []
      // 将座位列表转换为二维数组
      if (seats.length > 0) {
        const maxRow = Math.max(...seats.map(s => s.rowNum))
        const maxCol = Math.max(...seats.map(s => s.colNum))
        
        // 初始化二维数组
        const map = Array.from({ length: maxRow }, () => Array(maxCol).fill(null))
        
        // 填充座位数据
        seats.forEach(seat => {
          const row = seat.rowNum - 1
          const col = seat.colNum - 1
          map[row][col] = {
            id: seat.seatId,
            seatNo: seat.seatLabel,
            status: seat.status === 0 ? 'available' : seat.status === 2 ? 'locked' : 'sold',
            type: seat.seatType === 1 ? 'vip' : seat.seatType === 2 ? 'couple' : 'normal',
            price: seat.price
          }
        })
        
        seatMap.value = map
      }
    }
  } catch (err) {
    console.error('获取座位信息失败:', err)
  } finally {
    loadingSeats.value = false
  }
}

const fetchSnacks = async () => {
  try {
    const res = await snackApi.getList({ size: 4 })
    if (res.code === 200) {
      snacks.value = (res.data?.records || res.data || []).map(s => ({ ...s, qty: 0 }))
    }
  } catch (err) {
    console.error('获取小食列表失败:', err)
  }
}

const fetchAvailableCoupons = async () => {
  if (!authStore.isLoggedIn) return
  try {
    const res = await couponApi.getMyCoupons(0) // 0 = 未使用
    if (res.code === 200) {
      availableCoupons.value = res.data || []
    }
  } catch (err) {
    console.error('获取优惠券失败:', err)
  }
}

const calculateDiscount = () => {
  if (!selectedCouponId.value) {
    discountAmount.value = 0
    return
  }
  
  const coupon = availableCoupons.value.find(c => c.id === selectedCouponId.value)
  if (!coupon) {
    discountAmount.value = 0
    return
  }
  
  const amount = parseFloat(originalAmount.value)
  
  // 检查是否满足最低消费
  if (amount < coupon.minAmount) {
    ElMessage.warning(`该优惠券需满${coupon.minAmount}元才能使用`)
    selectedCouponId.value = null
    discountAmount.value = 0
    return
  }
  
  // 计算优惠金额
  if (coupon.discountType === 1) {
    // 满减券
    discountAmount.value = parseFloat(coupon.discountValue).toFixed(2)
  } else {
    // 折扣券
    const discount = amount * (1 - coupon.discountValue)
    discountAmount.value = discount.toFixed(2)
  }
}

function isSelected(ri, ci) {
  return selectedSeats.value.some(s => s.rowIndex === ri && s.colIndex === ci)
}

function selectSeat(ri, ci, seat) {
  if (seat.status === 'sold') return
  const idx = selectedSeats.value.findIndex(s => s.rowIndex === ri && s.colIndex === ci)
  if (idx >= 0) {
    selectedSeats.value.splice(idx, 1)
  } else {
    if (selectedSeats.value.length >= 4) return ElMessage.warning('最多选择4个座位')
    const price = seat.type === 'vip' ? (scheduleInfo.value.vipPrice || scheduleInfo.value.price) : scheduleInfo.value.price
    selectedSeats.value.push({ 
      rowIndex: ri, 
      colIndex: ci, 
      seatId: seat.id,
      seatNo: seat.seatNo || `${String.fromCharCode(65 + ri)}${ci + 1}`,
      price: price
    })
  }
}

function removeSelected(seat) {
  const idx = selectedSeats.value.findIndex(s => s.rowIndex === seat.rowIndex && s.colIndex === seat.colIndex)
  if (idx >= 0) selectedSeats.value.splice(idx, 1)
}

async function submitOrder() {
  if (!authStore.isLoggedIn) return router.push('/login')
  if (selectedSeats.value.length === 0) return ElMessage.warning('请选择座位')
  
  submitting.value = true
  try {
    const orderData = {
      scheduleId: Number(route.params.scheduleId),
      seatIds: selectedSeats.value.map(s => s.seatId),
      snacks: snacks.value.filter(s => s.qty > 0).map(s => ({ snackId: s.id, quantity: s.qty })),
      couponId: selectedCouponId.value || undefined
    }
    
    const res = await orderApi.create(orderData)
    if (res.code === 200) {
      ElMessage.success('下单成功！正在跳转支付...')
      setTimeout(() => router.push('/orders'), 1500)
    }
  } catch (err) {
    console.error('下单失败:', err)
    ElMessage.error(err.response?.data?.message || '下单失败，请重试')
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.seat-page { padding-bottom: 40px; }
.seat-header { display: flex; align-items: center; gap: 20px; margin-bottom: 24px; }
.show-info h2 { font-size: 18px; font-weight: 700; color: var(--color-text); }
.show-info span { font-size: 13px; color: var(--color-text-muted); }
.seat-container { display: flex; gap: 24px; align-items: flex-start; }
.seat-area { flex: 1; }
.screen-wrap { text-align: center; margin-bottom: 20px; }
.screen { display: inline-block; padding: 8px 60px; background: linear-gradient(to bottom, rgba(232,184,75,0.3), rgba(232,184,75,0.05)); border-top: 2px solid var(--color-primary); border-radius: 50% 50% 0 0; color: var(--color-primary); font-size: 12px; letter-spacing: 4px; }
.legend { display: flex; justify-content: center; gap: 20px; margin-bottom: 16px; }
.legend-item { display: flex; align-items: center; gap: 6px; font-size: 12px; color: var(--color-text-muted); }
.seat-demo { display: inline-block; width: 16px; height: 16px; border-radius: 3px; }
.seat-demo.available { background: var(--color-surface-2); border: 1px solid var(--color-border); }
.seat-demo.selected { background: var(--color-primary); }
.seat-demo.sold { background: #444; }
.seat-demo.vip { background: rgba(74,144,217,0.3); border: 1px solid var(--color-info); }
.seat-grid { overflow-x: auto; display: flex; flex-direction: column; align-items: center; }
.seat-row { display: flex; align-items: center; gap: 6px; margin-bottom: 6px; justify-content: center; }
.row-label { width: 20px; text-align: center; font-size: 12px; color: var(--color-text-muted); flex-shrink: 0; }
.seat { width: 32px; height: 28px; border-radius: 4px 4px 2px 2px; border: 1px solid var(--color-border); background: var(--color-surface-2); display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all .15s; flex-shrink: 0; }
.seat .seat-number { font-size: 10px; color: var(--color-text-muted); }
.seat.available:hover { border-color: var(--color-primary); background: var(--color-primary-light); }
.seat.selected { background: var(--color-primary) !important; border-color: var(--color-primary) !important; }
.seat.selected .seat-number { color: #1a1a1a; }
.seat.sold { background: #2a2a2a !important; border-color: #333 !important; cursor: not-allowed; opacity: 0.5; }
.seat.vip { border-color: rgba(74,144,217,0.5); background: rgba(74,144,217,0.15); }
.order-panel { width: 300px; flex-shrink: 0; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); padding: 20px; position: sticky; top: 80px; }
.panel-title { font-size: 16px; font-weight: 700; color: var(--color-text); margin-bottom: 16px; }
.panel-info { margin-bottom: 16px; border-bottom: 1px solid var(--color-border); padding-bottom: 16px; }
.info-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; font-size: 13px; color: var(--color-text-muted); }
.info-row strong { color: var(--color-text); }
.selected-label { font-size: 13px; color: var(--color-text-muted); margin-bottom: 8px; }
.seat-tags { display: flex; flex-wrap: wrap; gap: 6px; min-height: 32px; }
.seat-tag { background: var(--color-primary-light) !important; border-color: rgba(232,184,75,0.3) !important; color: var(--color-primary) !important; }
.no-seat { font-size: 12px; color: var(--color-text-muted); }
.selected-seats { margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid var(--color-border); }
.snack-section { margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid var(--color-border); }
.snack-items { display: flex; flex-direction: column; gap: 8px; }
.snack-item { display: flex; align-items: center; gap: 8px; font-size: 12px; }
.snack-name { flex: 1; color: var(--color-text); }
.snack-price { color: var(--color-primary); min-width: 40px; text-align: right; }
.coupon-section { margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid var(--color-border); }
.total-section { margin-bottom: 16px; }
.price-detail { margin-bottom: 8px; }
.price-row { display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: var(--color-text-muted); margin-bottom: 4px; }
.final-price { display: flex; justify-content: space-between; align-items: center; padding-top: 8px; border-top: 1px dashed var(--color-border); }
.total-amount { font-size: 24px; font-weight: 700; color: var(--color-primary); }
</style>
