importScripts('workbox-sw.prod.v1.1.0.js')

/**
 * DO NOT EDIT THE FILE MANIFEST ENTRY
 *
 * The method precache() does the following:
 * 1. Cache URLs in the manifest to a local cache.
 * 2. When a network request is made for any of these URLs the response
 *    will ALWAYS comes from the cache, NEVER the network.
 * 3. When the service worker changes ONLY assets with a revision change are
 *    updated, old cache entries are left as is.
 *
 * By changing the file manifest manually, your users may end up not receiving
 * new versions of files because the revision hasn't changed.
 *
 * Please use workbox-build or some other tool / approach to generate the file
 * manifest which accounts for changes to local files and update the revision
 * accordingly.
 */
const fileManifest = [
  {
    'url': '/_nuxt/0.nuxt.bundle.d4b7eb4013ebe55871be.js',
    'revision': '70e8da3f23b30e1d8bd14c025af63e6a'
  },
  {
    'url': '/_nuxt/1.nuxt.bundle.378c5053cc60dffb2fd0.js',
    'revision': '5ad89e76ab7e4e0abdb1d25ddb496b7d'
  },
  {
    'url': '/_nuxt/2.nuxt.bundle.2c19e4c5195b0ce8c820.js',
    'revision': 'ed29a9395278a1856ac20c7184d588e3'
  },
  {
    'url': '/_nuxt/client-manifest.json',
    'revision': 'fb68c3fb8ed45d5a7114dda3bf5eccd9'
  },
  {
    'url': '/_nuxt/index.html',
    'revision': '744fb1c184ce0e85af057191b683d6a2'
  },
  {
    'url': '/_nuxt/manifest.05168352.json',
    'revision': 'bbb0b1237320a3eb6a98dd3cb1039c94'
  },
  {
    'url': '/_nuxt/manifest.a56263c545aa9af79beb.js',
    'revision': '1b102c45de92a75dbbf88a10997d706c'
  },
  {
    'url': '/_nuxt/nuxt.bundle.8aef1693312b60690609.js',
    'revision': 'e5c080b464281c315db0fef7968af14f'
  },
  {
    'url': '/_nuxt/server-bundle.json',
    'revision': '6e6f1a9a80354cb142b4c06f29d17ead'
  },
  {
    'url': '/_nuxt/vendor.bundle.492199eb0094753f096d.js',
    'revision': 'ff7d4bb616c92f4eb148d51d812d238e'
  }
]

const workboxSW = new self.WorkboxSW({
  'cacheId': 'vue-todolist_1.0.0',
  'clientsClaim': true,
  'directoryIndex': '/'
})
workboxSW.precache(fileManifest)
workboxSW.router.registerRoute('/_nuxt/**', workboxSW.strategies.cacheFirst({}), 'GET')
workboxSW.router.registerRoute('/**', workboxSW.strategies.networkFirst({}), 'GET')
