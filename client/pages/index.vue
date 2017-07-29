<template lang="pug">
  div
    h3 projects
    ul
      li(v-for='project in projects')
        nuxt-link(:to='`project/${project.id}`')
          | {{ project.name }}
</template>

<script>
import projects from '~/queries/projects'

export default {
  name: 'Index',
  middleware: 'authenticated',
  apollo: {
    projects: {
      prefetch: true,
      query: projects
    }
  }
}
</script>

<style></style>
