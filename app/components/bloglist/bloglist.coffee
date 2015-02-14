###
App Module
###
class BlogListApp extends App then constructor: -> return [
  'ui.router'
  'templates'
  'ab-base64'
]

class BlogListConfiguration extends Config
  constructor: ($stateProvider) ->

    $stateProvider
      .state 'bloggers.list',
        url: '/list'
        views:
          '':
            templateUrl: 'components/bloglist/list.html'
            controller: 'blogListController'


class BlogList extends Controller
  constructor: ($scope, BlogListService, base64) ->
    BlogListService.getBlogs().then (resp) ->
      $scope.blogs = angular.fromJson base64.decode resp
      return
    
    $scope.openUrl = (url) ->
      window.open url



class BlogListService extends Factory
  constructor: ($http) ->
    return {
      getBlogs : () ->
        $http.get('https://api.github.com/repos/cosenonjaviste/blogzinga/contents/blogs.json?ref=master').then (resp) ->
          resp.data.content

    }

class Join extends Filter
  constructor: ->
    return (value) ->
      value.join? ', '
      
class RandomHeader extends Directive
  constructor: ->
    return {
      restrict: 'A'
      link: ($scope, $element, $attrs) ->
        classes = ['panel-primary', 'panel-success', 'panel-warning', 'panel-danger', 'panel-info']
        
        random = () ->
          Math.floor Math.random() * (classes.length - 1);
          
        $element.parent().addClass classes[random()]
        return
    }

