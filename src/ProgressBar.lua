ProgressBar = Class {}

local function clamp(n, low, high)
  return math.min(math.max(n, low), high)
end

function ProgressBar:init(params)
  self.x = love.graphics.getWidth() / 2 + 150
  self.y = love.graphics.getHeight() / 2 - 150
  self.visible = false
  self.origCameraX, self.origCameraY = gCamera:position()
end

function ProgressBar:update(dt, distance, lock)
  if love.keyboard.isDown('e') then
    self.visible = true
  else
    self.visible = false
  end

  if self.visible and lock.blocked then
    -- Max distance is 150
    local min = -4 * (distance / 150)
    local max = 4 * (distance / 150)
    -- If the pick is past fill max, indicate that the pick will break
    gCamera:lookAt(
      self.origCameraX + math.random(min, max),
      self.origCameraY + math.random(min, max)
    )
  else
    gCamera:lookAt(self.origCameraX, self.origCameraY)
  end
end

function ProgressBar:render(lock)
  if not self.visible then
    return
  end

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', self.x, self.y, lock.progress, 10)
end
