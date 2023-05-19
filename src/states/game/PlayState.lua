PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.spawnCooldown = 0
    self.spawnTimer = 0
    self.textAnimations = {alpha = {value = 0, render = true}}
    Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 255}})
    Timer.after(2, function() Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 0}}) end)
    Timer.after(3.5, function() self.textAnimations.alpha.render = false end)

    -- self.camera = Camera {}

    -- Key combinations
    self.lctrlPressed = false
    self.rctrlPressed = false

    self.controllerButtoms = {a = false, x = false, start = false}
end

function PlayState:enter(def)
    local isANewDay = def.isANewDay or false

    if START_AT_FRIDAY then
        self.dayNumber = 5
    else
        self.dayNumber = def.dayNumber or 1
    end
    if isANewDay then
        SOUNDS['scenary-music']:stop(true)
        SOUNDS['scenary-music']:setLooping(true)
        SOUNDS['scenary-music']:play()
    end

    self.camera = def.camera or Camera{}
    self.entities = def.entities or {}
    self.objects = def.objects or {}
    self.signs = def.signs or {}
    self.boss = def.boss or nil

    -- Creating Player 1
    self.player = def.player or Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        x = 0,
        y = VIRTUAL_HEIGHT / 2 ,
        width = 24,
        height = 73,
        health = 100,
    }

    local playerParams
    if def and def.player then
        playerParams = {
            heldObject = def.player.stateMachine.current.heldObject,
        }
        if string.match(def.player.direction, 'left') then
            self.player.direction = 'left'
        else
            self.player.direction = 'right'
        end
    end

    self.projectiles = def.projectiles or {}

    self.players = {self.player}

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.objects) end,
        ['idle'] = function() return PlayerIdleState(self.player, self.projectiles) end,
        ['slap'] = function() return PlayerSlapState(self.player, self.entities,self.boss) end,
        ['knee-hit'] = function() return PlayerKneeHitState(self.player, self.entities,self.boss) end,
        ['pick-up'] = function() return PlayerPickUpState(self.player) end,
        ['dodge'] = function() return PlayerDodgeState(self.player, self.entities) end
    }

    self.player:changeState('idle', playerParams)
    self.player.pervert = false

    if self.player.x > 0 then
        self.textAnimations.alpha.render = false
    end
    -- Creating Player 2
    if def.twoPlayers then
        self.player2 = def.player2 or Player {
            animations = ENTITY_DEFS['player2'].animations,
            walkSpeed = ENTITY_DEFS['player2'].walkSpeed,
            x = 0,
            y = VIRTUAL_HEIGHT / 2 + 55,
            width = 24,
            height = 73,
            health = 100,
        }
        local player2Params
        if def.player2 then
            player2Params = {
                heldObject = def.player2.stateMachine.current.heldObject,
            }
            if string.match(def.player2.direction, 'left') then
                self.player2.direction = 'left'
            else
                self.player2.direction = 'right'
            end
        end
        self.player2.playerNum = 2
        self.player.numOfPlayersInGame = 2
        self.player2.numOfPlayersInGame = 2
        self.player2.stateMachine = StateMachine {
            ['walk'] = function() return PlayerWalkState(self.player2,self.objects) end,
            ['idle'] = function() return PlayerIdleState(self.player2, self.projectiles) end,
            ['slap'] = function() return PlayerSlapState(self.player2, self.entities,self.boss) end,
            ['knee-hit'] = function() return PlayerKneeHitState(self.player2, self.entities, self.boss) end,
            ['pick-up'] = function() return PlayerPickUpState(self.player2) end,
            ['dodge'] = function() return PlayerDodgeState(self.player2, self.entities) end
        }
        self.player2:changeState('idle', player2Params)
        self.player2.pervert = false
        self.healthBar2 = ProgressBar {
            x = VIRTUAL_WIDTH - 10 - 100,
            y = 0 + 10,
            width = 100,
            height = 12,
            color = {r = 189, g = 32, b = 32},
            value = self.player2.health,
            max = 100,
            showDetails = true,
            title = "Kurohime's Health"
        }
        if def.player2 then
            self.player2.stateMachine.current.heldObject = def.player2.stateMachine.current.heldObject
        end
        table.insert(self.players,self.player2)
    end

    self.healthBar = ProgressBar {
        x = 0 + 10,
        y = 0 + 10,
        width = 100,
        height = 12,
        color = {r = 189, g = 32, b = 32},
        value = self.player.health,
        max = 100,
        showDetails = true,
        title = "Akira's Health"
    }
    -- Respect Bar is shared between the 2 player, health its separated
    self.respectBar = ProgressBar {
        x = 0 + 10,
        y = 0 + self.healthBar.y + self.healthBar.height + 10,
        width = 100,
        height = 12,
        color = {r = 128, g = 128, b = 128},
        value = self.player.respect,
        max = 100,
        showDetails = true,
        title = 'Respect'
    }
    if self.dayNumber == 5 then
        if self.boss == nil then
            self:generateBoss()
        end
        self.bossHealthBar = ProgressBar {
            x = 0 + 10,
            y = 0 + self.healthBar.y + self.healthBar.height + 10,
            width = VIRTUAL_WIDTH - 20,
            height = 20,
            color = {r = 189, g = 32, b = 32},
            value = self.boss.health,
            max = 1000,
            showDetails = true,
            title = "Raiden Tameemon's Health"
        }
    end

    if self.boss ~= nil then
        if self.boss.fighting then
            SOUNDS['boss_music']:play()
        else
            SOUNDS['scenary-music']:play()
        end
    else
        SOUNDS['end_day_music']:stop()
        SOUNDS['boss_music']:stop()
        SOUNDS['scenary-music']:setLooping(true)
        SOUNDS['scenary-music']:play()
    end

    --GameObjects

    --bus and bus sign
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bus'], MAP_WIDTH - 300, 140))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bus-sign'], MAP_WIDTH - 350, 120))
    --bushes
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bush'], VIRTUAL_WIDTH-300, MAP_HEIGHT-66))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bush'], VIRTUAL_WIDTH*1.7, MAP_HEIGHT-66))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bush'], VIRTUAL_WIDTH*3, MAP_HEIGHT-66))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bush'], VIRTUAL_WIDTH*5+300, MAP_HEIGHT-66))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bush'], VIRTUAL_WIDTH*6.5, MAP_HEIGHT-66))
    --lights
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH-200, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*1.2, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*2, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*3.5, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*5, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*6, MAP_HEIGHT-138))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['light'], VIRTUAL_WIDTH*7, MAP_HEIGHT-138))

    --signs
    self.signTimer = 0
    self.signWaitTimer = 0
    if not def.signs then
        table.insert(self.signs, GameObject(GAME_OBJECT_DEFS['sushi'], VIRTUAL_WIDTH + 450, 20))
        table.insert(self.signs, GameObject(GAME_OBJECT_DEFS['sushi'], VIRTUAL_WIDTH*6 + 350, 20))
        table.insert(self.signs, GameObject(GAME_OBJECT_DEFS['neon'], VIRTUAL_WIDTH*3 +125, 40))
        table.insert(self.signs, GameObject(GAME_OBJECT_DEFS['cafe'], VIRTUAL_WIDTH*7 + 400, 40))
    end
    --barrels
    if isANewDay and not def.objects then
        for i = 1, NUMBER_OF_BARRELS, 1 do
            local barrel_x = math.random(10,VIRTUAL_WIDTH*6.5)
            local barrel_y_variation = math.random(0,45)
            table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['barrel'],barrel_x, VIRTUAL_HEIGHT*0.47 + barrel_y_variation))
        end
    end

    if SPAWN_AT_BUS_STATION then
        self.player.x = VIRTUAL_WIDTH * 6
        if self.player2 then
            self.player2.x = VIRTUAL_WIDTH * 6
        end
    end
