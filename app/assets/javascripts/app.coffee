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
      .when '/profiles/:uuid/results',
        templateUrl: "results.html"
        controller: 'ResultsController'
])

controllers = angular.module('controllers',[])

controllers.controller("InstructionsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
])

controllers.controller("ProfileController", [ '$scope', '$location', '$http', ($scope, $location, $http) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
  $scope.profile = {
    newRecord: true
    spots: '1'
    plus_ones: '0'
  }

  # Most validation and error code taken from: 
  # http://fdietz.github.io/recipes-with-angular-js/backend-integration-with-ruby-on-rails/validating-forms-server-side.html

  $scope.errorClass = (col) ->
    s = $scope.profileForm[col]
    if s.$invalid and s.$dirty then "has-error" else ""
  
  $scope.errorMessage = (col) ->
    errors = []
    return unless $scope.profileForm?[col]?.$error
    col_name = col.charAt(0).toUpperCase() + col.slice(1)
    col_name = col_name.replace '_', ' '
    errors.push "#{col_name} #{k}." for k,v of $scope.profileForm[col].$error
    errors.join " "
  

  # Save code written from scratch
  $scope.save = ->
    url = if $scope.profile.newRecord then "/profiles" else "/profiles/#{$scope.profile.uuid}"

    onSuccess = -> $location.path "/profiles/#{response.data.uuid}/results"
    onError = (response) ->
      console.log response
      for col, errors of response.data
        for error in errors
          $scope.profileForm[col].$dirty = true
          $scope.profileForm[col].$setValidity error, false

    # Send it!
    $http.post url, { profile: $scope.profile } 
    .then onSuccess, onError

])

controllers.controller("ResultsController", [ '$scope', '$routeParams', ($scope, $routeParams) ->
  #$http.get "/profiles/#{$routeParams.uuid}"
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
    location: 'Uptown Oakland near the 7/11'
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

