do ->
  game = new Phaser.Game 1024px, 768px, Phaser.AUTO

  game.state.add \Menu new platformer.state.Menu
  game.state.add \Play new platformer.state.Play
  game.state.add \Edit new platformer.state.Edit

  game.state.start \Menu