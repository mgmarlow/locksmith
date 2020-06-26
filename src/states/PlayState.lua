PlayState = Class {__includes = BaseState}

local function distance(x1, x2, y1, y2)
  return math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
end

function PlayState:enter(params)
  self.originX = love.graphics.getWidth() / 2
  self.originY = love.graphics.getHeight() / 2
  self.origCameraX, self.origCameraY = gCamera:position()
  self.numPicks = params.numPicks or 3

  self.lock =
    Lock {
    difficulty = params.difficulty,
    radius = 75,
    originX = self.originX,
    originY = self.originY
  }

  self.pick =
    params.pick or
    Lockpick {
      originX = self.originX,
      originY = self.originY
    }

  self.target =
    params.target or
    Target {
      originX = self.originX,
      originY = self.originY,
      r = self.lock.radius
    }

  self.progressBar = ProgressBar {}

  local handleLockPicked = function()
    gStateMachine:change(
      'victory',
      {prevDifficulty = params.difficulty, numPicks = self.numPicks}
    )
  end

  local handlePickBreak = function()
    self.numPicks = self.numPicks - 1
  end

  Signal.register('pick_break', handlePickBreak)
  Signal.register('lock_picked', handleLockPicked)
end

function PlayState:exit()
  Signal.clear('pick_break')
  Signal.clear('lock_picked')
  gCamera:lookAt(self.origCameraX, self.origCameraY)
end

function PlayState:update(dt)
  local distance =
    distance(self.pick.endX, self.target.x, self.pick.endY, self.target.y) -
    self.lock.radius

  self.lock:update(dt, distance)
  self.pick:update(dt, distance, self.lock)
  self.progressBar:update(dt, distance, self.lock, self.pick)

  if self.numPicks == 0 then
    gStateMachine:change('game_over')
  end

  if love.keyboard.wasPressed('escape') then
    gStateMachine:change(
      'pause',
      {target = self.target, pick = self.pick, numPicks = self.numPicks}
    )
  end
end

function PlayState:render()
  self.lock:render()
  self.pick:render()
  self.target:render()
  self.progressBar:render(self.lock)

  love.graphics.setColor(1, 1, 1, 1)

  -- Game State
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('picks remaining: ' .. self.numPicks, 25, 80, 500)

  -- Tutorial
  love.graphics.setFont(gFonts['small'])
  love.graphics.printf(
    'try to find the sweet spot to pick the lock',
    25,
    WINDOW_HEIGHT - 160,
    500
  )
  love.graphics.printf(
    'control the pick with your mouse',
    25,
    WINDOW_HEIGHT - 120,
    500
  )
  love.graphics.printf(
    'press e to apply the tension wrench',
    25,
    WINDOW_HEIGHT - 80,
    500
  )
end

function PlayState:reset()
end
