<template lang="pug">
  div(v-if='Car')
    h3 {{ Car.make }} {{ Car.model }}
    p {{ formatCurrency(Car.price) }}
    img(:src='Car.photoURL', :alt='`${Car.model} photo`')
    p
      nuxt-link(to='/') Home page
</template>

<script>
import car from '~/queries/car'

export default {
  apollo: {
    Car: {
      query: car,
      prefetch: ({ route }) => ({ id: route.params.id }),
      variables () {
        return { id: this.$route.params.id }
      }
    }
  },
  methods: {
    formatCurrency (num) {
      const formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 2
      })
      return formatter.format(num)
    }
  }

}
</script>

<style>
img {
  max-width: 600px;
}
</style>
