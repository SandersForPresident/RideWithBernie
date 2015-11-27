ridewithbernie = angular.module('ridewithbernie',[
  'templates',
  'ngRoute',
  'controllers',
])

ridewithbernie.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when '/',
        templateUrl: "home.html"
        controller: 'HomeController'
      .when '/instructions',
        templateUrl: "instructions.html"
        controller: 'InstructionsController'
      .when '/profile',
        templateUrl: "profile.html"
        controller: 'ProfileController'
      .when '/profile/:uuid',
        templateUrl: "profile.html"
        controller: 'ProfileController'
      .when '/profile/:uuid/search',
        templateUrl: "search.html"
        controller: 'SearchController'
      .when '/events/build',
        templateUrl: "build_event.html"
        controller: 'BuildEventController'
      .otherwise
        redirectTo: "/"
])

# Only one service so far, so it's easy to keep in the same file!
angular.module("ridewithbernie").service "Db", ->
  # This simple localstorage "database" is just a javascript object
  # that can be serialized and de-serialized, and saved to the device easily
  db = window.localStorage.getItem "ridewithbernie_database"
  db = if db? then JSON.parse(db) else {} 

  db.save = ->
    window.localStorage.setItem "ridewithbernie_database", JSON.stringify(db)

  db.clear = ->
    # wibe the db
    for key, val of db
      delete db[key] if db.hasOwnProperty(key) and key isnt 'save' and key isnt 'clear'
    db.save()

  db.profiles ||= []
  return db 


# Controllers for the rest of the file
controllers = angular.module('controllers',[])

controllers.controller("HomeController", [(->)])

controllers.controller("InstructionsController", [ '$scope', '$routeParams', '$location', ($scope, $routeParams, $location) ->
  if $routeParams.event_title?.length && $routeParams.event_id?.length
    $scope.event_title = $routeParams.event_title
    $scope.event_id = $routeParams.event_id
  else
    $location.path("/").search {}

  $scope.next = ->
    $location.path("profile").search { event_id: $scope.event_id, event_title: $scope.event_title }
])

controllers.controller("ProfileController", [ '$scope', '$location', '$http', '$routeParams', 'Db', ($scope, $location, $http, $routeParams, Db) ->
  # Check if we already stored a profile for this event
  if profile = _.findWhere(Db.profiles, event_id: $routeParams.event_id)
    # if so, just redirect there
    $location.path("/profile/#{profile.uuid}").search {}

  # editing an existing profile
  if $routeParams.uuid?.length

    onError = (response) ->
      alert "Sorry, we couldn't find your profile!"
      # Remove this profile from the database, if it's there!
      Db.profiles = _.reject Db.profiles, ((p) -> p.uuid is $routeParams.uuid)
      Db.save()
      $location.path('/').search {}

    onProfileSuccess = (response) -> $scope.profile = response.data

    $http.get "/profiles/#{$routeParams.uuid}.json"
    .then onProfileSuccess, onError

  # creating a new one? we need the event details
  else if $routeParams.event_title?.length && $routeParams.event_id?.length

    $scope.profile =
      newRecord: true
      seats: 1
      passengers: 1
      event_title: $routeParams.event_title
      event_id: $routeParams.event_id

  # no event details? that's a problem
  else
    $location.path("/").search {}


  $scope.back = ->
    $location.path('/instructions').search event_id: $scope.profile.event_id, event_title: $scope.profile.event_title

  $scope.save = ->
    $scope.state = {saving: true}

    onSuccess = (response) ->
      profile = response.data
      # remove this profile if is exists already
      Db.profiles = _.reject Db.profiles, ((p) -> p.uuid is profile.uuid)
      # Add it back!
      Db.profiles.push profile
      Db.save()

      # Head to matches!
      $location.path("/profile/#{response.data.uuid}/search").search {}
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
      # angular's anchroScroll function seems to break navigation, so let's use jquery
      $("body").animate scrollTop: 0
      0 # return 0 so angular doesn't freak out about jquery

    # Send it!
    url = if $scope.profile.newRecord then "/profiles.json" else "/profiles/#{$scope.profile.uuid}.json"
    $http.post url, { profile: $scope.profile } 
    .then onSuccess, onError

  $scope.delete = ->
    $scope.state = {deleting: true}

    onSuccess = (response) ->
      $scope.state.saving = false
      alert "Profile deleted!"
      # Remove this profile from the database, if it's there!
      Db.profiles = _.reject Db.profiles, ((p) -> p.uuid is $scope.profile.uuid)
      Db.save()
      $location.path('/').search {}

    onError = (response) ->
      alert "Sorry, we weren't able to delete the profile. Perhaps try refreshing, as it may already have been deleted!"

    # Send it!
    url = "/profiles/#{$scope.profile.uuid}.json"
    $http.delete(url).then onSuccess, onError

])

