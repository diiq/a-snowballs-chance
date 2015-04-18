Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"
Light = require "./light/Light"

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

# The Room:
room = new Room(
  {x: 10, y: 10},
  {x: 590, y: 590}
)


blinds = blinds.concat room.walls

l = new Light {x: 580, y: 300}
canvas.add(l.visibleFabricPoly(blinds))

l = new Light {x: 580, y: 320}
canvas.add(l.visibleFabricPoly(blinds))

l = new Light {x: 580, y: 280}
canvas.add(l.visibleFabricPoly(blinds))

l = new Light {x: 580, y: 310}
canvas.add(l.visibleFabricPoly(blinds))

l = new Light {x: 580, y: 290}
canvas.add(l.visibleFabricPoly(blinds))


canvas.renderAll()
