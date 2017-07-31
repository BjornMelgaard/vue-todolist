export default function ({ store, redirect }) {
  if (!store.getters.loggedIn) {
    redirect('/account/login')
  }
}
