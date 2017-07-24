const webpack = require('webpack')

module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'starter',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Global CSS
  */
  css: ['~assets/css/main.css'],
  build: {
    /*
    ** Run ESLINT on save
    */
    extend (config, ctx) {
      if (ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    },
    vendor: ['babel-polyfill', 'vue-apollo', 'apollo-client'],
    plugins: [
      new webpack.DefinePlugin({
        // also will set baseURL and browserBaseURL in @nuxtjs/axios
        'process.env.API_URL': "'http://localhost:3001/api/edge'"
      })
    ]
  },
  router: {
    // middleware: 'apollo'
  },
  plugins: [
    '~plugins/apollo.js'
  ],
  modules: [
    '@nuxtjs/pwa',
    '@nuxtjs/axios',
    '@nuxtjs/bulma',
    '@nuxtjs/toast'
  ]
}
