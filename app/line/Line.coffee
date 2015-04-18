module.exports = class Line
  constructor: (@pointA, @pointB) ->
    @x = @pointA.x
    @y = @pointA.y
    @dx = @pointB.x - @pointA.x
    @dy = @pointB.y - @pointA.y

  intersection: (ray) ->
    # http://ncase.me/sight-and-light/

    T2 = ((ray.dx * (@y - ray.y) +
           ray.dy * (ray.x - @x)) /
           (@dx * ray.dy -
            @dy * ray.dx))

    T1 = (@x + @dx * T2 - ray.x) / ray.dx

    if T1 < 0 or T2 < 0 or T2 > 1
      return false

    {
      x: @x + @dx * T2,
      y: @y + @dy * T2
    }
