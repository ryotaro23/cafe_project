const { environment } = require('@rails/webpacker')

// setting to use typescript
const typescript = require('./loaders/typescript')
environment.loaders.prepend('typescript', typescript)


// ここから
// jQuery&Bootstap
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)
// ここまで

module.exports = environment
