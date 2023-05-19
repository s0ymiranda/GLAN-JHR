BossIdleState = Class{__includes = EntityIdleState}

function BossIdleState:init(entity)
    self.entity = entity

    --if entity ~= nil then self.entity:changeAnimation('idle-' .. self.entity.direction) end
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0

    -- self.objetive = nil
    -- self.objectiveAlreadyChosen = false
end

function BossIdleState:processAI(params, dt)
    local playState = params.PlayState
    local distance = math.sqrt((self.entity.x - playState.player.x)^2 + (self.entity.y - playState.player.y)^2)
    local distance2 = distance

    if playState.player2 ~= nil then
        distance2 = math.sqrt((self.entity.x - playState.player2.x)^2 + (self.entity.y - playState.player2.y)^2)
    end

    if distance < 200 or distance2 < 200 then
        self.entity.fighting = true
        playState.player.fighting = true
        if playState.player2 ~= nil then
            playState.player2.fighting = true
        end
        SOUNDS['scenary-music']:pause(true)
        SOUNDS['boss_music']:setLooping(true)
        SOUNDS['boss_music']:play()
    end
end

function BossIdleState:processAIFighting(params, dt)
    -- TODO: add punches
    if self.entity ~= nil then
        if not self.entity.punching then
            -- self:processAI(params, dt)
            self.entity:changeState('walk')
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
                if math.random() < 0.70 then
                    self.entity:changeState('punch', {
                        dialogElapsedTime = self.dialogElapsedTime,
                        dialog = self.dialog,
                        displayDialog = self.displayDialog,
                    })
                else
                    self.entity:changeState('spank', {
                        dialogElapsedTime = self.dialogElapsedTime,
                        dialog = self.dialog,
                        displayDialog = self.displayDialog,
                    })
                end
                return
            end
        end
    end
end

function BossIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))

    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end