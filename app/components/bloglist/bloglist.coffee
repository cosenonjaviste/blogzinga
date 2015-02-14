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
      $scope.blogs = resp
      #for blog in $scope.blogs
      #  for author, i in blog.authors
      #    blog['author_' + i] = author
      #  for tag, i in blog.tags
      #    blog['tag_' + i] = tag
      return
    
    $scope.openUrl = (url) ->
      window.open url
      
    $scope.filterByTag = (tag) ->
      $scope.filterBlog = tag



class BlogListService extends Factory
  constructor: ($http, base64) ->
    return {
      getBlogs : () ->
        $http.get('https://api.github.com/repos/cosenonjaviste/blogzinga/contents/blogs.json?ref=master').then (resp) ->
          base64Content = resp.data.content
          angular.fromJson base64.decode base64Content

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
    
class RandomLabel extends Directive
  constructor: ->
    return {
      restict: 'A',
      link: ($scope, $element, $attrs) ->
        classes = ['label-primary', 'label-success', 'label-warning', 'label-danger', 'label-info']

        random = () ->
          Math.floor Math.random() * (classes.length - 1);
          
        $element.addClass classes[random()]
    }

