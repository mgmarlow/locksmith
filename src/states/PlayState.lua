PlayState = Class {__includes = BaseState}

local LINE_LENGTH = 150
local CIRCLE_RADIUS = 75

local function randomFloat(min, max, precision)
  local range = max - min
  local offset = range * math.random()
  local unrounded = min + offset

  if not precision then
    return unrounded
  end

  local powerOfTen = 10 ^ precision
  return math.floor(unrounded * powerOfTen + 0.5) / powerOfTen
end

function PlayState:enter(params)
  self.originX = love.graphics.getWidth() / 2
  self.originY = love.graphics.getHeight() / 2
  self.normalizedX = 0
  self.normalizedY = 0

  local targetAngle = randomFloat(0, math.pi, 3)
  self.targetX = self.originX + CIRCLE_RADIUS * math.cos(targetAngle)
  self.targetY = self.originY + -(CIRCLE_RADIUS * math.sin(targetAngle))
end

function PlayState:update(dt)
  self:updateNormalizedVector()

  if love.keyboard.wasPressed('escape') then
    gStateMachine:change('pause')
  end
end

function PlayState:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle('line', self.originX, self.originY, CIRCLE_RADIUS)

  love.graphics.line(
    self.originX,
    self.originY,
    self.originX + self.normalizedX * LINE_LENGTH,
    self.originY + self.normalizedY * LINE_LENGTH
  )

  -- debug only
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.setPointSize(10)
  love.graphics.points(self.targetX, self.targetY)
end

function PlayState:reset()
end

function PlayState:exit()
end

function PlayState:updateNormalizedVector()
  local mx, my = love.mouse.getPosition()

  -- vectors
  local dirX = mx - self.originX
  local dirY = my - self.originY

  local dirLength = math.sqrt(dirX * dirX + dirY * dirY)

  -- unit vectors
  self.normalizedX = dirX / dirLength
  self.normalizedY = dirY / dirLength
end
