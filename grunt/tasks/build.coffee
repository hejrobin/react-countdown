module.exports = (grunt) ->

  grunt.registerTask 'build', ->

    grunt.task.run 'coffeelint', 'cjsx'

    grunt.task.run 'less'
