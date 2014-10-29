module.exports = (grunt) ->

  require('load-grunt-tasks') grunt
  loadOptions = require './grunt/load-options'
  grunt.loadTasks 'grunt/tasks'

  config =
    env: process.env
    pkg: grunt.file.readJSON 'package.json'

  config = loadOptions grunt, config
  grunt.initConfig config
