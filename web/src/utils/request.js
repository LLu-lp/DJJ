import axios from 'axios'
import { ElMessage } from 'element-plus'

// TODO: 替换为实际后端地址
const request = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  timeout: 10000
})

// 请求拦截器：注入 JWT Token
request.interceptors.request.use(config => {
  const token = localStorage.getItem('jy_token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// 响应拦截器：统一错误处理
request.interceptors.response.use(
  res => res.data,
  err => {
    const msg = err.response?.data?.message || '网络请求失败'
    if (err.response?.status === 401) {
      localStorage.removeItem('jy_token')
      localStorage.removeItem('jy_user')
      window.location.hash = '/login'
    }
    ElMessage.error(msg)
    return Promise.reject(err)
  }
)

export default request
