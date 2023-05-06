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
    self.objects = {}

    -- Key combinations
    self.lctrlPressed = false
    self.rctrlPressed = false

    SOUNDS['dungeon-music']:setLooping(true)
    SOUNDS['dungeon-music']:play()
end

function PlayState:exit()
    SOUNDS['dungeon-music']:stop()
end

function PlayState:bottom_collision(a, b, y_diff)
    if math.abs(a.y - b.y) > y_diff then
        return false
    end
    if a.x + a.width < b.x then -- aaaaa...... b
        return false
    end
    if b.x + b.width < a.x then -- bbbbb...... a
        return false
    end
    return true
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

    -- Ctrl + H: generate heart
    if love.keyboard.wasPressed('h') and (self.lctrlPressed or self.rctrlPressed) then
        local heartDefs = GAME_OBJECT_DEFS['heart']
        table.insert(self.objects, GameObject(heartDefs, self.player.x + self.player.width + 10, self.player.y + self.player.height - heartDefs.height))
    end

    -- Ctrl + B: generate barrel
    if love.keyboard.wasPressed('b') and (self.lctrlPressed or self.rctrlPressed) then
        local barrelDefs = GAME_OBJECT_DEFS['barrel']
        table.insert(self.objects, GameObject(barrelDefs, self.player.x + self.player.width + 10, self.player.y + self.player.height - barrelDefs.height))
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

    for k, object in pairs(self.objects) do
        object:update(dt)
        if object.type == 'heart' then
            local player_bottom = {
                x = self.player.x,
                y = self.player.y + self.player.height,
                width = self.player.width
            }
            local heart_bottom = {
                x = object.x,
                y = object.y + 3*object.height/4,
                width = object.width
            }
            if self:bottom_collision(player_bottom, heart_bottom, object.height/2) then
                self.player.health = math.min(self.player.health + 10, 100)
                self:deleteObject(k)
            end
        end
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

    if self.deletion then
        print("Entities:")
        for k, entity in pairs(self.entities) do
            print("", k, entity)
        end
    end

    local enemyFighting = false
    for k, entity in pairs(self.entities) do
        if entity.pervert and self.player.fighting and not self.player.afterFighting and not entity.fighting then
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
            -- self:deleteFromTable(self.entities, k)
            self:deleteEntity(k)
            if entity.pervert then
                if self.player.respect < 100 then
                    self.player.respect = self.player.respect + 5
                end
                if math.random() < HEARTH_DROP_PROBABILITY then
                    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['heart'], entity.x, entity.y + entity.height - 12))
                end
            else
                self.player.respect = self.player.respect - 5
            end
            goto continue
            -- self.player.afterFigthing = true
            -- Timer.tween(1, {
            --     [self.camera] = {
            --         x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3))),
            --         y = self.camera.y
            --     }
            -- })
            -- Timer.after(1.2,function() entity.fighting = false self.player.afterFigthing = false end)
        end
        -- elseif (entity.x < -25 and self.player.x < VIRTUAL_WIDTH/2) or (entity.x < self.player.x - VIRTUAL_WIDTH/2 - 25 and self.player.x >= VIRTUAL_WIDTH/2 and self.player.x < VIRTUAL_WIDTH*3)  or
        --         (self.player.x >= VIRTUAL_WIDTH*3 and entity.x < VIRTUAL_WIDTH*3 - 25) then
        if entity.x < self.camera.x - 25 then
            if entity.pervert then
                self.player.respect = self.player.respect - 10
            end
            self:deleteEntity(k)
            goto continue
        end
        entity:processAI({room = self}, dt)
        entity:update(dt)
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

        local to_render = {self.player}
        for _, entity in pairs(self.entities) do
            table.insert(to_render, entity)
        end
        for _, object in pairs(self.objects) do
            table.insert(to_render, object)
        end

        table.sort(to_render, function(a, b)
            -- if a.z == b.z then
            --     return a.y < b.y
            -- end
            -- return a.z < b.z
            return a.y + a.height < b.y + b.height
        end)

        for _, entity in pairs(to_render) do
            entity:render()
        end

        -- Way too slow tho
        -- for i=0,VIRTUAL_HEIGHT*0.45/5,1 do
        --     if self.player.z == i then
        --         self.player:render()
        --     end
        --     for k, entity in pairs(self.entities) do
        --         if entity.z == i then entity:render() end
        --     end
        -- end

        self.healthBar:render()
        self.respectBar:render()
    self.camera:unset()
end

function PlayState:deleteEntity(idx)
    self.entities[idx].stateMachine.current.entity = nil
    self.entities[idx] = nil
end

function PlayState:deleteObject(idx)
    self.objects[idx] = nil
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

    local new_entity = Entity {
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
    }

    new_entity.stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(new_entity) end,
        ['idle'] = function() return EntityIdleState(new_entity) end,
        ['punch'] = function() return EntityPunchState(new_entity,self.player) end
    }
    new_entity:changeState('walk')
    new_entity.justWalking = true

    table.insert(self.entities, new_entity)
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

