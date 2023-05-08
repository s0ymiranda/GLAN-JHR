StartState = Class{__includes = BaseState}

function StartState:init()
    SOUNDS['start-music']:setLooping(true)
    SOUNDS['start-music']:play()
    if #joysticks > 0 then
        self.message = "Press Start"
    else
        self.message = "Press Enter"
    end
end

function StartState:exit()
    SOUNDS['start-music']:stop()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('play')
    end
    --For Joystick
    if #joysticks > 0 then
        if joystick:isGamepadDown('start') then
            stateMachine:change('play')
        end
    end
end

function StartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    love.graphics.setFont(FONTS['medium'])

    love.graphics.setColor(love.math.colorFromBytes(34, 34, 34, 255))
    love.graphics.printf(GAME_TITLE, 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf(GAME_TITLE, 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    love.graphics.setFont(FONTS['small'])
    love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end