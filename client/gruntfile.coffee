module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json'),

    jshint:
      files: ['lib/**/*.js',
              'test/**/*.js']
    
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

   
    ngtemplates:
      strator:
        options:
          base:       'lib/'
          prepend:    ''
        src: 'lib/partials/*.html'
        dest: 'lib/templates.js'
        
   
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
        
    
    compress:
      main:
        options:
          mode: 'gzip'
        expand: true,
        cwd: 'dist/',
        src: ['**/*'],
        dest: 'dist/'
     
    
    clean:
      dev: ['bower_components', 'dist', 'lib', 'node_modules']
    
    jade:
      partials:
        files: [{
            expand: true,
            cwd: 'src/partials/',
            src: ['**/*.jade'],
            dest: 'lib/partials/',
            ext: '.html'
          }]
      main:
        files:
          'dist/index.html': 'src/index.jade'
   
    watch:
      files: ['src/**/*.litcoffee', 'test/**/*.litcoffee']
      tasks: ['coffee', 'jshint']
  )

  grunt.loadNpmTasks('grunt-angular-templates')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-compress')
  
  grunt.registerTask('test', [])

  grunt.registerTask('default', ['coffee', 'jshint', 'jade', 'ngtemplates', 'uglify', 'compress'])
  


