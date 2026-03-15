<template>
  <div class="admin-movies">
    <div class="page-header">
      <h2 class="page-title">电影管理</h2>
      <div class="header-actions">
        <el-input v-model="keyword" placeholder="搜索电影名..." style="width:200px" clearable @keyup.enter="fetchMovies">
          <template #prefix><el-icon><Search /></el-icon></template>
        </el-input>
        <el-select v-model="filterStatus" placeholder="全部状态" clearable style="width:130px" @change="fetchMovies">
          <el-option label="正在热映" :value="1" />
          <el-option label="即将上映" :value="2" />
        </el-select>
        <el-button type="primary" @click="openDialog()">
          <el-icon><Plus /></el-icon> 新增电影
        </el-button>
      </div>
    </div>

    <el-table :data="movies" style="width:100%" v-loading="loading">
      <el-table-column label="电影" min-width="200">
        <template #default="{ row }">
          <div style="display:flex;align-items:center;gap:10px">
            <img :src="row.poster" :alt="row.title" style="width:50px;height:70px;object-fit:cover;border-radius:4px" />
            <div>
              <div style="font-weight:600">{{ row.title }}</div>
              <div style="font-size:12px;color:var(--color-text-muted)">{{ row.genre?.replace(/,/g, ' / ') }}</div>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="duration" label="时长" width="80">
        <template #default="{ row }">{{ row.duration }}分钟</template>
      </el-table-column>
      <el-table-column prop="rating" label="评分" width="80">
        <template #default="{ row }">
          <span style="color:#e8b84b">{{ row.rating || 0 }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="releaseDate" label="上映日期" width="110" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
            {{ row.status === 1 ? '正在热映' : '即将上映' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="160" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" text @click="openDialog(row)">编辑</el-button>
          <el-button size="small" type="danger" text @click="deleteMovie(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog v-model="dialogVisible" :title="editingMovie ? '编辑电影' : '新增电影'" width="600px">
      <el-form :model="movieForm" label-width="90px">
        <el-form-item label="电影名称" required>
          <el-input v-model="movieForm.title" />
        </el-form-item>
        <el-form-item label="海报URL">
          <el-input v-model="movieForm.poster" placeholder="图片URL" />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="movieForm.genreList" multiple style="width:100%">
            <el-option v-for="g in genreOptions" :key="g" :label="g" :value="g" />
          </el-select>
        </el-form-item>
        <el-form-item label="导演">
          <el-input v-model="movieForm.director" />
        </el-form-item>
        <el-form-item label="主演">
          <el-input v-model="movieForm.actors" placeholder="逗号分隔" />
        </el-form-item>
        <el-form-item label="时长（分）">
          <el-input-number v-model="movieForm.duration" :min="1" />
        </el-form-item>
        <el-form-item label="上映日期">
          <el-date-picker v-model="movieForm.releaseDate" type="date" value-format="YYYY-MM-DD" style="width:100%" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="movieForm.status">
            <el-radio :value="1">正在热映</el-radio>
            <el-radio :value="2">即将上映</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="简介">
          <el-input v-model="movieForm.description" type="textarea" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveMovie" :loading="saving">确认保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { movieApi } from '@/api'
import { Plus, Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { onMounted, ref } from 'vue'

const loading = ref(false)
const saving = ref(false)
const keyword = ref('')
const filterStatus = ref(null)
const dialogVisible = ref(false)
const editingMovie = ref(null)
const movies = ref([])

const genreOptions = ['科幻', '动作', '动画', '喜剧', '爱情', '悬疑', '犯罪', '历史', '奇幻', '恐怖']

const defaultForm = () => ({
  title: '', poster: '', genreList: [], director: '', actors: '',
  duration: 120, releaseDate: '', status: 1, description: ''
})
const movieForm = ref(defaultForm())

const fetchMovies = async () => {
  loading.value = true
  try {
    const res = await movieApi.getPage({
      keyword: keyword.value,
      status: filterStatus.value,
      size: 100
    })
    if (res.code === 200) {
      movies.value = res.data?.records || []
    }
  } catch (err) {
    console.error('获取电影列表失败:', err)
  } finally {
    loading.value = false
  }
}

function openDialog(movie = null) {
  editingMovie.value = movie
  if (movie) {
    movieForm.value = {
      ...movie,
      genreList: movie.genre?.split(',') || [],
      actors: movie.actors || ''
    }
  } else {
    movieForm.value = defaultForm()
  }
  dialogVisible.value = true
}

async function saveMovie() {
  if (!movieForm.value.title) return ElMessage.warning('请输入电影名称')
  saving.value = true
  
  const data = {
    ...movieForm.value,
    genre: movieForm.value.genreList?.join(',') || ''
  }
  
  try {
    let res
    if (editingMovie.value) {
      res = await movieApi.update(editingMovie.value.id, data)
    } else {
      res = await movieApi.create(data)
    }
    
    if (res.code === 200) {
      ElMessage.success(editingMovie.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchMovies()
    }
  } catch (err) {
    console.error('保存电影失败:', err)
  } finally {
    saving.value = false
  }
}

function deleteMovie(movie) {
  ElMessageBox.confirm(`确认删除电影《${movie.title}》？`, '删除确认', { type: 'warning' }).then(async () => {
    try {
      const res = await movieApi.delete(movie.id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchMovies()
      }
    } catch (err) {
      console.error('删除电影失败:', err)
    }
  }).catch(() => {})
}

onMounted(() => {
  fetchMovies()
})
</script>

<style scoped>
.admin-movies { padding-bottom: 40px; }
.page-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; margin-bottom: 20px; }
.page-title { font-size: 18px; font-weight: 700; color: var(--color-text); }
.header-actions { display: flex; gap: 10px; flex-wrap: wrap; }
</style>
