<template>
  <div class="page-container">
    <div class="page-header">
      <h2>订单核销</h2>
    </div>

    <!-- 扫码/输入核销 -->
    <el-card class="verify-card">
      <el-row :gutter="24" align="middle">
        <el-col :span="14">
          <div class="verify-input-area">
            <el-icon size="48" color="#e50914"><Ticket /></el-icon>
            <div>
              <h3>扫码或输入订单号核销</h3>
              <el-input
                v-model="verifyCode"
                placeholder="扫描二维码或输入订单号"
                size="large"
                style="width:360px"
                @keyup.enter="handleVerify"
              >
                <template #append>
                  <el-button type="danger" @click="handleVerify" :loading="verifying">核销</el-button>
                </template>
              </el-input>
            </div>
          </div>
        </el-col>
        <el-col :span="10">
          <div v-if="verifyResult" class="verify-result" :class="verifyResult.success ? 'success' : 'fail'">
            <el-icon size="40">
              <component :is="verifyResult.success ? 'CircleCheck' : 'CircleClose'" />
            </el-icon>
            <div class="result-info">
              <p class="result-msg">{{ verifyResult.message }}</p>
              <template v-if="verifyResult.order">
                <p>{{ verifyResult.order.movieTitle }}</p>
                <p>{{ verifyResult.order.showTime }} · {{ verifyResult.order.seats }}</p>
                <p>{{ verifyResult.order.username }}</p>
              </template>
            </div>
          </div>
        </el-col>
      </el-row>
    </el-card>

    <!-- 今日核销记录 -->
    <el-card>
      <template #header>
        <div style="display:flex;justify-content:space-between;align-items:center">
          <span>今日核销记录</span>
          <el-tag type="success">今日共核销 {{ verifyRecords.length }} 张</el-tag>
        </div>
      </template>
      <el-table :data="verifyRecords" v-loading="loadingRecords">
        <el-table-column prop="orderNo" label="订单号" width="200" />
        <el-table-column prop="username" label="用户" width="120" />
        <el-table-column prop="movieTitle" label="电影" min-width="150" />
        <el-table-column prop="seats" label="座位" width="100" />
        <el-table-column prop="verifyTime" label="核销时间" width="180" />
        <el-table-column prop="staffName" label="核销员工" width="100" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag type="success" size="small">{{ row.status }}</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { staffApi } from '@/api'
import { Ticket } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { onMounted, ref } from 'vue'

const verifyCode = ref('')
const verifyResult = ref(null)
const verifying = ref(false)
const loadingRecords = ref(false)
const verifyRecords = ref([])

onMounted(() => {
  fetchVerifyRecords()
})

const fetchVerifyRecords = async () => {
  loadingRecords.value = true
  try {
    const today = new Date().toISOString().split('T')[0]
    const res = await staffApi.getOrders({ 
      status: 1,        // 已支付的订单
      ticketed: 1,      // 已核销的订单
      size: 50,
      startDate: today,
      endDate: today
    })
    if (res.code === 200) {
      verifyRecords.value = (res.data?.records || []).map(o => ({
        id: o.id,
        orderNo: o.orderNo,
        username: o.username || `用户${o.userId}`,
        movieTitle: o.movieTitle,
        seats: o.seats?.map(s => s.seatLabel).join(', ') || '--',
        verifyTime: o.ticketTime || o.payTime,
        staffName: '员工',
        status: '已核销'
      }))
    }
  } catch (err) {
    console.error('获取核销记录失败:', err)
  } finally {
    loadingRecords.value = false
  }
}

const handleVerify = async () => {
  if (!verifyCode.value.trim()) {
    ElMessage.warning('请输入订单号')
    return
  }

  verifying.value = true
  try {
    const res = await staffApi.verifyTicket(verifyCode.value.trim())
    if (res.code === 200) {
      verifyResult.value = {
        success: true,
        message: '核销成功',
        order: res.data || {
          movieTitle: '电影',
          showTime: '--',
          seats: '--',
          username: '--'
        }
      }
      ElMessage.success('核销成功')
      fetchVerifyRecords()
    } else {
      verifyResult.value = { success: false, message: res.message || '核销失败', order: null }
      ElMessage.error(res.message || '核销失败')
    }
  } catch (err) {
    console.error('核销失败:', err)
    verifyResult.value = { success: false, message: err.response?.data?.message || '订单无效或已核销', order: null }
    ElMessage.error('核销失败')
  } finally {
    verifying.value = false
    verifyCode.value = ''
  }
}
</script>

<style scoped>
.page-container { padding: 20px; }
.page-header { margin-bottom: 20px; }
.page-header h2 { font-size: 18px; font-weight: 700; color: var(--color-text); margin: 0; }
.verify-card { margin-bottom: 20px; }
.verify-input-area { display: flex; align-items: center; gap: 24px; padding: 20px 0; }
.verify-input-area h3 { margin: 0 0 12px; font-size: 16px; }

.verify-result { display: flex; align-items: center; gap: 16px; padding: 20px; border-radius: 8px; }
.verify-result.success { background: rgba(103, 194, 58, 0.1); color: #67c23a; }
.verify-result.fail { background: rgba(245, 108, 108, 0.1); color: #f56c6c; }
.result-info p { margin: 4px 0; font-size: 14px; }
.result-msg { font-size: 18px; font-weight: 600; margin-bottom: 8px !important; }
</style>
