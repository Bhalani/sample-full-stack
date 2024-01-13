import { defineStore } from 'pinia'
import Cookies from 'js-cookie';

export const LimitExceededStore = defineStore('limit_exceeded', {
  state: () => {
    return {
      dailyExceededRecords: [],
      pagination: {},
      page: 1,
      threshold: 0
    }
  },

  actions: {
    async index(params = {}) {
      return this.axios.get('/exceeded_calories', { params: Object.assign(params, { page: this.page }) }).then(response => {
        console.log(response.data)
        this.dailyExceededRecords = response.data.exceeded_records;
        this.threshold = response.data.daily_calorie_limit;
        this.pagination = response.data.pagination
      })
    }
  }
})
