_ = require "lodash"
fabric = require("fabric").fabric

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

blinds = room.walls
text = new fabric.Text(
  'you melted and are dead.\nso sad.',
  left: 100,
  top: 100
)

#################
#  The LIGHTS
#################

light = new Light({x: 550, y: 300})

#################
#  The PLAYER
#################

player = new Player
  x: -200
  y: -200

#################
#  The GOAL
#################

goal = new Goal {x: -400, y: -400}



##########################
#  Updating and Drawing
##########################

moveStuff = (steps) ->

drawWorldBottom = (canvas) ->

drawWorldTop = (canvas) ->
  canvas.add text

module.exports =
  light: light
  blinds: blinds
  goal: goal
  drawBottom: drawWorldBottom
  drawTop: drawWorldTop
  moveStuff: moveStuff
  player: player
  reset: ->
