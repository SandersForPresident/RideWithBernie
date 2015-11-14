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
      .when '/results',
        templateUrl: "results.html"
        controller: 'ResultsController'
])

controllers = angular.module('controllers',[])

controllers.controller("InstructionsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
])

controllers.controller("ProfileController", [ '$scope', '$location', ($scope, $location) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
  $scope.profile = {
    newRecord: false
  }
  $scope.save = ->
    $location.path '/results'
])

controllers.controller("ResultsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
  $scope.search = { type: 'drivers' }
  $scope.searchFilter = (p) ->
    console.log p.driver
    console.log $scope.search.type
    return false if $scope.search.type is 'drivers' and !p.driver
    return false if $scope.search.type is 'passengers' and p.driver
    return true

  $scope.closeContactForms = ->
    p.contactFormOpen = false for p in $scope.profiles

  $scope.profiles = [
    driver: true
    spots: 2
    firstName: 'Moe'
    location: 'Downtown Oakland'
  ,
    driver: true
    spots: 1
    firstName: 'Stevey'
    location: 'Uptown Oakland'
    contacted: true
  ,
    driver: false
    plus_ones: 0
    firstName: 'Lucy'
    location: 'Downtown Berkeley'
  ,
    driver: false
    plus_ones: 3
    firstName: 'Dave'
    location: 'West Oakland'
  ]
  #$scope.profiles = []
])

