<template lang="pug">
form.box(ref='form', @submit.prevent='onSubmit')
  b-notification(:active.sync="error.show", type="is-danger", has-icon) {{error.text}}
  b-field(label='Email *')
    b-input(v-fields='fields.email', type='email', placeholder='Email', required)
  b-field(label='Password *')
    b-input(v-fields='fields.password', type='password', placeholder='Password', required, maxlength='30')
  button.button.is-primary(type='submit', :disabled='button.disabled', :class="{'is-loading': button.loading}") Submit
</template>

<script>
import _ from 'lodash'

export default {
  name: 'SigninForm',
  props: {
    redirect: {
      type: String,
      default: '/'
    }
  },
  data () {
    return {
      error: {
        show: false,
        text: ''
      },
      button: {
        loading: false,
        disabled: false
      },
      fields: {
        email: '',
        password: ''
      }
    }
  },
  created () {
    this.$multiwatch(['fields.email', 'fields.password'], function () {
      const valid = this.$refs.form.checkValidity()
      this.button.disabled = !valid
    })
  },
  methods: {
    async onSubmit () {
      this.button.loading = true
      try {
        await this.$store.dispatch('signIn', this.fields)
        this.$router.push(this.redirect)
      } catch (err) {
        this.button.loading = false
        console.log(err.response)
        // const errors = _.get(err, ['response', 'data', 'errors'])
        errorMessage = err?.response?.data?.errors?.join('\n')
        if (errorMessage) {
          this.error.text = errorMessage
        } else {
          this.error.text = 'Server error'
        }
      }
    }
    // onSubmit () {
    //   self = this
    //   self.button.loading = true
    //   self.$store
    //     .dispatch('signIn', this.fields)
    //     .then(r => {
    //       this.$router.push(this.redirect)
    //     })
    //     .catch(err => {
    //       console.log(err.response.data.errors)
    //       self.button.loading = false
    //       debugger
    //     })
    // }
  }
}
</script>
