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
          },
          {'app.js': 'app.litcoffee'}
        ]
      app:
        files: [{
          expand: true,
          cwd: 'test/',
          src: ['**/*.litcoffee'],
          dest: 'test/',
          ext: '.js'
        }]

   
    watch:
      files: ['app.litcoffee', 'src/**/*.litcoffee', 'test/**/*.litcoffee']
      tasks: ['coffee', 'jshint']
  )


  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  
  grunt.registerTask('test', [])

  grunt.registerTask('default', ['coffee', 'jshint'])
  


