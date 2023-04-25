PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.camera = Camera {}
    
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = 0 ,
        y = VIRTUAL_HEIGHT / 2 ,
        
        width = 32,
        height = 73,
        
        -- one_heart == 2 health
        health = 6,
        
        -- rendering and collision offset for spaced sprites
        offsetY = 0
    }
    
    -- local xHB_P, yHB_P
    -- xHB_P = self.player.x

    self.healthBar = ProgressBar {
        x = 0 + 10,
        y = 0 + 10,
        width = 64,
        height = 12,
        color = {r = 189, g = 32, b = 32},
        value = self.player.health,
        max = self.player.health,
        showDetails = true,
        title = 'Health'
    }
    self.respectBar = ProgressBar {
        x = 0 + 10,
        y = 0 + self.healthBar.y + self.healthBar.height + 10,
        width = 64,
        height = 12,
        color = {r = 128, g = 128, b = 128},
        value = self.player.respect,
        max = self.player.respect,
        showDetails = true,
        title = 'Respect'
    }
    -- self.dungeon = Dungeon(self.player)

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['idle'] = function() return PlayerIdleState(self.player, self.dungeon) end
        -- ['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        -- ['pot-lift'] = function() return PlayerPotLiftState(self.player, self.dungeon) end,
        -- ['pot-idle'] = function() return PlayerPotIdleState(self.player, self.dungeon) end,
        -- ['pot-walk'] = function() return PlayerPotWalkState(self.player, self.dungeon) end
    }
    self.player:changeState('idle')

    SOUNDS['dungeon-music']:setLooping(true)
    SOUNDS['dungeon-music']:play()
end

function PlayState:exit()
    SOUNDS['dungeon-music']:stop()
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('p') then
        stateMachine:change('pause')
    end
    if love.keyboard.wasPressed('g') then
        stateMachine:change('game-over')
    end
    if love.keyboard.wasPressed('o') then
        stateMachine:change('win')
    end
    -- self.dungeon:update(dt)
    -- self.player.currentAnimation:update(dt)
    self.player:update(dt)

    -- print(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2))
    self.camera.x = math.floor(math.min(math.floor(math.max(0,self.player.x + self.player.width/2 - VIRTUAL_WIDTH/2)),math.floor(VIRTUAL_WIDTH*3)))
    --self.camera.y = math.floor(math.max(0,self.player.y + self.player.height/2 - VIRTUAL_HEIGHT/2))

    self.healthBar:setValue(self.player.health)
    --self.healthBar:setPosition(math.floor(math.max(10,self.player.x - self.player.width/2 - VIRTUAL_WIDTH/2 + 26)), math.floor(math.max(10,self.player.y - self.player.height/2 - VIRTUAL_HEIGHT/2 + 32)))
    self.healthBar:setPosition(math.floor(math.max(10,self.player.x - self.player.width/2 - VIRTUAL_WIDTH/2 + self.player.width + 10)), 10)
    self.healthBar:update()
    self.respectBar:setValue(self.player.respect)
    --self.respectBar:setPosition(math.floor(math.max(10,self.player.x - self.player.width/2 - VIRTUAL_WIDTH/2 + 26)), self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:setPosition(math.floor(math.max(10,self.player.x - self.player.width/2 - VIRTUAL_WIDTH/2 + self.player.width + 10)), self.healthBar.y + self.healthBar.height + 10)
    self.respectBar:update()
    -- self.camera.x = math.max(0,math.min(self.player.x + 8 - VIRTUAL_WIDTH / 2, 16 - VIRTUAL_WIDTH))
    -- self.camera.y = math.max(
    --     0,
    --     math.min(
    --         self.player.y + 10 - VIRTUAL_HEIGHT / 2,
    --         16 - VIRTUAL_HEIGHT
    --     )
    -- )
    
end

function PlayState:render()
    -- -- render dungeon and all entities separate from hearts GUI
    -- love.graphics.push()
    -- self.dungeon:render()
    -- love.graphics.pop()

    -- -- draw player hearts, top of screen
    -- local healthLeft = self.player.health
    -- local heartFrame = 1

    -- for i = 1, 3 do
    --     if healthLeft > 1 then
    --         heartFrame = 5
    --     elseif healthLeft == 1 then
    --         heartFrame = 3
    --     else
    --         heartFrame = 1
    --     end

    --     love.graphics.draw(TEXTURES['hearts'], FRAMES['hearts'][heartFrame],
    --         (i - 1) * (TILE_SIZE + 1), 2)

    --     healthLeft = healthLeft - 2
    -- end

    -- love.graphics.draw(TEXTURES['bg-play'], 0, 0, 0,
    -- VIRTUAL_WIDTH / TEXTURES['bg-play']:getWidth(),
    -- VIRTUAL_HEIGHT / TEXTURES['bg-play']:getHeight())
    self.camera:set()
        --love.graphics.draw(TEXTURES['bg-play'],0,0,0)
        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)
        self.player:render()
        self.healthBar:render()
        self.respectBar:render()
    self.camera:unset()
end
