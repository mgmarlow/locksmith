PlayState = Class {__includes = BaseState}

local CIRCLE_RADIUS = 75

local function distance(x1, x2, y1, y2)
  return math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
end

function PlayState:enter(params)
  self.originX = love.graphics.getWidth() / 2
  self.originY = love.graphics.getHeight() / 2
  self.numPicks = params.numPicks or 3

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
      r = CIRCLE_RADIUS
    }

  self.progressBar = ProgressBar {difficulty = params.difficulty}

  local handlePickBreak = function()
    print('breakage!')
  end

  Signal.register('pick_break', handlePickBreak)
end

function PlayState:exit()
  Signal.clear('pick_break')
end

function PlayState:update(dt)
  local distance =
    distance(self.pick.endX, self.target.x, self.pick.endY, self.target.y) -
    CIRCLE_RADIUS

  self.pick:update(dt)
  self.progressBar:update(dt, distance)

  if love.keyboard.wasPressed('escape') then
    gStateMachine:change('pause', {target = self.target})
  end
end

function PlayState:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle('line', self.originX, self.originY, CIRCLE_RADIUS)

  self.pick:render()
  self.target:render()
  self.progressBar:render()

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['small'])
  love.graphics.printf(
    'try to find the sweet spot to pick the lock',
    25,
    40,
    500
  )
  love.graphics.printf('control the pick with your mouse', 25, 80, 500)
  love.graphics.printf('press e to apply the tension wrench', 25, 120, 500)
end

function PlayState:reset()
end

function PlayState:exit()
end
