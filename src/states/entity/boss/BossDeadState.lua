BossDeadState = Class { __includes = BaseState }

function BossDeadState:init(entity)
    self.entity = entity
    SOUNDS['dead']:play()
    SOUNDS['boss_music']:stop(true)
    SOUNDS['scenary-music']:play()
    if entity.direction == 'right' then
        entity.x = entity.x - 75 / 2
    end
    entity:changeAnimation('die-' .. entity.direction)
    entity.dead = true
    Timer.after(0.48, function()
        entity.fighting = false
        entity.y = entity.y + 5
        self.entity:changeAnimation('dead-' .. self.entity.direction)
    end)
end

function BossDeadState:processAI(params, dt)

end

function BossDeadState:processAIFighting(params, dt)

end

function BossDeadState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
end
