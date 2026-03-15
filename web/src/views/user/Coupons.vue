<template>
  <div class="coupons-page">
    <el-tabs v-model="activeTab" class="coupon-tabs">
      <el-tab-pane label="领券中心" name="available">
        <div class="coupons-grid" v-loading="loading">
          <div v-for="coupon in availableCoupons" :key="coupon.id" class="coupon-card available">
            <div class="coupon-left">
              <div class="coupon-value">
                <span v-if="coupon.discountType === 1" class="value">¥{{ coupon.discountValue }}</span>
                <span v-else class="value">{{ (coupon.discountValue * 10).toFixed(1) }}折</span>
              </div>
              <div class="coupon-condition">满{{ coupon.minAmount }}元可用</div>
            </div>
            <div class="coupon-right">
              <h3 class="coupon-name">{{ coupon.name }}</h3>
              <p class="coupon-desc">{{ coupon.description }}</p>
              <p class="coupon-time">有效期：{{ coupon.validDays }}天</p>
              <div class="coupon-footer">
                <span class="coupon-stock">剩余 {{ coupon.totalCount - coupon.receivedCount }}</span>
                <el-button size="small" type="primary" @click="receiveCoupon(coupon)">立即领取</el-button>
              </div>
            </div>
          </div>
        </div>
        <el-empty v-if="availableCoupons.length === 0 && !loading" description="暂无可领取的优惠券" />
      </el-tab-pane>

      <el-tab-pane label="我的优惠券" name="my">
        <el-radio-group v-model="couponStatus" class="status-filter" @change="loadMyCoupons">
          <el-radio-button :label="null">全部</el-radio-button>
          <el-radio-button :label="0">未使用</el-radio-button>
          <el-radio-button :label="1">已使用</el-radio-button>
          <el-radio-button :label="2">已过期</el-radio-button>
        </el-radio-group>

        <div class="coupons-grid" v-loading="loading">
          <div v-for="coupon in myCoupons" :key="coupon.id" class="coupon-card" :class="couponStatusClass(coupon.status)">
            <div class="coupon-left">
              <div class="coupon-value">
                <span v-if="coupon.discountType === 1" class="value">¥{{ coupon.discountValue }}</span>
                <span v-else class="value">{{ (coupon.discountValue * 10).toFixed(1) }}折</span>
              </div>
              <div class="coupon-condition">满{{ coupon.minAmount }}元可用</div>
            </div>
            <div class="coupon-right">
              <h3 class="coupon-name">{{ coupon.couponName }}</h3>
              <p class="coupon-time">有效期至：{{ formatDate(coupon.expireTime) }}</p>
              <div class="coupon-status-tag">
                <el-tag v-if="coupon.status === 0" type="success" size="small">未使用</el-tag>
                <el-tag v-else-if="coupon.status === 1" type="info" size="small">已使用</el-tag>
                <el-tag v-else type="danger" size="small">已过期</el-tag>
              </div>
            </div>
          </div>
        </div>
        <el-empty v-if="myCoupons.length === 0 && !loading" description="暂无优惠券" />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup>
import { couponApi } from '@/api'
import { ElMessage } from 'element-plus'
import { onMounted, ref, watch } from 'vue'

const activeTab = ref('available')
const loading = ref(false)
const availableCoupons = ref([])
const myCoupons = ref([])
const couponStatus = ref(null)

const loadAvailableCoupons = async () => {
  loading.value = true
  try {
    const res = await couponApi.getAvailable()
    if (res.code === 200) {
      availableCoupons.value = res.data || []
    }
  } catch (err) {
    console.error('加载优惠券失败:', err)
  } finally {
    loading.value = false
  }
}

const loadMyCoupons = async () => {
  loading.value = true
  try {
    const res = await couponApi.getMyCoupons(couponStatus.value)
    if (res.code === 200) {
      myCoupons.value = res.data || []
    }
  } catch (err) {
    console.error('加载我的优惠券失败:', err)
  } finally {
    loading.value = false
  }
}

const receiveCoupon = async (coupon) => {
  try {
    const res = await couponApi.receive(coupon.id)
    if (res.code === 200) {
      ElMessage.success('领取成功')
      coupon.receivedCount++
      loadMyCoupons()
    } else {
      ElMessage.error(res.message || '领取失败')
    }
  } catch (err) {
    ElMessage.error(err.response?.data?.message || '领取失败')
  }
}

const formatDate = (date) => {
  if (!date) return ''
  return new Date(date).toLocaleDateString('zh-CN')
}

const couponStatusClass = (status) => {
  if (status === 0) return 'unused'
  if (status === 1) return 'used'
  return 'expired'
}

watch(activeTab, (newTab) => {
  if (newTab === 'available') {
    loadAvailableCoupons()
  } else {
    loadMyCoupons()
  }
})

onMounted(() => {
  loadAvailableCoupons()
})
</script>

<style scoped>
.coupons-page {
  padding: 20px;
}

.coupon-tabs {
  background: var(--color-surface);
  border-radius: var(--radius);
  padding: 20px;
}

.status-filter {
  margin-bottom: 20px;
}

.coupons-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
  gap: 16px;
}

.coupon-card {
  display: flex;
  background: var(--color-surface);
  border: 2px solid var(--color-border);
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s;
}

.coupon-card.available:hover {
  border-color: var(--color-primary);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.coupon-card.used {
  opacity: 0.6;
}

.coupon-card.expired {
  opacity: 0.5;
  border-color: #ccc;
}

.coupon-left {
  width: 120px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px 10px;
  position: relative;
}

.coupon-left::after {
  content: '';
  position: absolute;
  right: -8px;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  background: var(--color-bg);
  border-radius: 50%;
}

.coupon-value .value {
  font-size: 32px;
  font-weight: 700;
  line-height: 1;
}

.coupon-condition {
  font-size: 12px;
  margin-top: 8px;
  opacity: 0.9;
}

.coupon-right {
  flex: 1;
  padding: 16px;
  display: flex;
  flex-direction: column;
}

.coupon-name {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 8px;
}

.coupon-desc {
  font-size: 13px;
  color: var(--color-text-muted);
  margin: 0 0 8px;
  line-height: 1.5;
}

.coupon-time {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0 0 12px;
}

.coupon-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: auto;
}

.coupon-stock {
  font-size: 12px;
  color: var(--color-text-muted);
}

.coupon-status-tag {
  margin-top: auto;
}
</style>

