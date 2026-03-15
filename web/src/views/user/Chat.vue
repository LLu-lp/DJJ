<template>
  <div class="chat-page">
    <div class="chat-container">
      <!-- 左侧：FAQ 列表 -->
      <div class="faq-section">
        <h2 class="section-title">常见问题</h2>
        <div class="faq-list">
          <div
            v-for="item in faqList"
            :key="item.id"
            class="faq-item"
            :class="{ active: selectedFAQ?.id === item.id }"
            @click="selectFAQ(item)"
          >
            <p class="faq-question">{{ item.question }}</p>
            <el-icon v-if="selectedFAQ?.id === item.id" class="faq-icon"><Check /></el-icon>
          </div>
        </div>
      </div>

      <!-- 右侧：聊天窗口 -->
      <div class="chat-section">
        <!-- 聊天头部 -->
        <div class="chat-header">
          <div class="header-info">
            <h3>在线客服</h3>
            <p class="status">
              <span class="status-dot"></span>
              {{ isOnline ? '在线' : '离线' }}
            </p>
          </div>
          <el-button link @click="showFAQ = !showFAQ">
            <el-icon><QuestionFilled /></el-icon>
            {{ showFAQ ? '隐藏' : '显示' }}FAQ
          </el-button>
        </div>

        <!-- 聊天消息区 -->
        <div class="chat-messages" ref="messagesContainer">
          <div v-if="messages.length === 0" class="empty-state">
            <el-icon size="48"><ChatDotRound /></el-icon>
            <p>暂无消息，开始聊天吧</p>
          </div>

          <div v-for="msg in messages" :key="msg.id" class="message-group" :class="msg.userRole">
            <div class="message-item">
              <img :src="msg.senderAvatar || getDefaultAvatar(msg.userRole)" :alt="msg.senderName" class="avatar" />
              <div class="message-content">
                <p class="sender-name">{{ msg.senderName }}</p>
                <div class="message-text">{{ msg.content }}</div>
                <p class="message-time">{{ formatTime(msg.sendTime) }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- FAQ 答案展示 -->
        <div v-if="showFAQ && selectedFAQ" class="faq-answer">
          <div class="answer-header">
            <p class="answer-question">{{ selectedFAQ.question }}</p>
            <el-button link size="small" @click="showFAQ = false">
              <el-icon><Close /></el-icon>
            </el-button>
          </div>
          <div class="answer-content">
            {{ selectedFAQ.answer }}
          </div>
        </div>

        <!-- 输入框 -->
        <div class="chat-input-area">
          <el-input
            v-model="inputMessage"
            type="textarea"
            :rows="3"
            placeholder="输入消息（按 Ctrl+Enter 发送）"
            @keydown.ctrl.enter="sendMessage"
            maxlength="500"
            show-word-limit
          />
          <div class="input-actions">
            <el-button type="primary" @click="sendMessage" :loading="sending">
              <el-icon><Promotion /></el-icon>
              发送
            </el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Check, ChatDotRound, Close, QuestionFilled, Promotion } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { onMounted, onUnmounted, ref } from 'vue'
