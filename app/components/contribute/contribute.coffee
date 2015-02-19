###
App Module
###
class ContributeApp extends App then constructor: -> return [
  'ui.router'
  'templates'
]

class ContributeConfiguration extends Config
  constructor: ($stateProvider) ->

    $stateProvider
      .state 'blogs.contribute',
        url: '/contribute'
        views:
          '':
            templateUrl: 'components/contribute/contribute.html'