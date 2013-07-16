angular.module("dist").run(["$templateCache", function($templateCache) {

  $templateCache.put("../dev/partials/item_add.html",
    "<h1>Ajouter un élément d'inventaire</h1><label>Titre<input ng-model=\"item.title\"/></label><button ng-click=\"submit()\">Créer</button>"
  );

  $templateCache.put("../dev/partials/item_list.html",
    "<h1>Inventaire : liste</h1><a href=\"#/additem\" class=\"button\">Add  item</a><div ng-repeat=\"item in items\">{{item.title}}</div><h2>Fournisseurs</h2><a ng-click=\"addProvider()\">Ajouter un fournisseur</a><div ng-repeat=\"provider in providers\">{{provider.title}}</div><h2>Emplacements</h2><a>Ajouter un emplacement</a><div ng-repeat=\"place in places\">{{place.title}}</div><h2>Sécurité</h2><a> Ajouter un élément de sécurité</a><div ng-repeat=\"security in securities\">{{security.title}}</div>"
  );

  $templateCache.put("../dev/partials/provider_add.html",
    "<div class=\"modal-header\"><h3>Ajouter un provider</h3></div><div class=\"modal-body\"><p>Ajouter un provider</p><input ng-model=\"provider.title\"/></div><div class=\"modal-footer\"><button ng-click=\"close(provider)\" class=\"btn btn-primary\">Enregistrer</button></div>"
  );

}]);
