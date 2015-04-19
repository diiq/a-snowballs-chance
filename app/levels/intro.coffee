_ = require "lodash"

Room = require "../room/Room"
Blind = require "../blind/Blind"
Rail = require "../rail/Rail"
Light = require "../light/Light"
Goal = require "../goal/Goal"
Player = require "../player/Player"
fabric = require("fabric").fabric

light = null
blinds = null
goal = null
player = null
rails = null
title = null
instructions = null
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
    # H
    new Blind(
      {x: 100/2, y: 350/2},
      {x: 190/2, y: 750/2},
      {}
    ),
    new Blind(
      {x: 188/2, y: 500/2},
      {x: 262/2, y: 575/2},
      {}
    ),
    new Blind(
      {x: 260/2, y: 350/2},
      {x: 350/2, y: 750/2},
      {}
    ),

    # E
    new Blind(
      {x: 380/2, y: 350/2},
      {x: 470/2, y: 750/2},
      {}
    ),

    new Blind(
      {x: 469/2, y: 350/2},
      {x: 580/2, y: 425/2},
      {}
    ),

    new Blind(
      {x: 469/2, y: 500/2},
      {x: 555/2, y: 575/2},
      {}
    ),

    new Blind(
      {x: 469/2, y: 675/2},
      {x: 580/2, y: 750/2},
      {}
    ),

    # L
    new Blind(
      {x: 610/2, y: 350/2},
      {x: 700/2, y: 750/2},
      {}
    ),
    new Blind(
      {x: 698/2, y: 675/2},
      {x: 840/2, y: 750/2},
      {}
    ),

    # L
    new Blind(
      {x: 870/2, y: 350/2},
      {x: 950/2, y: 750/2},
      {}
    ),
    new Blind(
      {x: 948/2, y: 675/2},
      {x: 1100/2, y: 750/2},
      {}
    ),
  ]

  blinds = blinds.concat room.walls

  rails = [
    new Rail 'x', 750/2
    new Rail 'x', 500
    new Rail 'y', 380/2
    new Rail 'y', 350/2
    new Rail 'x', 100
  ]


  fabric.Image.fromURL 'levels/title.png', (img) ->
    img.scale .5
    img.set
      top: 140
      left: 50

    title = img


  fabric.Image.fromURL 'levels/instructions.png', (img) ->
    img.scale .5
    img.set
      top: 420
      left: 120

    instructions = img

  #################
  #  The LIGHTS
  #################

  light = new Light({x: 300, y: 10})
  light.velocity = {x: .05, y: 0}


  #################
  #  The PLAYER
  #################

  player = new Player
    x: -1000
    y: -1000

  #################
  #  The GOAL
  #################

  goal = new Goal {x: 330, y: 455}

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


  if light.location.x > 580
    light.velocity = {x: -.05, y: 0}
  if light.location.x < 20
    light.velocity = {x: .05, y: 0}

drawWorldBottom = (canvas) ->
  _.each rails, (b) -> canvas.add(b.fabricObject())

drawWorldTop = (canvas) ->
  canvas.add light.visibleFabricPoly(blinds)
  canvas.add goal.fabricObject()
  _.each blinds, (b) -> canvas.add(b.fabricObject())
  canvas.add title
  canvas.add instructions


reset()

module.exports = exports
