EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity

    --if entity ~= nil then self.entity:changeAnimation('idle-' .. self.entity.direction) end
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0
end

function EntityIdleState:processAI(params, dt)
    -- TODO: add punches
    local room = params.room
    if self.dialogElapsedTime == nil then
        local distance = math.sqrt((self.entity.x - room.player.x)^2 + (self.entity.y - room.player.y)^2)
        if distance < 500 then
            local message = CATCALLING_MESSAGES[math.random(#CATCALLING_MESSAGES)]
            self.dialog = Dialog(self.entity.x + self.entity.width/2, self.entity.y - 1, message)
            self.displayDialog = true
            self.dialogElapsedTime = 0
        end
    elseif self.displayDialog then
        self.dialogElapsedTime = self.dialogElapsedTime + dt
        if self.dialogElapsedTime > 3 then
            self.displayDialog = false
        end
    end
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
            self.entity:changeState('walk', {
                dialogElapsedTime = self.dialogElapsedTime,
                dialog = self.dialog,
                displayDialog = self.displayDialog,
            })
        end
    end
end

function EntityIdleState:processAIFighting(params, dt)
    -- TODO: add punches

    if self.entity ~= nil then
        if not self.entity.punching then
            self:processAI(params, dt)
        else
            if self.waitDuration == 0 then
                self.waitTimer = 0
                while self.waitDuration < 0.2 do
                    self.waitDuration = math.random()
                end
            end
            self.waitTimer = self.waitTimer + dt
            if self.waitTimer > self.waitDuration then
                self.waitTimer = 0
                self.waitDuration = 0
                self.entity.punching = false
                self.entity:changeState('punch', {
                    dialogElapsedTime = self.dialogElapsedTime,
                    dialog = self.dialog,
                    displayDialog = self.displayDialog,
                })
            end
        end
    end
end

function EntityIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

    love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end