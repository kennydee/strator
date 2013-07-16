Strator main app
################

Defines states and deps

    angular.module( "stratorDev", ['strator', 'ngMockE2E'])
    .run [ '$httpBackend', ($httpBackend) ->
      $httpBackend.when("OPTIONS",/.*/).respond(204, [], {
        "access-control-allow-origin": "*"
        "Access-Control-Allow-Methods": "GET,HEAD,PUT,POST,DELETE"
        "Access-Control-Allow-Headers": "x-requested-with"})
      $httpBackend.whenGET("http://localhost:3000/items").respond([ {title: "TOTO"}])
      $httpBackend.whenGET(/.*/).passThrough()
    ]
