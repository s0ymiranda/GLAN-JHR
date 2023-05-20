StartState = Class { __includes = BaseState }

function StartState:init()
    SOUNDS['scenary-music']:stop()
    SOUNDS['start-music']:setLooping(true)
    SOUNDS['start-music']:play()
    self.last_selection = 1

    self.cloud1_x = -50
    self.cloud2_x = 0

    if #joysticks > 0 then
        self.startMenu = Menu {
            x = VIRTUAL_WIDTH / 2 - 64,
            y = VIRTUAL_HEIGHT / 2 + 50,
            width = 128,
            height = 60,
            current_selection = last_selection,
            items = {
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play', { isANewDay = true })
                    end
                },
                {
                    text = 'Two Players',
                    onSelect = function()
                        stateMachine:change('play', { twoPlayers = true, isANewDay = true })
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
    else
        self.startMenu = Menu {
            x = VIRTUAL_WIDTH / 2 - 64,
            y = VIRTUAL_HEIGHT / 2 + 50,
            width = 128,
            height = 60,
            current_selection = last_selection,
            items = {
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play', { isANewDay = true })
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
    end

    self.startMenu.panel:toggle()

    self.timer = 0
end

function StartState:exit()
    SOUNDS['start-music']:stop()
end

function StartState:update(dt)
    self.timer = self.timer + dt
    if self.timer >= 0.05 then
        self.timer = 0
        self.cloud1_x = self.cloud1_x + 0.04
        self.cloud2_x = self.cloud2_x + 0.08
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    --For Joystick
    if #joysticks > 0 then
        self.startMenu.selection.items = {
            {
                text = 'One Player',
                onSelect = function()
                    stateMachine:change('play', { isANewDay = true })
                end
            },
            {
                text = 'Two Players',
                onSelect = function()
                    stateMachine:change('play', { twoPlayers = true, isANewDay = true })
                end
            },
            {
                text = 'Exit Game',
                onSelect = function()
                    love.event.quit()
                end
            }
        }
    else
        joysticks = love.joystick.getJoysticks()
        if #joysticks > 0 then
            joystick = joysticks[1]
            self.startMenu.selection.items = {
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play', { isANewDay = true })
                    end
                },
                {
                    text = 'Two Players',
                    onSelect = function()
                        stateMachine:change('play', { twoPlayers = true, isANewDay = true })
                    end
                },
                {
                    text = 'Exit Game',
                    onSelect = function()
                        love.event.quit()
                    end
                }
            }
        end
    end
    self.startMenu:update(dt)
end

function StartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    love.graphics.draw(TEXTURES['cloud1'], self.cloud1_x, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['cloud1']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['cloud1']:getHeight())

    love.graphics.draw(TEXTURES['estructure1'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['estructure1']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['estructure1']:getHeight())

    love.graphics.draw(TEXTURES['cloud2'], self.cloud2_x, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['cloud2']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['cloud2']:getHeight())

    love.graphics.draw(TEXTURES['estructure2'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['estructure2']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['estructure2']:getHeight())


    love.graphics.setFont(FONTS['medium'])

    love.graphics.setColor(love.math.colorFromBytes(34, 34, 34, 255))
    love.graphics.printf(GAME_TITLE, 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(255, 127, 0, 255))
    love.graphics.printf(GAME_TITLE, 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))

    self.startMenu:render()
end
