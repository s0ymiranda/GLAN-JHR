EntityDeadState = Class{__includes = BaseState}

function EntityDeadState:init(entity)
    self.entity = entity
    SOUNDS['dead']:play()
    if entity.direction == 'right' then
        entity.x = entity.x - 75/2
    end
    entity:changeAnimation('die-' .. entity.direction)
    entity.dead = true
    entity.stillFalling = true
    Timer.after(0.48,function()
        entity.fighting = false
        entity.y = entity.y + 5
        self.entity:changeAnimation('dead-' .. self.entity.direction)
        entity.stillFalling = false
    end)
end

function EntityDeadState:processAI(params, dt)

end

function EntityDeadState:processAIFighting(params, dt)

end

function EntityDeadState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
end