EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
    --if not entity == nil then self.prevDirection = entity.direction end
    self.prevDirection = entity.direction
end

function EntityWalkState:update(dt)
    -- assume we didn't hit a wall
    self.bumped = false

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        if self.entity.x <= self.entity.leftLimit and not self.entity.justWalking then
        --if self.entity.x <= 0 then
            self.entity.x = self.entity.leftLimit
            if not self.entity.justWalking then
                self.bumped = true
            end
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        --if self.entity.x + self.entity.width >= VIRTUAL_WIDTH*4 and not self.entity.justWalking then
        if self.entity.x + self.entity.width >= self.entity.rightLimit then
            self.entity.x = self.entity.rightLimit - self.entity.width
            if not self.entity.justWalking then
                self.bumped = true
            end
        end
    elseif self.entity.direction == 'up-left' or self.entity.direction == 'up-right' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

    --    if self.entity.y <= VIRTUAL_HEIGHT*0.45 - self.entity.height * 0.45 and not self.entity.justWalking then
        if self.entity.y <= VIRTUAL_HEIGHT*0.45 - self.entity.height * 0.45 then
            self.entity.y = VIRTUAL_HEIGHT*0.45  - self.entity.height * 0.45

            if not self.entity.justWalking then
                self.bumped = true
            end
        end
    elseif self.entity.direction == 'down-left' or self.entity.direction == 'down-right' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        local bottomEdge = VIRTUAL_HEIGHT

        --if self.entity.y + self.entity.height >= bottomEdge and not self.entity.justWalking then
        if self.entity.y + self.entity.height >= bottomEdge then
            self.entity.y = bottomEdge - self.entity.height
            if not self.entity.justWalking then
                self.bumped = true
            end
        end
    end
    if self.displayDialog then
        self.dialog:update(self.entity.x + self.entity.width/2, self.entity.y - 1)
    end
end

function EntityWalkState:processAI(params, dt)
    -- TODO: add punches
    local room = params.room

    if self.dialogElapsedTime == nil then
        local distance = math.sqrt((self.entity.x - room.player.x)^2 + (self.entity.y - room.player.y)^2)
        if distance < 150 and self.entity.pervert then
            local message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
            self.dialog = Dialog(self.entity.x + self.entity.width/2, self.entity.y - 1, message)
            self.displayDialog = true
            self.dialogElapsedTime = 0
        end
    elseif self.displayDialog then
        self.dialogElapsedTime = self.dialogElapsedTime + dt
        if self.dialogElapsedTime > 3 then
            self.displayDialog = false
        end
    end

    self.entity.direction = 'left'

    self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))

    -- if math.random(3) == 1 then
    --     self.entity.direction = self.prevDirection
    --     self.entity:changeState('idle', {
    --         dialogElapsedTime = self.dialogElapsedTime,
    --         dialog = self.dialog,
    --         displayDialog = self.displayDialog,
    --     })
    -- end

end

-- function EntityWalkState:processAI(params, dt)
--     -- TODO: add punches
--     local room = params.room

--     if self.dialogElapsedTime == nil then
--         local distance = math.sqrt((self.entity.x - room.player.x)^2 + (self.entity.y - room.player.y)^2)
--         if distance < 500 then
--             local message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
--             self.dialog = Dialog(self.entity.x + self.entity.width/2, self.entity.y - 1, message)
--             self.displayDialog = true
--             self.dialogElapsedTime = 0
--         end
--     elseif self.displayDialog then
--         self.dialogElapsedTime = self.dialogElapsedTime + dt
--         if self.dialogElapsedTime > 3 then
--             self.displayDialog = false
--         end
--     end

--     local directions = {'left', 'right', 'up-left', 'up-right', 'down-left', 'down-right'}
--     local directions = {'left'}

--     if self.moveDuration == 0 or self.bumped then
--         -- set an initial move duration and direction
--         self.moveDuration = math.random(5)
--         self.entity.direction = directions[math.random(#directions)]
--         local a,b = string.find(self.entity.direction,'left')
--         if a == nil or b == nil then
--             self.prevDirection = 'right'
--         else
--             self.prevDirection = string.sub(self.entity.direction, a, b)
--         end
--         self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
--     elseif self.movementTimer > self.moveDuration then
--         self.movementTimer = 0

--         -- chance to go idle
--         if math.random(3) == 1 then
--             self.entity.direction = self.prevDirection
--             self.entity:changeState('idle', {
--                 dialogElapsedTime = self.dialogElapsedTime,
--                 dialog = self.dialog,
--                 displayDialog = self.displayDialog,
--             })
--         else
--             self.moveDuration = math.random(5)
--             self.entity.direction = directions[math.random(#directions)]
--             self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
--         end
--     end

--     self.movementTimer = self.movementTimer + dt
-- end

function EntityWalkState:processAIFighting(params,dt)
    -- TODO: add punches
    local room = params.room
    local distance = math.sqrt((self.entity.x - room.player.x)^2 + (self.entity.y - room.player.y)^2)

    if distance < math.random(20,30) then
        self.bumped = true
    end

    if self.dialogElapsedTime == nil then
        if distance < 500 then
            local message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
            self.dialog = Dialog(self.entity.x + self.entity.width/2, self.entity.y - 1, message)
            self.displayDialog = true
            self.dialogElapsedTime = 0
        end
    elseif self.displayDialog then
        self.dialogElapsedTime = self.dialogElapsedTime + dt
        if self.dialogElapsedTime > 3 then
            self.displayDialog = false
        end
    end

    if not self.bumped then

        self.moveDuration = math.random(5)

        if room.player.x + room.player.width < self.entity.x and math.abs(room.player.z - self.entity.z) <= 1 then
            self.entity.direction = "left"
        elseif room.player.x > self.entity.x + self.entity.width and math.abs(room.player.z - self.entity.z) <= 1 then
            self.entity.direction = "right"
        elseif room.player.x + room.player.width < self.entity.x and self.entity.z+1 < room.player.z then
            self.entity.direction = "down-left"
        elseif room.player.x + room.player.width < self.entity.x and self.entity.z-1 > room.player.z then
            self.entity.direction = "up-left"
        elseif room.player.x > self.entity.x + self.entity.width and self.entity.z+1 < room.player.z then
            self.entity.direction = "down-right"
        elseif room.player.x > self.entity.x + self.entity.width and self.entity.z-1 > room.player.z then
            self.entity.direction = "up-right"
        end

        local a,b = string.find(self.entity.direction,'left')
        if a == nil or b == nil then
            self.prevDirection = 'right'
        else
            self.prevDirection = string.sub(self.entity.direction, a, b)
        end

        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))

    else
        local a,b = string.find(self.entity.direction,'left')
        if a == nil or b == nil then
            self.prevDirection = 'right'
        else
            self.prevDirection = string.sub(self.entity.direction, a, b)
        end
        self.entity.punching = true
        self.entity.direction = self.prevDirection
        self.entity:changeState('idle', {
            dialogElapsedTime = self.dialogElapsedTime,
            dialog = self.dialog,
            displayDialog = self.displayDialog,
        })
        return
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

    if self.displayDialog then
        self.dialog:render()
    end
end