_ = require "lodash"

Room = require "../room/Room"
Blind = require "../blind/Blind"
Rail = require "../rail/Rail"
Light = require "../light/Light"
Goal = require "../goal/Goal"
Player = require "../player/Player"

light = null
blinds = null
goal = null
player = null
rails = null
exports = {}

reset = ->
  room = new Room(
    {x: -10, y: -10},
    {x: 610, y: 610}
  )

  #################
  #  The WORLD
  #################

  blinds = [
    new Blind(
      {x: 178, y: 429},
      {x: 263, y: 462},
      constraint:
        y:
          ease: 1
          min: 0
          max: 340
    ),
    new Blind(
      {x: 300, y: 97},
      {x: 590, y: 100},
      constraint:
        x:
          ease: 1
          min: 0
          max: 330
    )
    new Blind(
      {x: 378, y: 500},
      {x: 414, y: 544},
      constraint:
        x:
          ease: 1
          min: 0
          max: 500
    )
  ]

  blinds = blinds.concat room.walls

  rails = [
    new Rail 'y', 378
    new Rail 'y', 414
    new Rail 'x', 97
    new Rail 'x', 100
    new Rail 'x', 429
    new Rail 'x', 462
  ]

  #################
  #  The LIGHTS
  #################

  light = new Light({x: 50, y: 550})
  light.velocity = {x: .05, y: 0}

  #################
  #  The PLAYER
  #################

  player = new Player
    x: 400
    y: 10

  #################
  #  The GOAL
  #################

  goal = new Goal {x: 100, y: 480}

  exports.light = light
  exports.blinds = blinds
  exports.goal = goal
  exports.drawBottom = drawWorldBottom
  exports.drawTop = drawWorldTop
  exports.moveStuff = moveStuff
  exports.player = player
  exports.reset = reset

##########################
#  Updating and Drawing
##########################

moveStuff = (steps) ->
  light.move
    x: light.location.x + light.velocity.x * steps
    y: light.location.y + light.velocity.y * steps


  if light.location.x > 500
    light.velocity = {y: 0, x: -.05}
  if light.location.x < 160
    light.velocity = {y: 0, x: .05}

drawWorldBottom = (canvas) ->
  _.each rails, (b) -> canvas.add(b.fabricObject())

drawWorldTop = (canvas) ->
  canvas.add light.visibleFabricPoly(blinds)
  canvas.add goal.fabricObject()
  _.each blinds, (b) -> canvas.add(b.fabricObject())

reset()

module.exports = exports
