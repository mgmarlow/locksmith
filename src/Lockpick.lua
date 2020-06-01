Lockpick = Class {}

local LINE_LENGTH = 150

function Lockpick:init(params)
  self.originX = params.originX
  self.originY = params.originY
  -- Set initial values
  self.endX, self.endY = self.originX, self.originY
end

function Lockpick:update(dt)
  if love.keyboard.isDown('e') then
    return
  end

  local normalizedX, normalizedY = self:getNormalizedVector()
  destX = self.originX + normalizedX * LINE_LENGTH
  destY = self.originY + normalizedY * LINE_LENGTH

  local angle = self:angle(destX, destY)
  if angle > -0.5 or angle < -2.5 then
    self.endX = destX
    self.endY = destY
  end
end

function Lockpick:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(self.originX, self.originY, self.endX, self.endY)
end

function Lockpick:angle(destX, destY)
  -- Negate to translate onto love2d coords
  return -math.atan2(destY - self.originY, destX - self.originX)
end

function Lockpick:getNormalizedVector()
  local mx, my = love.mouse.getPosition()

  -- vectors
  local dirX = mx - self.originX
  local dirY = my - self.originY

  local dirLength = math.sqrt(dirX * dirX + dirY * dirY)

  return dirX / dirLength, dirY / dirLength
end
