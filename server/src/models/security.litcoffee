Security data
#############


    mongoose = require 'mongoose'
    
    securitySchema = mongoose.Schema
      type: String
      code: String
      details: String
      
    exports.Security = mongoose.model "Security", securitySchema
