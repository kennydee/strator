Tests for providers
###################


Testing providers


    process.env.NODE_ENV = 'test'

    app = require "../app"
    should = require "should"
    request = require "supertest"


    describe "Provider", ->
      beforeEach (done) ->
        fixtures = require '../lib/fixtures'
        fixtures.clear app, ['providers'], () ->
          fixtures.load app, ['providers'], done



      describe "Provider API : ", ->
        describe "GET providers", ->
          it "should return a list of providers", (done) ->
            request(app)
              .get('/providers')
              .set('Accept','application/json')
              .end (err, res) ->
                res.body.should.have.lengthOf 1
                done()
        describe "POST provider", ->
          it "should create a provider", (done) ->
            request(app)
              .post('/providers')
              .send
                title: "Test"
              .end (err, res) ->
                res.status.should.be.equal 201
                res.body.should.have.property "title"
                res.body.title.should.be.equal "Test"
                done()
