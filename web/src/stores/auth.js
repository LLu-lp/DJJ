import { defineStore } from 'pinia'
import { computed, ref } from 'vue'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('jy_token') || '')
  
  const storedUser = localStorage.getItem('jy_user')
  const user = ref(storedUser && storedUser !== 'undefined' ? JSON.parse(storedUser) : null)

  const isLoggedIn = computed(() => !!token.value)
  const isAdmin = computed(() => user.value?.role === 'admin')
  const isStaff = computed(() => user.value?.role === 'staff')

  function setAuth(tokenVal, userVal) {
    token.value = tokenVal
    user.value = userVal
    localStorage.setItem('jy_token', tokenVal)
    localStorage.setItem('jy_user', JSON.stringify(userVal))
  }

  function logout() {
    token.value = ''
    user.value = null
    localStorage.removeItem('jy_token')
    localStorage.removeItem('jy_user')
  }

  return { token, user, isLoggedIn, isAdmin, isStaff, setAuth, logout }
})
