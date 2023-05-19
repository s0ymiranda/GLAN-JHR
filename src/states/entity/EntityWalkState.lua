EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, objects)
    self.entity = entity
    self.objects = objects

    self.objetive = nil
    self.objectiveAlreadyChosen = false

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
    self.prevDirection = entity.direction
end

function EntityWalkState:exit()
    -- self.entity.direction = self.prevDirection
end

function EntityWalkState:update(dt)
    -- assume we didn't hit a wall
    self.bumped = false
    local entity = self.entity

    for _, obj in pairs(self.objects) do
        local entityBottom = {
            x = entity.x,
            y = entity.y + entity.height - 2,
            width = entity.width,
        }
        local objBottom = obj.getBottom(obj)
        if obj.solid and BottomCollision(entityBottom, objBottom, obj.bottomCollisionDistance) then
            -- if entity.direction == 'right' and entityBottom.x + entityBottom.width < objBottom.x then
            --     return
            -- end
            -- if entity.direction == 'left' and entityBottom.x > objBottom.x + objBottom.width then
            --     return
            -- end
            if string.match(entity.direction, 'up') and entityBottom.y > objBottom.y then
                return
            end
            if string.match(entity.direction, 'down') and entityBottom.y < objBottom.y then
                return
            end
        end
    end

    if entity.direction == 'left' then
        entity.x = entity.x - entity.walkSpeed * dt
        if entity.x <= entity.leftLimit and not entity.justWalking then

            entity.x = entity.leftLimit
            if not entity.justWalking then
                self.bumped = true
            end
        end
    elseif entity.direction == 'right' then
        entity.x = entity.x + entity.walkSpeed * dt

        if entity.x + entity.width >= entity.rightLimit then
            entity.x = entity.rightLimit - entity.width
            if not entity.justWalking then
                self.bumped = true
            end
        end
    elseif entity.direction == 'up-left' or entity.direction == 'up-right' then
        entity.y = entity.y - entity.walkSpeed * dt

        if entity.y <= VIRTUAL_HEIGHT*0.45 - entity.height * 0.45 then
            entity.y = VIRTUAL_HEIGHT*0.45  - entity.height * 0.45

            if not entity.justWalking then
                self.bumped = true
            end
        end
    elseif entity.direction == 'down-left' or entity.direction == 'down-right' then
        entity.y = entity.y + entity.walkSpeed * dt

        local bottomEdge = VIRTUAL_HEIGHT

        if entity.y + entity.height >= bottomEdge then
            entity.y = bottomEdge - entity.height
            if not entity.justWalking then
                self.bumped = true
            end
        end
    end
    if entity.displayDialog then
        entity.dialog:update(entity.x + entity.width/2, entity.y - 1)
    end
end

