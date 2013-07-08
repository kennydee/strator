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
        
    # Minimize javascript
    uglify:
      app:
        files: 
          'dist/js/app.min.js': ['lib/**/*.js']
      vendor:
        files:
          'dist/js/vendor.min.js': ['bower_components/angular/angular.js',
            'bower_components/angular-bootstrap/ui-bootstrap.js']
      options: {
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
          '<%= grunt.template.today("yyyy-mm-dd") %> */'
        mangle: true
        report: false
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
      files: ['src/**/*.*', 'test/**/*.*']
      tasks: ['coffee', 'jshint', 'jade']
  )

  grunt.loadNpmTasks('grunt-angular-templates')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-compress')
  grunt.loadNpmTasks('grunt-contrib-watch')
  
  grunt.registerTask('test', [])

  grunt.registerTask('default', ['coffee', 'jshint', 'jade', 'ngtemplates', 'uglify', 'compress'])
  


