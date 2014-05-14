class Block extends GameObject

  sheet: 'main'
  frame: 220
  physics:
    immovable: yes


merge = (a, b)->
  for i in a
    b