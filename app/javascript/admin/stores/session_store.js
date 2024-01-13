import { defineStore } from 'pinia'
import Cookies from 'js-cookie';

export const SessionStore = defineStore('session', {
  state: () => {
    return {
      loggedIn: !!Cookies.get('admin_session_token'),
      user: null,
      error: null
    }
  },

  actions: {
    async getUser(token) {
      return this.axios.post('/session', { token: token }).then(response => {
        if(response.data.error){
          this.error = response.data.error
        } else {
          this.user = response.data.user;
          localStorage.setItem('adminName', `${this.user.first_name} ${this.user.last_name}`);
        }
      })
    },
  }
});
