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

message = null
fabric.Image.fromURL 'levels/dead.png', (img) ->
  img.scale .5
  img.set
    top: 220
    left: 30

  message = img


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
  canvas.add message

module.exports =
  light: light
  blinds: blinds
  goal: goal
  drawBottom: drawWorldBottom
  drawTop: drawWorldTop
  moveStuff: moveStuff
  player: player
  reset: ->
