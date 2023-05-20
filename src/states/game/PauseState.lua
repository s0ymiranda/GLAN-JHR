PauseState = Class{__includes = BaseState}

function PauseState:enter(def)

    self.player = def.player
    self.camera = def.camera
    self.entities = def.entities
    self.objects = def.objects
    self.projectiles = def.projectiles
    self.signs = def.signs
    self.dayNumber = def.dayNumber
    self.player2 = def.player2
    self.twoPlayers = def.twoPlayers
    self.boss = def.boss

    self.controllerButtoms = {a = false, x = false, start = false}
    self.pauseMenu = Menu {
        x = VIRTUAL_WIDTH/2 - 64 -32 + self.camera.x,
        y = VIRTUAL_HEIGHT/2 + 50,
        width = 128+64,
        height = 60,
        current_selection = last_selection,
        items = {
            {
                text = 'Resumen Game',
                onSelect = function()
                    stateMachine:change('play',{
                        player = self.player,
                        camera = self.camera,
                        entities = self.entities,
                        objects = self.objects,
                        projectiles = self.projectiles,
                        signs = self.signs,
                        dayNumber = self.dayNumber,
                        twoPlayers = self.twoPlayers,
                        player2 = self.player2,
                        boss = self.boss,
                })
                end
            },
            {
                text = 'Go to Title Screen',
                onSelect = function()
                    stateMachine:change('start')
                end
            },
            {
                text = 'Exit Game',
                onSelect = function()
                    love.event.quit()
                end
            }
        }
    }

    self.music = def.music

    self.pauseMenu.panel:toggle()

    SOUNDS['pause']:stop()
    SOUNDS['pause']:play()
    SOUNDS[self.music]:setVolume(0.5)
    SOUNDS[self.music]:play()
end

function PauseState:exit()
    SOUNDS['pause']:stop()
    SOUNDS['pause']:play()
    SOUNDS[self.music]:setVolume(1)
end

function PauseState:update(dt)
    self.pauseMenu:update(dt)
end

function PauseState:render()
    self.camera:set()
        love.graphics.draw(TEXTURES['scenary'], 0, 0, 0)

        local to_render = {self.player}
        local corpses = {}
        if self.player2 ~= nil then
            table.insert(to_render, self.player2)
        end
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
        for _, object in pairs(self.projectiles) do
            table.insert(to_render, object)
        end
        for _, sign in pairs(self.signs) do
            table.insert(to_render, sign)
        end
        if self.boss ~= nil then
            if self.boss.dead then
                table.insert(corpses, self.boss)
            else
                table.insert(to_render, self.boss)
            end
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

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
        love.graphics.setFont(FONTS['large'])
        love.graphics.printf("GAME PAUSED", self.camera.x, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
        self.pauseMenu:render(dt)
    self.camera:unset()
end
