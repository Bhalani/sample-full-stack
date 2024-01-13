<template>
  <section class="card container">
    <div v-if="store.error">
      <h4 class="red-text">{{store.error}}</h4>
    </div>

    <form @submit.prevent="login" ref="filters" accept-charset="UTF-8">
      <div class="row">
        <div class="col-xs-24 col-md-10 mx0auto">
          <label>Token</label>
          <input type="text" v-model="token" placeholder="token">
        </div>
      </div>
      <div class="row">
        <div class="col-xs-24 col-md-5">
          <input type="submit" role="button" class="button button-primary" value="Login">
        </div>
      </div>
    </form>
  </section>
</template>

<script>
import { SessionStore } from "@/admin/stores/session_store";
import Cookies from 'js-cookie';

export default {
  setup() {
    const store = SessionStore();

    return { store }
  },
  data: function() {
    return {
      token: null
    }
  },
  beforeCreate() {
    if(Cookies.get('admin_session_token')) {
      this.$router.push({ name: 'root_path' })
    }
  },
  methods: {
    login() {
      this.$api.call(this.store.getUser(this.token)).then(() => {
        if(this.store.user) {
          Cookies.set("admin_session_token", this.token)
          this.$router.go(this.$router.currentRoute)
        }
      })
    }
  }
}
</script>
