const { resolve } = require('path')

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
  ** Customize the progress-bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Global CSS
  */
  css: [
    'buefy/lib/buefy.css',
    { src: '~assets/css/main.scss', lang: 'scss' }
  ],
  build: {
    /*
    ** Run ESLINT on save
    */
    // extend (config, ctx) {
    //   if (ctx.isClient) {
    //     config.module.rules.push({
    //       enforce: 'pre',
    //       test: /\.(js|vue)$/,
    //       loader: 'eslint-loader',
    //       exclude: /(node_modules)/
    //     })
    //   }
    // },
    // vendor: ['babel-polyfill', 'vue-apollo', 'apollo-client']
  },
  env: {
    // dublicate baseURL for internal usage
    baseURL: 'http://localhost:3001/api/edge'
  },
  router: {
    // middleware: 'apollo'
  },
  plugins: [
    // '~plugins/apollo.js'
    resolve(__dirname, 'plugins/buefy.js'),
    resolve(__dirname, 'plugins/multiwatch.js')
  ],
  modules: [
    ['@nuxtjs/axios', { baseURL: 'http://localhost:3001/api/edge' }],
    '@nuxtjs/bulma',
    '@nuxtjs/font-awesome'
  ]
}
