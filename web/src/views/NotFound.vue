<template>
  <div class="not-found">
    <el-icon size="80" color="#e50914"><Film /></el-icon>
    <h1>404</h1>
    <p>页面走丢了，可能去看电影了</p>
    <el-button type="danger" @click="$router.push('/')">返回首页</el-button>
  </div>
</template>

<script setup>
import { Film } from '@element-plus/icons-vue'
</script>

<style scoped>
.not-found {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #0a0a0a;
  gap: 16px;
}
.not-found h1 { color: #fff; font-size: 80px; margin: 0; }
.not-found p { color: rgba(255,255,255,0.5); font-size: 16px; }
</style>
