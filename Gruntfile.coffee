# Grunt configuration updated to latest Grunt.  That means your minimum
# version necessary to run these tasks is Grunt 0.4.
#
# Please install this locally and install `grunt-cli` globally to run.
module.exports = ->

  # Initialize the configuration.
  @initConfig

    jshint:
      all: ["Gruntfile.js", "tasks/*.js", "<%= nodeunit.tests %>"]

      options:
        jshintrc: ".jshintrc"

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]
    
    # Configuration to be run (and then tested).
    bbb_server:
      default_options:
        options: {}
        files:
          "tmp/default_options": ["test/fixtures/testing", "test/fixtures/123"]

      custom_options:
        options:
          separator: ": "
          punctuation: " !!!"

        files:
          "tmp/custom_options": ["test/fixtures/testing", "test/fixtures/123"]

    # Unit tests.
    nodeunit:
      tests: ["test/*_test.js"]
  
  # Actually load this plugin's task(s).
  @loadTasks "tasks"
  
  # These plugins provide necessary tasks.
  @loadNpmTasks "grunt-contrib-jshint"
  @loadNpmTasks "grunt-contrib-clean"
  @loadNpmTasks "grunt-contrib-nodeunit"
  
  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  @registerTask "test", ["clean", "bbb_server", "nodeunit"]
  
  # By default, lint and run all tests.
  @registerTask "default", ["jshint", "test"]
