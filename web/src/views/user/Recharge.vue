<template>
  <div class="recharge-page">
    <div class="page-header">
      <h1 class="page-title">会员充值</h1>
      <p class="page-desc">充值享受优惠，赠送积分</p>
    </div>

    <div class="recharge-container">
      <!-- 左侧：充值选项 -->
      <div class="recharge-section">
        <h2 class="section-title">选择充值金额</h2>
        
        <!-- 预设金额 -->
        <div class="preset-amounts">
          <div
            v-for="amount in presetAmounts"
            :key="amount.value"
            class="amount-card"
            :class="{ active: selectedAmount === amount.value }"
            @click="selectedAmount = amount.value; customAmount = ''"
          >
            <div class="amount-value">¥{{ amount.value }}</div>
            <div class="amount-gift">送¥{{ amount.gift }}</div>
            <div class="amount-points">+{{ amount.points }}积分</div>
          </div>
        </div>

        <!-- 自定义金额 -->
        <div class="custom-amount">
          <label>自定义金额</label>
          <div class="input-group">
            <span class="currency">¥</span>
            <el-input
              v-model.number="customAmount"
              type="number"
              placeholder="输入金额"
              :min="10"
              :max="10000"
              @input="selectedAmount = null"
            />
          </div>
          <p class="hint">最低充值 ¥10，最高 ¥10000</p>
        </div>

        <!-- 充值说明 -->
        <div class="recharge-info">
          <h3>充值说明</h3>
          <ul>
            <li>✓ 充值金额可用于购票和小食消费</li>
            <li>✓ 充值赠送的金额可直接使用</li>
            <li>✓ 充值赠送的积分可用于兑换商品</li>
            <li>✓ 充值金额不支持提现</li>
            <li>✓ 充值后立即到账</li>
          </ul>
        </div>
      </div>

      <!-- 右侧：充值预览 -->
      <div class="preview-section">
        <el-card class="preview-card">
          <template #header>
            <div class="card-header">充值预览</div>
          </template>

          <div class="preview-content">
            <div class="preview-item">
              <span class="label">充值金额</span>
              <span class="value">¥{{ rechargeAmount }}</span>
            </div>
            <div class="preview-item">
              <span class="label">赠送金额</span>
              <span class="value gift">+¥{{ giftAmount }}</span>
            </div>
            <div class="divider"></div>
            <div class="preview-item total">
              <span class="label">实际到账</span>
              <span class="value">¥{{ rechargeAmount + giftAmount }}</span>
            </div>
            <div class="preview-item">
              <span class="label">赠送积分</span>
              <span class="value points">+{{ giftPoints }}</span>
            </div>

            <!-- 支付方式 -->
            <div class="payment-method">
              <h4>选择支付方式</h4>
              <el-radio-group v-model="paymentMethod" class="method-group">
                <el-radio label="wechat">
                  <el-icon><component :is="'WechatFilled'" /></el-icon>
                  微信支付
                </el-radio>
                <el-radio label="alipay">
                  <el-icon><component :is="'AlipayCircleFilled'" /></el-icon>
                  支付宝
                </el-radio>
                <el-radio label="card">
                  <el-icon><CreditCard /></el-icon>
                  银行卡
                </el-radio>
              </el-radio-group>
            </div>

            <!-- 充值按钮 -->
            <el-button
              type="primary"
              size="large"
              style="width: 100%; margin-top: 20px"
              :loading="submitting"
              :disabled="!canRecharge"
              @click="handleRecharge"
            >
              {{ submitting ? '处理中...' : `立即充值 ¥${rechargeAmount}` }}
            </el-button>

            <p class="agreement">
              点击充值即表示同意
              <el-link type="primary">《充值协议》</el-link>
            </p>
          </div>
        </el-card>

        <!-- 当前余额 -->
        <div class="balance-info">
          <div class="balance-item">
            <span class="label">当前余额</span>
            <span class="amount">¥{{ userBalance }}</span>
          </div>
          <div class="balance-item">
            <span class="label">会员等级</span>
            <el-tag type="success">{{ memberLevel }}</el-tag>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { memberApi } from '@/api'
import { CreditCard } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref } from 'vue'

const selectedAmount = ref(500)
const customAmount = ref('')
const paymentMethod = ref('wechat')
const submitting = ref(false)
const userBalance = ref(0)
const memberLevel = ref('普通会员')

const presetAmounts = [
  { value: 100, gift: 10, points: 10 },
  { value: 300, gift: 30, points: 30 },
  { value: 500, gift: 75, points: 75 },
  { value: 1000, gift: 200, points: 200 },
  { value: 2000, gift: 500, points: 500 },
]

