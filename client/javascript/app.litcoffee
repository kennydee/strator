Strator main app
################

Defines states and deps

    angular.module "strator", ['ui.bootstrap', 'ui.router',
      'strator.controllers', 'strator.services']
    .config [ '$routeProvider', ($routeProvider) ->
      $routeProvider.when "/list",
        controller: 'itemListCtrl',
        templateUrl: 'partials/items_list.html'
    ]

