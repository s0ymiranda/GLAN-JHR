GameObject = Class{}

function GameObject:init(def, x, y)
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

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
    if (self.y and self.floor) and self.y >= self.floor then
        self.y = self.floor
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

function GameObject:render()
    local currentState = self:getCurrentState()
    local frames = FRAMES[self.texture]
    local emptySpaces = currentState.emptySpaces
    local x = math.floor(self.x - emptySpaces[4])
    local y = math.floor(self.y - emptySpaces[1])
    local width = currentState.width or self.width
    local height = currentState.height or self.height
    love.graphics.draw(
        TEXTURES[self.texture],
        frames[currentState.frame or self.frame],
        x, y
    )
    -- debug
    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', math.floor(self.x), math.floor(self.y), width, height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    -- local objectBottom = self.getBottom(self)
    -- if objectBottom then
    --     love.graphics.setColor(love.math.colorFromBytes(0, 255, 0, 255))
    --     love.graphics.line(objectBottom.x, objectBottom.y, objectBottom.x + objectBottom.width, objectBottom.y)
    --     love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    -- end
end
