PlayerIdleState = Class{__includes = EntityIdleState}

-- function PlayerIdleState:enter(params)

--     self.starting = true
--     Timer.after(1,function() self.starting = false end)

-- end

function PlayerIdleState:update(dt)
    EntityIdleState.update(self, dt)

    -- local joysticks = love.joystick.getJoysticks()
    -- local joystick = joysticks[1]

    --For Joystick
    if #joysticks > 0 then
        if (joystick:isGamepadDown('dpdown','dpup','dpleft','dpright')
        or math.abs(joystick:getGamepadAxis("leftx")) == 1 or math.abs(joystick:getGamepadAxis("lefty")) == 1)  and not self.entity.afterFigthing  then
            self.entity:changeState('walk')
        end
        if joystick:isGamepadDown('a') then
            self.entity:changeState('slap')
        elseif joystick:isGamepadDown('x') then
            self.entity:changeState('knee-hit')
        end
    end

    if (love.keyboard.isDown('left','a','right','d','up','w','down','s')) and not self.entity.afterFigthing  then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('slap')
    elseif love.keyboard.wasPressed('k') then
        self.entity:changeState('knee-hit')
        --DEJO ESTO COMO GUIA PARA AGARRAR LOS OBJETOS Y LANZARLOS

    -- elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    --     -- look for the pot
    --     local takenPot = nil
    --     local potIdx = 0

    --     for k, obj in pairs(room.objects) do
    --         if obj.takeable then
    --             local playerY = self.entity.y + self.entity.height / 2
    --             local playerHeight = self.entity.height - self.entity.height / 2
    --             local playerXCenter = self.entity.x + self.entity.width / 2
    --             local playerYCenter = playerY + playerHeight / 2
    --             local playerCol = math.floor(playerXCenter / TILE_SIZE)
    --             local playerRow = math.floor(playerYCenter / TILE_SIZE)
    --             local objXCenter = obj.x + obj.width / 2
    --             local objYCenter = obj.y + obj.height / 2
    --             local objCol = math.floor(objXCenter / TILE_SIZE)
    --             local objRow = math.floor(objYCenter / TILE_SIZE)

    --             if (self.entity.direction == 'right') and (objRow == playerRow) and (objCol == (playerCol + 1)) then
    --                 takenPot = obj
    --                 potIdx = k
    --                 break
    --             end

    --             if (self.entity.direction == 'left') and (objRow == playerRow) and (objCol == (playerCol - 1)) then
    --                 takenPot = obj
    --                 potIdx = k
    --                 break
    --             end

    --             if (self.entity.direction == 'up') and (objCol == playerCol) and (objRow == (playerRow - 1)) then
    --                 takenPot = obj
    --                 potIdx = k
    --                 break
    --             end

    --             if (self.entity.direction == 'down') and (objCol == playerCol) and (objRow == (playerRow + 1)) then
    --                 takenPot = obj
    --                 potIdx = k
    --                 break
    --             end
    --         end
    --     end
    --     if takenPot ~= nil  then
    --         table.remove(room.objects, potIdx)
    --         self.entity:changeState('pot-lift', {
    --             pot = takenPot
    --         })
    --     end
    -- elseif love.keyboard.wasPressed('p') and self.entity.have_bow then
    --     self.entity:changeState('shoot-arrow')
    end
end