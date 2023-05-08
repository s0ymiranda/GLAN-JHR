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

    -- an object could be taken or not
    self.takeable = def.takeable
    self.taken = false
end

function GameObject:update(dt)

end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    local frames = FRAMES[self.texture]
    if frames then
        love.graphics.draw(
            TEXTURES[self.texture],
            frames[self.states[self.state].frame or self.frame],
            self.x + (adjacentOffsetX or 0),
            self.y + (adjacentOffsetY or 0)
        )
    else
        love.graphics.draw(
            TEXTURES[self.texture],
            self.x + (adjacentOffsetX or 0),
            self.y + (adjacentOffsetY or 0)
        )
    end
end
