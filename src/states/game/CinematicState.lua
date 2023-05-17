CinematicState = Class{__includes = BaseState}

function CinematicState:init(params)

end

function CinematicState:enter(params)
    self.camera = params.camera
    self.entities = params.entities
    self.objects = params.objects
    self.dayNumber = params.dayNumber
    self.players = params.players

    self.player = self.players[1]
    self.player2 = self.players[2]

    self.animationPrefix = 'walk-'
    for k, player in pairs(self.players) do
        player:changeAnimation(self.animationPrefix .. player.direction)
    end
    for k, player in pairs(self.players) do
        local y_destiny = VIRTUAL_HEIGHT*0.46 +10
        local x_destiny = MAP_WIDTH - 380
        if k == 2 then
            x_destiny = x_destiny - player.width - 10
        end
        Timer.tween(3, {
            [player] = {
                y = y_destiny,
                x = x_destiny
            }})
        Timer.after(3, function()
            player:changeAnimation('win')
        end)
    end
    for k, player in pairs(self.players) do
        Timer.after(6, function()
            player:changeAnimation(self.animationPrefix .. player.direction)
            Timer.tween(3, {
                [player] = {
                    y = VIRTUAL_HEIGHT*0.46 +10,
                    x = MAP_WIDTH - 200
                }})
        end)
    end
end

function CinematicState:update(dt)
    for k, player in pairs(self.players) do
        player:onlyAnimation(dt)
    end
    for k, entities in pairs(self.entities) do
        entities:processAI({PlayState = self},dt)
        entities:update(dt)
    end
    local player = self.players[1]
    local player2 = self.players[2]
    if player.x >=  MAP_WIDTH - 200  then
        player:changeState('idle')
        player.x = 0
        player.y = VIRTUAL_HEIGHT/2
        if self.dayNumber == 5 then
            stateMachine:change('win')
        else
            local twoPlayersMode = false
            if player2 ~= nil then
                player2:changeState('idle')
                twoPlayersMode = true
                player2.x = 0
                player2.y = VIRTUAL_HEIGHT/2 + 55
            end
            stateMachine:change('play',{player = player,dayNumber = self.dayNumber + 1,isANewDay = true, player2 = player2, twoPlayers = twoPlayersMode})
        end
    end
    if player2 ~= nil then
        self.camera.x = math.floor(math.min(math.floor(math.max(self.camera.x,math.floor((player.x + player.width/2 - VIRTUAL_WIDTH/2 + player2.x + player2.width/2 - VIRTUAL_WIDTH/2)/2))),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
    else
        self.camera.x = math.floor(math.min(math.floor(math.max(self.camera.x,player.x + player.width/2 - VIRTUAL_WIDTH/2)),math.floor(MAP_WIDTH-VIRTUAL_WIDTH)))
    end
end


function CinematicState:render()
    self.camera:set()

        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

        local to_render = {}
        for k, player in pairs(self.players) do
            table.insert(to_render, player)
        end

        local corpses = {}

        for _, entity in pairs(self.entities) do
            if entity.dead then
                table.insert(corpses, entity)
            else
                table.insert(to_render, entity)
            end
        end
        for _, object in pairs(self.objects) do
            table.insert(to_render, object)
        end

        table.sort(to_render, function(a, b)
            return a.y + a.height < b.y + b.height
        end)

        for _, corpse in pairs(corpses) do
            corpse:render()
        end

        for _, entity in pairs(to_render) do
            entity:render()
        end

    self.camera:unset()
end