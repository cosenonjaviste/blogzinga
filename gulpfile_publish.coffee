rimraf = require 'gulp-rimraf'
base = require './gulpfile.coffee'
gulp = base.gulp
runSequence = require 'run-sequence'

base.destDir = './browse/'

base.paths.libJs = [
  './bower_components/angular/angular.min.js'
  './bower_components/angular-ui-router/release/angular-ui-router.min.js'
  './bower_components/angular-animate/angular-animate.min.js'
  './bower_components/angular-translate/angular-translate.min.js'
  './bower_components/angular-svg-round-progressbar/roundProgress.js'
  './bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
  './bower_components/underscore/underscore-min.js'
  './bower_components/angular-utf8-base64/angular-utf8-base64.min.js'
]

base.paths.libCss = [
  './app/css/bootstrap.min.css'
  './bower_components/font-awesome/css/font-awesome.min.css'
]

gulp.task 'browse_clean', ['clean'], ->
  gulp.src ['browse/']
  .pipe rimraf
    read: false
    force: true

gulp.task 'default', ->
  runSequence 'browse_clean', 
  [
    'appJs',
    'libJs',
    'minMaps',
    'index',
    'templates',
    'appCss',
    'libCss',
    'img',
    'favicon',
    'fonts',
    'libMap',
    'connect',
  ]