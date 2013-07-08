Controllers
###########

Controllers

    angular.module("strator.controllers", [])
    .controller('itemListCtrl', [ '$scope', '$http', '$dialog', ($scope, $http, $dialog) ->
      $scope.items = $http.get("http://localhost:3000/items")
        .success (data) ->
          $scope.items = data
          data
      $scope.providers = $http.get("http://localhost:3000/providers")
        .success (data) ->
          $scope.providers = data
          data
      $scope.places = $http.get("http://localhost:3000/places")
        .success (data) ->
          $scope.places = data
          data
      $scope.securities = $http.get("http://localhost:3000/securities")
        .success (data) ->
          $scope.securities = data
          data
      $scope.addProvider = () -> 
        d = $dialog.dialog {
          dialogFade: true
          backdrop: true
          keyboard: true
          backdropClick: true
        }
        d.open('partials/provider_add.html', 'providerAddCtrl')
          .then (result) -> 
            console.log(result)
            if result
              $scope.providers.push(result)
      $scope
    ])
    .controller('itemAddCtrl', ['$scope', '$http', ($scope, $http) ->
      $scope.submit = () ->
        console.log "Submitting item"
        $http.post "http://localhost:3000/items", $scope.item
      $scope
    ])
    .controller('providerAddCtrl', ['$scope', '$http', 'dialog', ($scope, $http, dialog) ->
      $scope.close = () ->
        console.log "Submitting provider"
        $http.post("http://localhost:3000/providers", $scope.provider)
          .success( (data) ->
            dialog.close(data))
          .error( () ->
            dialog.close())
      $scope
    ])
    
    
