ProgressBar = Class {}

function ProgressBar:init()
  self.x = love.graphics.getWidth() / 2 + 150
  self.y = love.graphics.getHeight() / 2 - 150
end

function ProgressBar:update(dt, distance)
end

function ProgressBar:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('line', self.x, self.y, 100, 10)
end
