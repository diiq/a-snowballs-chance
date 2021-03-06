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
      {x: 100, y: 250},
      {x: 250, y: 350},
      constraint:
        x:
          ease: 1
          min: 0
          max: 350
    ),
  ]

  blinds = blinds.concat room.walls

  rails = [
    new Rail 'x', 250
    new Rail 'x', 350
    new Rail 'y', 500
  ]

  #################
  #  The LIGHTS
  #################

  light = new Light({x: 550, y: 300})
  light.velocity = {x: 0, y: .05}


  #################
  #  The PLAYER
  #################

  player = new Player
    x: 30
    y: 275

  #################
  #  The GOAL
  #################

  goal = new Goal {x: 400, y: 200}

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


  if light.location.y > 320
    light.velocity = {x: 0, y: -.05}
  if light.location.y < 280
    light.velocity = {x: 0, y: .05}

drawWorldBottom = (canvas) ->
  _.each rails, (b) -> canvas.add(b.fabricObject())

drawWorldTop = (canvas) ->
  canvas.add light.visibleFabricPoly(blinds)
  canvas.add goal.fabricObject()
  _.each blinds, (b) -> canvas.add(b.fabricObject())

reset()

module.exports = exports
