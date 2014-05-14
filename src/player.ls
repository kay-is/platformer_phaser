class Player extends GameObject

  sheet: 'main'
  frame: 70

  physics:
    gravity: 300

  animations:
    * id    : 'stand'
      frames: [70]
      start : yes

    * id    : 'walk'
      frames: [71 72]