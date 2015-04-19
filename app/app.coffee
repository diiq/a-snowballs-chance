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

setWorld = (ind) ->
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
      setWorld(worlds.first)
    , 3000

  if world.goal.win(world.player)
    setWorld(worldInd + 1)
    points += world.player.health


  # HAHAHAHAHAHAAAAXXXXXX

  if worldInd == worlds.intro and input.isKeyDown "space"
    setWorld(worlds.first)

  # REDRAW!!

  canvas.clear()
  world.drawBottom(canvas)
  history.drawLightHistory(canvas)
  canvas.add world.player.fabricObject()
  world.drawTop(canvas)


  canvas.renderAll()

  lastStep = thisStep
, 10
