GameOverState = Class { __includes = BaseState }

function GameOverState:enter(def)
    SOUNDS['game-over-music']:play()
    self.player = def.player
    self.camera = def.camera
    self.entities = def.entities
    self.objects = def.objects
    self.dayNumber = def.dayNumber
    self.player2 = def.player2
    self.boss = def.boss
    self.alpha = { a1 = 0, a2 = 0 }

    self.canRender = false
    self.canInput = false

    self.controllerButtoms = { a = false, x = false, start = false }

    self.opacity = 0
    self.r = 0
    self.g = 0
    self.b = 0
    self.time = 3

    Timer.tween(self.time, {
        [self] = { opacity = 255 }
    })
    Timer.after(4.5, function()
        if self.player2 ~= nil then
            self.player.x = VIRTUAL_WIDTH / 2 - self.player.width / 2 - 5 - 20
            self.player.y = VIRTUAL_HEIGHT / 2
            self.player2.x = VIRTUAL_WIDTH / 2 - self.player.width / 2 - 5 + 20
            self.player2.y = VIRTUAL_HEIGHT / 2
        else
            self.player.x = VIRTUAL_WIDTH / 2 - self.player.width / 2 - 5
            self.player.y = VIRTUAL_HEIGHT / 2
        end
        self.canRender = true
        Timer.tween(self.time, {
            [self.alpha] = { a1 = 255 }
        })
            :finish(function()
                Timer.tween(self.time, {
                    [self.alpha] = { a2 = 255 }
                })
                Timer.after(self.time, function() self.canInput = true end)
            end)
    end)
end

function GameOverState:exit()
    SOUNDS['game-over-music']:stop()
end

function GameOverState:update(dt)
    self.player:onlyAnimation(dt)
    if self.player2 ~= nil then
        self.player2:onlyAnimation(dt)
    end

    if self.canInput then
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            stateMachine:change('start')
        end
        --For Joystick
        if #joysticks > 0 then
            if joystick:isGamepadDown('a') then
                stateMachine:change('start')
            end
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    self.camera:set()
    love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

    local to_render = { self.player }
    if self.player2 ~= nil then
        table.insert(to_render, self.player2)
    end
    local corpses = {}
    for _, entity in pairs(self.entities) do
        if entity.dead then
            table.insert(corpses, entity)
        else
            table.insert(to_render, entity)
        end
    end
    for _, object in pairs(self.objects) do
        table.insert(to_render, object)
    end
    if self.boss ~= nil then
        if self.boss.dead then
            table.insert(corpses, self.boss)
        else
            table.insert(to_render, self.boss)
        end
    end
    table.sort(to_render, function(a, b)
        return a.y + a.height < b.y + b.height
    end)

    for _, corpse in pairs(corpses) do
        corpse:render()
    end

    for _, entity in pairs(to_render) do
        entity:render()
    end
    self.camera:unset()

    love.graphics.setColor(love.math.colorFromBytes(self.r, self.g, self.b, self.opacity))
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    if self.canRender then
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alpha.a1))
        self.player:render()
        if self.player2 ~= nil then
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alpha.a1))
            self.player2:render()
        end
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 0, self.alpha.a2))
        love.graphics.setFont(FONTS['large'])
        love.graphics.printf("DEFEATED", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(FONTS['medium'])
        love.graphics.printf("Press Enter to Go to the Menu", 0, self.player.y + self.player.height + 25, VIRTUAL_WIDTH,
            'center')
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    end
end
