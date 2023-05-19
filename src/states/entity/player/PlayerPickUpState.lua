PlayerPickUpState = Class{__includes = BaseState}

function PlayerPickUpState:init(player)
    self.player = player
    self.player:changeAnimation('pick-up-' .. self.player.direction)
    self.previousFrame = 0
    SOUNDS['barrel_pick_up']:stop()
    SOUNDS['barrel_pick_up']:play()
end

function PlayerPickUpState:enter(params)
    self.params = params

    -- restart animation
    self.player.currentAnimation:refresh()
end

function PlayerPickUpState:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player:changeState(self.params.playerPreviousState, {heldObject = self.params.heldObject})
        return
    end
end

function PlayerPickUpState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x), math.floor(self.player.y))
    local frame = anim.currentFrame
    -- print("frame: " .. frame)
    local heldObject = self.params.heldObject
    local heldObjectState = heldObject:getCurrentState()
    local player = self.player

    if frame > 2 then
        heldObject.y = player.y + player.height - heldObjectState.height
        if frame == 3 then
            if self.previousFrame == 2 then
                heldObject.previousState = heldObject.state
                heldObject.state = 'default-noshadow'
            end
            if player.direction == 'left' then
                heldObject.x = player.x + 10 - heldObjectState.width/2
            else
                heldObject.x = player.x + 32 - 10 - heldObjectState.width/2
            end
            heldObject.y = math.min(heldObject.y, player.y + 55 - heldObjectState.height / 2)
        end
        if frame == 4 then
            if player.direction == 'left' then
                heldObject.x = player.x + 14 - heldObjectState.width/2
            else
                heldObject.x = player.x + 32 - 14 - heldObjectState.width/2
            end
            heldObject.y = math.min(heldObject.y, player.y + 41 - heldObjectState.height / 2)
        end
        if frame == 5 then
            if player.direction == 'left' then
                heldObject.x = player.x + 12 - heldObjectState.width/2
            else
                heldObject.x = player.x + 32 - 12 - heldObjectState.width/2
            end
            heldObject.y = math.min(heldObject.y, player.y + 39 - heldObjectState.height / 2)
        end
    end
    self.previousFrame = frame
    heldObject:render()
end