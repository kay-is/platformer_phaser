class Game

  game: void
  player: void

  -> @game = new Phaser.Game @width, @height, Phaser.AUTO, it, this

  preload: !~>
    @game.load.spritesheet 'main', 'res/simples_pimples.png', 32px, 32px

  create: !~>
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.gravity.y = 1200
    @game.physics.p2.restitution = 0.0
    @game.physics.p2.setImpactEvents on

    @playerCollisionGroup = @game.physics.p2.createCollisionGroup!
    @platformCollisionGroup = @game.physics.p2.createCollisionGroup!

    @game.physics.p2.updateBoundsCollisionGroup!

    @createPlayer x:4, y:15

    @initInput!

    @platforms = @game.add.group!
    @platforms.enableBody = yes
    @platforms.physicsBodyType = Phaser.Physics.P2JS

    for x from 2 to 20
      @createBlock x:x, y:18

    for y from 15 to 17
      @createBlock x:2, y:y

    for y from 15 to 17
      @createBlock x:20, y:y

  update: !~>
    @updateInput!

  bulletBlockCollision: (bullet, block)!~>
    bullet.body.gravity = 0
    @game.debug.body bullet

  createBlock: ({x = 0px, y = 0px})!->
    block = @platforms.create x*32, y*32, 'main', 220
    block.body.static = yes
    block.body.setCollisionGroup @platformCollisionGroup
    block.body.collides @playerCollisionGroup
    return block

  createPlayer: ({x = 0, y = 0})!->
    @player = @game.add.sprite x*32, y*32, 'main', 70

    @player.anchor.setTo 0.5, 0.5

    @game.physics.p2.enable @player, no
    @player.body.fixedRotation = yes
    @player.body.setCollisionGroup @playerCollisionGroup
    @player.body.collides @platformCollisionGroup, ~> @player.body.touchingBlock = true

    @player.animations.add \walk [71 72] 10 yes
    @initBullets!

  initBullets: !->
    @bulletPool = @game.add.group!
    @bulletPool.enableBody = yes

    for i from 0 til 5
      bullet = @game.add.sprite 0, 0, 'main', 1700
      @bulletPool.add bullet
      bullet.anchor.setTo 0.5, 0.5
      bullet.body.gravity.y = 700
      bullet.kill!

  initInput: !->
    uses = @game.input.keyboard~addKey
    @key =
      up: uses Phaser.Keyboard.W
      left: uses Phaser.Keyboard.A
      right: uses Phaser.Keyboard.D

  movePlayerLeft: !->
    @flip @player
    @player.body.velocity.x = -160
    @player.animations.play \walk

  movePlayerRight: !->
    @unflip @player
    @player.body.velocity.x = 160
    @player.animations.play \walk

  letPlayerStand: !->
    @player.animations.stop!
    @player.frame = 70

  letPlayerJump: !->
    @player.body.velocity.y = -500

  shotBullets: {}
  shootBullet: !->
    @lastBulletShotAt = 0 unless @lastBulletShotAt?

    return unless @game.time.now - @lastBulletShotAt > 1000ms

    @lastBulletShotAt = @game.time.now

    bullet = @bulletPool.getFirstDead!

    return unless bullet?

    bullet.revive!

    bullet.checkWorldBounds = yes
    bullet.outOfBoundsKill = yes

    bullet.reset @player.x, @player.y
    @game.physics.arcade.moveToPointer bullet, 700

  updateInput: !->
    @player.body.velocity.x = 0

    if @key.left.isDown
      @movePlayerLeft!
    else if @key.right.isDown
      @movePlayerRight!
    else
      @letPlayerStand!

    if @key.up.isDown and @player.body.touchingBlock
      @letPlayerJump!

    if @game.input.activePointer.isDown
      @shootBullet!

    @player.body.touchingBlock = false

  flip: !-> it.scale.x *= -1 unless it.scale.x < 0
  unflip: !-> it.scale.x *= -1 unless it.scale.x > 0