Strator main application
########################

Start express application.

    LIB = __dirname + '/lib'
    ENV = process.env.NODE_ENV || "development"
    CONFIG = __dirname + '/config'

    
    express = require 'express'
    http = require 'http'
    path = require 'path'
    cors = require 'cors'
    models = require LIB + '/models'
    routes = require LIB + '/routes'
    fixtures = require LIB + '/fixtures'

    app = express()


Settings

    
    app.set 'dbname', "strator"
    app.set 'dbparams', {host: "localhost"}
    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger('dev')
    app.use cors()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('your secret here')
    app.use express.session()
    app.use app.router
    app.use require('stylus').middleware(__dirname + '/public')
    app.use express.static(path.join(__dirname, 'public'))

    # development only
    if 'development' is app.get('env')
      app.use express.errorHandler()


Apply public vision routes

    app.get '/', routes.index

API Routes

    app.get '/items', routes.api_item_list
    app.get '/items/:id', routes.api_item_detail
    app.get '/places', routes.api_place_list
    app.get '/providers', routes.api_provider_list
    app.get '/security', routes.api_security_list

    app.post '/items', routes.api_item_add
    app.post '/places', routes.api_place_add
    app.post '/providers', routes.api_provider_add
    app.post '/security', routes.api_security_add
    

    if require.main is module
      http.createServer(app).listen app.get('port'), () ->
        console.log 'Express server listening on port ' + app.get('port')
    else
      module.exports = app
  
