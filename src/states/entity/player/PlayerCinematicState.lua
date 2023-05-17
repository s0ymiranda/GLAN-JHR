PlayerCinematicState = Class{__includes = EntityWalkState}

function PlayerCinematicState:init(player)
    self.entity = player
    self.prev = player.direction
    -- self.joystickAction = ''
    self.usingJoystick = false
    Timer.tween(3, {
        [self.entity] = {
            y = VIRTUAL_HEIGHT*0.46 +10,
            x = MAP_WIDTH - 220
        }}
    )
end

function PlayerCinematicState:enter(params)
    self.animationPrefix = 'walk-'

    self.entity:changeAnimation(self.animationPrefix .. self.entity.direction)
end


function PlayerCinematicState:render()
    EntityWalkState.render(self)
end