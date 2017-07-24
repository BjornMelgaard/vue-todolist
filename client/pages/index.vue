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

export default {
  data () {
    console.log(this.$error) // binded function in browser console, undefined in terminal
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
        console.log(this.loading) // defined everywhere
        console.log(this.$error) // binded function in browser console, undefined in terminal
        console.log(error)
        // this.$error(error.message) // critical error here, but not in browser
      }
    }
  }
}
</script>
