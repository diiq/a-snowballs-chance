canvas = require "./canvas"
Player = require "./player/Player"
Light = require "./light/Light"
world = require "./world"
history = require "./history-of-the-world"

now = -> (new Date()).getTime()


# The player
player = new Player
  x: 40
  y: 490


# The Game loop

lastStep = now()
setInterval ->
  thisStep = now()
  steps = thisStep - lastStep

  # If you change tabs, steps can be a bajillion. Don't let that
  # happen.
  if steps > 500
    #lastStep = thisStep
    return

  # hax for playtesting
  Light.moveLight(world.light, steps)

  # move the player
  player.move(steps, world.blinds)
  player.updateHealth history.lightHistory.evilPolys(), steps

  # REDRAW!!
  canvas.clear()
  history.drawLightHistory(canvas)
  canvas.add player.fabricObject()
  world.draw(canvas)
  canvas.renderAll()

  lastStep = thisStep
, 10
