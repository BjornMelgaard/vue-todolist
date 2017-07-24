<template>
  <div>
    <h3>Cars</h3>
    <div v-if="loading > 0">
      loading...
    </div>
    <ul v-else>
      <li v-for="car in allCars">
        <nuxt-link :to="`car/${car.id}`">
          {{ car.year }} {{ car.make }} {{ car.model }}
        </nuxt-link>
      </li>
    </ul>
  </div>
</template>

<script>
import gql from 'graphql-tag'
import { mapActions } from 'vuex'
import { ADD_TOAST_MESSAGE } from 'vuex-toast'

export default {
  data () {
    return {
      loading: 0
    }
  },
  apollo: {
    allCars: {
      query: gql`query {
        projects {
          name
        }
      }`,
      loadingKey: 'loading',
      error (error) {
        console.log('sending')
        this.sendNotification(error.message)
      }
    }
  },
  methods: {
    ...mapActions({
      addToast: ADD_TOAST_MESSAGE
    }),

    sendNotification (text) {
      this.addToast({
        text,
        type: 'success',
        dismissAfter: 10000
      })
    }
  }
}
</script>
