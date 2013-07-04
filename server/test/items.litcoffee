Tests for items
###############


Testing items infos


    process.env.NODE_ENV = 'test'

    app = require "../app"
    should = require "should"
    request = require "supertest"


    describe "Items data", ->
      beforeEach (done) ->
        fixtures = require '../fixtures'
        fixtures.clear app, ['securities','providers','items', 'places'], () ->
          fixtures.load app, ['securities', 'providers', 'items', 'places'], done



      describe "Items API : ", ->
        describe "GET items", ->
          it "should return a list of items", (done) ->
            request(app)
              .get('/items')
              .set('Accept','application/json')
              .end (err, res) ->
                res.body.should.have.lengthOf 1
                done()
        
        describe "GET item by id", ->
          it "should return an item details", (done) ->
            request(app)
              .get('/items/912411eee60644e96d000001')
              .set('Accept', 'application/json')
              .end (err, res) ->
                res.body.should.have.property "title"
                res.body.title.should.be.equal "Prisme"
                done()

        describe "POST items", ->
          it "should create an item", (done) ->
            request(app)
              .post('/items')
              .send
                title: "Michelson"
              .end (err, res) ->
                res.status.should.be.equal 201
                res.body.should.have.property "_id"
                res.body.should.have.property "title"
                res.body.title.should.be.equal "Michelson"
                done()

