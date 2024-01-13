<template>
  <section class="top-nav">
    <div class="container">
      <div class="row" v-if="isLoggedIn">
        <div class="col-md-16 col-lg-21">
          <nav>
            <ul>
              <li :class="activeOn(['root_path'])">
                <router-link :to="{name: 'root_path'}">Dashboard</router-link>
              </li>

              <li :class="activeOn(['food_entries_path'])">
                <router-link :to="{name: 'food_entries_path'}">Food Entries</router-link>
              </li>

              <li :class="activeOn(['limit_exceeded_path'])">
                <router-link to="/limit_exceeded" >Exceeded Daily Limit</router-link>
              </li>

              <li>
                <a href="javascript:;" @click.prevent="logout">{{ $t('nav.logout') }}</a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import Cookies from 'js-cookie';

export default {
  methods: {
    activeOn(paths) {
      return paths.includes(this.$route.name) ? 'active' : ''
    },

    logout() {
      console.log("admin logout")
      Cookies.remove('admin_session_token');
      this.$router.go(this.$router.currentRoute)
    }
  },
  computed: {
    isLoggedIn() {
      return !!Cookies.get('admin_session_token');
    },
    userName() {
      return localStorage.getItem('adminName')
    }
  }
}
</script>