function EntityWalkState:processAI(params, dt)
    -- TODO: add punches
    local playState = params.PlayState
    local entity = self.entity

    if entity.dialogElapsedTime == nil then
        local distance = math.sqrt((entity.x - playState.player.x)^2 + (entity.y - playState.player.y)^2)
        local distance2 = distance
        if playState.player2 ~= nil then
            distance2 = math.sqrt((entity.x - playState.player2.x)^2 + (entity.y - playState.player2.y)^2)
        end
        if (distance < 150 or distance2 < 150) then
            local message
            if entity.pervert then
                message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
                entity.dialog = Dialog(entity.x + entity.width/2, entity.y - 1, message)
                entity.displayDialog = true
                entity.dialogElapsedTime = 0
            else
                local hp = playState.player.health
                if playState.player2 then
                    hp = math.min(hp, playState.player2.health)
                end
                local hpBasedProbability = 0.9 - (hp / 100)
                local respect = playState.player.respect
                local respectBasedProbability = (respect / 100) - 0.5
                local baseCondition = hp < 50 and respect > 50
                if baseCondition and math.random() < (hpBasedProbability + respectBasedProbability) / 2 then
                    message = HELP_MESSAGES[math.random(#HELP_MESSAGES)]
                    local healType
                    if math.random() < SMALL_FIRST_AID_KIT_DROP_PROBABILITY then
                        healType = 'small-first-aid-kit'
                    else
                        healType = 'first-aid-kit'
                    end
                    local healDefs = GAME_OBJECT_DEFS[healType]
                    table.insert(self.objects, GameObject(healDefs, entity.x, entity.y + entity.height - healDefs.height))
                    entity.dialog = Dialog(entity.x + entity.width/2, entity.y - 1, message)
                    entity.displayDialog = true
                    entity.dialogElapsedTime = 0
                else
                    message = REGULAR_MESSAGES[math.random(#REGULAR_MESSAGES)]
                    entity.dialog = Dialog(entity.x + entity.width/2, entity.y - 1, message)
                    entity.displayDialog = true
                    entity.dialogElapsedTime = 0
                end
            end
        end
    elseif entity.displayDialog then
        entity.dialogElapsedTime = entity.dialogElapsedTime + dt
        if entity.dialogElapsedTime > 3 then
            entity.displayDialog = false
        end
    end

    entity.direction = 'left'

    entity:changeAnimation('walk-' .. tostring(entity.direction))
end

function EntityWalkState:processAIFighting(params,dt)
    -- TODO: add punches
    local entity = self.entity
    local playState = params.PlayState
    local distance = math.sqrt((entity.x - playState.player.x)^2 + (entity.y - playState.player.y)^2)
    local distance2 = distance

    if playState.player2 ~= nil then
        distance2 = math.sqrt((entity.x - playState.player2.x)^2 + (entity.y - playState.player2.y)^2)
    end

    if distance < math.random(20,30) or distance2 < math.random(20,30) then
        self.bumped = true
    end

    if not self.objectiveAlreadyChosen then
        if distance < distance2 then
            self.objetive = playState.player
        else
            self.objetive = playState.player2
        end
        self.objectiveAlreadyChosen = true
    end
    if self.objetive == nil then
        self.objetive = playState.player
    end

    if entity.dialogElapsedTime == nil then
        if distance < 500 or distance2 < 500 then
            local message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
            entity.dialog = Dialog(entity.x + entity.width/2, entity.y - 1, message)
            entity.displayDialog = true
            entity.dialogElapsedTime = 0
        end
    elseif entity.displayDialog then
        entity.dialogElapsedTime = entity.dialogElapsedTime + dt
        if entity.dialogElapsedTime > 3 then
            entity.displayDialog = false
        end
    end

    if not self.bumped then

        self.moveDuration = math.random(5)

        -- if playState.player.x + playState.player.width < entity.x and math.abs(playState.player.z - entity.z) <= 1 then
        --     entity.direction = "left"
        -- elseif playState.player.x > entity.x + entity.width and math.abs(playState.player.z - entity.z) <= 1 then
        --     entity.direction = "right"
        -- elseif playState.player.x + playState.player.width < entity.x and entity.z+1 < playState.player.z then
        --     entity.direction = "down-left"
        -- elseif playState.player.x + playState.player.width < entity.x and entity.z-1 > playState.player.z then
        --     entity.direction = "up-left"
        -- elseif playState.player.x > entity.x + entity.width and entity.z+1 < playState.player.z then
        --     entity.direction = "down-right"
        -- elseif playState.player.x > entity.x + entity.width and entity.z-1 > playState.player.z then
        --     entity.direction = "up-right"
        -- end

        if self.objetive.x + self.objetive.width < entity.x and math.abs(self.objetive.z - entity.z) <= 1 then
            entity.direction = "left"
        elseif self.objetive.x > entity.x + entity.width and math.abs(self.objetive.z - entity.z) <= 1 then
            entity.direction = "right"
        elseif self.objetive.x + self.objetive.width < entity.x and entity.z+1 < self.objetive.z then
            entity.direction = "down-left"
        elseif self.objetive.x + self.objetive.width < entity.x and entity.z-1 > self.objetive.z then
            entity.direction = "up-left"
        elseif self.objetive.x > entity.x + entity.width and entity.z+1 < self.objetive.z then
            entity.direction = "down-right"
        elseif self.objetive.x > entity.x + entity.width and entity.z-1 > self.objetive.z then
            entity.direction = "up-right"
        end

        local a,b = string.find(entity.direction,'left')
        if a == nil or b == nil then
            self.prevDirection = 'right'
        else
            self.prevDirection = string.sub(entity.direction, a, b)
        end

        entity:changeAnimation('walk-' .. tostring(entity.direction))

    else
        local a,b = string.find(entity.direction,'left')
        if a == nil or b == nil then
            self.prevDirection = 'right'
        else
            self.prevDirection = string.sub(entity.direction, a, b)
        end
        entity.punching = true
        entity.direction = self.prevDirection
        self.objetive = nil
        self.objectiveAlreadyChosen = false
        entity:changeState('idle', {
            dialogElapsedTime = entity.dialogElapsedTime,
            dialog = entity.dialog,
            displayDialog = entity.displayDialog,
        })
        return
    end
end

function EntityWalkState:render()
    local entity = self.entity
    local anim = entity.currentAnimation
    if anim then
        love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
            math.floor(entity.x), math.floor(entity.y))

        if entity.displayDialog then
            entity.dialog:render()
        end
    elseif SHOW_STDOUT then
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> anim is nil")
        for k, v in pairs(entity) do
            print(k, v)
        end
    end
end