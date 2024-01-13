<template>
  <section class="container">
    <div class="row">
      <div class="col-xs-24">
        Add Food Consumtion Entry
      </div>

      <div class="col-xs-24">
        <a href="javascript:;" @click.prevent="backToList"> &lt; Back to List </a>
      </div>
      <div class="col-xs-24">
        <form @submit.prevent="addRecord" ref="filters" accept-charset="UTF-8" class="card container">
          <div class="row">
            <div class="col-xs-12 col-md-8 mx0auto">
              <label>Users *</label>
              <select v-model="user" required>
                <option v-for="user in store.users" :key="user.id" :value="user.id">{{ user.first_name }} {{user.last_name}}</option>
              </select>
            </div>

            <div class="col-xs-12 col-md-8 mx0auto">
              <label>Date of consumtion *</label>
              <input type="date" v-model="date" required placeholder="Date">
            </div>

            <div class="col-xs-12 col-md-8 mx0auto">
              <label>Time of consumtion *</label>
              <input type="time" v-model="time" required placeholder="Time">
            </div>

            <div class="col-xs-12 col-md-8 mx0auto">
              <label>Food *</label>
              <select v-model="food" @change="selectCalories($event)" required>
                <option v-for="food in store.foods" :key="food.id" :value="food.id">{{ food.name }} - {{food.calories}}</option>
                <option value="-1" key="custom">Other</option>
              </select>
            </div>

            <div class="col-xs-12 col-md-8 mx0auto hidden" ref="customFood">
              <label>Other Food *</label>
              <input type="text" v-model="customFood" :required="addingCustomFood" placeholder="Food"/>
            </div>

            <div class="col-xs-12 col-md-8 mx0auto">
              <label>Daily Calorie Limit *</label>
              <input type="number" v-model="calories" min="50" required placeholder="Calories">
            </div>

            <div class="col-xs-24 col-md-5">
              <input type="submit" role="button" class="button button-primary" value="Save">
            </div>
          </div>
        </form>
      </div>
    </div>
  </section>
</template>

<script>

export default {
  props: ['store'],

  data() {
    return {
      date: new Date(),
      time: new Date(),
      food: null,
      calories: 0,
      customFood: null,
      addingCustomFood: false,
      user: null
    }
  },
  beforeCreate() {
    this.$api.call(this.store.getFood())
    this.$api.call(this.store.getUsers())
  },
  methods: {
    addRecord() {
      const params = { user_calories: { consume_at: new Date(`${this.date} ${this.time}`), calories: this.calories, food_id: this.food, custom_food: this.customFood, user_id: this.user } };
      this.$api.call(this.store.create(params)).then(() => {
        if(!this.store.creationError) {
          this.backToList();
        }
      })
    },
    selectCalories(e) {
      if (this.food === '-1') {
        this.$refs.customFood.classList.remove('hidden')
        this.addingCustomFood = true
      } else {
        this.calories = parseInt(e.target.options[e.target.options.selectedIndex].text.split(' - ')[1])
        this.$refs.customFood.classList.add('hidden')
        this.addingCustomFood = false
      }
    },
    backToList() {
      this.$emit('back')
    }
  }
}
</script>
