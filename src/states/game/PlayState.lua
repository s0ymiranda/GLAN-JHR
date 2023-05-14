PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.spawnCooldown = 0
    self.spawnTimer = 0
    self.textAnimations = {alpha = {value = 0, render = true}}
    Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 255}})
    Timer.after(2, function() Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 0}}) end)
    Timer.after(3.5, function() self.textAnimations.alpha.render = false end)

    -- self.camera = Camera {}

    -- self.entities = {}
    -- self.objects = {}

    -- Key combinations
    self.lctrlPressed = false
    self.rctrlPressed = false

    SOUNDS['dungeon-music']:setLooping(true)
    SOUNDS['dungeon-music']:play()
end

function PlayState:enter(def)

    local isANewDay = def.isANewDay or false

    self.dayNumber = def.dayNumber or 1

    self.camera = def.camera or Camera{}
    self.entities = def.entities or {}
    self.objects = def.objects or {}

    self.player = def.player or Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        x = 0 ,
        y = VIRTUAL_HEIGHT / 2 ,
        width = 24,
        height = 73,
        health = 100,
    }

    if def.player == nil or isANewDay then
        self.player.stateMachine = StateMachine {
            ['walk'] = function() return PlayerWalkState(self.player) end,
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['slap'] = function() return PlayerSlapState(self.player, self.entities) end,
            ['knee-hit'] = function() return PlayerKneeHitState(self.player, self.entities) end,
            ['dodge'] = function() return PlayerDodgeState(self.player, self.entities) end
        }
        self.player:changeState('idle')
        self.player.direction = 'right'
        self.player:changeAnimation('idle-right')
    end
    self.player.pervert = false

    if self.player.x > 0 then
        self.textAnimations.alpha.render = false
    end

    self.healthBar = ProgressBar {
        x = 0 + 10,
        y = 0 + 10,
        width = 64,
        height = 12,
        color = {r = 189, g = 32, b = 32},
        value = self.player.health,
        max = 100,
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

end

function PlayState:exit()
    SOUNDS['dungeon-music']:pause()
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
        stateMachine:change('pause',{
            player = self.player,
            camera = self.camera,
            entities = self.entities,
            objects = self.objects,
            dayNumber = self.dayNumber,
    })
    end
    if self.player.health <= 0 or self.player.respect <= 0 then
        for k,e in pairs(self.entities) do
            e:changeState('idle')
        end
        self.player.dead = true
        self.player:changeAnimation('falling')
        Timer.after(0.4,function()
            self.player.y = self.player.y + 15
            self.player:changeAnimation('defeated')
        end)
        stateMachine:change('game-over',{
            player = self.player,
            camera = self.camera,
            entities = self.entities,
            objects = self.objects,
            dayNumber = self.dayNumber,
        })
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

    if self.spawnCooldown == 0 and self.player.x < MAP_WIDTH then
        self.spawnCooldown = math.random(8-self.dayNumber)
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
        Timer.tween(0.5, {
            [self.camera] = {
                x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH))),
                y = self.camera.y
            }
        })
        Timer.after(0.5,function() self.player.fighting = false self.player.afterFigthing = false  self.player.leftLimit = 0 self.player.rightLimit = MAP_WIDTH end)
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
                self.player.respect = self.player.respect - 10
                self.player.perverts_passed = self.player.perverts_passed + 1
            end
        end

        if entity.health <= 0 then
            SOUNDS['dead']:play()
            self:deleteEntity(k)
            if entity.pervert then
                if self.player.respect < 100 then
                    self.player.respect = self.player.respect + 5
                    self.player.perverts_defeated = self.player.perverts_defeated + 1
                end
                if math.random() < HEARTH_DROP_PROBABILITY then
                    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['heart'], entity.x, entity.y + entity.height - 12))
                end
            else
                self.player.respect = self.player.respect - 5
            end
            goto continue
        end
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

    -- self.player:update(dt)

    if self.player.stateMachine.currentStateName ~= 'slap' and self.player.stateMachine.currentStateName ~= 'knee-hit' and not self.player.fighting and not self.player.afterFighting then
        self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
    end
    self.healthBar:setValue(self.player.health)
    self.healthBar:setPosition(self.camera.x+10, 10)
    self.healthBar:update()
    self.respectBar:setValue(self.player.respect)
    self.respectBar:setPosition(self.healthBar.x , self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:update()

    if self.player.x + self.player.width == MAP_WIDTH then
        self.player.x = 0
        self.player.y = VIRTUAL_HEIGHT/2
        if self.dayNumber == 5 then
            stateMachine:change('win')
        else
            -- self.player.afterFighting = false
            -- self.player.fighting = false
            stateMachine:change('play',{player = self.player,dayNumber = self.dayNumber + 1,isANewDay = true})
        end
    end

    if love.keyboard.wasPressed('r') then
        self.player.x = 0
        self.player.y = VIRTUAL_HEIGHT/2
        if self.dayNumber == 5 then
            stateMachine:change('win')
        else
            -- self.player.afterFighting = false
            -- self.player.fighting = false
            stateMachine:change('play',{player = self.player,dayNumber = self.dayNumber + 1,isANewDay = true})
        end
    end

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
            return a.y + a.height < b.y + b.height
        end)

        for _, entity in pairs(to_render) do
            entity:render()
        end

        self.healthBar:render()
        self.respectBar:render()
        if self.textAnimations.alpha.render then
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.textAnimations.alpha.value))
            love.graphics.setFont(FONTS['large'])
            love.graphics.printf(WEEK_DAYS[self.dayNumber], self.camera.x, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
        end
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

    local type = types[math.random(#types)]

    local x_distance = self.camera.x + VIRTUAL_WIDTH + 20

    local y_distance = math.floor(math.random(VIRTUAL_HEIGHT*0.55-70,VIRTUAL_HEIGHT-77))
    local height = 75

    local new_entity = Entity {
        animations = ENTITY_DEFS[type].animations,
        walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

        x = x_distance,
        y = y_distance,

        width = 24,
        height = height,

        health = 3,
        pervertFactor = self.player.respect/100,
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

