<template>
  <div class="review-manage-page">
    <div class="page-header">
      <h2 class="page-title">评论审核</h2>
      <div class="header-actions">
        <el-select v-model="filterStatus" placeholder="审核状态" clearable style="width: 140px" @change="fetchReviews">
          <el-option label="待审核" :value="0" />
          <el-option label="已通过" :value="1" />
          <el-option label="已拒绝" :value="2" />
        </el-select>
        <el-input
          v-model="searchKeyword"
          placeholder="搜索电影或用户..."
          style="width: 200px"
          clearable
          @keyup.enter="fetchReviews"
        >
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
      </div>
    </div>

    <el-table :data="reviews" v-loading="loading" style="width: 100%">
      <el-table-column label="用户" width="120" prop="username" />
      <el-table-column label="电影" min-width="150" prop="movieTitle" />
      <el-table-column label="评分" width="100" align="center">
        <template #default="{ row }">
          <el-rate v-model="row.rating" disabled size="small" />
        </template>
      </el-table-column>
      <el-table-column label="评价内容" min-width="250">
        <template #default="{ row }">
          <div class="content-preview">{{ row.content }}</div>
        </template>
      </el-table-column>
      <el-table-column label="点赞数" width="100" align="center" prop="likes" />
      <el-table-column label="提交时间" width="160">
        <template #default="{ row }">
          {{ formatDateTime(row.createdAt) }}
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">
            {{ getStatusLabel(row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="viewDetail(row)">详情</el-button>
          <el-button
            v-if="row.status === 0"
            size="small"
            type="success"
            text
            @click="approveReview(row)"
          >
            通过
          </el-button>
          <el-button
            v-if="row.status === 0"
            size="small"
            type="danger"
            text
            @click="rejectReview(row)"
          >
            拒绝
          </el-button>
          <el-button
            v-if="row.status === 1"
            size="small"
            type="danger"
            text
            @click="deleteReview(row)"
          >
            删除
          </el-button>
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
        @size-change="fetchReviews"
        @current-change="fetchReviews"
      />
    </div>

    <el-empty v-if="reviews.length === 0 && !loading" description="暂无评论" />

    <!-- 详情对话框 -->
    <el-dialog v-model="detailVisible" title="评论详情" width="600px">
      <div v-if="currentReview" class="detail-content">
        <div class="detail-item">
          <span class="label">用户</span>
          <span class="value">{{ currentReview.username }}</span>
        </div>
        <div class="detail-item">
          <span class="label">电影</span>
          <span class="value">{{ currentReview.movieTitle }}</span>
        </div>
        <div class="detail-item">
          <span class="label">评分</span>
          <el-rate v-model="currentReview.rating" disabled size="small" />
        </div>
        <div class="detail-item">
          <span class="label">评价内容</span>
          <p class="value" style="white-space: pre-wrap">{{ currentReview.content }}</p>
        </div>
        <div class="detail-item">
          <span class="label">提交时间</span>
          <span class="value">{{ formatDateTime(currentReview.createdAt) }}</span>
        </div>
        <div class="detail-item">
          <span class="label">状态</span>
          <el-tag :type="getStatusType(currentReview.status)">
            {{ getStatusLabel(currentReview.status) }}
          </el-tag>
        </div>
        <div v-if="currentReview.rejectReason" class="detail-item">
          <span class="label">拒绝原因</span>
          <span class="value">{{ currentReview.rejectReason }}</span>
        </div>
      </div>
    </el-dialog>

    <!-- 拒绝原因对话框 -->
    <el-dialog v-model="rejectDialogVisible" title="拒绝评论" width="500px">
      <el-form :model="rejectForm" label-width="80px">
        <el-form-item label="拒绝原因">
          <el-select v-model="rejectForm.reason" placeholder="选择拒绝原因">
            <el-option label="内容不当" value="内容不当" />
            <el-option label="广告推广" value="广告推广" />
            <el-option label="人身攻击" value="人身攻击" />
            <el-option label="重复评论" value="重复评论" />
            <el-option label="其他" value="其他" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input
            v-model="rejectForm.remark"
            type="textarea"
            :rows="3"
            placeholder="可选，输入更详细的拒绝原因"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="rejectDialogVisible = false">取消</el-button>
        <el-button type="danger" :loading="rejecting" @click="confirmReject">确定拒绝</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { adminApi } from '@/api'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const rejecting = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)
const reviews = ref([])
const filterStatus = ref(null)
const searchKeyword = ref('')
const detailVisible = ref(false)
const rejectDialogVisible = ref(false)
const currentReview = ref(null)

const rejectForm = ref({
  reason: '',
  remark: ''
})

const getStatusLabel = (status) => {
  const map = { 0: '待审核', 1: '已通过', 2: '已拒绝' }
  return map[status] || status
}

const getStatusType = (status) => {
  const map = { 0: 'warning', 1: 'success', 2: 'danger' }
  return map[status] || 'info'
}

const formatDateTime = (dt) => {
  if (!dt) return '--'
  return typeof dt === 'string' ? dt.replace('T', ' ').slice(0, 19) : dt
}

const fetchReviews = async () => {
  loading.value = true
  try {
    const res = await adminApi.getReviews({
      page: page.value,
      size: size.value,
      status: filterStatus.value
    })
    if (res.code === 200) {
      reviews.value = res.data?.records || []
      total.value = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取评论列表失败:', err)
    ElMessage.error('获取评论列表失败')
  } finally {
    loading.value = false
  }
}

const viewDetail = (review) => {
  currentReview.value = review
  detailVisible.value = true
}

const approveReview = (review) => {
  ElMessageBox.confirm('确定通过该评论？', '通过评论', { type: 'success' }).then(async () => {
    try {
      const res = await adminApi.approveReview(review.id)
      if (res.code === 200) {
        ElMessage.success('已通过')
        fetchReviews()
      }
    } catch (err) { ElMessage.error('操作失败') }
  }).catch(() => {})
}

const rejectReview = (review) => {
  currentReview.value = review
  rejectForm.value = { reason: '', remark: '' }
  rejectDialogVisible.value = true
}

const confirmReject = async () => {
  if (!rejectForm.value.reason) {
    ElMessage.warning('请选择拒绝原因')
    return
  }
  rejecting.value = true
  try {
    const res = await adminApi.rejectReview(currentReview.value.id)
    if (res.code === 200) {
      ElMessage.success('已拒绝')
      rejectDialogVisible.value = false
      fetchReviews()
    }
  } catch (err) {
    ElMessage.error('操作失败')
  } finally {
    rejecting.value = false
  }
}

const deleteReview = (review) => {
  ElMessageBox.confirm('确定删除该评论？', '删除评论', { type: 'danger' }).then(async () => {
    try {
      const res = await adminApi.deleteReview(review.id)
      if (res.code === 200) {
        ElMessage.success('已删除')
        fetchReviews()
      }
    } catch (err) { ElMessage.error('删除失败') }
  }).catch(() => {})
}

onMounted(() => {
  fetchReviews()
})
</script>

<style scoped>
.review-manage-page {
  padding-bottom: 40px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 16px;
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.content-preview {
  color: var(--color-text);
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-size: 13px;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

.detail-content {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.detail-item {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.label {
  min-width: 80px;
  font-weight: 600;
  color: var(--color-text-muted);
  font-size: 13px;
}

.value {
  flex: 1;
  color: var(--color-text);
  font-size: 13px;
}
</style>

