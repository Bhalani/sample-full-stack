import { createWebHistory, createRouter } from 'vue-router'

import Dashboard from '@/admin/views/dashboard/index.vue';
import Login from '@/admin/views/login/index.vue';
import LimitExceeded from '@/admin/views/limit_exceeded/index.vue';
import Error404 from '@/views/pages/error_404.vue';
import FoodEntries from '@/admin/views/food_entries/index.vue'

const router = createRouter({
  history: createWebHistory(`/${I18n.prefix}admin`),
  routes: [
    { path: '/', component: Dashboard, name: 'root_path' },
    { path: '/limit_exceeded', component: LimitExceeded, name: 'limit_exceeded_path' },
    { path: '/food_entries', component: FoodEntries, name: 'food_entries_path' },
    { path: '/login', component: Login, name: 'login_path' },
    { path: '/404', component: Error404 },

    { path: '/:catchAll(.*)', redirect: '/404' }
  ]
});

export default router;