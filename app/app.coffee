fabric = require("fabric").fabric
_ = require "lodash"
deepcopy = require "deepcopy"

Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"
Light = require "./light/Light"
intersect = require "./polygon/intersect"
LightHistory = require "./light/LightHistory"


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


light = new Light {x: 550, y: 300}
light.velocity = {x: 0, y: .05}

now = -> (new Date()).getTime()

history = new LightHistory()
lastStep = now()
lastPoly = null

setInterval ->
  thisStep = now()
  steps = thisStep - lastStep

  # If you change tabs, steps can be a bajillion. Don't let that
  # happen.
  if steps > 500
    #lastStep = thisStep
    return

  moveLight(steps)

  canvas.clear()
  showLightHistory()
  canvas.add light.visibleFabricPoly(blinds)
  _.each blinds, (b) -> canvas.add(b.fabricObject())

  canvas.renderAll()
  lastStep = thisStep
, 50



moveLight = (steps)->
  light.move
    x: light.location.x + light.velocity.x * steps,
    y: light.location.y + light.velocity.y * steps

  if light.location.y > 500
    light.velocity = {x: 0, y: -.05}
  if light.location.y < 100
    light.velocity = {x: 0, y: .05}

showLightHistory = () ->
  ps = _.pluck history.polys, "poly"
  _.each ps, (points) ->
    canvas.add new fabric.Polygon deepcopy(points),
      fill: '#f00'
      opacity: .05

recordLightHistory = () ->
  history.gc(10000)
  if lastPoly
    lastPoly.ended()
  lastPoly = history.addPoly light.litPolygon(blinds)

setInterval recordLightHistory, 250
