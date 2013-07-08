Tests for security
##################


Testing scurity infos


    process.env.NODE_ENV = 'test'

    app = require "../app"
    should = require "should"
    request = require "supertest"


    describe "Security data", ->
      beforeEach (done) ->
        fixtures = require '../fixtures'
        fixtures.clear app, ['securities'], () ->
          fixtures.load app, ['securities'], done



      describe "Security API : ", ->
        describe "GET security", ->
          it "should return a list of security data", (done) ->
            request(app)
              .get('/securities')
              .set('Accept','application/json')
              .end (err, res) ->
                res.body.should.have.lengthOf 1
                done()

        describe "POST security", ->
          it "should create a security", (done) ->
            request(app)
              .post('/securities')
              .send
                type: "R"
                code: "R11"
                details: "Porter des gants"
              .end (err, res) ->
                res.status.should.be.equal 201
                res.body.should.have.property "_id"
                res.body.should.have.property "code"
                res.body.code.should.be.equal "R11"
                done()

