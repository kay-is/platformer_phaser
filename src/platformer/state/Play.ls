class platformer.state.Play

  id: 'Play'
  player: void

  maps:
    test1: [["main",220,0,23],["main",220,1,23],["main",220,2,23],["main",220,3,23],["main",220,4,23],["main",220,5,23],["main",220,6,23],["main",220,7,23],["main",220,8,23],["main",220,9,23],["main",220,10,23],["main",220,11,23],["main",220,12,23],["main",220,18,23],["main",220,19,23],["main",220,20,23],["main",220,21,23],["main",220,23,23],["main",220,22,23],["main",220,24,23],["main",220,25,23],["main",220,26,23],["main",220,31,23],["main",220,27,23],["main",220,29,23],["main",220,30,23],["main",220,28,23],["main",220,13,23],["main",220,18,22],["main",220,19,22],["main",220,20,22],["main",220,21,22],["main",220,22,22],["main",220,23,22],["main",220,24,22],["main",220,25,22],["main",220,26,22],["main",220,28,22],["main",220,30,22],["main",220,31,22],["main",220,29,22],["main",220,27,22],["main",220,13,22],["main",220,11,22],["main",220,12,22],["main",220,10,22],["main",220,9,22],["main",220,8,22],["main",220,6,22],["main",220,5,22],["main",220,7,22],["main",220,4,22],["main",220,3,22],["main",220,2,22],["main",220,1,22],["main",220,0,22],["main",220,13,5],["main",220,13,0],["main",220,13,2],["main",220,13,4],["main",220,13,3],["main",220,13,1],["main",220,18,5],["main",220,18,4],["main",220,18,2],["main",220,18,0],["main",220,18,1],["main",220,18,3],["main",220,12,5],["main",220,12,4],["main",220,12,3],["main",220,12,2],["main",220,12,1],["main",220,12,0],["main",220,19,0],["main",220,19,1],["main",220,19,2],["main",220,19,3],["main",220,19,5],["main",220,13,9],["main",220,14,9],["main",220,15,9],["main",220,16,9],["main",220,17,9],["main",220,18,9],["main",220,14,10],["main",220,15,10],["main",220,17,10],["main",220,16,10],["main",221,0,21],["main",221,0,20],["main",224,0,18],["main",224,0,17],["main",220,0,19],["main",220,0,16],["main",220,1,16],["main",220,2,16],["main",220,3,16],["main",220,1,19],["main",220,2,19],["main",220,3,19],["main",220,4,19],["main",220,5,19],["main",220,6,19],["main",223,0,15],["main",223,0,14],["main",220,0,13],["main",220,1,13],["main",220,2,13],["main",220,3,13],["main",220,4,16],["main",220,5,16],["main",220,6,16],["main",220,7,19],["main",220,8,19],["main",220,9,19],["main",220,22,19],["main",220,23,19],["main",220,24,19],["main",220,25,19],["main",220,26,19],["main",220,27,19],["main",220,30,19],["main",220,31,19],["main",220,29,19],["main",220,28,19],["main",220,31,16],["main",220,30,16],["main",220,31,13],["main",220,30,13],["main",220,29,13],["main",220,28,13],["main",220,29,16],["main",220,28,16],["main",220,27,16],["main",220,26,16],["main",220,25,16],["main",224,31,17],["main",224,31,18],["main",221,31,20],["main",221,31,21],["main",223,31,14],["main",223,31,15],["main",220,31,9],["main",220,30,9],["main",220,28,9],["main",220,27,9],["main",220,26,9],["main",220,25,9],["main",220,24,9],["main",220,23,9],["main",220,22,9],["main",220,22,8],["main",220,22,7],["main",220,22,6],["main",220,22,5],["main",220,20,5],["main",220,21,5],["main",220,20,4],["main",220,19,4],["main",220,22,4],["main",220,21,4],["main",220,23,4],["main",220,23,5],["main",220,23,6],["main",220,23,7],["main",220,23,8],["main",220,9,8],["main",220,9,7],["main",220,9,6],["main",220,9,5],["main",220,11,5],["main",220,10,5],["main",220,11,4],["main",220,10,4],["main",220,9,4],["main",220,8,4],["main",220,8,5],["main",220,8,6],["main",220,8,7],["main",220,8,8],["main",220,8,9],["main",220,7,9],["main",220,0,9],["main",220,1,9],["main",220,3,9],["main",220,6,9],["main",220,4,9],["main",220,5,9],["main",220,2,9],["main",220,7,8],["main",220,6,8],["main",220,5,8],["main",220,4,8],["main",220,1,8],["main",220,0,8],["main",220,3,8],["main",220,2,8],["main",220,9,9],["main",220,24,8],["main",220,25,8],["main",220,26,8],["main",220,27,8],["main",220,29,8],["main",220,28,8],["main",220,30,8],["main",220,29,9],["main",220,31,9],["main",220,13,10],["main",220,18,10],["main",220,31,8]]

  create: !~>
    @game.stage.backgroundColor = \#000000

    esc = @game.input.keyboard.addKey Phaser.Keyboard.ESC
    esc.onDown.add !~> @game.state.start \Menu

    @initPhysics!

    @blockCollisionGroup = @game.physics.p2.createCollisionGroup!

    @game.physics.p2.updateBoundsCollisionGroup!

    @player = new platformer.Player game:@game, x:15, y:18
    @player.collides collisionGroup:@blockCollisionGroup

    @blockGroup = @game.add.group!
    @blockGroup.enableBody = yes
    @blockGroup.physicsBodyType = Phaser.Physics.P2JS

    @loadMap map:@maps.test1

  update: !~>
    @player.update!

  initPhysics: !~>
    @game.world.setBounds 0px, 0px, 1024px, 768px
    @game.physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.gravity.y = 1200
    @game.physics.p2.restitution = 0.0
    @game.physics.p2.setImpactEvents on

  loadMap: ({map})!->
    for block in map
      @createBlock x:block.2, y:block.3, sheet:block.0, frame:block.1

  createBlock: ({x, y, sheet, frame})!->
    block = @blockGroup.create x*32+16, y*32+16, sheet, frame
    block.body.static = yes
    block.body.setCollisionGroup @blockCollisionGroup
    block.body.collides @player.collisionGroup
    block