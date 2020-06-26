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

  self.difficulty = params.difficulty
  if params.difficulty == 'easy' then
    self.confidence = 92
  elseif params.difficulty == 'med' then
    self.confidence = 96
  else
    self.confidence = 99
  end
end

function ProgressBar:update(dt, distance)
  -- TODO: Move the actual progress state into a separate
  -- class to decouple it from UI logic.
  if love.keyboard.isDown('e') then
    if self.fill < self.fillMax then
      self.fill = self.fill + 100 * dt
    end

    self.visible = true
  else
    self.fill = 0
    self.visible = false
  end

  if self.visible and self.fill >= self.confidence then
    gStateMachine:change('victory', {prevDifficulty = self.difficulty})
  elseif
    self.visible and self.fill >= self.fillMax and
      self.fill < self.confidence
   then
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
