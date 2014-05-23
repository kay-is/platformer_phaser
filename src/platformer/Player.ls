class Platformer.Player

  sprite: void
  game: void
  collisionGroup: void
  shurikenCollisionGroup: void

  speed: 300px
  jumpSpeed: 500px

  spriteFrame: 70

  keyConfig:
    jump: 'W'
    left: 'A'
    right: 'D'

  ({@game, x = 0px, y = 0px})!~>
    @sprite = @game.add.sprite x*32, y*32, 'main', @spriteFrame

    @sprite.anchor.setTo 0.5, 0.5

    @game.physics.p2.enable @sprite
    @sprite.body.fixedRotation = yes
    @collisionGroup = @game.physics.p2.createCollisionGroup!
    @sprite.body.setCollisionGroup @collisionGroup

    @sprite.body.collideWorldBounds = no

    @initInput!

    @sprite.animations.add \walk [71 72] 10 yes

    @initShurikens!

  initInput: !->
    uses = @game.input.keyboard~addKey
    @key =
      jump: uses Phaser.Keyboard[@keyConfig.jump]
      left: uses Phaser.Keyboard[@keyConfig.left]
      right: uses Phaser.Keyboard[@keyConfig.right]

  collides: ({collisionGroup})!~>
    @sprite.body.collides collisionGroup, (player, block)!~>
      @sprite.body.touchingBlock = yes if block.y > player.y

    @shurikenPool.forEach !->
      it.body.collides collisionGroup, !-> it.static = yes

  worldWrap: ({body})!~>
    if body.x < 0px
      body.x = @game.width
    else if body.x > @game.width
      body.x = 0px

    if body.y < 0px
      body.y = @game.height
    else if body.y > @game.height
      body.y = 0px

  updateInput: !~>
    | @key.left.isDown  => @moveLeft!
    | @key.right.isDown => @moveRight!
    | _                 => @stand!

    if @key.jump.isDown and @sprite.body.touchingBlock
      @sprite.body.touchingBlock = no
      @jump!

    if @game.input.activePointer.isDown
      @throw!

  update: !~>
    @sprite.body.velocity.x = 0px

    @worldWrap @sprite

    @updateInput!

    @shurikenPool.forEachAlive @worldWrap

  moveLeft: !->
    @flip!
    @sprite.body.velocity.x = -@speed
    @sprite.animations.play \walk

  moveRight: !->
    @unflip!
    @sprite.body.velocity.x = @speed
    @sprite.animations.play \walk

  stand: !->
    @sprite.animations.stop!
    @sprite.frame = 70

  jump: !->
    @sprite.body.velocity.y = -@jumpSpeed

  throw: !~>
    @lastBulletShotAt = 0 unless @lastBulletShotAt

    return if @game.time.now - @lastBulletShotAt < 300ms

    @lastBulletShotAt = @game.time.now

    shuriken = @shurikenPool.getFirstDead!
    return unless shuriken?

    shuriken.revive!

    mouse = @game.input.activePointer

    xOffset = if mouse.x < @sprite.x then -30 else 30

    shuriken.reset @sprite.x + xOffset, @sprite.y

    shuriken.checkWorldBounds = yes
    shuriken.outOfBoundsKill = yes

    shuriken.rotation = @game.math.angleBetween shuriken.x, shuriken.y, mouse.x, mouse.y

    shuriken.body.velocity.x = (Math.cos shuriken.rotation) * 1300px
    shuriken.body.velocity.y = (Math.sin shuriken.rotation) * 1300px

  createShuriken: !~>
      shuriken = @shurikenPool.add (@game.add.sprite 0px, 0px, 'main', 1742)

      shuriken.anchor.setTo 0.5width, 0.5height

      @game.physics.p2.enable shuriken

      shuriken.body.setCircle 10px

      shuriken.body.setCollisionGroup @shurikenCollisionGroup

      shuriken.body.collides @shurikenCollisionGroup
      shuriken.body.collides @collisionGroup, !->
        shuriken.body.static = no
        shuriken.kill!

      @sprite.body.collides @shurikenCollisionGroup

      shuriken.kill!

  initShurikens: !~>
    @shurikenPool = @game.add.group!
    @shurikenCollisionGroup = @game.physics.p2.createCollisionGroup!
    for i from 1 to 100
      @createShuriken!

  flip: !->
    @sprite.scale.x *= -1 unless @sprite.scale.x < 0
    @flipped = yes

  unflip: !->
    @sprite.scale.x *= -1 unless @sprite.scale.x > 0
    @flipped = no