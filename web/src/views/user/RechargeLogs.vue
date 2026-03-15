<template>
  <div class="recharge-logs-page">
    <div class="page-header">
      <h1 class="page-title">充值记录</h1>
      <div class="header-actions">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="YYYY-MM-DD"
          @change="fetchLogs"
          style="width: 280px"
        />
        <el-button @click="exportLogs">
          <el-icon><Download /></el-icon> 导出
        </el-button>
      </div>
    </div>

    <div class="stats-cards">
      <div class="stat-card">
        <div class="stat-label">总充值金额</div>
        <div class="stat-value">¥{{ totalRecharge }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">总赠送金额</div>
        <div class="stat-value gift">¥{{ totalGift }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">总赠送积分</div>
        <div class="stat-value points">{{ totalPoints }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">充值次数</div>
        <div class="stat-value">{{ logs.length }}</div>
      </div>
    </div>

    <el-table :data="logs" v-loading="loading" style="width: 100%">
      <el-table-column label="充值时间" width="180">
        <template #default="{ row }">
          {{ formatDateTime(row.payTime) }}
        </template>
      </el-table-column>
      <el-table-column label="充值金额" width="120" align="right">
        <template #default="{ row }">
          <span style="color: var(--color-primary); font-weight: 600">¥{{ row.amount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="赠送金额" width="120" align="right">
        <template #default="{ row }">
          <span style="color: #10b981; font-weight: 600">+¥{{ row.giftAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="赠送积分" width="120" align="right">
        <template #default="{ row }">
          <span style="color: #f59e0b">+{{ row.giftPoints }}</span>
        </template>
      </el-table-column>
      <el-table-column label="支付方式" width="120">
        <template #default="{ row }">
          <el-tag :type="getPayTypeTag(row.payType)">
            {{ getPayTypeLabel(row.payType) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'danger'">
            {{ row.status === 1 ? '成功' : '失败' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="订单号" min-width="160">
        <template #default="{ row }">
          <span class="order-no">{{ row.orderNo }}</span>
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
        @size-change="fetchLogs"
        @current-change="fetchLogs"
      />
    </div>

    <el-empty v-if="logs.length === 0 && !loading" description="暂无充值记录" />
  </div>
</template>

<script setup>
import { memberApi } from '@/api'
import { Download } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, ref } from 'vue'

const loading = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)
const logs = ref([])
const dateRange = ref([])

const totalRecharge = computed(() => {
  return logs.value.reduce((sum, log) => sum + (log.amount || 0), 0).toFixed(2)
})

const totalGift = computed(() => {
  return logs.value.reduce((sum, log) => sum + (log.giftAmount || 0), 0).toFixed(2)
})

const totalPoints = computed(() => {
  return logs.value.reduce((sum, log) => sum + (log.giftPoints || 0), 0)
})

const fetchLogs = async () => {
  loading.value = true
  try {
    const params = {
      page: page.value,
      size: size.value
    }
    if (dateRange.value && dateRange.value.length === 2) {
      params.startDate = dateRange.value[0]
      params.endDate = dateRange.value[1]
    }

    const res = await memberApi.getRechargeLogs(params)
    if (res.code === 200) {
      logs.value = res.data?.records || []
      total.value = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取充值记录失败:', err)
    ElMessage.error('获取充值记录失败')
  } finally {
    loading.value = false
  }
}

const formatDateTime = (dt) => {
  if (!dt) return '--'
  return typeof dt === 'string' ? dt.replace('T', ' ').slice(0, 19) : dt
}

const getPayTypeLabel = (type) => {
  const map = {
    'wechat': '微信支付',
    'alipay': '支付宝',
    'card': '银行卡',
    'balance': '余额支付'
  }
  return map[type] || type
}

const getPayTypeTag = (type) => {
  const map = {
    'wechat': 'success',
    'alipay': 'warning',
    'card': 'info',
    'balance': 'primary'
  }
  return map[type] || 'info'
}

const exportLogs = () => {
  ElMessage.info('导出功能开发中...')
}

onMounted(() => {
  fetchLogs()
})
</script>

<style scoped>
.recharge-logs-page {
  padding-bottom: 40px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

.page-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.stats-cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.stat-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 20px;
  text-align: center;
}

.stat-label {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: 8px;
}

.stat-value {
  font-size: 24px;
  font-weight: 700;
  color: var(--color-primary);
}

.stat-value.gift {
  color: #10b981;
}

.stat-value.points {
  color: #f59e0b;
}

.order-no {
  font-family: 'Courier New', monospace;
  font-size: 12px;
  color: var(--color-text-muted);
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

@media (max-width: 1024px) {
  .stats-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .header-actions {
    width: 100%;
    flex-direction: column;
  }
}
</style>

