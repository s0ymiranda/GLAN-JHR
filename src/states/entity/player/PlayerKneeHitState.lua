PlayerKneeHitState = Class{__includes = BaseState}

function PlayerKneeHitState:init(player,entities)
    self.player = player
    self.entities = entities
    self.miss = true
    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        self.player.x = self.player.x - 7
        hitboxWidth = 16
        hitboxHeight = 12
        hitboxX = self.player.x - hitboxWidth/2 + 7
        hitboxY = self.player.y + self.player.height/2
    elseif direction == 'right' then
        hitboxWidth = 16
        hitboxHeight = 12
        hitboxX = self.player.x + hitboxWidth
        hitboxY = self.player.y + self.player.height/2
    end

    self.kneeHitHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.player:changeAnimation('knee-hit-' .. self.player.direction)
end

function PlayerKneeHitState:enter(params)
    -- SOUNDS['slap']:stop()
    -- SOUNDS['slap']:play()

    -- restart slap swing animation
    self.player.currentAnimation:refresh()
end

function PlayerKneeHitState:update(dt)
    -- check if hitbox collides with any entities in the scene
    for k, entity in pairs(self.entities) do
        if math.abs(self.player.z - entity.z) <= 1 and entity:collides(self.kneeHitHitbox) and not entity.invulnerable then
            entity:damage(1.5)
            entity:goInvulnerable(ENTITY_INVULNERABILITY_TIME)
            SOUNDS['UOFF']:stop()
            SOUNDS['UOFF']:play()
            SOUNDS['knee-hit']:stop()
            SOUNDS['knee-hit']:play()
            self.miss = false
        end
    end

    if self.miss then
        SOUNDS['miss']:stop()
        SOUNDS['miss']:play()
        self.miss = false
    end

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0

        if self.player.direction == 'left' then
            self.player.x = self.player.x + 7
        end
        self.player:changeState('idle')
        return
    end
end

function PlayerKneeHitState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x), math.floor(self.player.y))

    -- debug for hurtbox collision rects
    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', self.kneeHitHitbox.x, self.kneeHitHitbox.y,
    --     self.kneeHitHitbox.width, self.kneeHitHitbox.height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end