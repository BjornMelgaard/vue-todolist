const apiURL = 'http://localhost:3001/api/edge'

module.exports = {
  // Headers of the page
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
  // Customize the progress-bar color
  loading: { color: '#3B8070' },
  // Global CSS
  css: [
    'buefy/lib/buefy.css',
    { src: '~assets/css/main.scss', lang: 'scss' }
  ],
  build: {
    // Run ESLINT on save
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
    vendor: ['babel-polyfill']
  },
  env: {
    // dublicate of axios baseURL for internal usage
    baseURL: apiURL
  },
  plugins: [
    '~plugins/buefy.js',
    '~plugins/multiwatch.js'
  ],
  modules: [
    '@nuxtjs/bulma',
    '@nuxtjs/font-awesome',
    '@nuxtjs/apollo',
    ['@nuxtjs/axios', { baseURL: apiURL }],
    'auth-devise'
  ],
  apollo: {
    clients: {
      default: `${apiURL}/graphql`
    }
  }
}
