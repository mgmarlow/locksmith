Target = Class {}

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

function Target:init(params)
  local targetAngle = randomFloat(-0.5, math.pi + 0.5, 3)
  self.x = params.originX + params.r * math.cos(targetAngle)
  self.y = params.originY + -(params.r * math.sin(targetAngle))
end

function Target:render()
  -- debug only
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.setPointSize(10)
  love.graphics.points(self.x, self.y)
end
