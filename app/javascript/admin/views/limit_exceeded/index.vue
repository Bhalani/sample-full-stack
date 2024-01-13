<template>
  <section class="container">
    <h3>Days exceeded daily calorie limit</h3>

    <div class="row" v-if="!isLoading">
      <table class="col-xs-24">
        <thead>
          <tr>
            <th> User ID </th>
            <th> User Name </th>
            <th> Limit </th>
            <th> Consumed Calories </th>
            <th> Date </th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="entry in store.dailyExceededRecords" :key="entry.id" class="col-xs-24 col-md-6 card">
            <td>{{ entry.user_id }}</td>
            <td>{{ entry.user_name }}</td>
            <td>{{ entry.limit }}</td>
            <td>{{ entry.total_calories }}</td>
            <td>{{ entry.consume_date }}</td>
          </tr>
        </tbody>
      </table>

      <pagination :store="store" :callPageCallback="fetchEntries"></pagination>
    </div>
  </section>
</template>

<script>

import Pagination from '@/views/shared/_pagination.vue';
import { LimitExceededStore } from "@/admin/stores/limit_exceeded_store";

export default {

  data() {
    return {
      startDate: null,
      endDate: null,
      isLoading: true
    }
  },

  components: {
    'pagination': Pagination
  },

  setup() {
    const store = LimitExceededStore();

    return { store }
  },

  beforeCreate() {
    this.$api.call(this.store.index()).then(() => {
      this.isLoading = false
    })
  },

  methods: {
    fetchEntries() {
      this.$api.call(this.store.index()).then(() => {
        this.isLoading = false
      })
    },

    // filter() {
    //   this.$api.call(this.store.index({ start_date: this.startDate, end_date: this.endDate }));
    // }
  }
}
</script>
