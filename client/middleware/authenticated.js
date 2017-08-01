export default function ({ store, redirect }) {
  if (!store.getters.signedIn) {
    redirect('/account/signin')
  }
}
