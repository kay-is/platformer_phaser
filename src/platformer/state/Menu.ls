class Platformer.state.Menu

  preload: !->
    @game.stage.backgroundColor = \#000000
    @game.scale.maxWidth = 1024px
    @game.scale.maxHeight = 768px
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    @game.scale.setScreenSize!

    @game.load.spritesheet 'main', 'res/simples_pimples.png', 32px, 32px

  create: !->
    addText = @game.add.text @game.world.centerX - 70px, _, _, fill:'#fff'

    play = addText 270, 'Play'
    play.inputEnabled = yes
    play.events.onInputDown.add !~> @game.state.start \Play

    edit = addText 320, 'Edit'
    edit.inputEnabled = yes
    edit.events.onInputDown.add !~> @game.state.start \Edit