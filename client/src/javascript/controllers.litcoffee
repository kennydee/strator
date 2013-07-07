Controllers
###########

Controllers

    angular.module("strator.controllers", [])
    .controller('itemListCtrl', [ '$scope', '$http', ($scope, $http) ->
      $scope.items = $http.get("http://localhost:3000/items")
        .success (data) ->
          $scope.items = data
          data
      $scope
    ])
    .controller('itemAddCtrl', ['$scope', '$http', ($scope, $http) ->
      $scope.submit = () ->
        console.log "Submitting"
        $http.post "http://localhost:3000/items", $scope.item
      $scope
    ])
    
    
