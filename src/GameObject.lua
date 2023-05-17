GameObject = Class{}

function GameObject:init(def, x, y)
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    self.damage = def.damage or 0
    self.timesHit = 0

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.width = def.width
    self.height = def.height
    self.x = x
    self.y = y
    self.z_base = VIRTUAL_HEIGHT*0.55
    self.z = math.floor(((self.y+self.height)-self.z_base)/10)

    -- default empty collision callback
    self.onCollide = def.onCollide or function() end

    -- variable for consumable objects
    self.consumable = def.consumable

    -- onConsume function an empty function if it is not specified
    self.onConsume = def.onConsume or function() end

    self.getBottom = def.getBottom or function() end

    -- an object could be taken or not
    self.takeable = def.takeable
    self.taken = false
    self.bottomCollisionDistance = def.bottomCollisionDistance
end

function GameObject:update(dt)
    if self.gravity then
        self.ySpeed = self.ySpeed + GRAVITY*dt
        self.y = self.y + self.ySpeed*dt
    end
    if self.floor and (self.y >= self.floor - self.height) then
        self.y = self.floor - self.height
        self.ySpeed = 0
        self.xSpeed = 0
        self.gravity = false
    end
    if self.xSpeed and (self.xSpeed ~= 0) then
        self.x = self.x + self.xSpeed*dt
    end
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:getCurrentState()
    return self.states[self.state]
end

function GameObject:hit(entity)
    if not entity.invulnerable then
        entity:damage(self.damage)
        entity:goInvulnerable(ENTITY_INVULNERABILITY_TIME)
        self.timesHit = self.timesHit + 1
        if self.timesHit == 3 then
            local previousHeight = self:getCurrentState().height
            self.state = 'damaged'
            self.previousState = 'damaged'
            self.takeable = false
            local currentHeight = self:getCurrentState().height
            self.floor = self.floor + (currentHeight - previousHeight)
        end
    end
end

function GameObject:render()
    local currentState = self:getCurrentState()
    local frames = FRAMES[self.texture]
    local emptySpaces = currentState.emptySpaces or {0, 0, 0, 0}
    local x = math.floor(self.x - emptySpaces[4])
    local y = math.floor(self.y - emptySpaces[1])
    local width = currentState.width or self.width
    local height = currentState.height or self.height
    if frames then
        love.graphics.draw(
            TEXTURES[self.texture],
            frames[currentState.frame or self.frame],
            x, y
        )
    else
        love.graphics.draw(TEXTURES[self.texture], x, y)
    end
end
