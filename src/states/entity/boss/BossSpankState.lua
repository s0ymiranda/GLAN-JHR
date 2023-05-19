BossSpankState = Class{__includes = BaseState}

function BossSpankState:init(entity,players)
    self.entity = entity
    self.players = players
    self.miss = true

    self.canHit = false

    Timer.after(0.3,function() self.canHit = true end)
    Timer.after(0.6,function() self.canHit = false end)
    -- create hitbox based on where the entity is and facing
    local direction = self.entity.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        self.entity.x = self.entity.x
        hitboxWidth = 16
        hitboxHeight = 14
        hitboxX = self.entity.x - hitboxWidth/3
        hitboxY = self.entity.y + 45
    elseif direction == 'right' then
        hitboxWidth = 16
        hitboxHeight = 14
        hitboxX = self.entity.x + self.entity.width/3 + hitboxWidth
        hitboxY = self.entity.y + 45
    end

    self.HandHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.entity:changeAnimation('spank-'.. direction)
end

function BossSpankState:enter(params)
    -- SOUNDS['slap']:stop()
    -- SOUNDS['slap']:play()

    -- restart slap swing animation
    self.entity.currentAnimation:refresh()
end

function BossSpankState:update(dt)
    -- check if hitbox collides with any.players in the scene
    for k, entity in pairs(self.players) do
        if self.canHit and math.abs(self.entity.z - entity.z) <= 1 and entity:collides(self.HandHitbox) and not entity.invulnerable then
            entity:damage(30)
            entity:goInvulnerable(ENTITY_INVULNERABILITY_TIME)
            SOUNDS['UOFF']:stop()
            SOUNDS['UOFF']:play()
            SOUNDS['spank']:stop()
            SOUNDS['spank']:play()
            self.miss = false
        end
    end

    if self.miss then
        SOUNDS['miss']:stop()
        SOUNDS['miss']:play()
        self.miss = false
    end

    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        self.entity:changeState('idle')
        return
    end
end

function BossSpankState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

    -- debug for hurtbox collision rects
    if SHOW_HURTBOX then
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
        love.graphics.rectangle('line', self.HandHitbox.x, self.HandHitbox.y,
            self.HandHitbox.width, self.HandHitbox.height)
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    end
end