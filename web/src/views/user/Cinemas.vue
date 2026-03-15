<template>
  <div class="cinemas-page">
    <div class="page-header">
      <h1 class="page-title">影院信息</h1>
      <el-input v-model="keyword" placeholder="搜索影院..." style="width:220px" clearable @input="fetchCinemas">
        <template #prefix><el-icon><Search /></el-icon></template>
      </el-input>
    </div>
    <div class="cinemas-list" v-loading="loading">
      <div v-for="cinema in cinemas" :key="cinema.id" class="cinema-card" @click="$router.push(`/cinemas/${cinema.id}`)">
        <div class="cinema-img">
          <img :src="`https://picsum.photos/seed/cinema${cinema.id}/400/200`" :alt="cinema.name" />
        </div>
        <div class="cinema-info">
          <h3 class="cinema-name">{{ cinema.name }}</h3>
          <p class="cinema-addr">
            <el-icon><Location /></el-icon>
            {{ cinema.address }}
          </p>
          <p class="cinema-phone">
            <el-icon><Phone /></el-icon>
            {{ cinema.phone }}
          </p>
          <div class="cinema-tags">
            <el-tag v-for="f in cinema.facilities?.split(',')" :key="f" size="small" type="info" style="margin-right:6px">{{ f }}</el-tag>
          </div>
          <div class="cinema-footer">
            <span class="cinema-desc">{{ cinema.description }}</span>
          </div>
        </div>
      </div>
    </div>
    <el-empty v-if="cinemas.length === 0 && !loading" description="暂无影院信息" />
  </div>
</template>

<script setup>
import { cinemaApi } from '@/api'
import { Location, Phone, Search } from '@element-plus/icons-vue'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const keyword = ref('')
const cinemas = ref([])

const fetchCinemas = async () => {
  loading.value = true
  try {
    const res = await cinemaApi.getPage({ keyword: keyword.value, size: 50 })
    if (res.code === 200) {
      cinemas.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取影院列表失败:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchCinemas()
})
</script>

<style scoped>
.cinemas-page { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
.page-title { font-size: 22px; font-weight: 700; color: var(--color-text); }
.cinemas-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 20px; }
.cinema-card { background: var(--color-surface); border: 1px solid var(--color-border); border-radius: var(--radius); overflow: hidden; transition: border-color .2s, transform .2s; cursor: pointer; }
.cinema-card:hover { border-color: var(--color-primary); transform: translateY(-3px); }
.cinema-img { height: 160px; overflow: hidden; }
.cinema-img img { width: 100%; height: 100%; object-fit: cover; transition: transform .3s; }
.cinema-card:hover .cinema-img img { transform: scale(1.05); }
.cinema-info { padding: 16px; }
.cinema-name { font-size: 16px; font-weight: 700; color: var(--color-text); margin-bottom: 8px; }
.cinema-addr, .cinema-phone { display: flex; align-items: center; gap: 6px; font-size: 13px; color: var(--color-text-muted); margin-bottom: 6px; }
.cinema-tags { margin: 10px 0; }
.cinema-footer { display: flex; align-items: center; justify-content: space-between; }
.cinema-desc { font-size: 12px; color: var(--color-text-muted); overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 200px; }
</style>
