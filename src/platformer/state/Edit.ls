class platformer.state.Edit

  create: !~>
    @blocks = []
    @blockType = 220

    @game.stage.backgroundColor = \#999999

    @clickArea = @game.add.sprite 0px, 0px, @game.add.bitmapData 1024px, 768px
    @clickArea.inputEnabled = yes
    @clickArea.events.onInputDown.add (target, mouse)!~>
      | mouse.button is Phaser.Mouse.LEFT_BUTTON   => @placeBlock!
      | mouse.button is Phaser.Mouse.MIDDLE_BUTTON => @exportMap!

    @game.input.onDown.add (mouse)!~>
      @openMenu! if mouse.button is Phaser.Mouse.RIGHT_BUTTON

    esc = @game.input.keyboard.addKey Phaser.Keyboard.ESC
    esc.onDown.add !~>
      @exportMap!
      @game.state.start \Menu

  placeBlock: !~>
    x = @game.input.x - @game.input.x % 32px
    y = @game.input.y - @game.input.y % 32px

    block = @game.add.sprite x, y, 'main', @blockType

    block.id = 'b_' + @game.time.now
    block.sheet = 'main'
    block.frame = @blockType
    block.inputEnabled = yes

    block.events.onInputDown.add ({id})!~>
      block.destroy!
      delete @blocks[id]

    @blocks[block.id] = block

  exportMap: !~>
    map = []
    for id, block of @blocks
      map.push [
        block.sheet
        block.frame
        block.x/32
        block.y/32
      ]
    console.log 'Map: ' + JSON.stringify map

  openMenu: !~>
    x = @game.input.x
    y = @game.input.y
    menu = @game.add.bitmapData 212px, 52px
    menu.fill 0xff, 0xff, 0xff

    menuSprite = @game.add.sprite x, y, menu

    closeMenu = !->
      menuSprite.destroy!
      red.destroy!
      blue.destroy!
      grey.destroy!
      brown.destroy!
      green.destroy!

    createButton = ({x, type})~>
      button = @game.add.sprite x, y+10px, 'main', type
      button.inputEnabled = yes
      button.blockType = type
      button.events.onInputDown.add ({@blockType})!~> closeMenu!
      button

    red   = createButton x:x+10px  type:220
    blue  = createButton x:x+50px  type:221
    grey  = createButton x:x+90px  type:222
    brown = createButton x:x+130px type:223
    green = createButton x:x+170px type:224

    @clickArea.events.onInputUp.addOnce !~>
      @clickArea.events.onInputDown.addOnce closeMenu