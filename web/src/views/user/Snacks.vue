<template>
  <div class="snacks-page">
    <div class="page-header">
      <h1 class="page-title">小吃零食</h1>
      <div class="header-right">
        <el-select v-model="selectedCategory" placeholder="全部分类" clearable style="width:140px" @change="fetchSnacks">
          <el-option v-for="c in categories" :key="c" :label="c" :value="c" />
        </el-select>
        <el-badge :value="cartCount" class="cart-badge">
          <el-button @click="showCart = true"><el-icon><ShoppingCart /></el-icon> 购物车</el-button>
        </el-badge>
      </div>
    </div>

    <!-- 场次选择提示 -->
    <div class="schedule-selector" v-if="!selectedScheduleId">
      <el-alert
        title="请先选择电影场次"
        type="warning"
        description="小吃需要在确定的影院购买，请先选择一个电影场次"
        :closable="false"
        style="margin-bottom:16px"
      />
      <el-button type="primary" @click="showScheduleDialog = true">选择场次</el-button>
    </div>

    <!-- 已选场次显示 -->
    <div class="selected-schedule" v-else>
      <el-alert
        :title="`已选场次：${selectedScheduleInfo.movieTitle} - ${selectedScheduleInfo.cinemaName}`"
        type="success"
        :closable="false"
        style="margin-bottom:16px"
      >
        <template #default>
          <div style="font-size:12px">
            {{ selectedScheduleInfo.showDate }} {{ selectedScheduleInfo.startTime }} · {{ selectedScheduleInfo.hallName }}
            <el-button link size="small" @click="selectedScheduleId = null; selectedScheduleInfo = {}">更换</el-button>
          </div>
        </template>
      </el-alert>
    </div>
    <div class="snacks-grid" v-loading="loading" v-if="selectedScheduleId">
      <div v-for="snack in snacks" :key="snack.id" class="snack-card">
        <img :src="snack.image || `https://picsum.photos/seed/snack${snack.id}/200/200`" :alt="snack.name" class="snack-img" />
        <div class="snack-info">
          <h3 class="snack-name">{{ snack.name }}</h3>
          <el-tag size="small" type="info" style="margin-bottom:8px">{{ snack.category }}</el-tag>
          <div class="snack-price-row">
            <div>
              <span class="snack-price">¥{{ snack.price }}</span>
              <span v-if="snack.cost && snack.cost < snack.price" class="snack-original">¥{{ snack.cost }}</span>
            </div>
            <div class="snack-qty">
              <el-button circle size="small" @click="changeQty(snack, -1)" :disabled="getQty(snack.id) === 0">
                <el-icon><Minus /></el-icon>
              </el-button>
              <span class="qty-num">{{ getQty(snack.id) }}</span>
              <el-button circle size="small" type="primary" @click="changeQty(snack, 1)" :disabled="snack.stock !== null && getQty(snack.id) >= snack.stock">
                <el-icon><Plus /></el-icon>
              </el-button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <el-empty v-if="snacks.length === 0 && !loading" description="暂无小食商品" />

    <!-- 购物车抽屉 -->
    <el-drawer v-model="showCart" title="购物车" direction="rtl" size="360px">
      <div v-if="cartItems.length > 0">
        <div v-for="item in cartItems" :key="item.id" class="cart-item">
          <img :src="item.image || `https://picsum.photos/seed/snack${item.id}/100/100`" :alt="item.name" class="cart-img" />
          <div class="cart-info">
            <p class="cart-name">{{ item.name }}</p>
            <p class="cart-price">¥{{ item.price }}</p>
          </div>
          <el-input-number v-model="item.qty" :min="0" :max="item.stock || 10" size="small" style="width:100px" @change="updateCart(item)" />
        </div>

        <!-- 优惠券选择 -->
        <div class="cart-coupon">
          <p class="cart-section-title">选择优惠券</p>
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
              :disabled="parseFloat(cartTotal) < coupon.minAmount"
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

        <!-- 价格明细 -->
        <div class="cart-total">
          <div class="price-row">
            <span>原价</span>
            <span>¥{{ cartTotal }}</span>
          </div>
          <div class="price-row" v-if="discountAmount > 0">
            <span style="color:var(--color-primary)">优惠</span>
            <span style="color:var(--color-primary)">-¥{{ discountAmount }}</span>
          </div>
          <div class="final-price">
            <span>实付</span>
            <span class="total-price">¥{{ finalAmount }}</span>
          </div>
        </div>
        <div style="margin-bottom:12px;padding:12px;background:var(--color-surface-2);border-radius:6px;font-size:12px;color:var(--color-text-muted)">
          <p style="margin:0 0 4px">场次：{{ selectedScheduleInfo.movieTitle }}</p>
          <p style="margin:0 0 4px">影院：{{ selectedScheduleInfo.cinemaName }}</p>
          <p style="margin:0">时间：{{ selectedScheduleInfo.showDate }} {{ selectedScheduleInfo.startTime }}</p>
        </div>
        <el-button type="primary" style="width:100%;margin-top:12px" :loading="submitting" @click="submitCart">
          立即结算（到店自提）
        </el-button>
      </div>
      <el-empty v-else description="购物车空空如也" />
    </el-drawer>

    <!-- 场次选择对话框 -->
    <el-dialog v-model="showScheduleDialog" title="选择电影场次" width="70%">
      <div class="schedule-list" v-loading="loadingSchedules">
        <div v-for="schedule in availableSchedules" :key="schedule.id" class="schedule-item" @click="selectSchedule(schedule)">
          <div class="schedule-main">
            <h4>{{ schedule.movieTitle }}</h4>
            <p class="schedule-time">{{ schedule.showDate }} {{ schedule.startTime }}</p>
            <p class="schedule-cinema">{{ schedule.cinemaName }} · {{ schedule.hallName }}</p>
          </div>
          <div class="schedule-price">
            <span class="price">¥{{ schedule.price }}</span>
            <span class="seats">余{{ schedule.availableSeats }}座</span>
          </div>
        </div>
      </div>
      <el-empty v-if="availableSchedules.length === 0 && !loadingSchedules" description="暂无可用场次" />
    </el-dialog>
  </div>
