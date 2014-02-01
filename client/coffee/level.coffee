module.exports = class Level
  constructor: (@stage) ->
    @init()
    @mapData
    @tileset

  initLayers: () =>
    @level = new createjs.Container()
    w = @mapData.tilesets[0].tilewidth
    h = @mapData.tilesets[0].tileheight
    imageData =
      images: [@tileset]
      frames:
        width: w
        height: h

    # create spritesheet
    tilesetSheet = new createjs.SpriteSheet(imageData)

    # loading each layer at a time
    idx = 0

    while idx < @mapData.layers.length
      layerData = @mapData.layers[idx]
      @initLayer layerData, tilesetSheet, @mapData.tilewidth, @mapData.tileheight if layerData.type is "tilelayer"
      idx++

  initLayer: (layerData, tilesetSheet, tilewidth, tileheight) =>
    y = 0
    console.log layerData
    while y < layerData.height
      x = 0

      while x < layerData.width

        # create a new Sprite for each cell
        cellSprite = new createjs.Sprite(tilesetSheet)

        idx = x + y * layerData.width

        if layerData.data[idx] isnt 0
          cellSprite.gotoAndStop layerData.data[idx] - 1

          cellSprite.x = x * tilewidth
          cellSprite.y = y * tileheight
          cellSprite.num = layerData.name

          cellSprite.hit = layerData.properties.hit
          cellSprite.type = 'tile'

          @stage.addChild cellSprite
        x++
      y++

  init: (sprite) =>
    $.ajax
      url: "images/Level1.json"
      async: false
      dataType: "json"
      success: (response) =>
        @mapData = response
        @tileset = new Image()
        @tileset.src = @mapData.tilesets[0].image
        @tileset.onLoad = @initLayers()


  @collide: (them, tile) ->
    return {} unless tile.hit is "true"
    top = tile.y
    left = tile.x
    right = tile.x + tile.spriteSheet._frameWidth
    bottom = tile.y + tile.spriteSheet._frameHeight

    collision =
      whore: false
      green: false

    if them.right > left and (top < them.top < bottom or top < them.bottom < bottom) and not (them.left > right)
      collision.whore = true
    if them.top < bottom and (left < them.left < right or left < them.right < right) and not (them.bottom < top)
      collision.green = true

    collision
