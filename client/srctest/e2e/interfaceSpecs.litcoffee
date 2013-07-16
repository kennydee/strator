Strator interface
#################

Homepage
========

La page d'accueil présente :

* un titre
* une liste de matériel
* une liste des emplacements de rangement
* une liste des fournisseurs

La liste des emplacements de rangements


    webdriver = require 'selenium-webdriver'
    protractor = require 'protractor'

    describe 'Homepage', () ->
      this.timeout 50000
      ptor = undefined
      driver = undefined

      before( () ->
        driver = new webdriver.Builder().
            usingServer('http://localhost:4444/wd/hub').
            withCapabilities({
              'browserName': 'firefox',
              'version': '',
              'platform': 'ANY',
              'javascriptEnabled': true
            }).build();

        driver.manage().timeouts().setScriptTimeout(10000)
        ptor = protractor.wrapDriver(driver)
        ptor
      )

      after( (done) ->
        driver.quit().then( done )
      )

      it 'should open a page', (done) ->
        ptor.get('http://localhost:9000/index-dev.html').then(() -> done())
