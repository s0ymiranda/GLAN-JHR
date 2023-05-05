PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.spawnCooldown = 0
    self.spawnTimer = 0

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
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['slap'] = function() return PlayerSlapState(self.player, self.entities) end,
        ['knee-hit'] = function() return PlayerKneeHitState(self.player, self.entities) end
    }
    self.player:changeState('idle')
    self.player.pervert = false

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
    if self.player.health <= 0 or self.player.respect <= 0 then
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
        self:generateWalkingEntity()
    end

    if self.spawnCooldown == 0 and self.player.x < VIRTUAL_WIDTH*4 then
        self.spawnCooldown = math.random(7)
    end

    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= self.spawnCooldown then
        self:generateWalkingEntity()
        self.spawnCooldown = 0
        self.spawnTimer = 0
    end

    self.player:update(dt)

    -- for i = #self.entities, 1, -1 do
    --     local entity = self.entities[i]
    --     if entity.dead then
    --         -- print(#self.entities)
    --         -- table.remove(self.entities,i)
    --         -- print(#self.entities)
    --         -- i = i + 1
    --         goto continue
    --     end
    --     -- if entity.x < -25 then
    --     --     print(#self.entities)
    --     --     table.remove(self.entities,i)
    --     --     print(#self.entities)
    --     --     i = i + 1
    --     --     --goto continue
    --     --     break
    --     -- end
    --     if entity.health < 3 then
    --         entity.fighting = true
    --     end
    --     -- remove entity from the table if health is <= 0
    --     if entity.health <= 0 or entity.x < -25 then
    --         SOUNDS['dead']:play()
    --         entity.dead = true
    --         --table.remove(self.entities,i)
    --         goto continue
    --         -- AQUI ELIMINO LA ENTIDAD DE LA TABLA NO SE SI ESTEN DE ACUERDO BY GERARDO
    --         --table.remove(self.entities,i)
    --     end
    --     if not entity.dead then
    --         entity:processAI({room = self}, dt)
    --         entity:update(dt)
    --     end
    --     -- TODO: check if the entity throw a punch
    --     ::continue::
    -- end

    local enemyFighting = false
    for k, entity in pairs(self.entities) do
        if entity.pervert and self.player.fighting and not self.player.afterFighting and not entity.fighting and not entity.dead then
            local distance = math.sqrt((entity.x - self.player.x)^2 + (entity.y - self.player.y)^2)
            if distance < 150 then
                entity.fighting = true
                entity:changeAnimation('idle-' .. tostring(entity.direction))
                entity:changeState('idle')
            end
        end
        if entity.fighting then
            self.player.fighting = true
            enemyFighting = true
        end
    end

    if not enemyFighting and self.player.fighting then
        self.player.afterFigthing = true
        --self.player.fighting = false
        Timer.tween(0.5, {
            [self.camera] = {
                x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3))),
                y = self.camera.y
            }
        })
        Timer.after(0.5,function() self.player.fighting = false self.player.afterFigthing = false  self.player.leftLimit = 0 self.player.rightLimit = VIRTUAL_WIDTH*4 end)
    end

    for k, entity in pairs(self.entities) do

        if entity.dead then
            --if #self.entities > 3 then table.remove(self.entities,k) end
            -- if not enemyFighting and #self.entities > 3 then
            --     table.remove(self.entities,k)
            --     print(#self.entities)
            -- end
            goto continue
        end

        if entity.health < entity.prevHealth then
            entity.prevHealth = entity.health
            if entity.pervert then
                entity.fighting = true
                entity.justWalking = false
                self.player.fighting = true
                self.player.leftLimit = self.camera.x
                self.player.rightLimit = self.camera.x + VIRTUAL_WIDTH
            else
                -- entity.angry = true
                self.player.respect = self.player.respect - 10
            end
        end

        if entity.health <= 0 then
            SOUNDS['dead']:play()
            entity.dead = true
            entity.fighting = false
            if entity.pervert then
                self.player.respect = self.player.respect + 5
            else
                self.player.respect = self.player.respect - 5
            end
            -- self.player.afterFigthing = true
            -- Timer.tween(1, {
            --     [self.camera] = {
            --         x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3))),
            --         y = self.camera.y
            --     }
            -- })
            -- Timer.after(1.2,function() entity.fighting = false self.player.afterFigthing = false end)
        -- elseif (entity.x < -25 and self.player.x < VIRTUAL_WIDTH/2) or (entity.x < self.player.x - VIRTUAL_WIDTH/2 - 25 and self.player.x >= VIRTUAL_WIDTH/2 and self.player.x < VIRTUAL_WIDTH*3)  or
        --         (self.player.x >= VIRTUAL_WIDTH*3 and entity.x < VIRTUAL_WIDTH*3 - 25) then
        elseif entity.x < self.camera.x - 25 then
            if entity.pervert then
                self.player.respect = self.player.respect - 10
            end
            entity.dead = true
        end

        if not entity.dead then
            entity:processAI({room = self}, dt)
            entity:update(dt)
        end
        ::continue::
    end


    if self.player.stateMachine.currentStateName ~= 'slap' and self.player.stateMachine.currentStateName ~= 'knee-hit' and not self.player.fighting and not self.player.afterFighting then
        self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3)))
    end
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

function PlayState:generateWalkingEntity()
    local types = {'npc1','enemy','npc0-blackskin-blond','npc0-blackskin-blond-noglasses','npc0-blackskin-whiteclothes','npc0-blond','npc0-blond-chinese','npc0-blond-noglasses','npc0-blond-otherclothes'}
    --local types = {'npc1'}
    local type = types[math.random(#types)]

    local x_distance = self.camera.x + VIRTUAL_WIDTH + 20
    -- if self.player.x <= VIRTUAL_WIDTH/2 then
    --     x_distance = VIRTUAL_WIDTH + 24
    -- else
    --     x_distance = self.player.x + VIRTUAL_WIDTH/2 + 24
    -- end
    local y_distance = math.floor(math.random(VIRTUAL_HEIGHT*0.55-70,VIRTUAL_HEIGHT-77))
    --local min_x = math.max(0, self.player.x - x_distance)
    --local max_x = math.min(MAP_WIDTH, self.player.x + x_distance)
    local height = 75

    table.insert(self.entities, #self.entities+1,Entity {
        animations = ENTITY_DEFS[type].animations,
        walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

        -- ensure X and Y are within bounds of the map
        --x = math.random(min_x, max_x),
        --y = math.random(MAP_HEIGHT*0.4 - height*0.45, MAP_HEIGHT - height),
        x = x_distance,
        y = y_distance,

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
    self.entities[i]:changeState('walk')
    self.entities[i].justWalking = true
end

function PlayState:generateEntity()
    --local types = {'enemy','npc0-blackskin-blond','npc0-blackskin-blond-noglasses','npc0-blackskin-whiteclothes','npc0-blond','npc0-blond-chinese','npc0-blond-noglasses','npc0-blond-otherclothes'}
    local types = {'npc1'}
    local type = types[math.random(#types)]

    local x_distance = 20
    local min_x = math.max(0, self.player.x - x_distance)
    local max_x = math.min(MAP_WIDTH, self.player.x + x_distance)
    local height = 75
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

