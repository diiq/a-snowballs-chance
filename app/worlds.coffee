list = [
  require("./levels/intro"),
  require("./levels/1"),
  require("./levels/three_block_shuffle"),
  require("./levels/random_1"),
  require("./levels/win")
  require("./levels/lose")
]

module.exports =
  dead: list.length - 1
  intro: 0
  first: 1
  list: list
