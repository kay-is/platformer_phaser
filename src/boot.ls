do ->
  game = new Phaser.Game 1024px, 768px, Phaser.AUTO

  game.state.add \Menu new Platformer.state.Menu
  game.state.add \Play new Platformer.state.Play
  game.state.add \Edit new Platformer.state.Edit

  game.state.start \Menu