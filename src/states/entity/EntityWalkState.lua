EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, dungeon)
    self.entity = entity
    --self.entity:changeAnimation('walk-down')

    self.dungeon = dungeon

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
    self.prevDirection = entity.direction
end

function EntityWalkState:update(dt)
    
    -- assume we didn't hit a wall
    self.bumped = false

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        
        if self.entity.x <= 0 then 
            self.entity.x = 0
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH*4 then
            self.entity.x = VIRTUAL_WIDTH*45 - self.entity.width
            self.bumped = true
        end
    elseif self.entity.direction == 'up-left' or self.entity.direction == 'up-right' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

        if self.entity.y <= VIRTUAL_HEIGHT*0.45 - self.entity.height * 0.45 then 
            self.entity.y = VIRTUAL_HEIGHT*0.45  - self.entity.height * 0.45
            self.bumped = true
        end
    elseif self.entity.direction == 'down-left' or self.entity.direction == 'down-right' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        -- local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
        --     + MAP_RENDER_OFFSET_Y - TILE_SIZE

        local bottomEdge = VIRTUAL_HEIGHT

        if self.entity.y + self.entity.height >= bottomEdge then
            self.entity.y = bottomEdge - self.entity.height
            self.bumped = true
        end
    end
end

function EntityWalkState:processAI(params, dt)
    -- TODO: add punches
    local room = params.room
    local directions = {'left', 'right', 'up-left', 'up-right', 'down-left', 'down-right'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        local a,b = string.find(self.entity.direction,'left')
        --print(a,b)
        -- if a == -1 and b == -1 then
        --     a,b = string.find(self.entity.direction,'right')
        -- end
        if a == nil or b == nil then
            self.prevDirection = 'right'
        else
            self.prevDirection = string.sub(self.entity.direction, a, b)
        end
        -- if string.len(self.entity.direction) < 6 then
        --     self.prevDirection = self.entity.direction
        -- else
        --     self.prevDirection = self.entity.direction
        -- end  
        -- self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity.direction = self.prevDirection
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end