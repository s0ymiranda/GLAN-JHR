GameOverState = Class{__includes = BaseState}

function GameOverState:enter(def)
    SOUNDS['game-over-music']:play()
    if #joysticks > 0 then
        self.message = "Press A"
    else
        self.message = "Press Enter"
    end
    self.player = def.player
    self.camera = def.camera
    self.entities = def.entities
    self.objects = def.objects
    self.dayNumber = def.dayNumber
    self.player2 = def.player2

    self.controllerButtoms = {a = false, x = false, start = false}
end

function GameOverState:exit()
    SOUNDS['game-over-music']:stop()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('start')
    end


    self.player:onlyAnimation(dt)
    if self.player2 ~= nil then
        self.player2:onlyAnimation(dt)
    end

    --For Joystick
    if #joysticks > 0 then
        if joystick:isGamepadDown('a') then
            stateMachine:change('start')
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    -- love.graphics.setFont(FONTS['medium'])
    -- love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    -- love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setFont(FONTS['small'])
    -- love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    self.camera:set()

        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

        local to_render = {self.player}
        if self.player2 ~= nil then
            table.insert(to_render, self.player2)
        end
        for _, entity in pairs(self.entities) do
            table.insert(to_render, entity)
        end
        for _, object in pairs(self.objects) do
            table.insert(to_render, object)
        end

        table.sort(to_render, function(a, b)
            return a.y + a.height < b.y + b.height
        end)

        for _, entity in pairs(to_render) do
            entity:render()
        end

        -- self.healthBar:render()
        -- self.respectBar:render()

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
        love.graphics.setFont(FONTS['large'])
        love.graphics.printf("DEFEATED", self.camera.x, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    self.camera:unset()
end
