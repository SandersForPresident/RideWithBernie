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
      .when '/profile/:uuid',
        templateUrl: "profile.html"
        controller: 'ProfileController'
      .when '/profiles/:uuid/search',
        templateUrl: "search.html"
        controller: 'SearchController'
])

controllers = angular.module('controllers',[])

controllers.controller("InstructionsController", [ '$scope', ($scope) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123
])

controllers.controller("ProfileController", [ '$scope', '$location', '$http', '$anchorScroll', '$routeParams', ($scope, $location, $http, $anchorScroll, $routeParams) ->
  $scope.eventTitle = "Tabling at UC Berkeley Sproul Plaza"
  $scope.eventId = 123

  if $routeParams.uuid?.length

    onError = (response) -> alert "Sorry, we couldn't find your profile!"
    onProfileSuccess = (response) -> $scope.profile = response.data
    $http.get "/profiles/#{$routeParams.uuid}.json"
    .then onProfileSuccess, onError

  else

    $scope.profile =
      newRecord: true
      seats: 1
      passengers: 1


  $scope.delete = ->
    $scope.state = {deleting: true}

    onSuccess = (response) ->
      $scope.state.saving = false
      alert "Profile deleted!"
      $location.path "/"

    onError = (response) ->
      alert "Sorry, we weren't able to delete the profile. Perhaps try refreshing, as it may already have been deleted!"

    # Send it!
    url = "/profiles/#{$scope.profile.uuid}.json"
    $http.delete(url).then onSuccess, onError

  $scope.save = ->
    $scope.state = {saving: true}

    onSuccess = (response) ->
      $location.path "/profiles/#{response.data.uuid}/search"
      $scope.state.saving = false

    onError = (response) ->
      # A simple $scope.errors object holds all errors, and is easy to look up in the template
      $scope.errors = {fullMessages: []}
      $scope.state.saving = false

      for col, errors of response.data
        $scope.errors[col] = true
        formatted_name = col.charAt(0).toUpperCase() + col.slice(1)
        formatted_name = formatted_name.replace '_', ' '
        for error in errors
          $scope.errors.fullMessages.push "#{formatted_name} #{error}"
      # Scroll to errors!
      $location.hash('errors')
      $anchorScroll()

    # Send it!
    url = if $scope.profile.newRecord then "/profiles.json" else "/profiles/#{$scope.profile.uuid}.json"
    $http.post url, { profile: $scope.profile } 
    .then onSuccess, onError

])

controllers.controller("SearchController", [ '$scope', '$routeParams', '$http', ($scope, $routeParams, $http) ->
  $scope.search = { type: 'drivers' }

  onError = (response) -> alert "Sorry, we couldn't find your profile!"
  onProfileSuccess = (response) ->
    $scope.profile = response.data
    $scope.search.type = if $scope.profile.driver then 'passengers' else 'drivers'

    $http.get "/profiles/#{$routeParams.uuid}/search.json"
    .then ((response) -> $scope.profiles = response.data), onError

  $http.get "/profiles/#{$routeParams.uuid}.json"
  .then onProfileSuccess, onError

  $scope.searchFilter = (p) ->
    return false if $scope.search.type is 'drivers' and !p.driver
    return false if $scope.search.type is 'passengers' and p.driver
    return true

  $scope.closeContactForms = ->
    p.contactFormOpen = false for p in $scope.profiles

  $scope.contact = (otherProfile) ->
    onError = (response) -> alert "Sorry, we were unable to contact that volunteer!"
    onSuccess = (response) ->
      alert "#{otherProfile.first_name} has been sent your contact info!"
      otherProfile.contactFormOpen = false

    $http.post "/profiles/#{$scope.profile.uuid}/contact/#{otherProfile.id}.json"
    .then onSuccess, onError
])

