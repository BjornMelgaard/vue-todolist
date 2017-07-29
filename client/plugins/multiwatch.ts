import Vue from 'vue'

Vue.prototype.$multiwatch = function (props, watcher) {
  var iterator = function (prop) {
    this.$watch(prop, watcher)
  }
  props.forEach(iterator, this)
}
