class Game

  width: 800px
  height: 600px
  game: void
  player: void

  -> @game = new Phaser.Game @width, @height, Phaser.AUTO, void, this

  preload: ->
    @loadSpriteSheet sheet:'main' url:'res/simples_pimples.png'

  create: ->
    @player = @createSprite sheet:'main' frame:35 y:10px x:10px

  update: ->

  loadSpriteSheet: ({ sheet, url, w = 32px, h = 32px })->
    @game.load.spritesheet sheet, url, w, h

  createSprite: ({sheet, x = 0px, y = 0px, frame = 0})->
    @game.add.sprite x, y, sheet, frame