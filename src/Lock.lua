Lock = Class {}

function Lock:init(params)
  self.progress = 0
  self.maxProgress = 0
  self.solved = false
  self.radius = params.radius
  self.originX = params.originX
  self.originY = params.originY
  self.image = love.graphics.newImage('img/lock2.png')

  self.difficulty = params.difficulty
  if params.difficulty == 'easy' then
    self.confidence = 92
  elseif params.difficulty == 'med' then
    self.confidence = 96
  else
    self.confidence = 99
  end
end

function Lock:update(dt, distance)
  if self.solved then
    return
  end

  if love.keyboard.isDown('e') then
    if self.progress < self.maxProgress then
      self.progress = self.progress + 100 * dt
    end
  else
    self.progress = 0
  end

  if self.progress >= self.confidence then
    self.solved = true
    Signal.emit('lock_picked')
    return
  end

  if self.progress >= self.maxProgress and self.progress < self.confidence then
    self.blocked = true
  else
    self.blocked = false
  end

  if (distance ~= nil) then
    self.maxProgress = clamp(100 - distance, 0, 100)
  end
end

function Lock:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(
    self.image,
    self.originX - self.image:getWidth() / 2,
    self.originY - self.image:getHeight() / 2 + 10
  )
end
