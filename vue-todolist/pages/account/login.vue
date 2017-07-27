<template>
  <section class="hero is-fullheight is-dark is-bold">
    <div class="hero-body">
      <div class="container">
        <div class="columns is vcentered">
          <div class="column is-8-tablet is-offset-2-tablet is-6-desktop is-offset-3-desktop">
            <h1 class="title">I already have an account</h1>
            <login-form @submit="onSubmit"></login-form>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
  import LoginForm from '~/components/account/LoginForm'

  export default {
    name: 'Login',
    components: { LoginForm },
    // middleware: 'nonauthenticated'
    methods: {
      onSubmit ({ email, password }) {
        console.log(email)
      }
    }
  }
</script>
