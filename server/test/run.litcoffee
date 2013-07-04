Tests
#####

Testing...

    process.env.NODE_ENV = 'test'

    Mocha = require 'mocha'
    optimist = require 'optimist'


    argv = optimist
      .usage("Usage: $0 -t [types] --reporter [reporter] --timeout [timeout]")
      .default({types: 'unit,functional', reporter: 'dot', timeout: 6000})
      .describe('types', 'The types of tests to run, separated by commas. E.g., unit,functional,acceptance')
      .describe('reporter', 'The mocha test reporter to use.')
      .describe('timeout', 'The mocha timeout to use per test (ms).')
      .boolean('help')
      .alias('types', 'T')
      .alias('timeout', 't')
      .alias('reporter', 'R')
      .alias('help', 'h')
      .argv;

    mocha = new Mocha {timeout: argv.timeout, reporter: argv.reporter, ui: 'bdd'}

    mocha.addFile __dirname + "/items.js"
    mocha.addFile __dirname + "/places.js"
    mocha.addFile __dirname + "/providers.js"
    mocha.addFile __dirname + "/security.js"  

    mocha.run (failures) ->
      process.exit failures

