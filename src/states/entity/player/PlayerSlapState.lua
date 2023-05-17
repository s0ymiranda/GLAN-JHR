PlayerSlapState = Class{__includes = BaseState}

function PlayerSlapState:init(player,entities, boss)
    -- create hitbox based on where the player is and facing
    local direction = player.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    hitboxWidth = 14
    hitboxHeight = 12
    hitboxY = player.y + 13

    if direction == 'left' then
        local emptySpaceFromIdleAndWalk = 4
        local emptySpaceFromSlap = 10
        self.xOffsetSlapTexture = -emptySpaceFromSlap + emptySpaceFromIdleAndWalk
        hitboxX = player.x + self.xOffsetSlapTexture
    elseif direction == 'right' then
        local emptySpaceFromIdleAndWalk = 1
        local emptySpaceFromSlap = 3
        local bodyWidth = 17
        local handToBodyDistance = 10
        self.xOffsetSlapTexture = -emptySpaceFromSlap + emptySpaceFromIdleAndWalk
        hitboxX = player.x + emptySpaceFromSlap + bodyWidth + handToBodyDistance - hitboxWidth
    end

    self.slapHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    player:changeAnimation('slap-' .. player.direction)

    -- class members
    self.player = player
    self.entities = entities
    self.boss = boss
    self.miss = true
end

function PlayerSlapState:enter(params)
    -- SOUNDS['slap']:stop()
    -- SOUNDS['slap']:play()

    -- restart slap swing animation
    self.player.currentAnimation:refresh()
end

function PlayerSlapState:update(dt)
    -- check if hitbox collides with any entities in the scene
    for k, entity in pairs(self.entities) do
        if math.abs(self.player.z - entity.z) <= 1 and entity:collides(self.slapHitbox) and not entity.invulnerable then
            entity:damage(1)
            entity:goInvulnerable(ENTITY_INVULNERABILITY_TIME-0.5)
            SOUNDS['UOFF']:stop()
            SOUNDS['UOFF']:play()
            SOUNDS['slap']:stop()
            SOUNDS['slap']:play()
            self.miss = false
        end
    end
    if self.boss ~= nil then
        if math.abs(self.player.z - self.boss.z) <= 1 and self.boss:collides(self.slapHitbox) and not self.boss.invulnerable then
            self.boss:damage(1)
            self.boss:goInvulnerable(ENTITY_INVULNERABILITY_TIME-0.5)
            SOUNDS['UOFF']:stop()
            SOUNDS['UOFF']:play()
            SOUNDS['slap']:stop()
            SOUNDS['slap']:play()
            self.miss = false
        end
    end

    if self.miss then
        SOUNDS['miss']:stop()
        SOUNDS['miss']:play()
        self.miss = false
        --print(self.player.x)
    end

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
        return
    end
end

function PlayerSlapState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
    math.floor(self.player.x + self.xOffsetSlapTexture), math.floor(self.player.y))

    -- debug for hurtbox collision rects
    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', math.floor(self.slapHitbox.x), math.floor(self.slapHitbox.y),
    --     self.slapHitbox.width, self.slapHitbox.height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end