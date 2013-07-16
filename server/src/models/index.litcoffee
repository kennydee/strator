Models
######

Elements de base de données
* Fournisseurs & catalogues
* Emplacements de rangement
* Elements de sécurité
* Elements d'inventaire (items)
* Etats & quantités inventaire (historique)
* Logs d'utilisation / réparation
* Commandes & état des commandes
* Documentation, fiches, etc...

Modèles pour la description d'un inventaire de laboratoire.


### Liste des modèles

    exports.Provider = require('./provider').Provider
    exports.Place = require('./place').Place
    exports.Security = require('./security').Security
    exports.Item = require('./item').Item
