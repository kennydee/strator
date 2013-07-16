Strator main app
################

Defines states and deps

    angular.module( "strator", ['ui.bootstrap',
      'strator.controllers', 'strator.services'])
    .config [ '$routeProvider', ($routeProvider) ->
      $routeProvider.when "/list",
        controller: 'itemListCtrl',
        templateUrl: 'partials/item_list.html'
      $routeProvider.when "/additem",
        controller: 'itemAddCtrl',
        templateUrl: 'partials/item_add.html'
      $routeProvider.otherwise
        redirectTo: "/list"
    ]
