PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player, projectiles)
    EntityIdleState.init(self, player)
    self.projectiles = projectiles
end

function PlayerIdleState:enter(params)
    if params and params.heldObject then
        self.entity:changeAnimation('held-idle-' .. self.entity.direction)
        self.heldObject = params.heldObject
        local heldObjectState = self.heldObject:getCurrentState()
        self.heldObject.x = self.entity.x + 12 - heldObjectState.width / 2
        self.heldObject.y = self.entity.y - heldObjectState.height + 3
    end
end

function PlayerIdleState:update(dt, params)
    EntityIdleState.update(self, dt)

    if self.throwTimer then
        self.throwTimer = self.throwTimer + dt
        if self.throwTimer >= 0.2 then
            table.insert(self.projectiles, self.heldObject)
            self.throwTimer = nil
            self.entity:changeAnimation('idle-' .. self.entity.direction)
        end
    end

    --For Joystick
    if #joysticks > 0 and (self.entity.numOfPlayersInGame == 1 or self.entity.playerNum == 2) then
        if (joystick:isGamepadDown('dpdown','dpup','dpleft','dpright')
        or math.abs(joystick:getGamepadAxis("leftx")) == 1 or math.abs(joystick:getGamepadAxis("lefty")) == 1)  and not self.entity.afterFigthing  then
            self.entity:changeState('walk', {heldObject = self.heldObject})
        end
        if self.heldObject then
            if joystick:isGamepadDown('leftshoulder') then
                self.throwTimer = 0
                self.heldObject.xSpeed = 200 * (self.entity.direction == 'right' and 1 or -1)
                self.heldObject.ySpeed = 0
                self.heldObject.gravity = true
                self.heldObject.floor = self.entity.y + self.entity.height
                --self.heldObject.z = self.player.z
                table.insert(self.projectiles, self.heldObject)
                self.heldObject = nil
                self.entity:changeAnimation('throw-' .. self.entity.direction)
                self.entity.currentAnimation:refresh()
            end
            -- return
        end
        if joystick:isGamepadDown('a') and not self.heldObject then
            self.entity:changeState('slap')
        elseif joystick:isGamepadDown('x') and not self.heldObject then
            self.entity:changeState('knee-hit')
        elseif joystick:isGamepadDown('rightshoulder') and not self.heldObject then
            self.entity:changeState('dodge')
        elseif joystick:isGamepadDown('leftshoulder') then
            if #params.objects == 0 then
                goto no_object
            end

            local objects = params.objects
            local entityX = self.entity.x + self.entity.width / 2
            local entityY = self.entity.y + self.entity.height
            table.sort(objects, function(a, b)
                if not a.takeable then
                    return false
                end
                if not b.takeable then
                    return true
                end
                local aXDist = math.abs(a.x + a.width / 2 - entityX)
                local bXDist = math.abs(b.x + b.width / 2 - entityX)
                local aYDist = math.abs(a.y + a.height - entityY)
                local bYDist = math.abs(b.y + b.height - entityY)
                return math.sqrt(aXDist^2 + aYDist^2) < math.sqrt(bXDist^2 + bYDist^2)
            end)
            local closestObject = objects[1]
            if not closestObject.takeable then
                goto no_object
            end
            local player_bottom = {
                x = self.entity.x,
                y = self.entity.y + self.entity.height - 2,
                width = self.entity.width
            }
            if not BottomCollision(player_bottom, closestObject.getBottom(closestObject), closestObject.bottomCollisionDistance) then
                goto no_object
            end

            table.remove(objects, 1)

            self.entity:changeState('pick-up', {heldObject = closestObject, playerPreviousState = 'idle'})
            -- objects[k].state = 'damaged'
            -- if takenObject ~= nil  then
            --     table.remove(params.objects, objectIdx)
            --     self.entity:changeState('pot-lift', {
            --         pot = takenObject
            --     })
            -- end
            return
        end
    end
    if self.entity.playerNum == 1 then
        if love.keyboard.isDown('left','a','right','d','up','w','down','s') and not self.entity.afterFigthing then
            self.entity:changeState('walk', {heldObject = self.heldObject})
            return
        end
        if self.heldObject then
            if love.keyboard.wasPressed('i') then
                self.throwTimer = 0
                self.heldObject.xSpeed = 200 * (self.entity.direction == 'right' and 1 or -1)
                self.heldObject.ySpeed = 0
                self.heldObject.gravity = true
                self.heldObject.floor = self.entity.y + self.entity.height
                --self.heldObject.z = self.player.z
                table.insert(self.projectiles, self.heldObject)
                self.heldObject = nil
                self.entity:changeAnimation('throw-' .. self.entity.direction)
                self.entity.currentAnimation:refresh()
            end
            return
        end
        if love.keyboard.wasPressed('j') then
            self.entity:changeState('slap')
            return
        end
        if love.keyboard.wasPressed('k') then
            self.entity:changeState('knee-hit')
            return
        end
        if love.keyboard.wasPressed('l') then
            self.entity:changeState('dodge')
            return
        end
        if love.keyboard.wasPressed('i') then
            if #params.objects == 0 then
                goto no_object
            end

            local objects = params.objects
            local entityX = self.entity.x + self.entity.width / 2
            local entityY = self.entity.y + self.entity.height

            local nilObjectsPositions = {}
            for k, v in pairs(objects) do
                if not v then
                    if SHOW_STDOUT then
                        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> NIL OBJECT")
                        print(k, v)
                    end
                    table.insert(nilObjectsPositions, k)
                end
            end
            for _, v in pairs(nilObjectsPositions) do
                table.remove(objects, v)
            end
            table.sort(objects, function(a, b)
                if not a.takeable then
                    return false
                end
                if not b.takeable then
                    return true
                end
                local aXDist = math.abs(a.x + a.width / 2 - entityX)
                local bXDist = math.abs(b.x + b.width / 2 - entityX)
                local aYDist = math.abs(a.y + a.height - entityY)
                local bYDist = math.abs(b.y + b.height - entityY)
                return math.sqrt(aXDist^2 + aYDist^2) < math.sqrt(bXDist^2 + bYDist^2)
            end)
            local closestObject = objects[1]
            if not closestObject.takeable then
                goto no_object
            end
            local player_bottom = {
                x = self.entity.x,
                y = self.entity.y + self.entity.height - 2,
                width = self.entity.width
            }
            if not BottomCollision(player_bottom, closestObject.getBottom(closestObject), closestObject.bottomCollisionDistance) then
                goto no_object
            end

            table.remove(objects, 1)

            self.entity:changeState('pick-up', {heldObject = closestObject, playerPreviousState = 'idle'})
            return
        end
    end
    ::no_object::
end

function PlayerIdleState:render()
    EntityIdleState.render(self)
    if self.heldObject then
        self.heldObject:render()
    end
    local player_bottom = {
        x = self.entity.x,
        y = self.entity.y + self.entity.height - 2,
        width = self.entity.width
    }
end