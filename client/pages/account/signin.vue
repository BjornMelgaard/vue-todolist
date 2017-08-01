<template lang="pug">
  section.hero.is-fullheight.is-dark.is-bold
    .hero-body
      .container
        .columns.is.vcentered
          .column.is-8-tablet.is-offset-2-tablet.is-6-desktop.is-offset-3-desktop
            h1.title I already have an account
            signin-form
</template>

<script>
  import SigninForm from '~/components/account/SigninForm'

  export default {
    name: 'Signin',
    middleware: 'unauthenticated',
    components: { SigninForm }
  }
</script>
