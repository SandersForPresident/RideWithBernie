ridewithbernie = angular.module('ridewithbernie',[
  'templates',
  'ngRoute',
  'controllers',
])

ridewithbernie.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when '/',
        templateUrl: "instructions.html"
        controller: 'InstructionsController'
      .when '/profile',
        templateUrl: "profile.html"
        controller: 'ProfileController'
])

controllers = angular.module('controllers',[])

controllers.controller("InstructionsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
])

controllers.controller("ProfileController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
  $scope.profile = {}
])
