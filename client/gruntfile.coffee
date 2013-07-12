LIVERELOAD_PORT=35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })
mountFolder = (connect, dir) ->
  connect.static(require('path').resolve(dir))


module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  
  cfg = 
    app: 'app'
    dist: 'dist'
    dev: 'dev',
    devtest: 'devtest',
  #  try {
  #      yeomanConfig.app = require('./bower.json').appPath || yeomanConfig.app;
  #  } catch (e) {}

  grunt.initConfig(

    pkg: grunt.file.readJSON('package.json')

    cfg: cfg
    
    # WATCH coffe changes, jade changes, stylus changes & livereload all
    watch:
      coffeesrc:
        files: ['src/**/*.litcoffee']
        tasks: ['coffee:src', 'jshint:src']
      coffeetest:
        files: ['test/**/*.litcoffee']
        tasks: ['coffee:test', 'jshist:test']
      jade:
        files: ['src/**/*.jade']
        tasks: ['jade:src']
      stylus:
        files: ['src/**/*.styl*']
        tasks: ['stylus:src']
      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: [
          'dev/**/*.*'
        ]
    
    # Serve dev files
    connect:
      options:
        port: 9000
        hostname: 'localhost'
      livereload:
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

    # Open server
    open:
      server:
        url: 'http://localhost:<%= connect.options.port %>'
          
    
    # Clean project
    clean:
      dist:
        files: [{
          dot: true
          src: [cfg.dev, cfg.dist]
        }]
      dec: cfg.dev
      
    # JSHint javascript files
    jshint:
      src: ['dev/**/*.js']
      test: ['devtest/**/*.js']
    
    # Make js files from coffeescript
    coffee:
      src:
        files: [
          {
            expand: true,
            cwd: 'src/',
            src: ['**/*.litcoffee'],
            dest: 'dev/',
            ext: '.js'
          }
        ]
      test:
        files: [{
          expand: true,
          cwd: 'test/',
          src: ['**/*.litcoffee'],
          dest: 'devtest/',
          ext: '.js'
        }]


    # Make html files from jade
    jade:
      src:
        files: [{
            expand: true,
            cwd: 'src/partials/',
            src: ['**/*.jade'],
            dest: 'dev/partials/',
            ext: '.html'
          }]
      dev:
        files:
          'dev/index.html': 'src/index-dev.jade'
      dist:
        files:
          'dist/index.html': 'src/index.jade'


    # Image minifier
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= cfg.src %>/images',
          src: '**.{png,jpg,jpeg}',
          dest: '<%= cfg.dist %>/images'
        }]
      }
    },

    # Compile and prefetch templates
    ngtemplates:
      strator:
        options:
          base:       'dev/'
          prepend:    ''
        src: 'dev/partials/*.html'
        dest: 'dev/templates.js'
        

    # Compile stylus stylesheets
    stylus:
      app:
        files:
          'dev/css/app.css': ['src/**/*.stylus']
      options:
        compress: false
    
    # Minimize css
    cssmin:
      minify:
        files:
          'dist/css/app.min.css': [
            'bower_components/bootstrap-css/css/bootstrap.css',
            'bower_components/bootstrap-css/bootstrap-responsive.css',
            'lib/css/app.css']

    # Minimize javascript
    uglify:
      dist:
        files:
          'dist/js/app.min.js': [
            'bower_components/angular/angular.js',
            'bower_components/angular-bootstrap/ui-bootstrap.js',
            'lib/**/*.js']
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
        cwd: 'dist/',
        src: ['**/*'],
        dest: 'dist/'

    # Copy other files
    copy:
      dist:
        files: [{
          expand: true
          dot: true
          cwd: 'src'
          dest: 'dist'
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            'images/{,*/}*.{gif,webp,svg}',
            'styles/fonts/*'
          ]}, {
            expand: true,
            cwd: 'dev/images',
            dest: 'dist/images',
            src: ['generated/*']
        }]


    # Concurrent
    concurrent:
      server: [
        'coffee:dist'
      ],
      test: [
        'coffee'
      ],
      dist: [
        'coffee',
        'imagemin',
        'htmlmin'
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

  grunt.registerTask 'build', ['coffee', 'jshint', 'jade', 'ngtemplates', 
    'stylus', 'cssmin', 'uglify', 'compress'])
    
  grunt.registerTask 'server', (target) ->
    if (target == 'dist')
      grunt.task.run(['build', 'open', 'connect:dist:keepalive'])
      
    grunt.task.run([
     # 'clean:server',
     # 'concurrent:server',
      'build',
      'connect:livereload',
      'open',
      'watch'
    ])


