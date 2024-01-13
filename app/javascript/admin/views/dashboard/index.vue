<template>
  <section class="container">
    <div class="row">
      <div class="col-xs-24 col-md-12 card">
        <p>A Week's Food Records</p>
        <h4>{{store.metrics.this_week_records}}</h4>
      </div>
      <div class="col-xs-24 col-md-12 card">
        <p>Food Records Added on a week before a week</p>
        <h4>{{store.metrics.last_week_records}}</h4>
      </div>
      <div class="col-xs-24 col-md-12 card">
        <p>Average Calories added per user last week</p>
        <h4>{{store.metrics.average_calories_per_user}}</h4>
      </div>
    </div>
  </section>
</template>

<script>
import { DashboardStore } from "@/admin/stores/dashboard_store";

export default {
  setup() {
    const store = DashboardStore();

    return { store }
  },

  beforeCreate() {
    this.$api.call(this.store.index());
  }
}
</script>
