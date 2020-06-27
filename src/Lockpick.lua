Lockpick = Class {}

local BREAK_VELOCITY = 2
local LINE_LENGTH = 150

function Lockpick:init(params)
  self.originX = params.originX
  self.originY = params.originY
  self.hp = 100
  self.broken = false
  self.image = love.graphics.newImage('img/pick.png')
  self.brokenImage = love.graphics.newImage('img/broken_pick.png')
  self.orientation = 0
  -- Set initial values
  self.endX, self.endY = self.originX, self.originY
end

function Lockpick:update(dt, distance, lock)
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
    if lock.blocked then
      self.hp = self.hp - ((distance / 150) * dt + BREAK_VELOCITY)
    end

    return
  end

  local normalizedX, normalizedY = self:getNormalizedVector()
  destX = self.originX + normalizedX * LINE_LENGTH
  destY = self.originY + normalizedY * LINE_LENGTH

  local angle = self:angle(destX, destY)
  if angle > -0.5 or angle < -2.5 then
    self.orientation = -angle
    self.endX = destX
    self.endY = destY
  end
end

function Lockpick:render()
  local scaleY = 1
  if self.orientation < -1.5 or self.orientation > 2.5 then
    scaleY = -1
  else
    scaleY = 1
  end

  local image = self.broken and self.brokenImage or self.image

  love.graphics.draw(
    image,
    self.originX,
    self.originY - self.image:getHeight() / 2 + 10,
    self.orientation,
    1.5,
    scaleY,
    0,
    self.image:getHeight() / 2
  )
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
