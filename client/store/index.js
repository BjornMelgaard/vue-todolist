import Vuex from 'vuex'
import { createModule } from 'vuex-toast'

const store = () => new Vuex.Store({
  modules: {
    toast: createModule({
      dismissInterval: 8000
    })
  }
})

export default store
