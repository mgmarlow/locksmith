Lockpick = Class {}

local LINE_LENGTH = 150

function Lockpick:init(params)
  self.originX = params.originX
  self.originY = params.originY
  self.normalizedX, self.normalizedY = 0, 0
end

function Lockpick:update(dt)
  self.normalizedX, self.normalizedY = self:getNormalizedVector()
end

function Lockpick:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(
    self.originX,
    self.originY,
    self.originX + self.normalizedX * LINE_LENGTH,
    self.originY + self.normalizedY * LINE_LENGTH
  )
end

function Lockpick:getNormalizedVector()
  local mx, my = love.mouse.getPosition()

  -- vectors
  local dirX = mx - self.originX
  local dirY = my - self.originY

  local dirLength = math.sqrt(dirX * dirX + dirY * dirY)

  return dirX / dirLength, dirY / dirLength
end
