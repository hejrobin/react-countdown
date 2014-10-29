module.exports =
  build:
    options:
      report: 'gzip'
      compress: on
      cleancss: yes
      paths: [ './app/assets/css' ]
    files:
      './build/assets/css/style.css': './app/assets/css/style.less'
