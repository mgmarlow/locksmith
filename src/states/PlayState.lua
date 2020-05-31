PlayState = Class {__includes = BaseState}

local CIRCLE_RADIUS = 75

local function distance(x1, x2, y1, y2)
  return math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
end

function PlayState:enter(params)
  self.originX = love.graphics.getWidth() / 2
  self.originY = love.graphics.getHeight() / 2

  self.pick =
    Lockpick {
    originX = self.originX,
    originY = self.originY
  }

  self.target =
    Target {
    originX = self.originX,
    originY = self.originY,
    r = CIRCLE_RADIUS
  }
end

function PlayState:update(dt)
  self.pick:update(dt, self.target)

  local distance =
    distance(self.pick.endX, self.target.x, self.pick.endY, self.target.y) -
    CIRCLE_RADIUS
  print(distance)

  if love.keyboard.wasPressed('escape') then
    gStateMachine:change('pause')
  end
end

function PlayState:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle('line', self.originX, self.originY, CIRCLE_RADIUS)

  self.pick:render()
  self.target:render()
end

function PlayState:reset()
end

function PlayState:exit()
end
