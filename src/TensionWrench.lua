TensionWrench = Class {}

function TensionWrench:init(params)
  self.originX = params.originX
  self.originY = params.originY
  self.angle = 1.57
  self.image = love.graphics.newImage('img/tension_wrench.png')
end

function TensionWrench:update(dt, pick)
  if love.keyboard.isDown('e') and not pick.broken then
    self.angle = 1.8
  else
    self.angle = 1.57
  end
end

function TensionWrench:render()
  love.graphics.draw(
    self.image,
    self.originX,
    self.originY - self.image:getHeight() / 2 + 30,
    self.angle,
    1,
    2,
    0,
    self.image:getHeight() / 2
  )
end
