<template>
  <div>
    <h3>Cars</h3>
    <div>
      {{project}}
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  async asyncData ({ app }) {
    const dd = await app.$axios.get('/members_only')
    return {
      project: dd.data
    }
  },
  fetch ({ app }) {
    // console.log(app.$axios)
    // console.log(this.$axios)
  }
}
</script>
