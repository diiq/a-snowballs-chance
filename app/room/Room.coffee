Blind = require "../blind/Blind"


module.exports = class Room
  constructor: (ptA, ptB) ->
    @walls = [new Blind(
      {x: ptA.x, y: ptA.y},
      {x: ptA.x, y: ptB.y}
    ),

    new Blind(
      {x: ptB.x, y: ptA.y},
      {x: ptB.x, y: ptB.y}
    ),

    new Blind(
      {x: ptA.x, y: ptA.y},
      {x: ptB.x, y: ptA.y}
    ),

    new Blind(
      {x: ptA.x, y: ptB.y},
      {x: ptB.x, y: ptB.y}
    )]
