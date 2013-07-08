Controllers
###########

Controllers

    angular.module("strator.controllers", [])
    .controller('itemListCtrl', [ '$scope', '$http', '$dialog', ($scope, $http, $dialog) ->
      $scope.items = $http.get("http://localhost:3000/items")
        .success (data) ->
          $scope.items = data
          data
      $scope.addProvider = () -> 
        d = $dialog.dialog {dialogFade: false}
        d.open 'partials/provider_add.html', 'providerAddCtrl'
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
        $http.post "http://localhost:3000/providers", $scope.provider
        dialog.close()
      $scope
    ])
    
    