end

function PlayState:exit()
    if self.boss ~= nil then
        if self.boss.fighting then
            SOUNDS['boss_music']:pause()
        else
            SOUNDS['scenary-music']:pause()
        end
    else
        SOUNDS['scenary-music']:pause()
    end
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
    -- if love.keyboard.wasPressed('escape') then
    --     love.event.quit()
    -- end
    if #joysticks > 0 then
        if joystick:isGamepadDown('start') then
            self.controllerButtoms.start = true
        elseif self.controllerButtoms.start then
            local twoPlayersMode = false
            if self.player2 ~= nil then
                twoPlayersMode = true
            end
            local musicTitle = 'scenary-music'
            if self.boss ~= nil then
                if self.boss.fighting then
                    musicTitle = 'boss_music'
                end
            end
            stateMachine:change('pause',{
                player = self.player,
                camera = self.camera,
                entities = self.entities,
                objects = self.objects,
                dayNumber = self.dayNumber,
                player2 = self.player2,
                twoPlayers = twoPlayersMode,
                boss = self.boss,
                music = musicTitle,
            })
        end
    end
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('escape') then
        local twoPlayersMode = false
        if self.player2 ~= nil then
            twoPlayersMode = true
        end
        local musicTitle = 'scenary-music'
        if self.boss ~= nil then
            if self.boss.fighting then
                musicTitle = 'boss_music'
            end
        end
        stateMachine:change('pause',{
            player = self.player,
            camera = self.camera,
            entities = self.entities,
            objects = self.objects,
            projectiles = self.projectiles,
            signs = self.signs,
            dayNumber = self.dayNumber,
            player2 = self.player2,
            twoPlayers = twoPlayersMode,
            boss = self.boss,
            music = musicTitle,
        })
    end
    if self.player.health <= 0 or self.player.respect <= 0 then
        for k,e in pairs(self.entities) do
            if not e.dead then
                local a,b = string.find(e.direction,'left')
                if a == nil or b == nil then
                    e.direction = 'right'
                else
                    e.direction = 'left'
                end
                e:changeState('idle')
            end
        end
        self.player.dead = true
        self.player.stateMachine.current.heldObject = nil
        self.player:changeAnimation('falling')
        if self.player2 ~= nil then
            self.player2.dead = true
            self.player2.stateMachine.current.heldObject = nil
            self.player2:changeAnimation('falling')
        end
        Timer.after(0.4,function()
            self.player.y = self.player.y + 15
            self.player:changeAnimation('defeated')
            if self.player2 ~= nil then
                self.player2.y = self.player2.y + 15
                self.player2:changeAnimation('defeated')
            end
        end)
        stateMachine:change('game-over',{
            player = self.player,
            camera = self.camera,
            entities = self.entities,
            objects = self.objects,
            dayNumber = self.dayNumber,
            player2 = self.player2,
            boss = self.boss,
        })
    elseif self.player2 ~= nil then
        if self.player2.health <= 0 then
            for k,e in pairs(self.entities) do
                if not e.dead then
                    local a,b = string.find(e.direction,'left')
                    if a == nil or b == nil then
                        e.direction = 'right'
                    else
                        e.direction = 'left'
                    end
                    e:changeState('idle')
                end
            end
            self.player.dead = true
            self.player:changeAnimation('falling')

            self.player2.dead = true
            self.player2:changeAnimation('falling')

            Timer.after(0.4,function()
                self.player.y = self.player.y + 15
                self.player:changeAnimation('defeated')

                self.player2.y = self.player2.y + 15
                self.player2:changeAnimation('defeated')

            end)
            stateMachine:change('game-over',{
                player = self.player,
                camera = self.camera,
                entities = self.entities,
                objects = self.objects,
                dayNumber = self.dayNumber,
                player2 = self.player2,
            })
        end
    end
    if ALLOW_CHEATS then
        -- Ctrl + E: generate entity
        if love.keyboard.wasPressed('e') and (self.lctrlPressed or self.rctrlPressed) then
            self:generateWalkingEntity()
        end

        -- Ctrl + H: generate first-aid-kit
        if love.keyboard.wasPressed('h') and (self.lctrlPressed or self.rctrlPressed) then
            local firstAidKitDefs = GAME_OBJECT_DEFS['first-aid-kit']
            table.insert(self.objects, GameObject(firstAidKitDefs, self.player.x + self.player.width + 10, self.player.y + self.player.height - firstAidKitDefs.height))
        end

        -- Ctrl + B: generate barrel
        if love.keyboard.wasPressed('b') and (self.lctrlPressed or self.rctrlPressed) then
            local barrelDefs = GAME_OBJECT_DEFS['barrel']
            table.insert(self.objects, GameObject(barrelDefs, self.player.x + self.player.width + 10, self.player.y + self.player.height - barrelDefs.height))
        end
        -- Press o to win
        if love.keyboard.wasPressed('o') then
            stateMachine:change('win',{players = self.players})
        end
        -- Press r to skip day
        if love.keyboard.wasPressed('r') then
            self.player.x = 0
            self.player.y = VIRTUAL_HEIGHT/2
            if self.dayNumber == 5 then
                stateMachine:change('win')
            else
                -- self.player.afterFighting = false
                -- self.player.fighting = false
                local twoPlayersMode = false
                if self.player2 ~= nil then
                    twoPlayersMode = true
                    self.player2.x = 0
                    self.player2.y = VIRTUAL_HEIGHT/2 + 55
                end
                stateMachine:change('play',{player = self.player,dayNumber = self.dayNumber + 1,isANewDay = true, player2 = self.player2, twoPlayers = twoPlayersMode})
            end
        end
    end
    -- Left Ctrl pressed and released
    if love.keyboard.wasPressed('lctrl') then
        self.lctrlPressed = true
    end
    if not love.keyboard.isDown('lctrl') then
        self.lctrlPressed = false
    end
    -- Right Ctrl pressed and released
    if love.keyboard.wasPressed('rctrl') then
        self.rctrlPressed = true
    end
    if not love.keyboard.isDown('rctrl') then
        self.rctrlPressed = false
    end

    if self.spawnCooldown == 0 and self.player.x < MAP_WIDTH then
        self.spawnCooldown = math.random(8-self.dayNumber)
    end

    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= self.spawnCooldown and not((self.camera.x + VIRTUAL_WIDTH) >= VIRTUAL_WIDTH*7.5) and not DISABLE_AUTOMATIC_ENTITY_SPAWN then
        self:generateWalkingEntity()
        self.spawnCooldown = 0
        self.spawnTimer = 0
    end

    self.signTimer = self.signTimer + dt

    if self.signWaitTimer == 0 then
        self.signTimer = 0
        if self.signs[1].state == 'on' then
            self.signWaitTimer = 0.2
        else
            ::again::
            self.signWaitTimer = math.random()*10
            if self.signWaitTimer > 3 then
                goto again
            end
        end
    end

    for k, signs in pairs(self.signs) do
        if self.signTimer >= self.signWaitTimer then
            self.signWaitTimer = 0
            if signs.state == 'off' then
                signs.state = 'on'
            else
                signs.state = 'off'
            end
        end
    end

    for k, obj in pairs(self.objects) do
        obj:update(dt)
        if obj.type == 'first-aid-kit' or obj.type == 'small-first-aid-kit' then
            local playerBottom = {
                x = self.player.x,
                y = self.player.y + self.player.height - 2,
                width = self.player.width
            }
            if self.player2 ~= nil then
                local player2Bottom = {
                    x = self.player2.x,
                    y = self.player2.y + self.player2.height - 2,
                    width = self.player2.width
                }
                if BottomCollision(player2Bottom, obj.getBottom(obj), obj.bottomCollisionDistance) then
                    obj.onConsume(self.player2)
                    self:deleteObject(k)
                end
            end
            if BottomCollision(playerBottom, obj.getBottom(obj), obj.bottomCollisionDistance) then
                obj.onConsume(self.player)
                self:deleteObject(k)
            end
        end
    end

    local enemies = {self.boss}
    for _, entity in pairs(self.entities) do
        table.insert(enemies, entity)
    end

    local stoppedProjectilesPositions = {}
    for k, projectile in pairs(self.projectiles) do
        projectile:update(dt)
        if projectile.xSpeed == 0 then
            table.insert(stoppedProjectilesPositions, 1, k)
            table.insert(self.objects, projectile)
            projectile.state = projectile.previousState
            SOUNDS['barrel_fall']:stop()
            SOUNDS['barrel_fall']:play()
        else
            for _, entity in pairs(enemies) do
                local entityFloor = entity.y + entity.height
                -- from 3 to 10
                if not entity.dead and (projectile.floor - 10 < entityFloor) and (entityFloor < projectile.floor + 10) and projectile:collides(entity) then
                    projectile:hit(entity)
                end
            end
        end
    end

    for _, v in pairs(stoppedProjectilesPositions) do
        table.remove(self.projectiles, v)
    end

    self.player:update(dt, {objects = self.objects})
    self.player.leftLimit = self.camera.x
    if self.player2 ~= nil then
        self.player2:update(dt, {objects = self.objects})
        self.player2.rightLimit = self.camera.x + VIRTUAL_WIDTH
        self.player2.leftLimit = self.camera.x
        self.player.rightLimit = self.camera.x + VIRTUAL_WIDTH
        -- self.healthBar2:setValue(self.player2.health)
        -- self.healthBar2:setPosition(math.floor(self.camera.x + VIRTUAL_WIDTH - 74), 10)
        -- self.healthBar2:update()
    end

    local enemyFighting = false
    for k, entity in pairs(self.entities) do
        if entity.pervert and self.player.fighting and not self.player.afterFighting and not entity.fighting then
            local distance = math.sqrt((entity.x - self.player.x)^2 + (entity.y - self.player.y)^2)
            local distance2 = 160
            if self.player2 ~= nil then
                distance2 = math.sqrt((entity.x - self.player2.x)^2 + (entity.y - self.player2.y)^2)
            end
            if (distance < 150 or distance2 < 150) and not entity.dead then
                entity.fighting = true
                entity:changeAnimation('idle-' .. tostring(entity.direction))
                entity:changeState('idle')
            end
        end
        if entity.fighting and not entity.dead then
            self.player.fighting = true
            if self.player2 ~= nil then
                self.player2.fighting = true
            end
            enemyFighting = true
        end
    end

    local bossFighting = false
    if self.boss ~= nil then
        if self.boss.fighting then
            bossFighting = true
        end
    end

    if not enemyFighting and self.player.fighting and not bossFighting then
        self.player.afterFigthing = true
        if self.player2 ~= nil then
            self.player2.afterFighting = true
            Timer.tween(0.5, {
                [self.camera] = {
                    x = math.floor(math.min(math.floor(math.max(self.camera.x,(self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2 + self.player2.x + self.player2.width/2 - VIRTUAL_WIDTH/2)/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH))),
                    y = self.camera.y
                }
            })
            Timer.after(0.5,function()
                self.player.fighting = false
                self.player.afterFigthing = false
                self.player.leftLimit = self.camera.x
                self.player.rightLimit = self.camera.x + VIRTUAL_WIDTH

                self.player2.fighting = false
                self.player2.afterFigthing = false
                self.player2.leftLimit = self.camera.x
                self.player2.rightLimit = self.camera.x + VIRTUAL_WIDTH
            end)
        else
            if self.camera.x + VIRTUAL_WIDTH/2 < self.player.x then
                Timer.tween(0.5, {
                    [self.camera] = {
                        x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH))),
                        y = self.camera.y
                    }
                })
            end
            Timer.after(0.5,function() self.player.fighting = false self.player.afterFigthing = false  self.player.leftLimit = self.camera.x self.player.rightLimit = MAP_WIDTH end)
        end
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
                -- self.player.innocent_beaten = self.player.innocent_beaten + 1
            end
        end
        if entity.health <= 0 and not entity.dead then
            entity:changeState('dead')
            if entity.pervert then
                if self.player.respect < 100 then
                    self.player.respect = self.player.respect + 5
                    -- self.player.perverts_defeated = self.player.perverts_defeated + 1
                end
            else
                self.player.respect = self.player.respect - 5
            end
            goto continue
        end
        if (entity.x < self.camera.x - 25 and not entity.dead) or (entity.x < self.camera.x - 75) then
            if entity.pervert and not entity.dead then
                self.player.respect = self.player.respect - 10
                self.player.perverts_passed = self.player.perverts_passed + 1
            end
            self:deleteEntity(k)
            goto continue
        end
        entity:processAI({PlayState = self}, dt)
        entity:update(dt)
        ::continue::
    end

    if INFINITE_RESPECT then
        self.player.respect = 100
    end

    -- logic for the Boss functionality
    if self.boss ~= nil then
        if self.boss.health <= 0 and not self.boss.dead then
            self.boss:changeState('dead')
        end
        if (self.boss.x < self.camera.x - 85) then
            self.boss.stateMachine.current.entity = nil
            self.boss = nil
            goto continue
        end
            self.boss:processAI({PlayState =self},dt)
            self.boss:update(dt)
            ::continue::
    end
    if (#self.players > 1 or (self.player.stateMachine.currentStateName ~= 'slap' and self.player.stateMachine.currentStateName ~= 'knee-hit' and self.player.stateMachine.currentStateName ~= 'dodge')) and not self.player.fighting and not self.player.afterFighting then
        -- OPCION ARRASTRAR AL PLAYER 2:
        -- self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
        -- if self.player2 ~= nil then
        --     if self.player2.x < self.camera.x then
        --         self.player2.x = self.camera.x
        --     end
        -- end
        --OPCIONA PREFERIDA, LA CAMARA SE MUEVE EN UN PUNTO MEDIO DE AMBOS JUGADORES
        if self.player2 ~= nil then
            self.camera.x = math.floor(math.min(math.floor(math.max(self.camera.x,math.floor((self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2 + self.player2.x + self.player2.width/2 - VIRTUAL_WIDTH/2)/2))),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
        else
            self.camera.x = math.floor(math.min(math.floor(math.max(self.camera.x,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
        end

    end
    self.healthBar:setValue(self.player.health)
    self.healthBar:setPosition(self.camera.x+10, 10)
    self.healthBar:update()
    self.respectBar:setValue(math.max(0,self.player.respect))
    self.respectBar:setPosition(self.healthBar.x , self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:update()

    if self.player2 ~= nil then
        self.healthBar2:setValue(self.player2.health)
        self.healthBar2:setPosition(math.floor(self.camera.x + VIRTUAL_WIDTH - 110), 10)
        self.healthBar2:update()
    end

    if self.boss ~= nil then
        if self.boss.fighting then
            self.bossHealthBar:setValue(self.boss.health)
            self.bossHealthBar:setPosition(math.floor(self.camera.x + 10), VIRTUAL_HEIGHT - 30)
            self.bossHealthBar:update()
        end
    end

    if (self.camera.x + VIRTUAL_WIDTH) >= MAP_WIDTH - 280 and not self.player.fighting then
        self.player.direction = 'right'
        self.player.stateMachine.current.heldObject = nil
        if self.player2 then
            self.player2.direction = 'right'
            self.player2.stateMachine.current.heldObject = nil
        end
        stateMachine:change('cinematic',{camera =self.camera, entities = self.entities, objects = self.objects, players = self.players,dayNumber = self.dayNumber})
    end

    if INFINITE_HP then
        self.player.health = 100
        if self.player2 then
            self.player2.health = 100
        end
    end
end

function PlayState:render()
    self.camera:set()

        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

        local to_render = {self.player}
        local corpses = {}
        if self.player2 ~= nil then
            table.insert(to_render, self.player2)
        end
        for _, entity in pairs(self.entities) do
            if entity.dead and not entity.stillFalling then
                table.insert(corpses, entity)
            else
                table.insert(to_render, entity)
            end
        end
        for _, object in pairs(self.objects) do
            table.insert(to_render, object)
        end
        for _, object in pairs(self.projectiles) do
            table.insert(to_render, object)
        end

        for _, sign in pairs(self.signs) do
            table.insert(to_render, sign)
        end
        if self.boss ~= nil then
            if self.boss.dead then
                table.insert(corpses, self.boss)
            else
                table.insert(to_render, self.boss)
            end
        end
        table.sort(to_render, function(a, b)
            local ay = a.floor
            local by = b.floor
            if not ay then ay = a.y + a.height end
            if not by then by = b.y + b.height end
            return ay < by
            -- return (a.floor or (a.y + a.height)) < (b.floor or (b.y + b.height))
        end)

        for _, corpse in pairs(corpses) do
            corpse:render()
        end

        for _, renderable in pairs(to_render) do
            renderable:render()
        end

        self.healthBar:render()
        self.respectBar:render()
        if self.player2 ~= nil then
            self.healthBar2:render()
        end
        if self.boss ~= nil then
            if self.boss.fighting then
                self.bossHealthBar:render()
            end
        end
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
    table.remove(self.entities, idx)
end

function PlayState:deleteObject(idx)
    self.objects[idx] = nil
    table.remove(self.objects, idx)
end

function PlayState:generateWalkingEntity()
    local types = {'npc1-0', 'npc1-1', 'npc1-2', 'npc1-3', 'npc1-4', 'npc1-5', 'npc1-6', 'npc1-7', 'enemy','npc0-blackskin-blond','npc0-blackskin-blond-noglasses','npc0-blackskin-whiteclothes','npc0-blond','npc0-blond-chinese','npc0-blond-noglasses','npc0-blond-otherclothes'}
    local type = types[math.random(#types)]

    local x_distance = self.camera.x + VIRTUAL_WIDTH + 20

    local y_distance = math.floor(math.random(VIRTUAL_HEIGHT*0.55-70,VIRTUAL_HEIGHT-77))

    local new_entity = Entity {
        animations = ENTITY_DEFS[type].animations,
        walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

        x = x_distance,
        y = y_distance,

        width = 24,
        height = 75,

        health = 30,
        pervertFactor = self.player.respect/100,
    }

    new_entity.stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(new_entity, self.objects) end,
        ['idle'] = function() return EntityIdleState(new_entity) end,
        ['punch'] = function() return EntityPunchState(new_entity,self.players) end,
        ['dead'] = function() return EntityDeadState(new_entity) end
    }
    new_entity.direction = 'left'
    new_entity:changeState('walk')
    new_entity.justWalking = true

    table.insert(self.entities, new_entity)
end
function PlayState:generateBoss()

    local y_distance = math.floor(math.random(VIRTUAL_HEIGHT*0.55-70,VIRTUAL_HEIGHT-77))

    local boss = Entity{
        animations = ENTITY_DEFS['boss'].animations,
        walkSpeed = ENTITY_DEFS['boss'].walkSpeed,

        x = VIRTUAL_WIDTH*6.5,
        y = y_distance,

        width = 37,
        height = 84,

        health = 1000,

    }

    boss.stateMachine = StateMachine {
        ['idle'] = function() return BossIdleState(boss) end,
        ['walk'] = function () return BossWalkState(boss) end,
        ['dead'] = function () return BossDeadState(boss) end,
        ['spank'] = function () return BossSpankState(boss,self.players) end,
        ['punch'] = function () return BossPunchState(boss,self.players) end
    }
    boss.direction = 'left'
    boss:changeState('idle')
    boss:changeAnimation('idle-left')
    boss.pervert = true
    self.boss = boss
end
