LIVERELOAD_PORT=35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })
mountFolder = (connect, dir) ->
  connect.static(require('path').resolve(dir))


module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  # Directory configuration
  cfg =
    dist: 'dist'         # Dist files
    dev: 'dev'           # Dev output directory
    devtest: 'devtest'   # Dev test output directory
    src: 'src'           # Source directory
    srctest: 'srctest'   # Source test directory


  grunt.initConfig(

    # Package infos
    pkg: grunt.file.readJSON('package.json')

    # Directory config
    cfg: cfg

    #---------------------------------------------------------------------------
    # WATCH coffe changes, jade changes, stylus changes & livereload for all
    watch:

      coffeesrc:
        files: ['<%= cfg.src %>/**/*.litcoffee']
        tasks: ['coffee:src', 'jshint:src']

      coffeetest:
        files: ['<%= cfg.srctest %>/**/*.litcoffee']
        tasks: ['coffee:test', 'jshint:test']

      jade:
        files: ['<%= cfg.src %>/**/*.jade']
        tasks: ['jade:src']

      stylus:
        files: ['<%= cfg.src %>/**/*.styl*']
        tasks: ['stylus:src']

      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: ['<%= cfg.dev %>/**/*.*', '<%= cfg.devtest %>/**/*.*']

    #---------------------------------------------------------------------------
    # SERVE dev files & dist
    connect:

      options:
        port: 9000
        hostname: 'localhost'

      dev:
        options:
          middleware: (connect) ->
            [ lrSnippet, mountFolder(connect, cfg.dev),
              mountFolder(connect, cfg.src) ]
      test:
        options:
          middleware: (connect) ->
            [ mountFolder(connect, cfg.dev),
              mountFolder(connect, cfg.test) ]
      dist:
        options:
          middleware: (connect) ->
            [ mountFolder(connect, cfg.dist) ]

    #---------------------------------------------------------------------------
    # OPEN browser
    open:
      server:
        url: 'http://localhost:<%= connect.options.port %>'


    #---------------------------------------------------------------------------
    # Clean project before build or commit
    clean:
      dist:
        files: [{
          dot: true
          src: [cfg.dev, cfg.dist, cfg.devtest, 'components']
        }]

    # Install components with bower
    bower:
      install:
        options:
          targetDir: './dev/lib'
          layout: 'byComponent'
          install: true
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: true

    # Install modernizr
    modernizr:
      devFile: "<%= cfg.dev %>/lib/modernizr/modernizr-dev.js"
      outputFile: "<%= cfg.dev %>/lib/modernizr/modernizr-dist.js"
      uglify: false
      parseFiles: false
      tests: []
      extra :
        shiv : true
        printshiv : false,
        load : false
        mq : false
        cssclasses : true

    #---------------------------------------------------------------------------
    # JSHint javascript files
    jshint:
      src: ['<%= cfg.dev %>/javascript/*.js']
      test: ['<%= cfg.devtest %>/**/*.js']

    #---------------------------------------------------------------------------
    # Make js files from coffeescript
    coffee:
      src:
        files: [
          {
            expand: true,
            cwd: '<%= cfg.src %>/',
            src: ['**/*.litcoffee'],
            dest: '<%= cfg.dev %>/',
            ext: '.js'
          }
        ]
      test:
        files: [{
          expand: true,
          cwd: '<%= cfg.srctest %>/',
          src: ['**/*.litcoffee'],
          dest: '<%= cfg.devtest %>/',
          ext: '.js'
        }]

    #---------------------------------------------------------------------------
    # Make html files from jade
    jade:
      src:
        files: [{
            expand: true,
            cwd: '<%= cfg.src %>/',
            src: ['**/*.jade'],
            dest: '<%= cfg.dev %>/',
            ext: '.html'
          }]

    #---------------------------------------------------------------------------
    # Image minifier
    imagemin:
      dist:
        files: [{
          expand: true,
          cwd: '<%= cfg.src %>/images',
          src: '**.{png,jpg,jpeg}',
          dest: '<%= cfg.dist %>/images'
        }]

    #---------------------------------------------------------------------------
    # Compile and prefetch partials
    ngtemplates:
      dist:
        options:
          base:       'dev/'
          prepend:    ''
          module:
            name: 'strator'
            define: false
        src: '<%= cfg.dev %>/partials/*.html'
        dest: '<%= cfg.dev %>/templates.js'


    #---------------------------------------------------------------------------
    # Compile stylus stylesheets
    stylus:
      app:
        files:
          '<%= cfg.dev %>/css/app.css': ['<%= cfg.src %>/**/*.stylus']
      options:
        compress: false

    #---------------------------------------------------------------------------
    # Minimize css
    cssmin:
      minify:
        files:
          '<%= cfg.dist %>/css/app.min.css': [
            '<%= cfg.dev %>/lib/bootstrap-css/css/bootstrap.css',
            '<%= cfg.dev %>/lib/bootstrap-css/bootstrap-responsive.css',
            '<%= cfg.dev %>/css/app.css']

    # Minimize javascript
    uglify:
      dist:
        files:
          '<%= cfg.dist %>/js/app.min.js': [
            '<%= cfg.dev %>/lib/angular/angular.js',
            '<%= cfg.dev %>/lib/angular-bootstrap/ui-bootstrap-tpls.js',
            '<%= cfg.dev %>/javascript/**/*.js',
            '<%= cfg.dev %>/templates.js'
            ]
      options: {
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
          '<%= grunt.template.today("yyyy-mm-dd") %> */'
        mangle: true
        report: 'min'
        compress: true
      },

    # Compress files (gzip, for server)
    compress:
      main:
        options:
          mode: 'gzip'
        expand: true,
        cwd: '<%= cfg.dist %>/',
        src: ['**/*'],
        dest: '<%= cfg.dist %>/'

    # Copy other files
    copy:

      dev:
        files: [{
          expand: true
          dot: true
          cwd: '<%= cfg.src %>'
          dest: '<%= cfg.dist %>'
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            'images/**.{gif,webp,svg}',
            'styles/fonts/*'
          ]}]

      dist:
        files: [{
          expand: true
          dot: true
          cwd: '<%= cfg.src %>'
          dest: '<%= cfg.dist %>'
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            'images/{,*/}*.{gif,webp,svg}',
            'styles/fonts/*'
          ]}, {
            expand: true,
            cwd: '<%= cfg.dev %>/images',
            dest: '<%= cfg.dist %>/images',
            src: ['generated/*']
        },
        { '<%= cfg.dist %>/index.html': '<%= cfg.dev %>/index-dist.html'}
        ]


    # Concurrent
    concurrent:
      compile: [
        'coffee','jade','stylus','copy:dev'
      ],

      downloads: [
        'bower', 'modernizr'
      ]
      dev: [
        'watch', 'server:dev'
      ]


    # Test
    test:
      unit: './test/karma-unit-conf.js',
      #midway: './test/karma-midway.conf.js',
      e2e: './test/karma-e2e-conf.js'

    autotest:
      unit: './test/karma-unit-conf.js',
      #midway: './test/karma-midway.conf.js',
      e2e: './test/karma-e2e-conf.js'
  )

  #===========================================================================
  # GLOBAL TASKS

  grunt.registerTask 'build', [
    'clean', 'concurrent:downloads', 'concurrent:compile', 'copy:dist', 'ngtemplates',
    'cssmin', 'imagemin', 'uglify', 'compress'
  ]

  # Run server (default : dev with livereload + watch)
  grunt.registerTask 'server', (target) ->
    if (target == 'dist')
      grunt.task.run(['build', 'open', 'connect:dist:keepalive'])

    grunt.task.run([
      'coffee','jade','stylus','bower', 'modernizr','copy:dev','connect:dev','watch'
    ])
