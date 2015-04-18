Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"
Light = require "./light/Light"

blinds = [
  new Blind(
    {x: 200, y: 200},
    {x: 200, y: 300}
  )
]

# The Room:
room = new Room(
  {x: 10, y: 10},
  {x: 590, y: 590}
)


blinds = blinds.concat room.walls

l = new Light {x: 580, y: 300}
canvas.add(l.visibleFabricPoly(blinds))


canvas.renderAll()
