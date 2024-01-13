<template>
  <section class="container">
    <div v-if="!showingFoodEntryForm">
      <div class="row">
        <div class="col-xs-12"><h3>Consumed Food Records</h3></div>
        <div class="col-xs-12">
          <button @click="addRecord">+ Add Food Consumtion Entry</button>
        </div>
      </div>

      <div class="row" v-if="!isLoading">
        <div class="col-xs-12">
          Consumtion Today: <h5>{{store.consumed_calories_today}} | {{store.threshold}}</h5>
        </div>

        <div class="col-xs-12 red-text" v-if="store.consumed_calories_today >= store.threshold">
          You have reached the daily limit today.
        </div>
        <div class="col-xs-24">
          <form @submit.prevent="filter" ref="filters" accept-charset="UTF-8" class="card container">
            <h5>Filter by Date range</h5>
            <div class="row">
              <div class="col-xs-12 col-md-8 mx0auto">
                <label>Daily Calorie Limit</label>
                <input type="date" v-model="startDate" :required="!!endDate" :max="endDate" placeholder="Start Date">
              </div>

              <div class="col-xs-12 col-md-8 mx0auto">
                <label>Daily Calorie Limit</label>
                <input type="date" v-model="endDate" :required="!!startDate" :min="startDate" placeholder="End Date">
              </div>

              <div class="col-xs-24 col-md-3">
                <input type="submit" role="button" class="button button-primary" value="Save"/>
              </div>
              <div class="col-xs-24 col-md-3">
                <input type="reset" role="button" class="button button-primary" value="Clear" @click="clearFilter"/>
              </div>
            </div>
          </form>
        </div>

        <table class="col-xs-24">
          <thead>
            <tr>
              <th> Food </th>
              <th> Calories </th>
              <th> Consumed at </th>
              <th> Cheat Food? </th>
              <th> </th>
            </tr>
          </thead>

          <tbody>
            <tr v-for="entry in store.foodEntries" :key="entry.id" class="col-xs-24 col-md-6 card">
              <td>{{ entry.name }}</td>
              <td>{{ entry.calories }}</td>
              <td>{{ entry.consume_at }}</td>
              <td>
                <input type="checkbox" :id="'cheat-'+entry.id" :value="entry.is_cheat_food" v-model="entry.is_cheat_food" @change="updateRecord($event, entry.id)">
              </td>
              <td>
                <a href="javascript:;" @click.prevent="deleteRecord($event, entry.id)">Delete</a>
              </td>
            </tr>
          </tbody>
        </table>

        <pagination :store="store" :callPageCallback="fetchEntries"></pagination>
      </div>
    </div>
    <div v-if="showingFoodEntryForm">
      <new-food-entry :store="store" @back="showList"></new-food-entry>
    </div>
  </section>
</template>

<script>

import Pagination from '@/views/shared/_pagination.vue';
import { FoodEntryStore } from "@/stores/food_entry_store";
import newFoodEntry from './_newFoodEntry.vue';

export default {

  data() {
    return {
      startDate: null,
      endDate: null,
      isLoading: true,
      showingFoodEntryForm: false
    }
  },

  components: {
    'pagination': Pagination,
    'new-food-entry': newFoodEntry
  },

  setup() {
    const store = FoodEntryStore();

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
      });
    },
    deleteRecord(_e, entryId) {
      this.$api.call(this.store.destroy(entryId));
    },

    updateRecord(e, entryId) {
      this.$api.call(this.store.update(entryId, { user_calories: { is_cheat_food: e.target.value } })).then(() => {
        this.fetchEntries();
      });
    },

    filter() {
      this.store.page = 1
      this.store.filter = { start_date: this.startDate, end_date: this.endDate }
      this.$api.call(this.store.index());
    },

    clearFilter() {
      this.store.filter = {};
      this.fetchEntries();
      this.startDate = null
      this.endDate = null
    },

    addRecord() {
      this.showingFoodEntryForm = true;
    },

    showList() {
      this.fetchEntries();
      this.showingFoodEntryForm = false;
    }
  }
}
</script>