import { faqApi, chatApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import { Client } from '@stomp/stompjs'
import SockJS from 'sockjs-client'

const authStore = useAuthStore()
const messages = ref([])
const inputMessage = ref('')
const sending = ref(false)
const isOnline = ref(false)
const showFAQ = ref(false)
const selectedFAQ = ref(null)
const faqList = ref([])
const messagesContainer = ref(null)
let stompClient = null

const getDefaultAvatar = (role) => {
  if (role === 'user') {
    return 'https://ui-avatars.com/api/?name=User&background=667eea&color=fff&size=40'
  }
  return 'https://ui-avatars.com/api/?name=Service&background=4a9ff5&color=fff&size=40'
}

const formatTime = (time) => {
  if (!time) return ''
  const date = new Date(time)
  const hours = String(date.getHours()).padStart(2, '0')
  const minutes = String(date.getMinutes()).padStart(2, '0')
  return `${hours}:${minutes}`
}

const connectWebSocket = () => {
  const userId = authStore.user?.id || authStore.user?.userId
  if (!userId) {
    console.warn('用户未登录，跳过 WebSocket 连接')
    ElMessage.warning('请先登录后再使用客服功能')
    return
  }

  try {
    const token = authStore.token

    stompClient = new Client({
      webSocketFactory: () => new SockJS('/api/ws'),
      connectHeaders: token ? { Authorization: `Bearer ${token}` } : {},
      reconnectDelay: 5000,
      heartbeatIncoming: 4000,
      heartbeatOutgoing: 4000,
      onConnect: (frame) => {
        console.log('WebSocket 连接成功:', frame)
        isOnline.value = true

        // 订阅用户消息
        stompClient.subscribe(`/user/${userId}/queue/messages`, (message) => {
          const msg = JSON.parse(message.body)
          messages.value.push({
            id: msg.id || Date.now(),
            senderId: msg.senderId,
            senderName: msg.senderName,
            senderAvatar: msg.senderAvatar,
            content: msg.content,
            sendTime: msg.sendTime,
            userRole: msg.userRole || 'service'
          })
          scrollToBottom()
        })

        // 订阅客服广播消息
        stompClient.subscribe('/topic/service', (message) => {
          const msg = JSON.parse(message.body)
          if (msg.senderId !== userId) {
            messages.value.push({
              id: msg.id || Date.now(),
              senderId: msg.senderId,
              senderName: msg.senderName,
              senderAvatar: msg.senderAvatar,
              content: msg.content,
              sendTime: msg.sendTime,
              userRole: msg.userRole || 'service'
            })
            scrollToBottom()
          }
        })
      },
      onStompError: (frame) => {
        console.error('WebSocket 连接失败:', frame)
        isOnline.value = false
        ElMessage.error('连接客服失败，请刷新页面重试')
      },
      onDisconnect: () => {
        isOnline.value = false
      }
    })

    stompClient.activate()
  } catch (error) {
    console.error('WebSocket 初始化失败:', error)
    isOnline.value = false
  }
}

const sendMessage = async () => {
  if (!inputMessage.value.trim()) {
    ElMessage.warning('请输入消息')
    return
  }

  const userId = authStore.user?.id || authStore.user?.userId
  if (!userId) {
    ElMessage.error('请先登录')
    return
  }

  if (!stompClient || !stompClient.active) {
    ElMessage.error('未连接到服务器，请刷新页面重试')
    return
  }

  sending.value = true
  try {
    const messageData = {
      senderId: userId,
      senderName: authStore.user.username || authStore.user.realName || '用户',
      senderAvatar: authStore.user.avatar,
      receiverId: 0, // 0 表示发送给客服
      content: inputMessage.value,
      type: 'text',
      userRole: 'user'
    }

    // 先添加到本地显示
    messages.value.push({
      id: Date.now(),
      ...messageData,
      sendTime: new Date().toISOString()
    })

    // 通过 WebSocket 发送消息
    stompClient.publish({ destination: '/app/send', body: JSON.stringify(messageData) })
    
    inputMessage.value = ''
    scrollToBottom()
  } catch (err) {
    console.error('发送消息失败:', err)
    ElMessage.error('发送失败，请重试')
  } finally {
    sending.value = false
  }
}

const selectFAQ = (item) => {
  selectedFAQ.value = selectedFAQ.value?.id === item.id ? null : item
  showFAQ.value = true
}

const scrollToBottom = () => {
  setTimeout(() => {
    if (messagesContainer.value) {
      messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
    }
  }, 100)
}

const loadFAQs = async () => {
  try {
    const res = await faqApi.getList()
    console.log('FAQ API 响应:', res)
    if (res.code === 200 && res.data) {
      faqList.value = res.data
      console.log('FAQ 列表加载成功:', faqList.value)
    } else {
      console.error('FAQ 加载失败，响应码:', res.code)
    }
  } catch (err) {
    console.error('加载 FAQ 失败:', err)
    ElMessage.error('加载常见问题失败')
  }
}

const loadChatHistory = async () => {
  const userId = authStore.user?.id || authStore.user?.userId
  if (!userId) {
    console.warn('用户未登录或用户信息不完整')
    return
  }
  
  try {
    const res = await chatApi.getHistory(userId)
    if (res.code === 200 && res.data) {
      messages.value = res.data.map(msg => ({
        id: msg.id,
        senderId: msg.senderId,
        senderName: msg.senderName,
        senderAvatar: msg.senderAvatar,
        content: msg.content,
        sendTime: msg.sendTime,
        userRole: msg.userRole
      }))
      scrollToBottom()
      console.log('聊天历史加载成功:', messages.value.length, '条消息')
    }
  } catch (err) {
    console.error('加载聊天历史失败:', err)
  }
}

onMounted(() => {
  console.log('当前用户信息:', authStore.user)
  loadFAQs()
  loadChatHistory()
  connectWebSocket()
})

onUnmounted(() => {
  if (stompClient && stompClient.active) {
    stompClient.deactivate()
  }
})
</script>

<style scoped>
.chat-page {
  padding: 20px;
  height: calc(100vh - 100px);
  background: var(--color-surface);
}

.chat-container {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 16px;
  height: 100%;
  background: var(--color-surface);
}

.faq-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: 16px;
  overflow-y: auto;
}

