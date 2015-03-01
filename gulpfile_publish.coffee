rimraf = require 'gulp-rimraf'
base = require './gulpfile.coffee'
gulp = base.gulp
runSequence = require 'run-sequence'

base.destDir = './dist/'

base.paths.libJs = [
  './bower_components/jquery/jquery.min.js'
  './bower_components/angular/angular.min.js'
  './bower_components/angular-ui-router/release/angular-ui-router.min.js'
  './bower_components/angular-animate/angular-animate.min.js'
  './bower_components/angular-translate/angular-translate.min.js'
  './bower_components/angular-svg-round-progressbar/roundProgress.js'
  './bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
  './bower_components/underscore/underscore-min.js'
  './bower_components/angular-utf8-base64/angular-utf8-base64.min.js'
  './bower_components/bootstrap/dist/js/bootstrap.min.js'
  './bower_components/angulartics/dist/angulartics.min.js'
  './bower_components/angulartics/dist/angulartics-ga.min.js'
  './bower_components/SHA-1/sha1.js'
]

base.paths.libCss = [
  './app/css/bootstrap.min.css'
  './bower_components/font-awesome/css/font-awesome.min.css'
  './bower_components/octicons/octicons/css/octicons.css'
]

gulp.task 'dest_clean', ['clean'], ->
  gulp.src [base.destDir]
  .pipe rimraf
    read: false
    force: true

gulp.task 'publishFiles', ->
  gulp.src [
    './sitemap.xml'
    './robots.txt'
  ]
    .pipe gulp.dest base.destDir
    
gulp.task 'default', ->
  runSequence 'dest_clean',
  [
    'appJs',
    'libJs',
    'minMaps',
    'index',
    'templates',
    'appCss',
    'libCss',
    'favicon',
    'fonts',
    'libMap',
    'publishFiles',
    'connect',
  ]