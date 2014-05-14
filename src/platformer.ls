class Platformer extends GameBase

  width : 800px
  height: 600px

  assets:
    * id: 'main'
      type: 'spriteSheet'
      url: 'res/simples_pimples.png'

  physics: Phaser.Physics.ARCADE

  objects:
    * id: 'player'
      type: Player
      x: 100px
      y: 100px
    * id: 'block1'
      type: Block
      x: 100px
      y: 200px