import { defineStore } from 'pinia'
import Cookies from 'js-cookie';

export const LimitExceededStore = defineStore('limit_exceeded', {
  state: () => {
    return {
      dailyExceededRecords: [],
      pagination: {},
      page: 1
    }
  },

  actions: {
    async index(params = {}) {
      return this.axios.get('/exceeded_calories', { params: Object.assign(params, { page: this.page }) }).then(response => {
        console.log(response.data)
        this.dailyExceededRecords = response.data.exceeded_records;
        this.pagination = response.data.pagination
      })
    }
  }
})
