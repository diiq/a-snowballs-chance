_ = require "lodash"

Room = require "./room/Room"
Blind = require "./blind/Blind"
Light = require "./light/Light"


# The WORLD
blinds = [
  new Blind(
    {x: 200, y: 200},
    {x: 203, y: 300}
  ),
  new Blind(
    {x: 100, y: 500},
    {x: 300, y: 350}
  )
  new Blind(
    {x: 400, y: 100},
    {x: 300, y: 150}
  )
]

room = new Room(
  {x: -10, y: -10},
  {x: 610, y: 610}
)
blinds = blinds.concat room.walls


# The Lighting

light = new Light({x: 550, y: 300})
light.velocity = {x: 0, y: .05}

# Drawing
drawWorld = (canvas) ->
  canvas.add light.visibleFabricPoly(blinds)
  _.each blinds, (b) -> canvas.add(b.fabricObject())

module.exports =
  light: light
  blinds: blinds
  draw: drawWorld
