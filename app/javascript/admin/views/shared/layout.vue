<template>
  <section>
    <nav-bar />
    <router-view />
  </section>
</template>


<script>
import NavBar from './_nav.vue';
import Cookies from 'js-cookie';

export default {
  components: {
    'nav-bar': NavBar
  },

  beforeCreate() {
    if(!Cookies.get('admin_session_token') && this.$route.name !== 'login_path') {
      this.$router.push({name: 'login_path'})
    }
  }
}
</script>
