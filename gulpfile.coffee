gulp        = require 'gulp'
preprocess  = require 'gulp-preprocess'
coffee      = require 'gulp-coffee'
rename      = require 'gulp-rename'

gulp.task 'release', ->
  gulp.src 'src/bundle.coffee'
  .pipe preprocess()
  .pipe coffee(bare: true)
  .pipe rename('backbone.sync-events.js')
  .pipe gulp.dest('lib')