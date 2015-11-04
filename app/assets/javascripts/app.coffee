ridewithbernie = angular.module('ridewithbernie',[
  'templates',
  'ngRoute',
  'controllers',
])

ridewithbernie.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when '/',
        templateUrl: "helloWorld.html"
        controller: 'HelloWorldController'
      .when '/goodbye',
        templateUrl: "goodbyeWorld.html"
        controller: 'GoodbyeWorldController'
])

controllers = angular.module('controllers',[])

controllers.controller("HelloWorldController", [ '$scope', ($scope) ->
  $scope.name = ['Buster', 'Gob', 'Michael', 'Tobias'][Math.floor(Math.random() * 4)]
])

controllers.controller("GoodbyeWorldController", [ '$scope', ($scope) ->
  $scope.name = ['Buster', 'Gob', 'Michael', 'Tobias'][Math.floor(Math.random() * 4)]
])
