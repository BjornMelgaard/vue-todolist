<template lang="pug">
  form.box(ref='form', @submit.prevent='onSubmit')
    b-field(label='Email *')
      b-input(v-model='model.email', type='email', placeholder='Email', required)
    b-field(label='Password *')
      b-input(v-model='model.password', type='password', placeholder='Password', required, maxlength='30')
    button.button.is-primary(type='submit', :disabled='isDisabled', :class="{'is-loading': isLoading}") Submit
</template>

<script>
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
      isLoading: false,
      isDisabled: true,
      model: {
        email: '',
        password: ''
      }
    }
  },
  created () {
    this.$multiwatch(['model.email', 'model.password'], function () {
      const valid = this.$refs.form.checkValidity()
      this.isDisabled = !valid
    })
  },
  methods: {
    async onSubmit () {
      this.isLoading = true
      try {
        await this.$store.dispatch('signIn', this.model)
        this.$router.push(this.redirect)
      } catch (error) {
        console.log('asdf')
        this.isLoading = false
        debugger;
      }
    }
  }
}
</script>
