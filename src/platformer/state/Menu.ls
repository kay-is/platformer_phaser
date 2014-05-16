class platformer.state.Menu

  preload: !~>
    @game.load.spritesheet 'main', 'res/simples_pimples.png', 32px, 32px

  create: !->
    addText = @game.add.text @game.world.centerX - 100px, _, _, fill:'#fff'

    addText 70, 'MENU'

    play = addText 120, 'Play'
    play.inputEnabled = yes
    play.events.onInputDown.add ~> @game.state.start \Play

    edit = addText 170, 'Edit'
    edit.inputEnabled = yes
    edit.events.onInputDown.add ~> @game.state.start \Edit

