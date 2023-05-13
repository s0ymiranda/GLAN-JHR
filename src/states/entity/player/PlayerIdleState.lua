PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player, projectiles)
    EntityIdleState.init(self, player)
    -- self.heldObjects = heldObjects
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

    if love.keyboard.isDown('left','a','right','d','up','w','down','s') and not self.entity.afterFigthing then
        self.entity:changeState('walk', {heldObject = self.heldObject})
        return
    end
    if love.keyboard.wasPressed('space') then
        self.entity:changeState('slap')
        return
    end
    if love.keyboard.wasPressed('k') then
        self.entity:changeState('knee-hit')
        return
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.heldObject then
            self.throwTimer = 0
            self.heldObject.xSpeed = 200 * (self.entity.direction == 'right' and 1 or -1)
            self.heldObject.ySpeed = 0
            self.heldObject.gravity = true
            self.heldObject.floor = self.entity.y + self.entity.height - 3 - self.heldObject.height
            table.insert(self.projectiles, self.heldObject)
            self.heldObject = nil
            self.entity:changeAnimation('throw-' .. self.entity.direction)
            self.entity.currentAnimation:refresh()
            return
        end
        -- look for the object
        local takenObject = nil
        local objectIdx = 0

        if #params.objects == 0 then
            goto no_object
        end

        local objects = params.objects
        table.sort(objects, function(a, b)
            if not a.takeable then
                return false
            end
            if not b.takeable then
                return true
            end
            local a_x = a.x + a.width / 2
            local b_x = b.x + b.width / 2
            local a_y = a.y + a.height
            local b_y = b.y + b.height
            return math.sqrt(a_x^2 + a_y^2) < math.sqrt(b_x^2 + b_y^2)
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

        self.entity:changeState('pickup', {heldObject = closestObject, playerPreviousState = 'idle'})
        -- objects[k].state = 'damaged'
        -- if takenObject ~= nil  then
        --     table.remove(params.objects, objectIdx)
        --     self.entity:changeState('pot-lift', {
        --         pot = takenObject
        --     })
        -- end
        return
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
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 0, 255))
    love.graphics.line(math.floor(player_bottom.x), math.floor(player_bottom.y), math.floor(player_bottom.x + player_bottom.width), math.floor(player_bottom.y))
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end