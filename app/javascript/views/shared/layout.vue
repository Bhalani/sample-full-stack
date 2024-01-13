<template>
  <div>
    <nav-bar />
    <div class="container">
      <router-view/>
    </div>
  </div>
</template>


<script>
import NavBar from './_nav.vue';
import Cookies from 'js-cookie';

export default {
  data() {
    return {
      loggedIn: false
    }
  },

  components: {
    'nav-bar': NavBar
  },

  beforeCreate() {
    if(!Cookies.get('session_token') && this.$route.name !== 'login_path') {
      this.$router.push({name: 'login_path'})
    }
  }
}
</script>
