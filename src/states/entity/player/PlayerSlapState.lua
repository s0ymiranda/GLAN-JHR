PlayerSlapState = Class{__includes = BaseState}

function PlayerSlapState:init(player,entities)
    self.player = player
    self.entities = entities
    self.miss = true
    --print(self.player.stateMachine.currentStateName)
    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        self.player.x = self.player.x - 7
        hitboxWidth = 16
        hitboxHeight = 12
        hitboxX = self.player.x - hitboxWidth/2 + 7
        hitboxY = self.player.y + 13
    elseif direction == 'right' then
        hitboxWidth = 16
        hitboxHeight = 12
        hitboxX = self.player.x + hitboxWidth--self.player.width
        hitboxY = self.player.y + 13
    -- elseif direction == 'up' then
    --     hitboxWidth = 16
    --     hitboxHeight = 8
    --     hitboxX = self.player.x
    --     hitboxY = self.player.y - hitboxHeight
    -- else
    --     hitboxWidth = 16
    --     hitboxHeight = 8
    --     hitboxX = self.player.x
    --     hitboxY = self.player.y + self.player.height
    end

    self.slapHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.player:changeAnimation('slap-' .. self.player.direction)
    -- self.player:changeAnimation('slap-left')
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
            entity:goInvulnerable(0.5)
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
    end
    
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        
        if self.player.direction == 'left' then 
            self.player.x = self.player.x + 7 
        end 
        self.player:changeState('idle')
    end

    if love.keyboard.wasPressed('space') then
        if self.player.direction == 'left' then 
            self.player.x = self.player.x + 7
        end 
        self.player:changeState('slap')
    end
end

function PlayerSlapState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    -- debug for player and hurtbox collision rects
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    love.graphics.rectangle('line', self.slapHitbox.x, self.slapHitbox.y,
    self.slapHitbox.width, self.slapHitbox.height)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end