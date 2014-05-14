class GameBase

  game: void

  ->
    @game = new Phaser.Game @width, @height, Phaser.AUTO, it, this
    GameObject.game = @game

  preload: !~>
    return unless @assets?

    for asset in @assets
      if asset.type is 'spriteSheet' and asset.id? and asset.url?
        @loadSpriteSheet asset
      else if asset.type is 'image' and asset.id? and asset.url?
        @loadImage asset

  create: !~>
    @game.physics.startSystem @physics if @physics?

    if @objects?
      objects = @objects
      @objects = {}
      for object in objects
        @objects[object.id] = new object.type x:object.x, y:object.y

  loadSpriteSheet: ({id, url, w = 32px, h = 32px })->
    @game.load.spritesheet id, url, w, h

  loadImage: ({id, url})->
    @game.load.image id, url

  collide: ({a, b})->
    @game.physics.arcade.collide a.sprite, b.sprite