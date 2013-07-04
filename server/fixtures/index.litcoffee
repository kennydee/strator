Load fixtures
#############

Fixtures loading

    exports.clear = (app, names, callback) ->
      fixtures = require('pow-mongodb-fixtures').connect(
        app.get('dbname'), app.get('dbparams')
      )

      fixtures.clear names, () ->
        fixtures.close callback
      

    exports.load = (app, names, callback) ->

      fixtures = require('pow-mongodb-fixtures').connect(
        app.get('dbname'), app.get('dbparams')
      )

      async = require 'async'
    
      async.map names, (name, cb) ->
          fixtures.load __dirname + "/" + name + '.js', cb
        ,() ->
          fixtures.close callback

