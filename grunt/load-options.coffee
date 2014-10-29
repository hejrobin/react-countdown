module.exports = (grunt, config) ->

  path = "./grunt/tasks/options/{,**/}*.{js,coffee}"
  options = grunt.file.expand path

  for taskOptions in options
    key = taskOptions.replace /\.(js|coffee)$/, ''
    key = key.split('/').pop()
    config[key] = require "./tasks/options/#{key}"

  config
