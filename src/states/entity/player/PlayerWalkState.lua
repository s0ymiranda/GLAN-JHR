PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, objects)
    self.entity = player
    self.objects = objects
    self.prev = player.direction
    -- self.joystickAction = ''
    self.usingJoystick = false
end

function PlayerWalkState:enter(params)
    self.animationPrefix = 'walk-'
    if params and params.heldObject then
        self.heldObject = params.heldObject
        self.animationPrefix = 'held-walk-'
    end
    self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
end

function PlayerWalkState:update(dt)

    --For Joystick
    if #joysticks > 0 and (self.entity.numOfPlayersInGame == 1 or self.entity.playerNum == 2) then
        local isJoystickMoving = true
        if joystick:getGamepadAxis("lefty") == 0 and joystick:getGamepadAxis("leftx") == 0 then
            isJoystickMoving = false
        end
        if (joystick:isGamepadDown('dpleft') or (joystick:getGamepadAxis("leftx") < 0 and isJoystickMoving)) then
            self.entity.direction = 'left'
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.prev = 'left'
            self.usingJoystick = true
        elseif (joystick:isGamepadDown('dpright') or (joystick:getGamepadAxis("leftx") > 0 and isJoystickMoving)) then
            self.entity.direction = 'right'
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.prev = 'right'
            self.usingJoystick = true
        elseif (joystick:isGamepadDown('dpup') or (joystick:getGamepadAxis("lefty") < 0 and isJoystickMoving)) then
            self.entity.direction = 'up-' .. self.prev
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.usingJoystick = true
        elseif (joystick:isGamepadDown('dpdown') or (joystick:getGamepadAxis("lefty") > 0 and isJoystickMoving)) then
            self.entity.direction = 'down-' .. self.prev
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.usingJoystick = true
        elseif self.entity.playerNum == 2 then
            self.entity.direction = self.prev
            self.entity:changeState('idle',{heldObject = self.heldObject})
        end
        if not self.heldObject then
            if (joystick:isGamepadDown('a')) then
                self.entity.direction = self.prev
                self.entity:changeState('slap')
                return
            elseif (joystick:isGamepadDown('x')) then
                self.entity.direction = self.prev
                self.entity:changeState('knee-hit')
                return
            elseif (joystick:isGamepadDown('rightshoulder')) then
                self.entity.direction = self.prev
                self.entity:changeState('dodge')
                return
            else
                -- self.joystickAction = ''
            end
        end
    end

    if self.entity.playerNum == 1 then
        if love.keyboard.isDown('left','a') then
            self.entity.direction = 'left'
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.prev = 'left'
        elseif love.keyboard.isDown('right','d') then
            self.entity.direction = 'right'
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
            self.prev = 'right'
        elseif love.keyboard.isDown('up','w') then
            self.entity.direction = 'up-' .. self.prev
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
        elseif love.keyboard.isDown('down','s') then
            self.entity.direction = 'down-' .. self.prev
            self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
        elseif not self.usingJoystick then
            self.entity.direction = self.prev
            self.entity:changeState('idle', {heldObject = self.heldObject})
            return
        end
        if not self.heldObject then
            if love.keyboard.wasPressed('j') then
                self.entity.direction = self.prev
                self.entity:changeState('slap')
                return
            end
            if love.keyboard.wasPressed('k') then
                self.entity.direction = self.prev
                self.entity:changeState('knee-hit')
                return
            end
            if love.keyboard.wasPressed('l') then
                self.entity.direction = self.prev
                self.entity:changeState('dodge')
                return
            end
        end
    end

    -- if self.entity.playerNum == 1 or (self.joystickAction ~= '' and self.entity.playerNum == 2) then
    --     if love.keyboard.isDown('left','a') or self.joystickAction == 'left' then
    --         self.entity.direction = 'left'
    --         self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    --         self.prev = 'left'
    --     elseif love.keyboard.isDown('right','d') or self.joystickAction == 'right' then
    --         self.entity.direction = 'right'
    --         self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    --         self.prev = 'right'
    --     elseif love.keyboard.isDown('up','w') or self.joystickAction == 'up' then
    --         self.entity.direction = 'up-' .. self.prev
    --         self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    --     elseif love.keyboard.isDown('down','s') or self.joystickAction == 'down' then
    --         self.entity.direction = 'down-' .. self.prev
    --         self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    --     else
    --         self.entity.direction = self.prev
    --         self.entity:changeState('idle', {heldObject = self.heldObject})
    --         return
    --     end
    --     if love.keyboard.wasPressed('space') or self.joystickAction == 'slap' then
    --         self.entity.direction = self.prev
    --         self.entity:changeState('slap')
    --         return
    --     end
    --     if love.keyboard.wasPressed('k') or self.joystickAction == 'knee-hit' then
    --         self.entity.direction = self.prev
    --         self.entity:changeState('knee-hit')
    --         return
    --     end
    --     if love.keyboard.wasPressed('l') or self.joystickAction == 'dodge' then
    --         self.entity:changeState('dodge')
    --         return
    --     end
    --     if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    --         -- self.entity.direction = self.prev
    --         -- self.entity:changeState('take-object', {heldObject = self.heldObject, playerPreviousState = 'walk'})
    --         -- return
    --     end
    --     if self.entity.playerNum == 2 then
    --         self.joystickAction = ''
    --     end
    -- end

    -- self.joystickAction = ''
    -- perform base collision detection against walls
    self.usingJoystick = false
    EntityWalkState.update(self, dt)

    if self.heldObject then
        local heldObjectState = self.heldObject:getCurrentState()
        self.heldObject.x = self.entity.x + 12 - heldObjectState.width / 2
        self.heldObject.y = self.entity.y - heldObjectState.height + 3
    end

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        if self.entity.direction == 'left' then
            -- temporarily adjust position
            self.entity.x = self.entity.x - self.entity.walkSpeed * dt
            -- readjust position
            self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        elseif self.entity.direction == 'right' then
            -- temporarily adjust position
            self.entity.x = self.entity.x + self.entity.walkSpeed * dt
            -- readjust position
            self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        elseif self.entity.direction == 'up-left' or self.entity.direction == 'up-right' then
            -- temporarily adjust position
            self.entity.y = self.entity.y - self.entity.walkSpeed * dt
            -- readjust position
            self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        else
            -- temporarily adjust position
            self.entity.y = self.entity.y + self.entity.walkSpeed * dt
            -- readjust position
            self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        end
    end
end

function PlayerWalkState:render()
    EntityWalkState.render(self)
    if self.heldObject then
        self.heldObject:render()
    end
end