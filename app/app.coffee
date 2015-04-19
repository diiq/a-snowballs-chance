canvas = require "./canvas"
Light = require "./light/Light"
history = require "./history-of-the-world"
worlds = require "./worlds"

now = -> (new Date()).getTime()

world = null

setWorld = (ind) ->
  world = worlds.list[ind]
  history.setWorld(world)

setWorld(worlds.intro)

# The Game loop

lastStep = now()
setInterval ->
  thisStep = now()
  steps = thisStep - lastStep

  # If you change tabs, steps can be a bajillion. Don't let that
  # happen.
  if steps > 500
    lastStep = thisStep
    return

  # move the world
  world.moveStuff(steps)

  # move the player
  world.player.move(steps, world.blinds)
  if world.player.updateHealth(
    history.lightHistory.evilPolys(),
    [world.light.litPolygon(world.blinds)],
    steps
  )
    setWorld(deadWorld)

  # REDRAW!!
  canvas.clear()
  history.drawLightHistory(canvas)
  canvas.add world.player.fabricObject()
  world.draw(canvas)
  canvas.renderAll()

  lastStep = thisStep
, 10
