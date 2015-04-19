fabric = require("fabric").fabric

canvas = require "./canvas"
Light = require "./light/Light"
history = require "./history-of-the-world"
worlds = require "./worlds"
input = require "./input"
now = -> (new Date()).getTime()


# Initialize some globals because globals are excellent software
# practice
points = 0
lastStep = now()
world = null
worldInd = null
lastWorldInd = null

setWorld = (ind) ->
  lastWorldInd = worldInd
  worldInd = ind
  world = worlds.list[ind]
  world.reset()
  history.setWorld(world)

setWorld(worlds.intro)

# The Game loop
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

  dead = world.player.updateHealth(
    history.lightHistory.evilPolys(),
    [world.light.litPolygon(world.blinds)],
    steps
  )

  if dead
    setWorld(worlds.dead)
    setTimeout ->
      if worldInd == worlds.dead
        setWorld(lastWorldInd)
    , 7000

  if world.goal.win(world.player)
    points += Math.round(world.player.health)
    setWorld(worldInd + 1)

  # HAHAHAHAHAHAAAAXXXXXX

  if worldInd == worlds.intro and input.anyKeysDown "space", "enter"
    setWorld(worlds.first)

  if worldInd == worlds.dead and input.anyKeysDown "space", "enter"
    setWorld(lastWorldInd)

  # REDRAW!!

  canvas.clear()
  world.drawBottom(canvas)
  history.drawLightHistory(canvas)
  canvas.add world.player.fabricObject()
  world.drawTop(canvas)

  score = new fabric.Text "Score: #{points}",
    fill: "#7c8"
    top: 580
    left: 500
  score.setFontSize 12
  score.setFontFamily "Courier New"

  canvas.add score
  canvas.renderAll()

  lastStep = thisStep
, 10
