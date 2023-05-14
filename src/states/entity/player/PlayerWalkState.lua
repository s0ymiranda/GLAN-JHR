PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.prev = player.direction
    self.joystickAction = ''
end

function PlayerWalkState:update(dt)

    --For Joystick
    if #joysticks > 0 then
        local isJoystickMoving = true
        if joystick:getGamepadAxis("lefty") == 0 and joystick:getGamepadAxis("leftx") == 0 then
            isJoystickMoving = false
        end
        if (joystick:isGamepadDown('dpleft') or (joystick:getGamepadAxis("leftx") < 0 and isJoystickMoving)) then
            self.joystickAction = 'left'
        elseif (joystick:isGamepadDown('dpright') or (joystick:getGamepadAxis("leftx") > 0 and isJoystickMoving)) then
            self.joystickAction = 'right'
        elseif (joystick:isGamepadDown('dpup') or (joystick:getGamepadAxis("lefty") < 0 and isJoystickMoving)) then
            self.joystickAction = 'up'
        elseif (joystick:isGamepadDown('dpdown') or (joystick:getGamepadAxis("lefty") > 0 and isJoystickMoving)) then
            self.joystickAction = 'down'
        end
        if (joystick:isGamepadDown('a')) then
            self.joystickAction = 'slap'
        elseif (joystick:isGamepadDown('x')) then
            self.joystickAction = 'knee-hit'
        elseif (joystick:isGamepadDown('rightshoulder')) then
            self.joystickAction = 'dodge'
        end
    end

    if love.keyboard.isDown('left','a') or self.joystickAction == 'left' then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        self.prev = 'left'
    elseif love.keyboard.isDown('right','d') or self.joystickAction == 'right' then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
        self.prev = 'right'
    elseif love.keyboard.isDown('up','w') or self.joystickAction == 'up' then
        self.entity.direction = 'up-' .. self.prev
        self.entity:changeAnimation('walk-' .. self.entity.direction)
    elseif love.keyboard.isDown('down','s') or self.joystickAction == 'down' then
        self.entity.direction = 'down-' .. self.prev
        self.entity:changeAnimation('walk-' .. self.entity.direction)
    else
        if self.prev == 'left' then
            self.entity.direction = 'left'
        elseif self.prev == 'right' then
            self.entity.direction = 'right'
        end
        self.entity:changeState('idle')
    end
    if love.keyboard.wasPressed('space') or self.joystickAction == 'slap' then
        if self.prev == 'left' then
            self.entity.direction = 'left'
        elseif self.prev == 'right' then
            self.entity.direction = 'right'
        end
        self.entity:changeState('slap')
    elseif love.keyboard.wasPressed('k') or self.joystickAction == 'knee-hit' then
        if self.prev == 'left' then
            self.entity.direction = 'left'
        elseif self.prev == 'right' then
            self.entity.direction = 'right'
        end
        self.entity:changeState('knee-hit')
    elseif love.keyboard.wasPressed('l') or self.joystickAction == 'dodge' then
        self.entity:changeState('dodge')
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local takenPot = nil
        local potIdx = 0
    end

    self.joystickAction = ''
    -- perform base collision detection against walls

    EntityWalkState.update(self, dt)

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