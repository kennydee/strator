Emplacements
############


    mongoose = require 'mongoose'
    
    placeSchema = mongoose.Schema
      place: String
      
    exports.Place = mongoose.model "Place", placeSchema