</template>

<script setup>
import { orderApi, snackApi, couponApi, scheduleApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { Minus, Plus, ShoppingCart } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref, watch } from 'vue'

const authStore = useAuthStore()
const loading = ref(false)
const submitting = ref(false)
const snacks = ref([])
const categories = ['爆米花', '饮品', '小食', '套餐']
const selectedCategory = ref('')
const showCart = ref(false)
const cart = ref({})
const showScheduleDialog = ref(false)
const loadingSchedules = ref(false)
const availableSchedules = ref([])
const selectedScheduleId = ref(null)
const selectedScheduleInfo = ref({})

// 计算属性需要在使用前定义
const cartItems = computed(() =>
  snacks.value.filter(s => cart.value[s.id] > 0).map(s => ({ ...s, qty: cart.value[s.id] }))
)
const cartCount = computed(() => Object.values(cart.value).reduce((a, b) => a + b, 0))
const cartTotal = computed(() => cartItems.value.reduce((sum, s) => sum + s.qty * s.price, 0).toFixed(2))

const availableCoupons = ref([])
const selectedCouponId = ref(null)
const discountAmount = ref(0)
const finalAmount = computed(() => (cartTotal.value - discountAmount.value).toFixed(2))

const fetchSnacks = async () => {
  loading.value = true
  try {
    const res = await snackApi.getList({ 
      category: selectedCategory.value || undefined,
      size: 50 
    })
    if (res.code === 200) {
      snacks.value = res.data?.records || res.data || []
    }
  } catch (err) {
    console.error('获取小食列表失败:', err)
  } finally {
    loading.value = false
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
  
  const amount = parseFloat(cartTotal.value)
  
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

onMounted(() => {
  fetchSnacks()
  fetchAvailableCoupons()
  // 不在 onMounted 时加载场次，等用户点击按钮时再加载
})

// 监听购物车打开，加载优惠券
watch(showCart, (isOpen) => {
  if (isOpen && authStore.isLoggedIn) {
    fetchAvailableCoupons()
  }
})

// 监听对话框打开，加载场次
watch(showScheduleDialog, (isOpen) => {
  if (isOpen) {
    fetchAvailableSchedules()
  }
})

// 监听购物车总价变化，重新计算优惠
watch(cartTotal, () => {
  if (selectedCouponId.value) {
    calculateDiscount()
  }
})

function getQty(id) { return cart.value[id] || 0 }

function changeQty(snack, delta) {
  const cur = cart.value[snack.id] || 0
  const next = Math.max(0, cur + delta)
  if (next === 0) delete cart.value[snack.id]
  else cart.value[snack.id] = next
}

function updateCart(item) {
  if (item.qty <= 0) {
    delete cart.value[item.id]
  } else {
    cart.value[item.id] = item.qty
  }
}

const fetchAvailableSchedules = async () => {
  loadingSchedules.value = true
  try {
    const today = new Date().toISOString().split('T')[0]
    console.log('正在获取场次，日期:', today)
    const res = await scheduleApi.getPage({ showDate: today, size: 100 })
    console.log('场次 API 完整响应:', res)
    console.log('res.code:', res.code)
    console.log('res.data:', res.data)
    
    if (res.code === 200) {
      // 处理分页数据
      let schedules = []
      if (res.data?.records) {
        schedules = res.data.records
      } else if (Array.isArray(res.data)) {
        schedules = res.data
      }
      
      console.log('提取的场次数据:', schedules)
      availableSchedules.value = schedules
      console.log('可用场次数量:', availableSchedules.value.length)
      
      if (schedules.length === 0) {
        ElMessage.info('今天暂无可购票的场次')
      }
    } else {
      console.error('API 返回错误码:', res.code, res.message)
      ElMessage.error(res.message || '获取场次失败')
    }
  } catch (err) {
    console.error('获取场次异常:', err)
    ElMessage.error('获取场次失败，请检查网络连接')
  } finally {
    loadingSchedules.value = false
  }
}

const selectSchedule = (schedule) => {
  selectedScheduleId.value = schedule.id
  selectedScheduleInfo.value = schedule
  showScheduleDialog.value = false
}

async function submitCart() {
  if (cartItems.value.length === 0) return
  
  if (!authStore.isLoggedIn) {
    ElMessage.warning('请先登录')
    return
  }
  
  if (!selectedScheduleId.value) {
    ElMessage.warning('请先选择电影场次')
    return
  }
  
  submitting.value = true
  try {
    const orderData = {
      scheduleId: selectedScheduleId.value,
      seatIds: [],
      snacks: cartItems.value.map(s => ({ snackId: s.id, quantity: s.qty })),
      couponId: selectedCouponId.value || undefined
    }
    const res = await orderApi.create(orderData)
    if (res.code === 200) {
      ElMessage.success('下单成功！凭票到店自提')
      cart.value = {}
      selectedCouponId.value = null
      discountAmount.value = 0
      showCart.value = false
    }
  } catch (err) {
    console.error('下单失败:', err)
    ElMessage.error(err.response?.data?.message || '下单失败')
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.snacks-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); }
.header-right { display: flex; align-items: center; gap: 12px; }
.schedule-selector { margin-bottom: 24px; }
.selected-schedule { margin-bottom: 24px; }
.schedule-list { display: flex; flex-direction: column; gap: 12px; max-height: 400px; overflow-y: auto; }
.schedule-item { display: flex; align-items: center; justify-content: space-between; padding: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); cursor: pointer; transition: all .2s; }
.schedule-item:hover { border-color: var(--color-primary); background: var(--color-primary-light); }
.schedule-main h4 { font-size: 14px; font-weight: 600; color: var(--color-text); margin: 0 0 6px; }
.schedule-time { font-size: 13px; color: var(--color-text-muted); margin: 0 0 4px; }
.schedule-cinema { font-size: 12px; color: var(--color-text-muted); margin: 0; }
.schedule-price { text-align: right; }
.price { display: block; font-size: 16px; font-weight: 700; color: var(--color-primary); margin-bottom: 4px; }
.seats { display: block; font-size: 12px; color: var(--color-text-muted); }
.snacks-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 16px; }
.snack-card { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); overflow: hidden; transition: border-color .2s, transform .2s; }
.snack-card:hover { border-color: var(--color-primary); transform: translateY(-3px); }
.snack-img { width: 100%; height: 160px; object-fit: cover; }
.snack-info { padding: 12px; }
.snack-name { font-size: 14px; font-weight: 600; color: var(--color-text); margin-bottom: 6px; }
.snack-price-row { display: flex; align-items: center; justify-content: space-between; }
.snack-price { font-size: 18px; font-weight: 700; color: var(--color-primary); }
.snack-original { font-size: 12px; color: var(--color-text-muted); text-decoration: line-through; margin-left: 6px; }
.snack-qty { display: flex; align-items: center; gap: 8px; }
.qty-num { font-size: 16px; font-weight: 600; color: var(--color-text); min-width: 20px; text-align: center; }
.cart-item { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--color-border); }
.cart-img { width: 48px; height: 48px; object-fit: cover; border-radius: 4px; }
.cart-info { flex: 1; }
.cart-name { font-size: 13px; color: var(--color-text); }
.cart-price { font-size: 14px; color: var(--color-primary); font-weight: 600; }
.cart-coupon { padding: 16px 0; border-bottom: 1px solid var(--color-border); }
.cart-section-title { font-size: 13px; color: var(--color-text-muted); margin-bottom: 8px; }
.cart-total { padding: 16px 0; }
.price-row { display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: var(--color-text-muted); margin-bottom: 8px; }
.final-price { display: flex; justify-content: space-between; align-items: center; padding-top: 8px; border-top: 1px dashed var(--color-border); font-size: 15px; color: var(--color-text); }
.total-price { font-size: 22px; font-weight: 700; color: var(--color-primary); }
</style>
