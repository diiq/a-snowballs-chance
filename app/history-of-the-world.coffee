_ = require "lodash"

LightHistory = require "./light/LightHistory"
now = -> (new Date()).getTime()

fabric = require("fabric").fabric
deepcopy = require "deepcopy"

world = null
setWorld = (newWorld) ->
  history.polys = []
  world = newWorld

history = new LightHistory()
lastStep = now()
lastPoly = null
recordLightHistory = () ->
  history.gc(3000)
  if lastPoly
    lastPoly.ended()
  lastPoly = history.addPoly world.light.litPolygon(world.blinds)

setInterval recordLightHistory, 250

drawLightHistory = (canvas) ->
  ps = _.pluck history.polys, "poly"
  _.each ps, (points) ->
    canvas.add new fabric.Polygon deepcopy(points),
      fill: '#f00'
      opacity: .07

module.exports =
  lightHistory: history
  drawLightHistory: drawLightHistory
  setWorld: setWorld
