PauseState = Class{__includes = BaseState}

function PauseState:enter(def)

    self.player = def.player
    self.camera = def.camera
    self.entities = def.entities
    self.objects = def.objects

end

function PauseState:exit()

end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        stateMachine:change('play',{
            player = self.player,
            camera = self.camera,
            entities = self.entities,
            objects = self.objects,
    })
    end

end

function PauseState:render()

    -- love.graphics.draw(TEXTURES['bg-play'], 0, 0, 0,
    -- VIRTUAL_WIDTH / TEXTURES['bg-play']:getWidth(),
    -- VIRTUAL_HEIGHT / TEXTURES['bg-play']:getHeight())
    self.camera:set()

    love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

    local to_render = {self.player}
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
    love.graphics.printf("GAME PAUSED", self.camera.x, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
self.camera:unset()
end
