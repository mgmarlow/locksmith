Lockpick = Class {}

local LINE_LENGTH = 150

function Lockpick:init(params)
  self.originX = params.originX
  self.originY = params.originY
  self.hp = 100
  self.broken = false
  -- Set initial values
  self.endX, self.endY = self.originX, self.originY
end

function Lockpick:update(dt)
  if self.broken then
    return
  end

  if self.hp <= 0 then
    Signal.emit('pick_break')
    self.broken = true

    local resetState = function()
      self.hp = 100
      self.broken = false
    end

    Timer.after(2, resetState)
  end

  if love.keyboard.isDown('e') then
    -- TODO: subtract HP if hitting against progress limit
    -- self.hp = self.hp - 5
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
  local alpha = self.broken and 0.2 or 1
  love.graphics.setColor(1, 1, 1, alpha)
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
