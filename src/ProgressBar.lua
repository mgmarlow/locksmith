ProgressBar = Class {}

local function clamp(n, low, high)
  return math.min(math.max(n, low), high)
end

function ProgressBar:init()
  self.x = love.graphics.getWidth() / 2 + 150
  self.y = love.graphics.getHeight() / 2 - 150
  self.fill = 0
  self.fillMax = 0
  self.visible = false
end

function ProgressBar:update(dt, distance)
  if love.keyboard.isDown('e') then
    if self.fill < self.fillMax then
      print(self.fill)
      self.fill = self.fill + 100 * dt
    end

    self.visible = true
  else
    self.fill = 0
    self.visible = false
  end

  if (distance ~= nil) then
    self.fillMax = clamp(100 - distance, 0, 100)
  end
end

function ProgressBar:render()
  if not self.visible then
    return
  end

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', self.x, self.y, self.fill, 10)
end
