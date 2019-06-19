const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))

environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  use: [
    { loader: 'expose-loader', options: '$' },
  ]
})

module.exports = environment
