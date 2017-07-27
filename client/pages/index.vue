<template>
  <div>
    <h3>Cars</h3>
    <div>
      {{project}}
    </div>
  </div>
</template>

<script>
// import { mapActions } from 'vuex'

export default {
  async asyncData ({ app }) {
    console.log('asdf')
    // const dd = await app.$axios.get('/members_only')
    return {
      project: 'asdf'
    }
  },
  fetch ({ app }) {
    // console.log(app.$axios)
    // console.log(this.$axios)
  }
}
</script>
