###
App Module
###
class AboutApp extends App then constructor: -> return [
  'ui.router'
  'templates'
]

class AboutConfiguration extends Config
  constructor: ($stateProvider) ->

    $stateProvider
      .state 'blogs.about',
        url: '/about'
        views:
          '':
            templateUrl: 'components/about/about.html'
            controller: 'aboutController'

class About extends Controller
  constructor: ($rootScope) ->
    $rootScope.status = 'ready'