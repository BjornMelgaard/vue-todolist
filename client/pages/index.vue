<template>
  <div>
    <h3>Cars</h3>
    <ul>
      <li v-for="car in allCars">
        <nuxt-link :to="`car/${car.id}`">
          {{ car.year }} {{ car.make }} {{ car.model }}
        </nuxt-link>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import Component from "nuxt-class-component"

import allCars from '~/queries/allCars'

export default {
  apollo: {
    allCars: {
      prefetch: true,
      query: allCars
    }
  }
}
</script>

<style></style>
