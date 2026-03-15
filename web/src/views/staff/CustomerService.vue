<template>
  <div class="customer-service">
    <div class="service-container">
      <!-- 左侧：用户列表 -->
      <div class="user-list-section">
        <div class="section-header">
          <h3>用户列表</h3>
          <el-badge :value="totalUnread" :hidden="totalUnread === 0">
            <el-icon size="20"><ChatDotRound /></el-icon>
          </el-badge>
        </div>
        
        <div class="user-list">
          <div
            v-for="user in userList"
            :key="user.userId"
            class="user-item"
            :class="{ active: selectedUser?.userId === user.userId }"
            @click="selectUser(user)"
          >
            <el-badge :value="user.unreadCount" :hidden="user.unreadCount === 0">
              <el-avatar :size="40" :src="user.avatar">
                {{ user.username?.[0]?.toUpperCase() }}
              </el-avatar>
            </el-badge>
            <div class="user-info">
              <p class="username">{{ user.username }}</p>
              <p class="last-message">{{ user.lastMessage }}</p>
            </div>
            <span class="last-time">{{ formatTime(user.lastTime) }}</span>
          </div>
        </div>
      </div>

      <!-- 右侧：聊天窗口 -->
      <div class="chat-section">
        <div v-if="!selectedUser" class="empty-chat">
          <el-icon size="64"><ChatDotRound /></el-icon>
          <p>请选择一个用户开始聊天</p>
        </div>

        <template v-else>
          <!-- 聊天头部 -->
          <div class="chat-header">
            <div class="header-info">
              <el-avatar :size="32" :src="selectedUser.avatar">
                {{ selectedUser.username?.[0]?.toUpperCase() }}
              </el-avatar>
              <div>
                <h3>{{ selectedUser.username }}</h3>
                <p class="user-id">ID: {{ selectedUser.userId }}</p>
              </div>
            </div>
            <el-button @click="markAllRead">标记已读</el-button>
          </div>

          <!-- 聊天消息区 -->
          <div class="chat-messages" ref="messagesContainer">
            <div v-for="msg in currentMessages" :key="msg.id" class="message-group" :class="msg.userRole">
              <div class="message-item">
                <img :src="msg.senderAvatar || getDefaultAvatar(msg.userRole)" :alt="msg.senderName" class="avatar" />
                <div class="message-content">
                  <p class="sender-name">{{ msg.senderName }}</p>
                  <div class="message-text">{{ msg.content }}</div>
                  <p class="message-time">{{ formatDateTime(msg.sendTime) }}</p>
                </div>
              </div>
            </div>
          </div>

          <!-- 快捷回复 -->
          <div class="quick-replies">
            <el-tag
              v-for="reply in quickReplies"
              :key="reply"
              @click="useQuickReply(reply)"
              style="cursor: pointer; margin-right: 8px"
            >
              {{ reply }}
            </el-tag>
          </div>

          <!-- 输入框 -->
          <div class="chat-input-area">
            <el-input
              v-model="inputMessage"
              type="textarea"
              :rows="3"
              placeholder="输入回复消息..."
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
        </template>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ChatDotRound, Promotion } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { computed, onMounted, onUnmounted, ref } from 'vue'
import { chatApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import SockJS from 'sockjs-client'
import { Stomp } from '@stomp/stompjs'

const authStore = useAuthStore()
const userList = ref([])
const selectedUser = ref(null)
const currentMessages = ref([])
const inputMessage = ref('')
const sending = ref(false)
const messagesContainer = ref(null)
let stompClient = null

const quickReplies = [
  '您好，有什么可以帮助您的吗？',
  '请稍等，我马上为您处理',
  '感谢您的咨询',
  '如有其他问题，欢迎随时联系我们',
  '祝您观影愉快！'
]

const totalUnread = computed(() => {
  return userList.value.reduce((sum, user) => sum + user.unreadCount, 0)
})

const getDefaultAvatar = (role) => {
  if (role === 'user') {
    return 'https://ui-avatars.com/api/?name=User&background=667eea&color=fff&size=40'
  }
  return 'https://ui-avatars.com/api/?name=Staff&background=4caf82&color=fff&size=40'
}

const formatTime = (time) => {
  if (!time) return ''
  const now = new Date()
  const date = new Date(time)
  const diff = now - date
  
  if (diff < 60000) return '刚刚'
  if (diff < 3600000) return `${Math.floor(diff / 60000)}分钟前`
  if (diff < 86400000) return `${Math.floor(diff / 3600000)}小时前`
  return `${Math.floor(diff / 86400000)}天前`
}

const formatDateTime = (time) => {
  if (!time) return ''
  const date = new Date(time)
  const hours = String(date.getHours()).padStart(2, '0')
  const minutes = String(date.getMinutes()).padStart(2, '0')
  return `${hours}:${minutes}`
}

const connectWebSocket = () => {
  try {
    const socket = new SockJS('/api/ws')
    stompClient = Stomp.over(() => socket)
    
    stompClient.connect({}, 
      (frame) => {
        console.log('员工 WebSocket 连接成功:', frame)
        
        // 订阅客服频道，接收所有用户消息
        stompClient.subscribe('/topic/service', (message) => {
          const msg = JSON.parse(message.body)
          console.log('收到消息:', msg)

          // 只处理普通用户发送的消息，忽略员工/管理员消息
          if (msg.userRole === 'staff' || msg.userRole === 'admin') return

          let user = userList.value.find(u => u.userId === msg.senderId)
          if (!user) {
            user = {
              userId: msg.senderId,
              username: msg.senderName,
              avatar: msg.senderAvatar,
              lastMessage: msg.content,
              lastTime: msg.sendTime,
              unreadCount: 0
            }
            userList.value.unshift(user)
          } else {
            user.lastMessage = msg.content
            user.lastTime = msg.sendTime
          }
          
          // 如果是当前选中的用户，添加到消息列表
          if (selectedUser.value?.userId === msg.senderId) {
            currentMessages.value.push({
              id: msg.id || Date.now(),
              senderId: msg.senderId,
              senderName: msg.senderName,
              senderAvatar: msg.senderAvatar,
              content: msg.content,
              sendTime: msg.sendTime,
              userRole: 'user'
            })
            scrollToBottom()
          } else {
            user.unreadCount++
          }
        })
      },
      (error) => {
        console.error('WebSocket 连接失败:', error)
        ElMessage.error('连接失败，请刷新页面重试')
      }
    )
  } catch (error) {
    console.error('WebSocket 初始化失败:', error)
  }
}

const loadUserList = async () => {
  try {
    const res = await chatApi.getChatUsers()
    if (res.code === 200 && res.data) {
      userList.value = res.data
      console.log('用户列表加载成功:', userList.value)
    }
  } catch (err) {
    console.error('加载用户列表失败:', err)
  }
}

const selectUser = async (user) => {
  selectedUser.value = user
  
  // 加载该用户的聊天历史
  try {
    const res = await chatApi.getHistory(user.userId)
    if (res.code === 200 && res.data) {
      currentMessages.value = res.data.map(msg => ({
        id: msg.id,
        senderId: msg.senderId,
        senderName: msg.senderName,
        senderAvatar: msg.senderAvatar,
        content: msg.content,
        sendTime: msg.sendTime,
        userRole: msg.userRole
      }))
      scrollToBottom()
    }
  } catch (err) {
    console.error('加载聊天历史失败:', err)
  }
  
  // 标记为已读
  user.unreadCount = 0
}

const sendMessage = async () => {
  if (!inputMessage.value.trim()) {
    ElMessage.warning('请输入消息')
    return
  }

  if (!selectedUser.value) {
    ElMessage.warning('请先选择用户')
    return
  }

  if (!stompClient || !stompClient.connected) {
    ElMessage.error('未连接到服务器，请刷新页面重试')
    return
  }

  sending.value = true
  try {
    const staffId = authStore.user?.id || authStore.user?.userId || 0
    const messageData = {
      senderId: staffId,
      senderName: authStore.user?.username || '客服',
      senderAvatar: authStore.user?.avatar,
      receiverId: selectedUser.value.userId,
      content: inputMessage.value,
      type: 'text',
      userRole: 'staff'
    }

    // 通过 WebSocket 发送消息
    stompClient.send('/app/send', {}, JSON.stringify(messageData))

    // 本地立即显示员工自己的消息
    currentMessages.value.push({
      id: Date.now(),
      senderId: staffId,
      senderName: messageData.senderName,
      senderAvatar: messageData.senderAvatar,
      content: messageData.content,
      sendTime: new Date().toISOString(),
      userRole: 'staff'
    })
    scrollToBottom()

    // 更新用户列表中的最后消息
    const user = userList.value.find(u => u.userId === selectedUser.value.userId)
    if (user) {
      user.lastMessage = inputMessage.value
      user.lastTime = new Date()
    }

    inputMessage.value = ''
    scrollToBottom()
  } catch (err) {
    console.error('发送消息失败:', err)
    ElMessage.error('发送失败，请重试')
  } finally {
    sending.value = false
  }
}

const useQuickReply = (reply) => {
  inputMessage.value = reply
}

const markAllRead = async () => {
  if (selectedUser.value) {
    selectedUser.value.unreadCount = 0
    ElMessage.success('已标记为已读')
  }
}

const scrollToBottom = () => {
  setTimeout(() => {
    if (messagesContainer.value) {
      messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
    }
  }, 100)
}

onMounted(() => {
  loadUserList()
  connectWebSocket()
})

onUnmounted(() => {
  if (stompClient && stompClient.connected) {
    stompClient.disconnect()
  }
})
</script>

<style scoped>
.customer-service {
  padding: 20px;
  height: calc(100vh - 100px);
}

.service-container {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 16px;
  height: 100%;
  background: var(--color-surface);
}

.user-list-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.section-header {
  padding: 16px;
  border-bottom: 1px solid var(--color-border);
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: var(--color-surface-2);
}

.section-header h3 {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.user-list {
  flex: 1;
  overflow-y: auto;
}

.user-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  cursor: pointer;
  transition: background 0.2s;
  border-bottom: 1px solid var(--color-border);
  position: relative;
}

.user-item:hover {
  background: var(--color-surface-2);
}

.user-item.active {
  background: var(--color-primary-light);
  border-left: 3px solid var(--color-primary);
}

.user-info {
  flex: 1;
  min-width: 0;
}

.username {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text);
  margin: 0 0 4px;
}

.last-message {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.last-time {
  font-size: 11px;
  color: var(--color-text-muted);
  position: absolute;
  top: 12px;
  right: 16px;
}

.chat-section {
  display: flex;
  flex-direction: column;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  overflow: hidden;
}

.empty-chat {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--color-text-muted);
}

.empty-chat p {
  margin-top: 16px;
  font-size: 14px;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid var(--color-border);
  background: var(--color-surface-2);
}

.header-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-info h3 {
  font-size: 16px;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 4px;
}

.user-id {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0;
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

.message-group {
  display: flex;
  margin-bottom: 8px;
}

.message-group.user {
  justify-content: flex-start;
}

.message-group.staff {
  justify-content: flex-end;
}

.message-item {
  display: flex;
  gap: 8px;
  max-width: 70%;
}

.message-group.staff .message-item {
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

.message-group.staff .message-content {
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

.message-group.staff .message-text {
  background: #4caf82;
  color: #fff;
}

.message-time {
  font-size: 11px;
  color: var(--color-text-muted);
  margin: 0;
}

.quick-replies {
  padding: 12px 16px;
  border-top: 1px solid var(--color-border);
  background: var(--color-surface-2);
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
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
</style>
