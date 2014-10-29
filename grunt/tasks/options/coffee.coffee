module.exports =
  build:
    ext: '.js'
    expand: yes
    cwd: './app/assets/'
    dest: './build/assets/'
    src: [
      '{,**/}*.coffee',
      '!**/components/**'
    ]
