fabric = require("fabric").fabric

Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"
Light = require "./light/Light"
intersect = require "./polygon/intersect"


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

l1 = new Light {x: 550, y: 300}
canvas.add(l1.visibleFabricPoly(blinds))

l2 = new Light {x: 60, y: 180}
canvas.add(l2.visibleFabricPoly(blinds))

#l3 = new Light {x: 10, y: 10}
#canvas.add(l3.visibleFabricPoly(blinds))

p1 = l1.litPolygon(blinds)
p2 = l2.litPolygon(blinds)
#p3 = l3.litPolygon(blinds)
ps = [p1, p2]

ps = intersect(ps)
for p in ps
  canvas.add new fabric.Polygon p,
    fill: "#f00"
    opacity: .5

canvas.renderAll()
