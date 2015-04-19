list = [
  require("./levels/intro"),
  require("./levels/1"),
  require("./levels/three_block_shuffle"),
  require("./levels/win")
  require("./levels/lose")
]

module.exports =
  dead: list.length - 1
  intro: 2
  first: 2
  list: list
