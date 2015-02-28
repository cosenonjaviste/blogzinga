###
App Module
###
class BlogzingaApp extends App then constructor: -> return [
  'ui.router'
  'templates'
  'angulartics'
  'angulartics.google.analytics'
  'bloglist'
  'about'
  'contribute'
]

class BlogzingaConfiguration extends Config
  constructor: ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->

    # Disable caching for IE
    $httpProvider.defaults.headers.get = {} unless $httpProvider.defaults.headers.get
    $httpProvider.defaults.headers.get['If-Modified-Since'] = '0'

    $locationProvider
    .html5Mode off
    
    $locationProvider
    .hashPrefix '!'

    $urlRouterProvider
    .otherwise '/home'

    $stateProvider
    .state 'blogs',
      abstract: true
      url: ''
      views:
        'template':
          templateUrl: 'components/home.html'
          
class Startup extends Run
  constructor: ($rootScope) ->
    $rootScope.status = 'not ready'