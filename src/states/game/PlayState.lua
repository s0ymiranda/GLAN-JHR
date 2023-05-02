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
        health = 100,
    }

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

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['slap'] = function() return PlayerSlapState(self.player, self.entities) end
    }
    self.player:changeState('idle')

    self.entities = {}

    -- Key combinations
    self.lctrlPressed = false
    self.rctrlPressed = false

    SOUNDS['dungeon-music']:setLooping(true)
    SOUNDS['dungeon-music']:play()
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
    if self.player.health <= 0 then
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

    self.player:update(dt)

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        if entity.dead then
            goto continue
        end
        if entity.health < 3 then
            entity.fighting = true
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

    if self.player.stateMachine.currentStateName ~= 'slap' then self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3))) end
    self.healthBar:setValue(self.player.health)
    self.healthBar:setPosition(self.camera.x+10, 10)
    self.healthBar:update()
    self.respectBar:setValue(self.player.respect)
    self.respectBar:setPosition(self.healthBar.x , self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:update()

end

function PlayState:render()

    self.camera:set()
        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)
        for i=0,VIRTUAL_HEIGHT*0.45/5,1 do
            if self.player.z == i then
                self.player:render()
            end
            for k, entity in pairs(self.entities) do
                if not entity.dead and entity.z == i then entity:render() end
            end
        end
        self.healthBar:render()
        self.respectBar:render()
    self.camera:unset()
end

function PlayState:generateEntity()
    local types = {'enemy','npc0-blackskin-blond','npc0-blackskin-blond-noglasses','npc0-blackskin-whiteclothes','npc0-blond','npc0-blond-chinese','npc0-blond-noglasses','npc0-blond-otherclothes'}
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
    })

    local i = #self.entities
    self.entities[i].stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self.entities[i]) end,
        ['idle'] = function() return EntityIdleState(self.entities[i]) end,
        ['punch'] = function() return EntityPunchState(self.entities[i],self.player) end
    }
    self.entities[i]:changeState('idle')
end
