<template>
  <form ref="form" class="box" @submit.prevent="onSubmit">

    <b-field label="Email *">
      <b-input v-model="model.email" type="email" required></b-input>
    </b-field>

    <b-field label="Password *">
      <b-input v-model="model.password" type="password" required maxlength="30"></b-input>
    </b-field>

    <button class="button is-primary" type="submit" :disabled="isDisabled">Submit</button>

  </form>
</template>

<script>
  export default {
    name: 'LoginForm',
    props: {
      redirect: {
        type: String,
        default: '/'
      }
    },
    data () {
      return {
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
      onSubmit () {
        this.$emit('submit', this.model)
      }
    }
  }
</script>
