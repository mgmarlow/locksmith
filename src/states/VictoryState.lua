VictoryState = Class {__includes = BaseState}

function VictoryState:enter(params)
  self.numPicks = params.numPicks

  if params.prevDifficulty == 'easy' then
    self.nextDifficulty = 'med'
  elseif params.prevDifficulty == 'med' then
    self.nextDifficulty = 'hard'
  else
    self.nextDifficulty = 'hard'
  end
end

function VictoryState:update(dt)
  if love.keyboard.wasPressed('e') then
    gStateMachine:change(
      'play',
      {difficulty = self.nextDifficulty, numPicks = self.numPicks}
    )
  end

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end
end

function VictoryState:render()
  -- title
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf(
    'success!',
    0,
    WINDOW_HEIGHT / 3,
    WINDOW_WIDTH,
    'center'
  )

  -- instructions
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf(
    'press e to go to next level',
    0,
    WINDOW_HEIGHT / 2 + 70,
    WINDOW_WIDTH,
    'center'
  )

  -- reset the color
  love.graphics.setColor(1, 1, 1, 1)
end
