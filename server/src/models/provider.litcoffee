Provider database
##################


    mongoose = require 'mongoose'
    
    providerSchema = mongoose.Schema
      title: String
      address: String
    
    exports.Provider = mongoose.model "Provider", providerSchema


