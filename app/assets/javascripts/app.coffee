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
      .when '/profiles/new',
        templateUrl: "profile_form.html"
        controller: 'NewProfileController'
      .when '/profiles/:uuid/edit',
        templateUrl: "profile_form.html"
        controller: "EditProfileController"
      .when '/profiles/:uuid',
        templateUrl: "profile.html"
        controller: "ShowProfileController"
      .when '/profiles/:uuid/results',
        templateUrl: "results.html"
        controller: 'ResultsController'
      .when '/events/:id',
        templateUrl: "events_show.html"
        controller: 'ShowEventsController'
      .when '/events',
        templateUrl: "events_index.html"
        controller: 'EventsController'
])

controllers = angular.module('controllers',[])

controllers.controller("InstructionsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
])

controllers.controller("NewProfileController", [ '$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  $scope.eventTitle = $routeParams.eventTitle || ''
  $scope.eventId = $routeParams.eventId || ''

  $scope.profile = {
    new_record: true
  }
  console.log($scope.profile);
  $scope.save = ->
    window.Profile = $scope.profile
    $http.post "/profiles", { profile: $scope.profile }
    .then (response) ->
      if $scope.eventId
        $location.path "/events/#{$scope.eventId}"
      else
        $location.path "/events"
      # $location.path "/profiles/#{response.data.uuid}/results"
    , (data) -> #error!
      alert "Error!"
])

controllers.controller("EditProfileController", [ '$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  $http.get "/profiles/#{$routeParams.uuid}", {}
  .then (response) ->
    window.Profile = response.data
    $scope.profile = response.data
    $scope.profile.new_record = false
  , (data) ->
    alert "Error!"
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123

  $scope.save = ->
    window.Profile = $scope.profile
    $http.put "/profiles/#{$scope.profile.uuid}", { profile: $scope.profile }
    .then (response) ->
      $location.path "/profiles/#{response.data.uuid}/results"
    , (data) -> #error!
      alert "Error!"
])

controllers.controller("ShowProfileController", [ '$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  $http.get "/profiles/#{$routeParams.uuid}", {}
  .then (response) ->
    window.Profile = response.data
    $scope.profile = response.data
  , (data) ->
    alert "Error!"
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123

  $scope.delete = ->
    $http.delete "/profiles/#{$scope.profile.uuid}", {}
    .then (response) ->
      alert "Successfully deleted your profile"
    , (data) ->
      alert "Error deleting your profile. Please try again later"
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

controllers.controller("EventsController", [ '$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  $location.url($location.path())
])

controllers.controller("ShowEventsController", [ '$scope', '$location', '$routeParams', '$http', ($scope, $location, $routeParams, $http) ->
  $location.url($location.path())
])