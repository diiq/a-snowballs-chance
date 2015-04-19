
intersecting = (a, b) ->
  if not a.isCircle and not b.isCircle
    return not (
      b.left() > a.right() or
      b.right() < a.left() or
      b.top() > a.bottom() or
      b.bottom() < a.top()
    )

  if a.isCircle and b.isCircle
    return true
     # true if centers are withing widths of each other

  if b.isCircle
    center = b.center()
    x = Math.max(Math.min(center.x, a.right()), a.left())
    y = Math.max(Math.min(center.y, a.bottom()), a.top())
    if Math.sqrt(
      Math.pow(x - center.x, 2) +
      Math.pow(y - center.y, 2)) < b.radius()
      return true

  if a.isCircle
    return intersecting(b, a)

module.exports = intersecting
