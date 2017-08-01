const apiPort = process.env.API_PORT
if (!apiPort) throw new Error('No api port')
const apiURL = `http://localhost:${apiPort}/api/edge`

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
    vendor: ['babel-polyfill'],
    babel: {
      plugins: ['lodash', 'syntax-optional-chaining']
    }
  },
  env: {
    // dublicate of axios baseURL for internal usage
    baseURL: apiURL
  },
  plugins: [
    '~plugins/buefy',
    '~plugins/multiwatch'
  ],
  // loading starts from bottom
  modules: [
    '@nuxtjs/bulma',
    '@nuxtjs/font-awesome',
    '@nuxtjs/apollo',
    'auth-devise',
    '@nuxtjs/axios'
  ],
  axios: {
    baseURL: apiURL,
    debug: process.env.NODE_ENV !== 'production',
    proxyHeaders: false,
    credentials: false
  },
  apollo: {
    clients: {
      default: `${apiURL}/graphql`
    }
  }
}
