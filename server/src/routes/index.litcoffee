Routes list
###########

UI Views
========

Needs models

    models = require '../models'

Index page


    exports.index = (req, res) ->
       res.render 'index', { title: 'Strator' }

List & detail views

    exports.item_list = (req, res) ->
      models.Item.find {}, (err, lst) ->
        if not err
          res.render 'item_list', { itemlist: lst }

    exports.item_detail = (req, res) ->
      models.Item.findOne {_id: req.params.id},
        (err, itm) ->
          if not err
            res.render 'item_detail', { item: itm }


API Views
=========
### Index and ping

Page d'accueil de l'API et page de ping

    exports.api_homepage = (req, res) ->
      res.send(200, {})

    exports.api_ping = (req, res) ->
      res.send 200, {status: "OK", version: "0.0.1"}


### Providers

Liste des fournisseurs existants / ajout de fournisseur

    exports.api_provider_list = (req, res) ->
      models.Provider.find {}, (err, lst) ->
        if not err
          res.send lst

    exports.api_provider_add = (req, res) ->
      provider = new models.Provider req.body
      provider.save (err, saved) ->
        res.send 201, saved

### Places

    exports.api_place_list = (req, res) ->
      models.Place.find {}, (err, lst) ->
        if not err
          res.send lst

    exports.api_place_add = (req, res) ->
      place = new models.Place req.body
      place.save (err, saved) ->
        if not err
          res.send 201, saved

### Security

    exports.api_security_list = (req, res) ->
      models.Security.find {}, (err, lst) ->
        if not err
          res.send lst

    exports.api_security_add = (req, res) ->
      sec = new models.Security req.body
      sec.save (err, saved) ->
        if not err
          res.send  201, saved

### Items

    exports.api_item_list = (req, res) ->
      models.Item.find {}, (err, lst) ->
        if not err
          res.send lst


    exports.api_item_add = (req, res) ->
      item = new models.Item (req.body)
      item.save (err, saved) ->
        res.send 201, saved

    exports.api_item_detail = (req, res) ->
      models.Item.findOne {_id: req.params.id},
        (err, itm) ->
          if not err
            res.send 200, itm
