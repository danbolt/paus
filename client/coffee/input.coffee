module.exports = class KeyInput
  constructor: () ->
    # KeyDown/Up defines
    @KEYCODE_UP = 38
    @KEYCODE_LEFT = 37
    @KEYCODE_RIGHT = 39
    @KEYCODE_DOWN = 40
    @KEYCODE_W = 87
    @KEYCODE_A = 65
    @KEYCODE_S = 83
    @KEYCODE_D = 68
    @KEYCODE_B = 66
    @KEYCODE_SPACE = 32
    @ACTION = 69
    @ENTER = 13
    @KEYCODE_ESCAPE = 27
    @KEYCODE_I = 73
    @KEYCODE_M = 77

    @lfHeld = false
    @rtHeld = false
    @fwdHeld = false
    @dnHeld = false
    @spaceHeld = false
    @escHeld = false
    @iHeld = false
    @mHeld = false
    @bHeld = false

    @spaceIsReady = false

    # E key. Talk to people, interact etc
    @actionheld = false

    window.setTimeout(
      () =>
        document.onkeydown = @handleKeyDown
        document.onkeyup = @handleKeyUp
        document.onkeypress = @handleKeyPress
      1000
    )
  #allow for WASD and arrow control scheme
  handleKeyDown: (e) =>
    #cross browser issues exist
    e = window.event unless e
    switch e.keyCode
      when @KEYCODE_A, @KEYCODE_LEFT
        @lfHeld = true
        false
      when @KEYCODE_D, @KEYCODE_RIGHT
        @rtHeld = true
        false
      when @KEYCODE_W, @KEYCODE_UP
        @fwdHeld = true
        false
      when @KEYCODE_S, @KEYCODE_DOWN
        @dnHeld = true
        false
      when @KEYCODE_SPACE
        if @spaceIsReady
          @spaceIsReady = false
          @spaceHeld = true
        false
      when @KEYCODE_ESCAPE
        @escHeld = true
        false
      when @KEYCODE_I
        @iHeld = true
        false
      when @KEYCODE_M
        @mHeld = true
        false
      when @KEYCODE_B
        @bHeld = true
        false
      when @ACTION
        @actionHeld = true
      when @ENTER
        @enterHeld = true

  handleKeyUp: (e) =>
    e = window.event  unless e
    switch e.keyCode
      when @KEYCODE_A, @KEYCODE_LEFT
        @lfHeld = false
      when @KEYCODE_D, @KEYCODE_RIGHT
        @rtHeld = false
      when @KEYCODE_W, @KEYCODE_UP
        @fwdHeld = false
      when @KEYCODE_S, @KEYCODE_DOWN
        @dnHeld = false
      when @KEYCODE_SPACE
         @spaceHeld = false
         @spaceIsReady = true
      when@KEYCODE_ESCAPE
        @escHeld = false
      when @KEYCODE_I
        @iHeld = false
      when @KEYCODE_M
        @mHeld = false
      when @KEYCODE_B
        @bHeld = false
      when @ACTION
        @actionHeld = false
      when @ENTER
        @enterHeld = false

  reset: () =>
    @lfHeld = @rtHeld = @fwdHeld = @dnHeld = @enterHeld = @actionHeld = false
