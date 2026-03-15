<template>
  <div class="announcements-page">
    <div class="page-header">
      <h1>最新公告</h1>
      <p>了解影院最新动态和优惠信息</p>
    </div>

    <div class="announcements-container">
      <el-empty v-if="announcements.length === 0" description="暂无公告" />
      
      <div v-else class="announcements-list">
        <div 
          v-for="announcement in announcements" 
          :key="announcement.id"
          class="announcement-card"
          @click="viewDetail(announcement)"
        >
          <div class="announcement-header">
            <div class="announcement-title-section">
              <el-tag 
                v-if="announcement.isTop === 1" 
                type="danger" 
                size="small"
                class="top-tag"
              >
                置顶
              </el-tag>
              <h3 class="announcement-title">{{ announcement.title }}</h3>
            </div>
            <span class="announcement-type">{{ getTypeLabel(announcement.type) }}</span>
          </div>
          
          <p class="announcement-content">{{ truncateContent(announcement.content) }}</p>
          
          <div class="announcement-footer">
            <span class="announcement-date">{{ formatDate(announcement.publishTime) }}</span>
            <span class="announcement-views">
              <el-icon><View /></el-icon>
              {{ announcement.viewCount }}
            </span>
          </div>
        </div>
      </div>

      <el-pagination
        v-if="pagination.total > 0"
        v-model:current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        layout="total, prev, pager, next"
        class="pagination"
        @current-change="fetchAnnouncements"
      />
    </div>

    <!-- 公告详情抽屉 -->
    <el-drawer v-model="drawerVisible" title="公告详情" size="600px">
      <template v-if="currentAnnouncement">
        <div class="announcement-detail">
          <h2>{{ currentAnnouncement.title }}</h2>
          <div class="detail-meta">
            <span>{{ getTypeLabel(currentAnnouncement.type) }}</span>
            <span>{{ formatDate(currentAnnouncement.publishTime) }}</span>
            <span>浏览 {{ currentAnnouncement.viewCount }} 次</span>
          </div>
          <div class="detail-content">
            {{ currentAnnouncement.content }}
          </div>
        </div>
      </template>
    </el-drawer>
  </div>
</template>

<script setup>
import { announcementApi } from '@/api'
import { View } from '@element-plus/icons-vue'
import { onMounted, reactive, ref } from 'vue'

const announcements = ref([])
const currentAnnouncement = ref(null)
const drawerVisible = ref(false)
const loading = ref(false)

const pagination = reactive({
  page: 1,
  size: 10,
  total: 0
})

onMounted(() => {
  fetchAnnouncements()
})

const fetchAnnouncements = async () => {
  loading.value = true
  try {
    const res = await announcementApi.getPage({
      page: pagination.page,
      size: pagination.size
    })
    if (res.code === 200) {
      announcements.value = res.data?.records || []
      pagination.total = res.data?.total || 0
    }
  } catch (err) {
    console.error('获取公告列表失败:', err)
  } finally {
    loading.value = false
  }
}

const viewDetail = async (announcement) => {
  try {
    const res = await announcementApi.getDetail(announcement.id)
    if (res.code === 200) {
      currentAnnouncement.value = res.data
      drawerVisible.value = true
    }
  } catch (err) {
    console.error('获取公告详情失败:', err)
  }
}

const getTypeLabel = (type) => {
  const typeMap = {
    0: '普通公告',
    1: '活动公告',
    2: '系统通知'
  }
  return typeMap[type] || '公告'
}

const formatDate = (date) => {
  if (!date) return '--'
  if (typeof date === 'string') {
    return date.split(' ')[0]
  }
  return new Date(date).toLocaleDateString('zh-CN')
}

const truncateContent = (content) => {
  if (!content) return ''
  return content.length > 100 ? content.substring(0, 100) + '...' : content
}
</script>

<style scoped>
.announcements-page {
  min-height: 100vh;
  background: var(--color-bg);
  padding: 40px 20px;
}

.page-header {
  text-align: center;
  margin-bottom: 40px;
  color: var(--color-text);
}

.page-header h1 {
  font-size: 32px;
  font-weight: 700;
  margin: 0 0 8px;
  color: var(--color-text);
}

.page-header p {
  font-size: 14px;
  color: var(--color-text-muted);
  margin: 0;
}

.announcements-container {
  max-width: 900px;
  margin: 0 auto;
}

.announcements-list {
  display: grid;
  gap: 16px;
}

.announcement-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: 12px;
  padding: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.announcement-card:hover {
  background: var(--color-surface-2);
  border-color: var(--color-primary);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(59, 130, 246, 0.15);
}

.announcement-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.announcement-title-section {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1;
}

.top-tag {
  flex-shrink: 0;
}

.announcement-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text);
  margin: 0;
  line-height: 1.4;
}

.announcement-type {
  font-size: 12px;
  color: var(--color-text-muted);
  white-space: nowrap;
  margin-left: 12px;
}

.announcement-content {
  font-size: 14px;
  color: var(--color-text-muted);
  margin: 0 0 12px;
  line-height: 1.6;
}

.announcement-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: var(--color-text-muted);
}

.announcement-date {
  display: flex;
  align-items: center;
}

.announcement-views {
  display: flex;
  align-items: center;
  gap: 4px;
}

.pagination {
  margin-top: 24px;
  text-align: center;
}

.announcement-detail {
  padding: 20px 0;
}

.announcement-detail h2 {
  font-size: 20px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 16px;
}

.detail-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--color-text-muted);
  margin-bottom: 20px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--color-border);
}

.detail-content {
  font-size: 14px;
  color: var(--color-text-muted);
  line-height: 1.8;
  white-space: pre-wrap;
  word-break: break-word;
}
</style>

