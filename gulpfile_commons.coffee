webdriver_update = require('gulp-protractor').webdriver_update

moment    = require 'moment'
pkg       = require './package.json'
gulp_pkg  = require './node_modules/gulp/package.json'

commons =
  gulp      : require 'gulp'
  rimraf    : require 'gulp-rimraf'
  fs        : require 'fs'

  implementation_version : if process.env.BUILD_NUMBER then pkg.version+'-b'+ process.env.BUILD_NUMBER else pkg.version+'-build_time_'+moment().format("YYYYMMDD_hhmmss")



  paths :
    appJs: ['./app/**/*.coffee','./app/**/*.js']
    appCss: ['./app/**/*.less', './app/**/*.css']
    img:['./app/**/*.png','./app/**/*.gif','./app/**/*.jpg']
    fonts:['./bower_components/bootstrap/fonts/*', './bower_components/font-awesome/fonts/*']
    templates: [
      '!./app/index.jade'
      '!./app/index.html'
      '!./app/jade_includes/**/*.jade'
      './app/**/*.html'
      './app/**/*.jade'
    ]
    index: ['./app/index.jade']
    i18n:[
      './bower_components/angular-i18n/angular-locale*it*',
      './bower_components/angular-i18n/angular-locale*en*',
      './bower_components/angular-i18n/angular-locale*en-us*',
      './bower_components/angular-i18n/angular-locale*ja-jp*',
      './bower_components/angular-i18n/angular-locale*fr-fr*',
      './bower_components/angular-i18n/angular-locale*de*',
      './bower_components/angular-i18n/angular-locale*es*',
      './bower_components/angular-i18n/angular-locale*pt-br*'
    ]
    favicon: ['./app/favicon.ico']

  ngClassifyDefinitions : (file, options) ->
      ##for windows
      return appName: 'bloglist' if file.path.indexOf('components\\bloglist') isnt -1
            ##for unix
      return appName: 'bloglist' if file.path.indexOf('components/bloglist') isnt -1

      return appName: 'blogzinga'

commons.gulp.task 'dir_clean', ->
  commons.gulp.src ['dist/', 'mvn_dist/', 'tests/reports/']
    .pipe commons.rimraf
      read: false
      force: true

commons.gulp.task 'clean', ['dir_clean'], ->
  commons.gulp.src commons.paths.i18n
    .pipe commons.gulp.dest './dist/js/i18n'

commons.gulp.task 'manifest', ['clean'],  ->
  commons.fs.mkdir('./dist/META-INF/')
  commons.fs.writeFile(
    './dist/META-INF/MANIFEST.MF'
    [
      'Manifest-Version: 1.0'
      'Implementation-Version: ' + commons.implementation_version
      'Built-By: ' + (process.env.USERNAME || process.env.USER)
      'Built-Date: ' + moment().format()
      'Class-Path: '
      'Created-By: ' + gulp_pkg.name + " " + gulp_pkg.version
    ].join('\n')
  )

commons.gulp.task 'update_driver', ->
  webdriver_update ->
    console.log("updated driver")

module.exports = commons
