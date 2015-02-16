###
App Module
###
class BlogzingaApp extends App then constructor: -> return [
  'ui.router'
  'templates'
  'bloglist'
  'about'
]

class BlogzingaConfiguration extends Config
  constructor: ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->

    # Disable caching for IE
    $httpProvider.defaults.headers.get = {} unless $httpProvider.defaults.headers.get
    $httpProvider.defaults.headers.get['If-Modified-Since'] = '0'

    $locationProvider
    .html5Mode off

    $urlRouterProvider
    .otherwise '/blogs/list'

    $stateProvider
    .state 'blogs',
      abstract: true
      url: '/blogs'
      views:
        'template':
          templateUrl: 'components/home.html'
