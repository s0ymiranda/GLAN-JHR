PlayerKneeHitState = Class{__includes = BaseState}

function PlayerKneeHitState:init(player,entities,boss)
    self.player = player
    self.entities = entities
    self.boss = boss
    self.miss = true
    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    self.scored = false

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
        if math.abs(self.player.z - entity.z) <= 1 and entity:collides(self.kneeHitHitbox) and not entity.invulnerable and not entity.dead then
            entity:damage(15)
            if not entity.pervert then
                self.player.innocent_beaten = self.player.innocent_beaten + 1
            elseif entity.health <= 0 then
                self.player.perverts_defeated = self.player.perverts_defeated + 1
            end
            entity:goInvulnerable(ENTITY_INVULNERABILITY_TIME)
            SOUNDS['UOFF']:stop()
            SOUNDS['UOFF']:play()
            SOUNDS['knee-hit']:stop()
            SOUNDS['knee-hit']:play()
            self.miss = false
            if not entity.pervert then
                local message = WRONG_PERSON_MESSAGES[math.random(#WRONG_PERSON_MESSAGES)]
                entity.dialog = Dialog(entity.x + entity.width/2, entity.y - 1, message)
                entity.displayDialog = true
                entity.dialogElapsedTime = 0
            end
        end
    end
    if self.boss ~=nil then
        if math.abs(self.player.z - self.boss.z) <= 1 and self.boss:collides(self.kneeHitHitbox) and not self.boss.invulnerable and not self.boss.dead then
            self.boss:damage(15)
            self.boss:goInvulnerable(ENTITY_INVULNERABILITY_TIME)
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
    if SHOW_HURTBOX then
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
        love.graphics.rectangle('line', self.kneeHitHitbox.x, self.kneeHitHitbox.y,
            self.kneeHitHitbox.width, self.kneeHitHitbox.height)
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    end
end