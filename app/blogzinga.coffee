###
App Module
###
class BlogzingaApp extends App then constructor: -> return [
  'ui.router'
  'templates'
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
    .html5Mode on
    
    #$locationProvider
    #.hashPrefix '!'

    $urlRouterProvider
    .otherwise '/'

    $stateProvider
    .state 'blogs',
      abstract: true
      url: ''
      views:
        'template':
          templateUrl: 'components/home.html'
