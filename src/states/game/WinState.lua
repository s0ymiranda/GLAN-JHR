WinState = Class{__includes = BaseState}

function WinState:init()
    SOUNDS['win-music']:play()
end

function WinState:exit()
    SOUNDS['win-music']:stop()
end

function WinState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function WinState:render()
    love.graphics.setFont(FONTS['medium'])
    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf('YOU WIN!', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(FONTS['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end
