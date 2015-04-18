fabric = require("fabric").fabric
_ = require "lodash"
deepcopy = require "deepcopy"

Blind = require "./blind/Blind"
canvas = require "./canvas"
Room = require "./room/Room"
Player = require "./player/Player"
Light = require "./light/Light"
intersect = require "./polygon/intersect"
LightHistory = require "./light/LightHistory"
now = -> (new Date()).getTime()

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

light = new Light {x: 550, y: 300}
light.velocity = {x: 0, y: .05}

moveLight = (steps)->
  light.move
    x: light.location.x + light.velocity.x * steps,
    y: light.location.y + light.velocity.y * steps

  if light.location.y > 500
    light.velocity = {x: 0, y: -.05}
  if light.location.y < 100
    light.velocity = {x: 0, y: .05}


# Lighting history

showLightHistory = () ->
  ps = _.pluck history.polys, "poly"
  _.each ps, (points) ->
    canvas.add new fabric.Polygon deepcopy(points),
      fill: '#f00'
      opacity: .05

history = new LightHistory()
lastStep = now()
lastPoly = null
recordLightHistory = () ->
  history.gc(5000)
  if lastPoly
    lastPoly.ended()
  lastPoly = history.addPoly light.litPolygon(blinds)

setInterval recordLightHistory, 250


# The player
player = new Player
  x: 40
  y: 510



# The Game loop

setInterval ->
  thisStep = now()
  steps = thisStep - lastStep

  # If you change tabs, steps can be a bajillion. Don't let that
  # happen.
  if steps > 500
    #lastStep = thisStep
    return

  moveLight(steps)

  player.updateHealth _.pluck(history.polys, "poly"), steps
  canvas.clear()
  showLightHistory()
  canvas.add player.fabricObject()
  canvas.add light.visibleFabricPoly(blinds)
  _.each blinds, (b) -> canvas.add(b.fabricObject())

  canvas.renderAll()
  lastStep = thisStep
, 50
