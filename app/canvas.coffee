fabric = require('fabric').fabric

canvas = new fabric.Canvas 'main-canvas',
  width:600
  height:600
  backgroundColor:"#333"

# In order to look sexy on HPD displays, we scale up to actual
# physical pixels, and then scale back down to CSS pixels.
ratio = window.devicePixelRatio
canvasElement = canvas.getElement()

canvasElement.setAttribute('width', canvasElement.width * ratio)
canvasElement.setAttribute('height', canvasElement.height * ratio)
canvasElement.getContext('2d').scale(ratio, ratio)

module.exports = canvas
