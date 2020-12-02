const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
environment.loaders.append('html', {
  test: /\.html$/,
  use:[
    { loader: 'html-loader' }
  ]
})
environment.loaders.prepend('typescript', typescript)
module.exports = environment
