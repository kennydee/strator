Karma configuration
###################

Karma client configuration


    basePath = ''


    files = [
      MOCHA,
      MOCHA_ADAPTER,
      'devtest/e2e/*.js'
    ]


    exclude = []


    reporters = ['progress']

    port = 9876


    runnerPort = 9100;


    colors = true;


    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel = LOG_INFO


    autoWatch = true

    browsers = ['PhantomJS', 'Firefox', 'Chrome', 'Opera']


    captureTimeout = 60000

    singleRun = false
