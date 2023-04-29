PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.camera = Camera {}
    
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = 0 ,
        y = VIRTUAL_HEIGHT / 2 ,
        
        width = 24,
        height = 73,
        
        -- one_heart == 2 health
        health = 100,
        
        -- rendering and collision offset for spaced sprites
        offsetY = 0
    }
    
    -- local xHB_P, yHB_P
    -- xHB_P = self.player.x

    self.healthBar = ProgressBar {
        x = 0 + 10,
        y = 0 + 10,
        width = 64,
        height = 12,
        color = {r = 189, g = 32, b = 32},
        value = self.player.health,
        max = self.player.health,
        showDetails = true,
        title = 'Health'
    }
    self.respectBar = ProgressBar {
        x = 0 + 10,
        y = 0 + self.healthBar.y + self.healthBar.height + 10,
        width = 64,
        height = 12,
        color = {r = 128, g = 128, b = 128},
        value = self.player.respect,
        max = 100,
        showDetails = true,
        title = 'Respect'
    }
    -- self.dungeon = Dungeon(self.player)

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['slap'] = function() return PlayerSlapState(self.player, self.entities) end
        -- ['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        -- ['pot-lift'] = function() return PlayerPotLiftState(self.player, self.dungeon) end,
        -- ['pot-idle'] = function() return PlayerPotIdleState(self.player, self.dungeon) end,
        -- ['pot-walk'] = function() return PlayerPotWalkState(self.player, self.dungeon) end
    }
    self.player:changeState('idle')

    self.entities = {}

    -- Key combinations
    self.lctrlPressed = false
    self.rctrlPressed = false

    SOUNDS['dungeon-music']:setLooping(true)
    SOUNDS['dungeon-music']:play()

    --table.insert(self.entities,self.player)
end

function PlayState:exit()
    SOUNDS['dungeon-music']:stop()
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('p') then
        stateMachine:change('pause')
    end
    if love.keyboard.wasPressed('g') then
        stateMachine:change('game-over')
    end
    if love.keyboard.wasPressed('o') then
        stateMachine:change('win')
    end
    -- Left Ctrl pressed and released
    if love.keyboard.wasPressed('lctrl') then
        self.lctrlPressed = true
        print('lctrl pressed')
    end
    if not love.keyboard.isDown('lctrl') then
        self.lctrlPressed = false
    end
    -- Right Ctrl pressed and released
    if love.keyboard.wasPressed('rctrl') then
        self.rctrlPressed = true
        print 'rctrl pressed'
    end
    if not love.keyboard.isDown('rctrl') then
        self.rctrlPressed = false
    end
    -- Ctrl + E: generate entity
    if love.keyboard.wasPressed('e') and (self.lctrlPressed or self.rctrlPressed) then
        self:generateEntity()
    end

    -- self.dungeon:update(dt)
    -- self.player.currentAnimation:update(dt)
    self.player:update(dt)

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        if entity.dead then
            goto continue
        end
        -- remove entity from the table if health is <= 0
        if entity.health <= 0 then
            SOUNDS['dead']:play()
            entity.dead = true
            -- AQUI ELIMINO LA ENTIDAD DE LA TABLA NO SE SI ESTEN DE ACUERDO BY GERARDO
            --table.remove(self.entities,i)
        end
        entity:processAI({room = self}, dt)
        entity:update(dt)
        -- TODO: check if the entity throw a punch
        ::continue::
    end

    self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3)))
    self.healthBar:setValue(self.player.health)
    --self.healthBar:setPosition(math.floor(math.max(10,self.player.x - self.player.width/2 - VIRTUAL_WIDTH/2 + self.player.width + 10)), 10)
    self.healthBar:setPosition(self.camera.x+10, 10)
    self.healthBar:update()
    self.respectBar:setValue(self.player.respect)
    self.respectBar:setPosition(self.healthBar.x , self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:update()

    --print(self.entities)


end

-- function PlayState:orderByZ()
--     --local aux = self.entities
--     local i = 1, j = 1, aux = {}
--     while(i < #self.entities) do
        
--     end
-- end

function PlayState:render()
    -- -- render dungeon and all entities separate from hearts GUI
    -- love.graphics.push()
    -- self.dungeon:render()
    -- love.graphics.pop()

    -- -- draw player hearts, top of screen
    -- local healthLeft = self.player.health
    -- local heartFrame = 1

    -- for i = 1, 3 do
    --     if healthLeft > 1 then
    --         heartFrame = 5
    --     elseif healthLeft == 1 then
    --         heartFrame = 3
    --     else
    --         heartFrame = 1
    --     end

    --     love.graphics.draw(TEXTURES['hearts'], FRAMES['hearts'][heartFrame],
    --         (i - 1) * (TILE_SIZE + 1), 2)

    --     healthLeft = healthLeft - 2
    -- end

    -- love.graphics.draw(TEXTURES['bg-play'], 0, 0, 0,
    -- VIRTUAL_WIDTH / TEXTURES['bg-play']:getWidth(),
    -- VIRTUAL_HEIGHT / TEXTURES['bg-play']:getHeight())
    self.camera:set()
        --love.graphics.draw(TEXTURES['bg-play'],0,0,0)
        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)
        for i=0,VIRTUAL_HEIGHT*0.45/5,1 do
            if self.player.z == i then
                self.player:render()
            end
            for k, entity in pairs(self.entities) do
                if not entity.dead and entity.z == i then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
            end
        end
        -- for k, entity in pairs(self.entities) do
        --     if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
        -- end
        --self.player:render()
        self.healthBar:render()
        self.respectBar:render()
    self.camera:unset()
end

function PlayState:generateEntity()
    local types = {'enemy'}
    local type = types[math.random(#types)]

    local x_distance = 20
    local min_x = math.max(0, self.player.x - x_distance)
    local max_x = math.min(MAP_WIDTH, self.player.x + x_distance)
    local height = 73
    table.insert(self.entities, Entity {
        animations = ENTITY_DEFS[type].animations,
        walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

        -- ensure X and Y are within bounds of the map
        x = math.random(min_x, max_x),
        y = math.random(MAP_HEIGHT*0.4 - height*0.45, MAP_HEIGHT - height),

        width = 24,
        height = height,

        health = 3,
        offsetY = 0,
    })

    local i = #self.entities
    self.entities[i].stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self.entities[i]) end,
        ['idle'] = function() return EntityIdleState(self.entities[i]) end
    }
    self.entities[i]:changeState('idle')
end
