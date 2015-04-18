Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"


blinds = [
  new Blind(
    {x: 200, y: 200},
    {x: 200, y: 300}
  )
]

# The Room:
new Room(
  {x: 10, y: 10},
  {x: 590, y: 590}
)

canvas.renderAll()
