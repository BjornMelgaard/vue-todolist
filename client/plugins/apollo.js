import Vue from 'vue'
import VueApollo from 'vue-apollo'
import { ApolloClient, createNetworkInterface } from 'apollo-client'

Vue.use(VueApollo)

function createClient (ctx) {
  const { isDev, isClient } = ctx

  const networkInterface = createNetworkInterface({
    uri: `${process.env.API_URL}/graphql`,
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
    defaultClient: createClient(ctx)
  })
}
