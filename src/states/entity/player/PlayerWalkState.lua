PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.prev = player.direction
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left','a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        self.prev = 'left'
    elseif love.keyboard.isDown('right','d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
        self.prev = 'right'
    elseif love.keyboard.isDown('up','w') then
        self.entity.direction = 'up-' .. self.prev
        self.entity:changeAnimation('walk-' .. self.entity.direction)
    elseif love.keyboard.isDown('down','s') then
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
    if love.keyboard.wasPressed('space') then
        if self.prev == 'left' then
            self.entity.direction = 'left'
        elseif self.prev == 'right' then
            self.entity.direction = 'right'  
        end
        self.entity:changeState('slap')
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local takenPot = nil
        local potIdx = 0
    end

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