.section-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--color-text);
  margin-bottom: 12px;
}

.faq-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.faq-item {
  padding: 10px 12px;
  background: var(--color-surface-2);
  border: 1px solid var(--color-border);
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.faq-item:hover {
  border-color: var(--color-primary);
  background: var(--color-primary-light);
}

.faq-item.active {
  border-color: var(--color-primary);
  background: var(--color-primary-light);
}

.faq-question {
  font-size: 12px;
  color: var(--color-text);
  margin: 0;
  flex: 1;
}

.faq-icon {
  color: var(--color-primary);
  flex-shrink: 0;
}

.chat-section {
  display: flex;
  flex-direction: column;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  overflow: hidden;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid var(--color-border);
  background: var(--color-surface-2);
}

.header-info h3 {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 4px;
}

.status {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #10b981;
  display: inline-block;
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  justify-content: flex-start;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: var(--color-text-muted);
}

.empty-state p {
  margin-top: 12px;
  font-size: 14px;
}

.message-group {
  display: flex;
  margin-bottom: 8px;
}

.message-group.user {
  justify-content: flex-end;
}

.message-item {
  display: flex;
  gap: 8px;
  max-width: 70%;
}

.message-group.user .message-item {
  flex-direction: row-reverse;
}

.avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
  flex-shrink: 0;
}

.message-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.message-group.user .message-content {
  align-items: flex-end;
}

.sender-name {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0;
}

.message-text {
  padding: 8px 12px;
  background: var(--color-surface-2);
  border-radius: 8px;
  font-size: 13px;
  color: var(--color-text);
  word-break: break-word;
  white-space: pre-wrap;
}

.message-group.user .message-text {
  background: var(--color-primary);
  color: #fff;
}

.message-time {
  font-size: 11px;
  color: var(--color-text-muted);
  margin: 0;
}

.faq-answer {
  padding: 12px 16px;
  background: rgba(59, 130, 246, 0.05);
  border-top: 1px solid var(--color-border);
  border-bottom: 1px solid var(--color-border);
}

.answer-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.answer-question {
  font-size: 13px;
  font-weight: 600;
  color: var(--color-text);
  margin: 0;
}

.answer-content {
  font-size: 12px;
  color: var(--color-text-muted);
  line-height: 1.6;
  white-space: pre-wrap;
}

.chat-input-area {
  padding: 16px;
  border-top: 1px solid var(--color-border);
  background: var(--color-surface-2);
}

.input-actions {
  display: flex;
  gap: 8px;
  margin-top: 8px;
  justify-content: flex-end;
}

@media (max-width: 1024px) {
  .chat-container {
    grid-template-columns: 1fr;
  }

  .faq-section {
    display: none;
  }

  .message-item {
    max-width: 85%;
  }
}
</style>
