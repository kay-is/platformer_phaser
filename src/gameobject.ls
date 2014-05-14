class GameObject

  @game = void

  sprite: void

  ({x, y})->
    @sprite = @@game.add.sprite x, y, @sheet, @frame

    if @physics?
      @enablePhysics!

    if @animations?
      @addAnimations @animations

  addAnimations: !~>
    for config in it when config.id? and config.frames?
      @addAnimation config
      @playAnimation config.id if config.start

  addAnimation: ({id, frames, fps = 10, loops = yes})!~>
    @sprite.animations.add id, frames, fps, loops

  playAnimation: !~>
    @sprite.animations.play it

  enablePhysics: !~>
    @@game.physics.arcade.enable @sprite

    for i of @physics
      @sprite.body[i] = @physics[i]