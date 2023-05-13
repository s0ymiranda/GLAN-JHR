EntityPunchState = Class{__includes = BaseState}

function EntityPunchState:init(entity,player)
    self.player = player
    self.entity = entity
    self.miss = true

    local direction = self.entity.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        self.entity.x = self.entity.x - 7
        hitboxWidth = 12
        hitboxHeight = 12
        hitboxX = self.entity.x - hitboxWidth/2 + 7
        hitboxY = self.entity.y + 17
    elseif direction == 'right' then
        self.entity.x = self.entity.x - 3
        hitboxWidth = 18
        hitboxHeight = 12
        hitboxX = self.entity.x + hitboxWidth
        hitboxY = self.entity.y + 17
    end

    self.punchHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.entity:changeAnimation('punch-' .. self.entity.direction)
end

function EntityPunchState:enter(params)
    -- SOUNDS['slap']:stop()
    -- SOUNDS['slap']:play()

    -- restart slap swing animation
    self.player.currentAnimation:refresh()
end

function EntityPunchState:update(dt)
    -- check if hitbox collides the player
    if math.abs(self.entity.z - self.player.z) <= 1 and self.player:collides(self.punchHitbox) and not self.player.invulnerable then
        self.player:damage(10)
        self.player:goInvulnerable(1.5)
        SOUNDS['hero-damage']:stop()
        SOUNDS['hero-damage']:play()
        SOUNDS['slap']:stop()
        SOUNDS['slap']:play()
        self.miss = false
    end

    if self.miss then
        SOUNDS['miss']:stop()
        SOUNDS['miss']:play()
        self.miss = false
    end

    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0

        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x + 7
        else
            self.entity.x = self.entity.x + 3
        end
        self.entity:changeState('idle')
        return
    end

    if love.keyboard.wasPressed('space') then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x + 7
        else
            self.entity.x = self.entity.x + 3
        end
        self.entity:changeState('punch')
        return
    end
end

function EntityPunchState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

    -- debug for player and hurtbox collision rects
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.rectangle('line', math.floor(self.punchHitbox.x), math.floor(self.punchHitbox.y),
    self.punchHitbox.width, self.punchHitbox.height)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end