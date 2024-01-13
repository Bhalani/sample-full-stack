import { createWebHistory, createRouter } from 'vue-router'

import Login from '@/views/login/index.vue';
import Error404 from '@/views/pages/error_404.vue';
import FoodEntryIndex from '@/views/food_entries/index.vue'
import Profile from '@/views/profile/index.vue'
import LimitExceeded from '@/views/limit_exceeded/index.vue'

const router = createRouter({
  history: createWebHistory(`/${I18n.prefix}`),
  routes: [
    { path: '/', component: FoodEntryIndex, name: 'root_path' },
    { path: '/limit_exceeded', component: LimitExceeded, name: 'limit_exceeded_path' },
    { path: '/profile', component: Profile, name: 'profile_path' },
    { path: '/login', component: Login, name: 'login_path' },
    { path: '/404', component: Error404 },
    { path: '/:catchAll(.*)', redirect: '/404' }
  ]
});

export default router;