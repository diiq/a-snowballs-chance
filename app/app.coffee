Blind = require "./blind/Blind"
canvas = require "./canvas"

new Blind(
  {x: 100, y: 100},
  {x: 200, y: 100}
)

canvas.renderAll()
