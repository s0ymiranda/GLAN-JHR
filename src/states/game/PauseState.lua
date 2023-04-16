PauseState = Class{__includes = BaseState}

function PauseState:init()

end

function PauseState:exit()

end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        stateMachine:change('play')
    end

end

function PauseState:render()

    -- love.graphics.draw(TEXTURES['bg-play'], 0, 0, 0,
    -- VIRTUAL_WIDTH / TEXTURES['bg-play']:getWidth(),
    -- VIRTUAL_HEIGHT / TEXTURES['bg-play']:getHeight())
end
