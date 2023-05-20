PlayerCinematicState = Class { __includes = EntityWalkState }

function PlayerCinematicState:init(player)
    self.entity = player
    self.prev = player.direction
    local y_destiny = VIRTUAL_HEIGHT * 0.46 + 10
    local x_destiny = MAP_WIDTH - 380
    if player.playerNum == 2 then
        y_destiny = VIRTUAL_HEIGHT * 0.46 + 10
        x_destiny = MAP_WIDTH - 380 - self.entity.width - 10
    end
    -- self.joystickAction = ''
    self.usingJoystick = false
    self.animationPrefix = 'walk-'
    self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    -- Timer.after(3, function()
    --     self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
    --     Timer.tween(3, {
    --         [self.entity] = {
    --             y = VIRTUAL_HEIGHT*0.46 +10,
    --             x = MAP_WIDTH - 200
    --         }})
    -- end)
    Timer.tween(3, {
        [self.entity] = {
            y = y_destiny,
            x = x_destiny
        }
    })
    Timer.after(3, function()
        self.entity:changeAnimation('win')
    end)

    Timer.after(6, function()
        self.animationPrefix = 'walk-'
        self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
        Timer.tween(3, {
            [self.entity] = {
                y = VIRTUAL_HEIGHT * 0.46 + 10,
                x = MAP_WIDTH - 200
            }
        })
    end)
end

function PlayerCinematicState:update(dt)

end

function PlayerCinematicState:render()
    EntityWalkState.render(self)
end
