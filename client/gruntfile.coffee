module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json'),
    
    # Make js files from coffeescript
    coffee:
      lib:
        files: [
          {
            expand: true,
            cwd: 'src/',
            src: ['**/*.litcoffee'],
            dest: 'lib/',
            ext: '.js'
          }
        ]
      test:
        files: [{
          expand: true,
          cwd: 'test/',
          src: ['**/*.litcoffee'],
          dest: 'test/',
          ext: '.js'
        }]

    # JSHint javascript files
    jshint:
      files: ['lib/**/*.js',
              'test/**/*.js']

    # Make html files from jade
    jade:
      partials:
        files: [{
            expand: true,
            cwd: 'src/partials/',
            src: ['**/*.jade'],
            dest: 'lib/partials/',
            ext: '.html'
          }]
      dev:
        files:
          'lib/index.html': 'src/index-dev.jade'
      build:
        files:
          'dist/index.html': 'src/index.jade'


    # Compile and prefetch templates
    ngtemplates:
      strator:
        options:
          base:       'lib/'
          prepend:    ''
        src: 'lib/partials/*.html'
        dest: 'lib/templates.js'
        

    # Compile stylus stylesheets
    stylus:
      app:
        files:
          'lib/css/app.css': ['src/**/*.stylus']
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
     
    # Clean for dist files
    clean:
      dev: ['bower_components', 'dist', 'lib', 'node_modules']
    
   
    watch:
      files: ['src/**/*.*', 'test/**/*.*', 'src/**/*.stylus']
      tasks: ['coffee', 'jshint', 'jade', 'stylus:app']
  )

  grunt.loadNpmTasks('grunt-angular-templates')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-compress')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  
  grunt.registerTask('test', [])

  grunt.registerTask('default', ['coffee', 'jshint', 'jade', 'ngtemplates', 'stylus', 'cssmin', 'uglify', 'compress'])
  


