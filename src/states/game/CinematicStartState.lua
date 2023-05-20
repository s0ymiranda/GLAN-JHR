CinematicStartState = Class{__includes = BaseState}

function CinematicStartState:init(params)
    self.spawnCooldown = 0
    self.spawnTimer = 0
    self.textAnimations = {alpha = {value = 0, render = true}}
    Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 255}})
    Timer.after(2, function() Timer.tween(1.5, {[self.textAnimations.alpha] = {value = 0}}) end)
    Timer.after(3.5, function() self.textAnimations.alpha.render = false end)
    self.pervert= Entity {
        animations = ENTITY_DEFS['npc0'].animations,
        walkSpeed = ENTITY_DEFS['npc0'].walkSpeed or 20,

        x = VIRTUAL_WIDTH + 10 ,
        y = VIRTUAL_HEIGHT/2,

        width = 24,
        height = 75,

        health = 30,
    }

    self.pervert.stateMachine = StateMachine {
        ['idle'] = function() return EntityIdleState(self.pervert) end,
        ['walk'] = function() return EntityIdleState(self.pervert) end,
        ['dead'] = function() return EntityDeadState(self.pervert) end
    }
    self.pervert.direction = 'left'
    self.pervert:changeState('walk')
    self.pervert:changeAnimation('walk-left')
end

function CinematicStartState:exit()
    self.pervert.stateMachine.current.entity = nil
    self.pervert = nil
end

function CinematicStartState:enter(params)
   
    self.camera = params.camera
    self.objects = params.objects
    self.dayNumber = params.dayNumber
    self.players = params.players
    SOUNDS['scenary-music']:play()
    
    self.player = self.players[1]
    self.player2 = self.players[2]

    self.twoPlayers = false
    if self.player2 ~= nil then
        self.twoPlayers = true
    end
 

    for k, player in pairs(self.players) do
        player:changeAnimation('walk-right')
    end
    
    self:Player1Animation()

    self:Player2Animation()

    self:PervertAnimation()

    Timer.after(10,function ()
        stateMachine:change('play',{player = self.player,objects = self.objects, dayNumber = self.dayNumber,isANewDay = false, player2 = self.player2, twoPlayers = self.twoPlayers, cinematicDone = true})
    end)
end

function CinematicStartState:update(dt)
    for k, player in pairs(self.players) do
        player:onlyAnimation(dt)
    end
    self.pervert:onlyAnimation(dt)
end


function CinematicStartState:render()
    self.camera:set()

        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

        local to_render = {}
        for k, player in pairs(self.players) do
            table.insert(to_render, player)
            if player.displayDialog then
                player.dialog:render()
            end
        end
        if not self.pervert.dead then
            table.insert(to_render, self.pervert)
        end
        
        for _, object in pairs(self.objects) do
            table.insert(to_render, object)
        end
        
        table.sort(to_render, function(a, b)
            return a.y + a.height < b.y + b.height
        end)
        
        for _, entity in pairs(to_render) do
            entity:render()
        end
        if self.pervert.displayDialog then
            self.pervert.dialog:render()
        end

        if self.textAnimations.alpha.render then
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.textAnimations.alpha.value))
            love.graphics.setFont(FONTS['large'])
            love.graphics.printf(WEEK_DAYS[1], self.camera.x, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
        end

    self.camera:unset()
end

function CinematicStartState:Player1Animation()
    Timer.tween(5, {
        [self.player] = {
            x = VIRTUAL_WIDTH/3
    }})
    Timer.after(5, 
    function() 
        self.player:changeAnimation('idle-left-mad')
        Timer.after(2.5, function() 
            self.player:changeAnimation('idle-right-mad')
            local message = 'I am not going to deal whit this anymore'
            self.player.dialog = Dialog(self.player.x + self.player.width/2, self.player.y - 1, message)
            self.player.displayDialog = true
            self.player.dialogElapsedTime = 2
            Timer.after(2, function() self.player.displayDialog = false end)
        end)
        Timer.after(3.5, function() self.player:changeAnimation('idle-right') end)
    end)

end
function CinematicStartState:Player2Animation()
    if self.player2 ~= nil then
        Timer.tween(5, {
            [self.player2] = {
                x = VIRTUAL_WIDTH/3 - 40, 
                y = VIRTUAL_HEIGHT/2 + 10
        }})
        Timer.after(5, 
        function() 
            self.player2:changeAnimation('idle-left-mad')
            Timer.after(3, function() 
                self.player2:changeAnimation('idle-right-mad')
                local message = 'What a jerk'
                self.player2.dialog = Dialog(self.player2.x + self.player2.width/2, self.player2.y - 1, message)
                self.player2.displayDialog = true
                self.player2.dialogElapsedTime = 2
                Timer.after(2, function() self.player2.displayDialog = false end)
            end)
            Timer.after(4, function() self.player2:changeAnimation('idle-right') end)
        end)
    end
end
function CinematicStartState:PervertAnimation()
    Timer.tween(5, {
        [self.pervert] = {
            x = VIRTUAL_WIDTH/3 + 10
        }})
    Timer.after(5, function() 
        self.pervert.x = self.pervert.x - 2
        local message = 'Come baby'
        self.pervert.dialog = Dialog(self.pervert.x + self.pervert.width/2, self.pervert.y - 1, message)
        self.pervert.displayDialog = true
        self.pervert.dialogElapsedTime = 2
        self.pervert:changeAnimation('cinematic-spank')
        SOUNDS['hero-damage']:stop()
        SOUNDS['hero-damage']:play()
        SOUNDS['spank']:stop()
        SOUNDS['spank']:play()
        Timer.after(1,function()
            self.pervert.x = self.pervert.x + 2
            self.pervert.displayDialog = false
            self.pervert:changeAnimation('walk-left') 
            Timer.tween(4,{
                [self.pervert] = {
                    x = -40
                }
            }) 
        end)
    end)
end