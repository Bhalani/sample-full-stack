import { defineStore } from 'pinia'
import Cookies from 'js-cookie';

export const FoodEntryStore = defineStore('food_entry', {
  state: () => {
    return {
      foodEntries: [],
      threshold: 0,
      consumed_calories_today: 0,
      pagination: {},
      page: 1,
      foods: [],
      creationError: null,
      filter: {},
      users: []
    }
  },

  actions: {
    async index() {
      return this.axios.get('/calories', { params: Object.assign(this.filter, { page: this.page }) }).then(response => {
        this.foodEntries = response.data.food_entries;
        this.threshold = response.data.daily_calorie_limit;
        this.consumed_calories_today = response.data.consumed_calorie_today;
        this.pagination = response.data.pagination
      })
    },

    async update(entryId, params) {
      return this.axios.put(`/calories/${entryId}`, params).then(response => {
        this.foodEntries = Object.assign(this.foodEntries, response.data.food_entry);
      })
    },

    async destroy(entryId, params) {
      return this.axios.delete(`/calories/${entryId}`, params).then(_response => {
        this.index();
      })
    },

    async getFood(params) {
      return this.axios.get(`/foods`).then(response => {
        this.foods = response.data.foods
      })
    },

    async getUsers(params) {
      return this.axios.get(`/users`).then(response => {
        this.users = response.data.users
      })
    },

    async create(params) {
      return this.axios.post('/calories', params).then(response => {
        console.log(response.data.error)
        if(response.data.error) {
          this.creationError = response.data.error
        }
      })
    }
  }
})
