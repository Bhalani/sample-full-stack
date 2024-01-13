<template>
  <section class="col-xs-24">
    <div v-if="store.pagination.next || store.pagination.previous">
      <ul class="pagination flex">
        <li v-if="store.pagination.previous != null">
          <a href="javascript:;" @click.prevent="callPage(store.pagination.previous)" v-if="store.pagination.previous">
            <span>&laquo;</span>
          </a>
          <router-link :to="{path: $route.path, query: setQuery(store.pagination.previous)}" >

          </router-link>
        </li>

        <li v-for="page in store.pagination.pages" :key="page" :class="[store.pagination.current == page ? 'active' : '']">
          <a href="javascript:;" @click.prevent="callPage(page)" v-if="page != store.pagination.current">{{ page }}</a>

          <!-- <span v-if="page != store.pagination.current && page == 4">...</span> -->
          <span v-if="page == store.pagination.current">{{ page }}</span>
          <!-- <span v-if="page == store.pagination.current && page == 4">...</span> -->
        </li>

        <li v-if="store.pagination.next != null && store.pagination.pages > 0">
          <a href="javascript:;" @click.prevent="callPage(store.pagination.next)" v-if="store.pagination.next">
            <span>&raquo;</span>
          </a>
        </li>
      </ul>
    </div>
  </section>
</template>

<script>
export default {
  props: ['store', 'callPageCallback'],

  beforeConnect() {
    debugger
  },
  connect() {
    console.log(this.store.pagination)
  },
  methods: {
    setQuery(page) {
      let query = JSON.parse(JSON.stringify(this.$route.query));
      query['page'] = page;

      return query;
    },

    callPage(page) {
      this.store.page = page
      this.callPageCallback()
    }
  },

  watch: {
    '$route.query': function() {
      this.$emit('clicked');
    }
  }
}
</script>