const rechargeAmount = computed(() => {
  return customAmount.value || selectedAmount.value || 0
})

const giftAmount = computed(() => {
  if (customAmount.value) {
    return Math.floor(customAmount.value * 0.1)
  }
  const preset = presetAmounts.find(a => a.value === selectedAmount.value)
  return preset ? preset.gift : 0
})

const giftPoints = computed(() => {
  if (customAmount.value) {
    return Math.floor(customAmount.value * 0.1)
  }
  const preset = presetAmounts.find(a => a.value === selectedAmount.value)
  return preset ? preset.points : 0
})

const canRecharge = computed(() => {
  return rechargeAmount.value >= 10 && rechargeAmount.value <= 10000
})

onMounted(async () => {
  try {
    const res = await memberApi.getInfo()
    if (res.code === 200) {
      userBalance.value = res.data?.balance || 0
      memberLevel.value = res.data?.levelName || '普通会员'
    }
  } catch (err) {
    console.error('获取会员信息失败:', err)
  }
})

const handleRecharge = async () => {
  if (!canRecharge.value) {
    ElMessage.warning('请输入有效的充值金额')
    return
  }

  submitting.value = true
  try {
    const res = await memberApi.recharge({
      amount: rechargeAmount.value,
      payType: paymentMethod.value
    })

    if (res.code === 200) {
      ElMessage.success('充值成功！')
      userBalance.value += rechargeAmount.value + giftAmount.value
      selectedAmount.value = 500
      customAmount.value = ''
      
      // 延迟跳转到充值记录
      setTimeout(() => {
        window.location.href = '/recharge-logs'
      }, 1500)
    }
  } catch (err) {
    console.error('充值失败:', err)
    ElMessage.error(err.response?.data?.message || '充值失败，请重试')
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.recharge-page {
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

.recharge-container {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 24px;
}

.recharge-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 24px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 20px;
}

.preset-amounts {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.amount-card {
  padding: 16px;
  border: 2px solid var(--color-border);
  border-radius: 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
  background: var(--color-surface-2);
}

.amount-card:hover {
  border-color: var(--color-primary);
  transform: translateY(-2px);
}

.amount-card.active {
  border-color: var(--color-primary);
  background: var(--color-primary-light);
}

.amount-value {
  font-size: 24px;
  font-weight: 700;
  color: var(--color-primary);
  margin-bottom: 4px;
}

.amount-gift {
  font-size: 12px;
  color: #10b981;
  margin-bottom: 4px;
}

.amount-points {
  font-size: 11px;
  color: var(--color-text-muted);
}

.custom-amount {
  margin-bottom: 24px;
  padding: 16px;
  background: var(--color-surface-2);
  border-radius: 8px;
}

.custom-amount label {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

.input-group {
  display: flex;
  align-items: center;
  gap: 8px;
}

.currency {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-primary);
}

.hint {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-top: 8px;
}

.recharge-info {
  padding: 16px;
  background: rgba(59, 130, 246, 0.05);
  border-left: 3px solid var(--color-primary);
  border-radius: 4px;
}

.recharge-info h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

.recharge-info ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.recharge-info li {
  font-size: 13px;
  color: var(--color-text-muted);
  line-height: 1.8;
}

.preview-section {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.preview-card {
  background: var(--color-surface) !important;
  border: 1px solid var(--color-border) !important;
}

.card-header {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
}

.preview-content {
  padding: 16px 0;
}

.preview-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  font-size: 14px;
}

.preview-item .label {
  color: var(--color-text-muted);
}

.preview-item .value {
  font-weight: 600;
  color: var(--color-text);
}

.preview-item.gift .value {
  color: #10b981;
}

.preview-item.points .value {
  color: var(--color-primary);
}

.preview-item.total {
  padding: 12px;
  background: var(--color-primary-light);
  border-radius: 6px;
  margin: 12px 0;
}

.preview-item.total .value {
  font-size: 18px;
  color: var(--color-primary);
}

.divider {
  height: 1px;
  background: var(--color-border);
  margin: 12px 0;
}

.payment-method {
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--color-border);
}

.payment-method h4 {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

.method-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.agreement {
  font-size: 12px;
  color: var(--color-text-muted);
  text-align: center;
  margin-top: 12px;
}

.balance-info {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 16px;
}

.balance-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  font-size: 14px;
}

.balance-item .label {
  color: var(--color-text-muted);
}

.balance-item .amount {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-primary);
}

@media (max-width: 1024px) {
  .recharge-container {
    grid-template-columns: 1fr;
  }

  .preset-amounts {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>

