Blind = require "../blind/Blind"


module.exports = class Room
  constructor: (ptA, ptB) ->
    @walls = [new Blind(
      {x: ptA.x, y: ptA.y},
      {x: ptA.x + 5, y: ptB.y}
    ),

    new Blind(
      {x: ptB.x, y: ptA.y},
      {x: ptB.x + 5, y: ptB.y}
    ),

    new Blind(
      {x: ptA.x, y: ptA.y},
      {x: ptB.x, y: ptA.y + 5}
    ),

    new Blind(
      {x: ptA.x, y: ptB.y},
      {x: ptB.x, y: ptB.y + 5}
    )]
