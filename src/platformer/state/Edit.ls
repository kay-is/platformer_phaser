class platformer.state.Edit

  blocks: void

  create: !~>
    @blocks = []

    @game.stage.backgroundColor = \#999999

    clickArea = @game.add.sprite 0px, 0px, @game.add.bitmapData 800px, 600px
    clickArea.inputEnabled = yes
    clickArea.events.onInputDown.add (target, mouse)!~>
      | mouse.button is Phaser.Mouse.LEFT_BUTTON   => @placeBlock!
      | mouse.button is Phaser.Mouse.MIDDLE_BUTTON => @exportMap!

    esc = @game.input.keyboard.addKey Phaser.Keyboard.ESC
    esc.onDown.add !~>
      @exportMap!
      @game.state.start \Menu

  placeBlock: !~>
    x = @game.input.x - @game.input.x % 32px
    y = @game.input.y - @game.input.y % 32px

    block = @game.add.sprite x, y, 'main', 220

    block.id = 'b_' + (new Date).getTime!
    block.sheet = 'main'
    block.frame = 220
    block.inputEnabled = yes

    block.events.onInputDown.add ({id})!~>
      block.destroy!
      delete @blocks[id]

    @blocks[block.id] = block

  exportMap: !~>
    map = []
    for block in @blocks
      map.push [
        block.sheet
        block.frame
        block.x/32
        block.y/32
      ]
    console.log 'Map: ' + JSON.stringify map