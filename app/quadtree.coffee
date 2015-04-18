class QuadTree
  constructor: (@maxObjects, @boundingBox) ->
    @quadrants = []
    @objects = []

  has_quadrants: ->
    @quadrants.len > 0

  full: ->
    @objects.length < @maxObjects

  insert: (obj, topRight, bottomLeft) ->
    if not @has_quadrants() and not @full()
      @objects.push obj
      obj.quadtree = this
