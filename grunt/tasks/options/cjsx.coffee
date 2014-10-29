componentsBuildObject = ->

  componentsBuildObject = {}
  currentComponentResources = []
  componentMatchRegex = /.*\/components\/([a-z0-9]+)/i
  componentDistPattern = './build/assets/js/components'
  componentPathPattern = './app/{,**/}/js/components/{,**/}'
  componentGlobPattern = [
    "#{componentPathPattern}*.coffee"
    "!#{componentPathPattern}/Component.coffee"
  ]
  componentResources = require('grunt').file.expand componentGlobPattern

  if componentResources.length isnt 0
    for componentResource in componentResources

      componentPathSegments = componentResource.split '/'
      do componentPathSegments.pop

      componentPath = componentPathSegments.join '/'
      componentName = componentResource.match(componentMatchRegex).pop()
      componentBuildDist = "#{componentDistPattern}/#{componentName}.js"

      if componentResource.match "/#{componentName}/"
        currentComponentResources.push componentResource

      componentsBuildObject[componentBuildDist] = currentComponentResources

    componentRegisterPath = "#{componentPath}/Component.coffee"
    componentsBuildObject[componentBuildDist].push componentRegisterPath

  componentsBuildObject



module.exports =
  build:
    options:
      join: yes
      sourceMap: yes
    files: do componentsBuildObject
