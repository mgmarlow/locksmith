GameOverState = Class {__includes = BaseState}

function GameOverState:enter()
end

function GameOverState:update(dt)
  if love.keyboard.wasPressed('e') then
    gStateMachine:change('play', {})
  end

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end
end

function GameOverState:render()
  -- title
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf(
    'game over',
    0,
    WINDOW_HEIGHT / 3,
    WINDOW_WIDTH,
    'center'
  )

  -- instructions
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf(
    'press e to try again',
    0,
    WINDOW_HEIGHT / 2 + 70,
    WINDOW_WIDTH,
    'center'
  )

  -- reset the color
  love.graphics.setColor(1, 1, 1, 1)
end
