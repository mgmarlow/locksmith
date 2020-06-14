ProgressBar = Class {}

local function clamp(n, low, high)
  return math.min(math.max(n, low), high)
end

function ProgressBar:init(params)
  self.x = love.graphics.getWidth() / 2 + 150
  self.y = love.graphics.getHeight() / 2 - 150
  self.fill = 0
  self.fillMax = 0
  self.visible = false
  self.origCameraX, self.origCameraY = gCamera:position()

  if params.difficulty == 'easy' then
    self.confidence = 90
  elseif params.difficulty == 'med' then
    self.confidence = 95
  else
    self.confidence = 98
  end
end

function ProgressBar:update(dt, distance)
  if love.keyboard.isDown('e') then
    if self.fill < self.fillMax then
      self.fill = self.fill + 100 * dt
    end

    if self.fill > 50 then
      gCamera:lookAt(
        self.origCameraX + math.random(-2, 2),
        self.origCameraY + math.random(-2, 2)
      )
    end

    self.visible = true
  else
    gCamera:lookAt(self.origCameraX, self.origCameraY)
    self.fill = 0
    self.visible = false
  end

  -- TODO: if hitting against max but below confidence, break after
  -- set amount of time based on difficulty & distance
  if self.visible and self.fill >= self.confidence then
    print('victory!')
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
