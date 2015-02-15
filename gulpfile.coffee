paths = require('./gulpfile_commons.coffee').paths
gulp = require('./gulpfile_commons.coffee').gulp
ngClassifyDefinitions = require('./gulpfile_commons.coffee').ngClassifyDefinitions
implementation_version = require('./gulpfile_commons.coffee').implementation_version

gutil      = require 'gulp-util'
connect    = require 'gulp-connect'
gulpif     = require 'gulp-if'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
tplCache   = require 'gulp-angular-templatecache'
jade       = require 'gulp-jade'
less       = require 'gulp-less'
sourcemaps = require 'gulp-sourcemaps'
ngClassify = require 'gulp-ng-classify'
coffeelint = require 'gulp-coffeelint'
rimraf     = require 'gulp-rimraf'
backend    = require './backend/app'

protractor = require('gulp-protractor').protractor

paths.libJs = [
      './bower_components/angular/angular.js'
      './bower_components/angular-ui-router/release/angular-ui-router.js'
      './bower_components/angular-animate/angular-animate.js'
      './bower_components/angular-translate/angular-translate.js'
      './bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
      './bower_components/underscore/underscore.js'
      './bower_components/angular-utf8-base64/angular-utf8-base64.js'
      ]

paths.libCss = [
      './app/css/bootstrap.css'
      './bower_components/font-awesome/css/font-awesome.css'
    ]

paths.minMaps = [
      './bower_components/angular/angular.min.js.map'
      './bower_components/angular-animate/angular-animate.min.js.map'
    ]

base =
  paths: paths
  gulp: gulp
  destDir: './dist/'

gulp.task 'appJs',  ->
  gulp.src paths.appJs #tutte le sottocartelle di app con file .coffee o .js
    .pipe coffeelint().on 'error', gutil.log
    .pipe ngClassify(ngClassifyDefinitions) .on 'error', gutil.log
    .pipe coffeelint.reporter().on 'error', gutil.log
    .pipe sourcemaps.init().on 'error', gutil.log
    .pipe (gulpif /[.]coffee$/, coffee(bare: true).on 'error', gutil.log).on 'error', gutil.log
    .pipe concat('app.js').on 'error', gutil.log
    .pipe sourcemaps.write('./maps').on 'error', gutil.log
    .pipe gulp.dest(base.destDir + 'js').on 'error', gutil.log

gulp.task 'libJs', ->
  gulp.src paths.libJs
    .pipe concat 'lib.js'
    .pipe gulp.dest base.destDir + 'js'

gulp.task 'minMaps', ->
  gulp.src paths.minMaps
    .pipe gulp.dest base.destDir + 'js/maps'

gulp.task 'index', ->
  gulp.src paths.index
    .pipe gulpif /[.]jade$/, jade(
      doctype: 'html'
      locals: { 'version' : implementation_version }).on 'error', gutil.log
    .pipe gulp.dest base.destDir

gulp.task 'templates', ->
  gulp.src paths.templates
    .pipe gulpif /[.]jade$/, jade(doctype: 'html').on 'error', gutil.log
    .pipe tplCache 'templates.js', { standalone:true }
    .pipe gulp.dest base.destDir + 'js/'

gulp.task 'appCss', ->
  gulp.src paths.appCss
    .pipe gulpif /[.]less$/, less
      paths: []
    .on 'error', gutil.log
    .pipe concat 'style.css'
    .pipe gulp.dest base.destDir + 'css'

gulp.task 'libCss', ->
  gulp.src paths.libCss
    .pipe concat 'lib.css'
    .pipe gulp.dest base.destDir + 'css'

gulp.task 'img',  ->
  gulp.src paths.img
    .pipe gulp.dest base.destDir

gulp.task 'favicon',  ->
  gulp.src paths.favicon
    .pipe gulp.dest base.destDir

gulp.task 'fonts',  ->
  gulp.src paths.fonts
    .pipe gulp.dest base.destDir + 'fonts'

gulp.task 'connect', ->
  backend.set "port", process.env.PORT or 8001
  server = backend.listen(backend.get("port"), ->
    # debug "Express server listening on port " + server.address().port
    connect.server
      root: ['dist']
      port: 8000
      livereload: true
  )

gulp.task 'watch', ->
  # reload connect server on built file change
  gulp.watch [
    'dist/**/*.html'
    'dist/**/*.js'
    'dist/**/*.css'
  ], (event) ->
    gulp.src event.path
      .pipe connect.reload()
  # watch files to build
  gulp.watch [
    './app/**/*.coffee'
    './app/**/*.js'],
    ['appJs']
  gulp.watch [
    '!./app/index.jade'
    '!./app/index.html'
    './app/**/*.jade'
    './app/**/*.html'],
    ['templates']
  gulp.watch ['./app/**/*.less','./app/**/*.css'], ['appCss']
  gulp.watch ['./app/index.jade', './app/index.html'], ['index']
  return

gulp.task 'libMap', ->
  # copy sourcemaps for each libs
  gulp.src [
    './bower_components/bootstrap/dist/css/bootstrap.css.map',
    './bower_components/font-awesome/css/font-awesome.css.map'
  ]
  .pipe gulp.dest base.destDir + 'css'

gulp.task 'default', [
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
  'watch'
]

module.exports = base
