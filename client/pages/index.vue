<template>
  <div>
    <h3>Cars</h3>
    <p>{{ smth }}</p>
  </div>
</template>

<script>
import allCars from '~/queries/allCars'

export default {
  data () {
    return {
      smth: 'safsdf'
    }
  }
  // apollo: {
  //   projects: {
  //     prefetch: true,
  //     query: allCars
  //   }
  // }
}
</script>

<style>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  line-height: 1.6;
}
a {
  text-decoration: none;
  color: #3498DB;
}
a:hover {
  border-bottom: 1px solid;
}
</style>
