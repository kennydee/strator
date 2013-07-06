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


    mongoose = require 'mongoose'
    mongoose.connect 'mongodb://localhost/strator'
    
    db = mongoose.connection
    db.on 'error', console.error.bind(console, "Connection error")
    
    itemSchema = mongoose.Schema {
      title: String
    }
    

### Liste des modèles

    exports.Provider = require('./provider').Provider
    exports.Place = require('./place').Place
    exports.Security = require('./security').Security
    exports.Item = require('./item').Item

