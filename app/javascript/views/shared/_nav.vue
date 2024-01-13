<template>
  <section class="top-nav">
    <div class="container">
      <div class="row">
        <div class="col-md-16 col-lg-21">
          <nav v-if="isLoggedIn">
            <ul>
              <li v-if="!!userName">
                {{userName}}
              </li>
              <li :class="activeOn(['root_path'])">
                <router-link to="/" >Home</router-link>
              </li>
              <li :class="activeOn(['limit_exceeded_path'])">
                <router-link to="/limit_exceeded" >Exceeded Daily Limit</router-link>
              </li>
              <li :class="activeOn(['profile_page'])">
                <router-link to="/profile" >Profile</router-link>
              </li>
              <li>
                <a @click.prevent="logout">{{ $t('nav.logout') }}</a>
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
import { SessionStore } from "@/stores/session_store";

export default {
  setup() {
    const store = SessionStore();

    return { store }
  },

  methods: {
    activeOn(paths) {
      return paths.includes(this.$route.name) ? 'active' : ''
    },

    logout() {
      Cookies.remove('session_token');
      this.$router.go(this.$router.currentRoute)
    }
  },

  computed: {
    isLoggedIn() {
      return !!Cookies.get('session_token');
    },
    userName() {
      return localStorage.getItem('userName')
    }
  }
}
</script>