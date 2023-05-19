WinState = Class{__includes = BaseState}

function WinState:init()
    SOUNDS['win-music']:play()
    if #joysticks > 0 then
        self.message = "Press A"
    else
        self.message = "Press Enter"
    end
    self.canInput = false
end

function WinState:enter(params)
    self.players = params.players

    if #self.players > 1 then
        self.players[1]:changeAnimation('win')
        self.players[2]:changeAnimation('win-reverse')
        self.players[1].x = VIRTUAL_WIDTH/2 - 25 - self.players[1].width/2 - 10
        self.players[1].y = VIRTUAL_HEIGHT/3 + 15
        self.players[2].x = VIRTUAL_WIDTH/2 + 25 - self.players[2].width/2 - 10
        self.players[2].y = VIRTUAL_HEIGHT/3 + 15
    else
        self.players[1]:changeAnimation('win')
        self.players[1].x = VIRTUAL_WIDTH/2 - self.players[1].width/2 - 10
        self.players[1].y = VIRTUAL_HEIGHT/3 + 15
    end

    self.alphas = {n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0}
    Timer.tween(2,
        {[self.alphas] = {
            n1 = 255,
            n2 = 0,
            n3 = 0,
            n4 = 0,
            n5 = 0,
    }})
    Timer.after(2,function()
        Timer.tween(2,
            {[self.alphas] = {
                n1 = 255,
                n2 = 255,
                n3 = 0,
                n4 = 0,
                n5 = 0,
        }})
    end)
    Timer.after(4,function()
        Timer.tween(2,
            {[self.alphas] = {
                n1 = 255,
                n2 = 255,
                n3 = 255,
                n4 = 0,
                n5 = 0,
        }})
    end)
    Timer.after(6,function()
        Timer.tween(2,
            {[self.alphas] = {
                n1 = 255,
                n2 = 255,
                n3 = 255,
                n4 = 255,
                n5 = 0,
        }})
    end)
    if #self.players == 1 then
        Timer.after(8,function() self.canInput = true end)
    else
        Timer.after(8,function()
            Timer.tween(2,
                {[self.alphas] = {
                    n1 = 255,
                    n2 = 255,
                    n3 = 255,
                    n4 = 255,
                    n5 = 255,
            }})
        end)
        Timer.after(10,function() self.canInput = true end)
    end

end

function WinState:exit()
    SOUNDS['win-music']:stop()
end

function WinState:update(dt)
    if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and self.canInput then
        stateMachine:change('start')
    end

    --For Joystick
    if #joysticks > 0 then
        if joystick:isGamepadDown('a') and self.canInput then
            stateMachine:change('start')
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    for k, player in pairs(self.players) do
        player:onlyAnimation(dt)
    end
end

function WinState:render()
    love.graphics.setFont(FONTS['large'])
    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf('YOU WIN!', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    if #self.players == 1 then
        love.graphics.setFont(FONTS['medium'])
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n1))
        love.graphics.printf("Perverts Defeated: " .. self.players[1].perverts_defeated, 0, self.players[1].y + self.players[1].height + 16, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n2))
        love.graphics.printf("Perverts Ignored: " .. self.players[1].perverts_passed, 0, self.players[1].y + self.players[1].height + 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n3))
        love.graphics.printf("Number of Blows to Innocent: " .. self.players[1].innocent_beaten, 0, self.players[1].y + self.players[1].height + 64, VIRTUAL_WIDTH, 'center')

        -- love.graphics.setFont(FONTS['small'])
        love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, self.alphas.n4))
        love.graphics.printf("Press Enter to Go to the Title Screen", 0, self.players[1].y + self.players[1].height + 96, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.setFont(FONTS['medium'])

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n1))
        love.graphics.printf("Player 1 - Akira:", 10, self.players[1].y + self.players[1].height + 8, VIRTUAL_WIDTH/2 - 10, 'center')
        love.graphics.printf("Player 2 - Kurohime:", VIRTUAL_WIDTH/2 , self.players[2].y + self.players[2].height + 8, VIRTUAL_WIDTH/2 - 10, 'center')

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n2))
        love.graphics.printf("Perverts Defeated: " .. self.players[1].perverts_defeated, 10, self.players[1].y + self.players[1].height + 32, VIRTUAL_WIDTH/2 - 10, 'center')
        love.graphics.printf("Perverts Defeated: " .. self.players[2].perverts_defeated, VIRTUAL_WIDTH/2 , self.players[2].y + self.players[2].height + 32, VIRTUAL_WIDTH/2 - 10, 'center')

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n3))
        love.graphics.printf("Perverts Ignored: " .. self.players[1].perverts_passed, 10, self.players[1].y + self.players[1].height + 56, VIRTUAL_WIDTH/2 - 10, 'center')
        love.graphics.printf("Perverts Ignored: " .. self.players[2].perverts_passed, VIRTUAL_WIDTH/2 , self.players[2].y + self.players[2].height + 56, VIRTUAL_WIDTH/2 - 10, 'center')

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alphas.n4))
        love.graphics.printf("Number of Blows\nto Innocent: " .. self.players[1].innocent_beaten, 10, self.players[1].y + self.players[1].height + 80, VIRTUAL_WIDTH/2 - 10, 'center')
        love.graphics.printf("Number of Blows\nto Innocent: " .. self.players[2].innocent_beaten, VIRTUAL_WIDTH/2 , self.players[2].y + self.players[2].height + 80, VIRTUAL_WIDTH/2 - 10, 'center')

        love.graphics.setFont(FONTS['small'])
        love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, self.alphas.n5))
        love.graphics.printf("Press Enter to Go\nto the Title Screen", 0, self.players[1].y + self.players[1].height + 90, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    for k, player in pairs(self.players) do
        player:render()
    end
end
