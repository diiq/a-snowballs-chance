
module.exports = (a, b) ->
  not (b.left() > a.right() or
       b.right() < a.left() or
       b.top() > a.bottom() or
       b.bottom() < a.top())