controllers.controller("SearchController", [ '$scope', '$routeParams', '$http', 'Db', '$location', ($scope, $routeParams, $http, Db, $location) ->
  $scope.search = { type: 'drivers' }

  onError = (response) ->
    alert "Sorry, we couldn't find your profile!"
    # Remove this profile from the database, if it's there!
    Db.profiles = _.reject Db.profiles, ((p) -> p.uuid is $routeParams.uuid)
    Db.save()
    $location.path('/').search {}

  onProfileFetchSuccess = (response) ->
    $scope.profile = response.data
    $scope.search.type = if $scope.profile.driver then 'passengers' else 'drivers'

    onSearchResultFetchSuccess = (response) ->
      profiles = _.reject response.data, ((p) -> p.uuid is $scope.profile.uuid)
      p.contacted = true for p in profiles when $scope.profile.profiles_contacted?.indexOf(p.id) > -1
      $scope.profiles = profiles

    $http.get "/profiles/#{$routeParams.uuid}/search.json"
    .then onSearchResultFetchSuccess, onError

  $http.get "/profiles/#{$routeParams.uuid}.json"
  .then onProfileFetchSuccess, onError

  $scope.searchFilter = (p) ->
    return false if $scope.search.type is 'drivers' and !p.driver
    return false if $scope.search.type is 'passengers' and p.driver
    return true

  $scope.closeContactForms = ->
    p.contactFormOpen = false for p in $scope.profiles

  $scope.contact = (otherProfile) ->
    $scope.state = {contacting: true}
    onError = (response) ->
      alert "Sorry, we were unable to contact that volunteer!"
      $scope.state.contacting = false
    onSuccess = (response) ->
      alert "#{otherProfile.first_name} has been sent your contact info!"
      otherProfile.contacted = true
      $scope.profile.profiles_contacted ||= []
      $scope.profile.profiles_contacted.push(otherProfile.id)
      otherProfile.contactFormOpen = false
      $scope.state.contacting = false

    $http.post "/profiles/#{$scope.profile.uuid}/contact/#{otherProfile.id}.json"
    .then onSuccess, onError
])


controllers.controller("BuildEventController", [ '$scope', '$http', '$location', ($scope, $http, $location) ->
  $scope.event = {}
  $scope.state = {}

  $scope.submit = ->
    $scope.state.saving = true

    onError = (response) ->
      $scope.error = response.data.message || "Sorry, we hit an error creating your link!"
      $scope.state.saving = false

    onSuccess = (response) ->
      $scope.error = null
      $scope.event.url = response.data.url
      $scope.event.shortlink = response.data.shortlink
      $scope.event.id = response.data.id
      $scope.state.saving = false

    $http.post "/events/generate.json", { event: $scope.event }
    .then onSuccess, onError

  $scope.deliver = ->
    $scope.state.saving = true

    onError = (response) ->
      $scope.phoneError = response.data.message
      $scope.state.saving = false
      
    onSuccess = (response) ->
      $scope.phoneError = null
      alert "Text delivered!"
      $scope.state.saving = false

    $http.post "/events/deliver.json", { event: $scope.event }
    .then onSuccess, onError

  $scope.clear = -> $scope.event = {}

  $scope.done = ->
    if confirm "Make sure you've got the link!"
      $location.path('/')
])
