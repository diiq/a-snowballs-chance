keyMap =
  enter: 13
  left: 37
  right: 39
  up: 38
  down: 40
  space: 32

keysPressed = []

window.addEventListener "keydown", (e) ->
  e = e or event
  keysPressed[e.keyCode] = true

window.addEventListener "keyup", (e) ->
  e = e or event
  keysPressed[e.keyCode] = false

isKeyDown = (name) ->
  code = keyMap[name]
  return keysPressed[code]

module.exports =
  isKeyDown: isKeyDown
