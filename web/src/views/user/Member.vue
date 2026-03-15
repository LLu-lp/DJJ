<template>
  <div class="member-page">
    <!-- 会员卡 -->
    <div class="member-card">
      <div class="card-bg"></div>
      <div class="card-content">
        <div class="card-top">
          <div>
            <p class="card-label">当前等级</p>
            <h2 class="card-level">{{ memberInfo.levelName || '普通会员' }}</h2>
          </div>
          <div class="card-points">
            <p class="card-label">积分</p>
            <h2 class="points-value">{{ memberInfo.points || 0 }}</h2>
          </div>
        </div>
        <div class="card-bottom">
          <span>累计消费 ¥{{ memberInfo.totalConsumed || 0 }}</span>
          <span>会员折扣 {{ discountDisplay }}折</span>
          <span>入会 {{ joinDateDisplay }}</span>
        </div>
        <!-- 升级进度 -->
        <div class="upgrade-bar" v-if="nextLevel">
          <div class="upgrade-label">
            <span>距离{{ nextLevel.levelName }}</span>
            <span>¥{{ Number(memberInfo.totalConsumed || 0).toFixed(0) }} / ¥{{ Number(nextLevel.minSpent).toFixed(0) }} 消费额</span>
          </div>
          <el-progress
            :percentage="upgradeProgress"
            :show-text="false"
            :stroke-width="6"
            color="#3b82f6"
            style="margin-top:6px"
          />
        </div>
      </div>
    </div>

    <!-- 等级说明 -->
    <div class="section">
      <h2 class="section-title">会员等级体系</h2>
      <div class="levels-grid">
        <div
          v-for="level in memberLevels"
          :key="level.id"
          class="level-card"
          :class="{ current: level.id === memberInfo.levelId }"
        >
          <div class="level-icon" :style="{ color: level.color || '#3b82f6' }">
            <el-icon :size="28"><Star /></el-icon>
          </div>
          <h3 class="level-name" :style="{ color: level.color || '#3b82f6' }">{{ level.levelName }}</h3>
          <p class="level-points">
            ¥{{ Number(level.minSpent).toFixed(0) }} {{ level.maxSpent ? `~ ¥${Number(level.maxSpent).toFixed(0)}` : '+' }} 消费额
          </p>
          <p class="level-discount">享 {{ discountFormat(level.discount) }} 折优惠</p>
          <div v-if="level.id === memberInfo.levelId" class="current-badge">当前等级</div>
        </div>
      </div>
    </div>

    <!-- 积分兑换 -->
    <div class="section">
      <h2 class="section-title">积分兑换</h2>
      <div class="exchange-grid">
        <div v-for="item in exchangeItems" :key="item.id" class="exchange-card">
          <div class="exchange-icon">{{ item.icon }}</div>
          <div class="exchange-info">
            <h4 class="exchange-name">{{ item.name }}</h4>
            <p class="exchange-desc">{{ item.description }}</p>
          </div>
          <div class="exchange-right">
            <p class="exchange-points">{{ item.points }} 积分</p>
            <el-button
              size="small"
              type="primary"
              :disabled="!memberInfo.points || memberInfo.points < item.points || item.stock <= 0"
              @click="exchange(item)"
            >{{ item.stock <= 0 ? '已兑完' : '兑换' }}</el-button>
          </div>
        </div>
      </div>
      <el-empty v-if="exchangeItems.length === 0" description="暂无可兑换商品" />
    </div>
  </div>
</template>

<script setup>
import { exchangeApi, memberApi, publicApi } from '@/api'
import { Star } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref } from 'vue'

const memberInfo = ref({})
const memberLevels = ref([])

const exchangeItems = ref([])

const discountDisplay = computed(() => {
  const discount = memberInfo.value.discount || 10
  return discount.toFixed(1)
})

const joinDateDisplay = computed(() => {
  return memberInfo.value.joinTime ? memberInfo.value.joinTime.split(' ')[0] : '--'
})

const nextLevel = computed(() => {
  if (!memberLevels.value.length) return null
  const currentSpent = Number(memberInfo.value.totalConsumed || 0)
  // 找到下一个等级（消费额度更高的等级）
  const next = memberLevels.value.find(l => Number(l.minSpent) > currentSpent)
  return next
})

const upgradeProgress = computed(() => {
  if (!nextLevel.value) return 100
  const currentSpent = Number(memberInfo.value.totalConsumed || 0)
  const currentLevelSpent = Number(memberLevels.value.find(l => Number(l.minSpent) <= currentSpent)?.minSpent || 0)
  const nextLevelSpent = Number(nextLevel.value.minSpent || 1)
  const progress = ((currentSpent - currentLevelSpent) / (nextLevelSpent - currentLevelSpent)) * 100
  return Math.min(100, Math.round(progress))
})

