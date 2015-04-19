_ = require "lodash"

Room = require "../room/Room"
Blind = require "../blind/Blind"
Rail = require "../rail/Rail"
Light = require "../light/Light"
Goal = require "../goal/Goal"
Player = require "../player/Player"


room = new Room(
  {x: -10, y: -10},
  {x: 610, y: 610}
)

#################
#  The WORLD
#################

blinds = [
  new Blind(
    {x: 200, y: 200},
    {x: 203, y: 300},
    constraint: {x: 0, y: 1}
  ),
  new Blind(
    {x: 100, y: 350},
    {x: 300, y: 500},
    constraint: {x: 1, y: 0}
  )
  new Blind(
    {x: 300, y: 100},
    {x: 400, y: 150},
    constraint: {x: 1, y: 0}
  )
]

blinds = blinds.concat room.walls

rails = [
  new Rail 'x', 350
  new Rail 'x', 500
  new Rail 'y', 200
  new Rail 'y', 203
  new Rail 'x', 100
  new Rail 'x', 150
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
  x: 40
  y: 490

#################
#  The GOAL
#################

goal = new Goal {x: 560, y: 10}



##########################
#  Updating and Drawing
##########################

moveStuff = (steps) ->
  light.move
    x: light.location.x + light.velocity.x * steps
    y: light.location.y + light.velocity.y * steps


  if light.location.y > 500
    light.velocity = {x: 0, y: -.05}
  if light.location.y < 100
    light.velocity = {x: 0, y: .05}

drawWorldBottom = (canvas) ->
  _.each rails, (b) -> canvas.add(b.fabricObject())

drawWorldTop = (canvas) ->
  canvas.add light.visibleFabricPoly(blinds)
  canvas.add goal.fabricObject()
  _.each blinds, (b) -> canvas.add(b.fabricObject())


module.exports =
  light: light
  blinds: blinds
  goal: goal
  drawBottom: drawWorldBottom
  drawTop: drawWorldTop
  moveStuff: moveStuff
  player: player
