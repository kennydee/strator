Elément d'inventaire
####################


    mongoose = require('mongoose')
    
    itemSchema = mongoose.Schema
      title: String
      code: String
      provider: String
      place: String
    
    exports.Item = mongoose.model "Item", itemSchema
