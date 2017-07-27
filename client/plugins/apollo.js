import Vue from 'vue'
import VueApollo from 'vue-apollo'
import { ApolloClient, createNetworkInterface } from 'apollo-client'

Vue.use(VueApollo)

function createClient () {
  const isDev = process.env.NODE_END === 'development'
  const isClient = process.browser

  const networkInterface = createNetworkInterface({
    uri: `${process.env.API_URL}/graphql`,
    // uri: 'https://api.graph.cool/simple/v1/cj1dqiyvqqnmj0113yuqamkuu',
    transportBatching: true
  })

  return new ApolloClient({
    networkInterface,
    connectToDevTools: isDev && isClient,
    ssrMode: !isClient
  })
}

export default (ctx) => {
  const { app } = ctx

  app.apolloProvider = new VueApollo({
    defaultClient: createClient()
  })
}
