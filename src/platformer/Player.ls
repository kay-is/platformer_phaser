class platformer.Player

  sprite: void
  game: void
  collisionGroup: void

  ({@game, x = 0px, y = 0px})!~>
    @sprite = @game.add.sprite x*32, y*32, 'main', 70

    @sprite.anchor.setTo 0.5, 0.5

    @game.physics.p2.enable @sprite, no
    @sprite.body.fixedRotation = yes
    @collisionGroup = @game.physics.p2.createCollisionGroup!
    @sprite.body.setCollisionGroup @collisionGroup

    @sprite.body.collideWorldBounds = no

    @initInput!

    @sprite.animations.add \walk [71 72] 10 yes

  initInput: !->
    uses = @game.input.keyboard~addKey
    @key =
      up: uses Phaser.Keyboard.W
      left: uses Phaser.Keyboard.A
      right: uses Phaser.Keyboard.D

  collides: ({collisionGroup})!~>
    @sprite.body.collides collisionGroup, (player, block)!~>
      @sprite.body.touchingBlock = yes if block.y > player.y

  update: !~>
    @sprite.body.velocity.x = 0

    if @sprite.body.x < 0px
      @sprite.body.x = @game.width
    else if @sprite.body.x > @game.width
      @sprite.body.x = 0px

    if @sprite.body.y < 0px
      @sprite.body.y = @game.height
    else if @sprite.body.y > @game.height
      @sprite.body.y = 0px

    if @key.left.isDown
      @moveLeft!
    else if @key.right.isDown
      @moveRight!
    else
      @stand!

    if @key.up.isDown and @sprite.body.touchingBlock
      @sprite.body.touchingBlock = no
      @jump!

    if @game.input.activePointer.isDown
      @shootBullet!

  moveLeft: !->
    @flip!
    @sprite.body.velocity.x = -300px
    @sprite.animations.play \walk

  moveRight: !->
    @unflip!
    @sprite.body.velocity.x = 300px
    @sprite.animations.play \walk

  stand: !->
    @sprite.animations.stop!
    @sprite.frame = 70

  jump: !->
    @sprite.body.velocity.y = -500px

  flip: !-> @sprite.scale.x *= -1 unless @sprite.scale.x < 0
  unflip: !-> @sprite.scale.x *= -1 unless @sprite.scale.x > 0