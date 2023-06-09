PlayerDodgeState = Class { __includes = BaseState }

function PlayerDodgeState:init(player, entities)
    self.player = player

    if self.player.direction == 'right' then
        self.player.x = self.player.x - 10
    end

    SOUNDS['dodge']:play()

    self.player:changeAnimation('dodge-' .. self.player.direction)
end

function PlayerDodgeState:enter(params)
    -- SOUNDS['slap']:stop()
    -- SOUNDS['slap']:play()

    -- restart slap swing animation
    self.player.currentAnimation:refresh()
end

function PlayerDodgeState:update(dt)
    self.player.invulnerable = true

    if self.player.currentAnimation.timesPlayed > 0 then
        if self.player.direction == 'right' then
            self.player.x = self.player.x + 10
        end
        self.player.invulnerable = false
        self.player:changeState('idle')
    end
end

function PlayerDodgeState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x), math.floor(self.player.y))
end
