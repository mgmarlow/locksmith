PlayState = Class {__includes = BaseState}

local LINE_LENGTH = 150

function PlayState:enter(params)
  self.originX = love.graphics.getWidth() / 2
  self.originY = love.graphics.getHeight() / 2
  self.normalizedX = 0
  self.normalizedY = 0
end

function PlayState:update(dt)
  self:updateNormalizedVectors()

  if love.keyboard.wasPressed('escape') then
    gStateMachine:change('pause')
  end
end

function PlayState:render()
  love.graphics.line(
    self.originX,
    self.originY,
    self.originX + self.normalizedX * LINE_LENGTH,
    self.originY + self.normalizedY * LINE_LENGTH
  )
end

function PlayState:reset()
end

function PlayState:exit()
end

function PlayState:updateNormalizedVectors()
  local mx, my = love.mouse.getPosition()

  -- vectors
  local dirX = mx - self.originX
  local dirY = my - self.originY

  local dirLength = math.sqrt(dirX * dirX + dirY * dirY)

  -- unit vectors
  self.normalizedX = dirX / dirLength
  self.normalizedY = dirY / dirLength
end
