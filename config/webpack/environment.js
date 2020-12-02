const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const webpack = require('webpack')
const config = environment.toWebpackConfig();

environment.loaders.append('html', {
  test: /\.html$/,
  use:[
    { loader: 'html-loader' }
  ]
})
environment.loaders.prepend('typescript', typescript)

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}));

config.resolve.alias = {
 jquery: 'jquery/src/jquery'
};

module.exports = environment