onMounted(async () => {
  await Promise.all([fetchMemberInfo(), fetchMemberLevels(), fetchExchangeItems()])
})

const fetchMemberInfo = async () => {
  try {
    const res = await memberApi.getInfo()
    if (res.code === 200) {
      memberInfo.value = res.data || {}
      // 使用后端返回的会员等级数据
      if (res.data?.memberLevels) {
        memberLevels.value = res.data.memberLevels
      }
    }
  } catch (err) {
    console.error('获取会员信息失败:', err)
  }
}

const fetchMemberLevels = async () => {
  try {
    const res = await publicApi.getMemberLevels()
    if (res.code === 200) {
      // 如果后端没有在会员信息中返回等级数据，则从这个接口获取
      if (!memberLevels.value || memberLevels.value.length === 0) {
        memberLevels.value = res.data || []
      }
    }
  } catch (err) {
    console.error('获取会员等级失败:', err)
  }
}

const fetchExchangeItems = async () => {
  try {
    const res = await exchangeApi.getItems()
    if (res.code === 200) {
      exchangeItems.value = res.data || []
    }
  } catch (err) {
    console.error('获取兑换商品失败:', err)
  }
}

function discountFormat(discount) {
  if (!discount) return '10.0'
  return discount.toFixed ? discount.toFixed(1) : discount
}

async function exchange(item) {
  if (!memberInfo.value.points || memberInfo.value.points < item.points) {
    return ElMessage.warning('积分不足')
  }
  
  try {
    const res = await exchangeApi.exchange(item.id)
    if (res.code === 200) {
      memberInfo.value.points -= item.points
      ElMessage.success(`兑换成功！${item.name} 已加入您的优惠券`)
      // 刷新会员信息
      await fetchMemberInfo()
    } else {
      ElMessage.error(res.message || '兑换失败')
    }
  } catch (err) {
    console.error('兑换失败:', err)
    ElMessage.error(err.response?.data?.message || '兑换失败')
  }
}
</script>

<style scoped>
.member-page { padding-bottom: 40px; }
.member-card { position: relative; border-radius: 16px; overflow: hidden; margin-bottom: 32px; padding: 28px; background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 50%, #f0f9ff 100%); border: 1px solid rgba(59,130,246,0.2); }
.card-bg { position: absolute; inset: 0; background: radial-gradient(ellipse at top right, rgba(59,130,246,0.1), transparent 60%); pointer-events: none; }
.card-content { position: relative; z-index: 1; }
.card-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px; }
.card-label { font-size: 12px; color: rgba(59,130,246,0.7); margin-bottom: 4px; }
.card-level { font-size: 28px; font-weight: 700; color: var(--color-primary); }
.card-points { text-align: right; }
.points-value { font-size: 32px; font-weight: 700; color: var(--color-primary); }
.card-bottom { display: flex; gap: 24px; font-size: 13px; color: rgba(59,130,246,0.8); margin-bottom: 16px; }
.upgrade-label { display: flex; justify-content: space-between; font-size: 12px; color: rgba(59,130,246,0.7); }
.section { margin-bottom: 32px; }
.section-title { font-size: 18px; font-weight: 700; color: var(--color-text); margin-bottom: 16px; padding-left: 12px; border-left: 3px solid var(--color-primary); }
.levels-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; }
.level-card { position: relative; padding: 20px 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); text-align: center; transition: border-color .2s; }
.level-card.current { border-color: var(--color-primary); background: var(--color-primary-light); }
.level-icon { margin-bottom: 8px; }
.level-name { font-size: 15px; font-weight: 700; margin-bottom: 6px; }
.level-points { font-size: 12px; color: var(--color-text-muted); margin-bottom: 4px; }
.level-discount { font-size: 12px; color: var(--color-text-muted); }
.current-badge { position: absolute; top: 8px; right: 8px; font-size: 10px; padding: 2px 6px; background: var(--color-primary); color: #ffffff; border-radius: 4px; font-weight: 600; }
.exchange-grid { display: flex; flex-direction: column; gap: 10px; }
.exchange-card { display: flex; align-items: center; gap: 16px; padding: 16px; background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); transition: border-color .2s; }
.exchange-card:hover { border-color: var(--color-primary); }
.exchange-icon { font-size: 28px; width: 44px; text-align: center; }
.exchange-info { flex: 1; }
.exchange-name { font-size: 14px; font-weight: 600; color: var(--color-text); margin-bottom: 2px; }
.exchange-desc { font-size: 12px; color: var(--color-text-muted); }
.exchange-right { display: flex; align-items: center; gap: 12px; }
.exchange-points { font-size: 14px; color: var(--color-primary); font-weight: 600; white-space: nowrap; }
</style>
