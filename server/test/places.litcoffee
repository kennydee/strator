Tests for places
################


Testing places infos


    process.env.NODE_ENV = 'test'

    app = require "../app"
    should = require "should"
    request = require "supertest"


    describe "Places data", ->
      beforeEach (done) ->
        fixtures = require '../fixtures'
        fixtures.clear app, ['places'], () ->
          fixtures.load app, ['places'], done



      describe "Places API : ", ->
        describe "GET places", ->
          it "should return a list of places", (done) ->
            request(app)
              .get('/places')
              .set('Accept','application/json')
              .end (err, res) ->
                res.body.should.have.lengthOf 1
                done()

        describe "POST places", ->
          it "should create a place", (done) ->
            request(app)
              .post('/places')
              .send
                place: "Tiroir jaune"
              .end (err, res) ->
                res.status.should.be.equal 201
                res.body.should.have.property "_id"
                res.body.should.have.property "place"
                res.body.place.should.be.equal "Tiroir jaune"
                done()

