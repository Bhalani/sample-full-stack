<template>
  <section class="container">
    <h1>Profile</h1>
    <div v-if="!isLoading">
      <ul>
        <li>
          Name:
          <h4>{{store.user.first_name}} {{store.user.last_name}}</h4>
        </li>
        <li>
          Email:
          <h4>{{store.user.email}}</h4>
        </li>
        <li>
          <form @submit.prevent="update" ref="filters" accept-charset="UTF-8" class="card container">
            <div class="row">
              <div class="col-xs-24 col-md-10 mx0auto">
                <label>Daily Calorie Limit</label>
                <input type="number" min="500" required v-model="threshold" placeholder="Daily Calorie Limit">
              </div>
            </div>
            <div class="row">
              <div class="col-xs-24 col-md-5">
                <input type="submit" role="button" class="button button-primary" value="Save" ref="saveBtn">
              </div>
            </div>
          </form>
        </li>
      </ul>
    </div>
  </section>
</template>

<script>
import { SessionStore } from "@/stores/session_store";

export default {
  data() {
    return {
      isLoading: true,
      threshold: 0
    }
  },
  setup() {
    const store = SessionStore();

    return { store }
  },

  beforeCreate() {
    this.$api.call(this.store.getUser()).then(() => {
      this.isLoading = false;
      this.threshold = this.store.user.daily_calorie_limit
    })
  },

  methods: {
    update() {
      this.$api.call(this.store.update(this.threshold)).then(() => {
        this.$refs.saveBtn.value = "Saved"
      })
    }
  },

  watch: {
    'threshold': function(val, oldVal) {
      if(oldVal != 0) {
        this.$refs.saveBtn.value = "Save"
      }
    }
  }
}
</script>
