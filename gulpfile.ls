gulp = require \gulp
concat = require \gulp-concat
livescript = require \gulp-livescript
bower = require \gulp-bower
uglify = require \gulp-uglify

resources = './res/*.png'

sources =
  './src/Namespace.ls'
  './src/platformer/*.ls'
  './src/platformer/state/*.ls'
  './src/boot.ls'

gulp.task \compile ->
  gulp.src sources
    .pipe concat 'game.ls'
    .pipe livescript!
    .pipe uglify!
    .pipe gulp.dest './build'

gulp.task \copyResources ->
  gulp.src resources
    .pipe gulp.dest './build/res'

gulp.task \installLibary ->
  bower!pipe gulp.dest './build/lib'

gulp.task \init -> bower!

gulp.task \build [\compile \copyResources \installLibary]

gulp.task \default [\init]