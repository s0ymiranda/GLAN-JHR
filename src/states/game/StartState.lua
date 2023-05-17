StartState = Class{__includes = BaseState}

function StartState:init()
    SOUNDS['start-music']:setLooping(true)
    SOUNDS['start-music']:play()
    self.last_selection = 1
    if #joysticks > 0 then
        -- self.message = "Press Start"
        self.startMenu = Menu {
            x = VIRTUAL_WIDTH/2 - 64,
            y = VIRTUAL_HEIGHT/2 + 50,
            width = 128,
            height = 60,
            current_selection = last_selection,
            items = {
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play',{isANewDay = true})
                    end
                },
                {
                    text = 'Two Players',
                    onSelect = function()
                        stateMachine:change('play',{twoPlayers = true, isANewDay = true})
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
        -- self.message = "Press Enter"
        self.startMenu = Menu {
            x = VIRTUAL_WIDTH/2 - 64,
            y = VIRTUAL_HEIGHT/2 + 50,
            width = 128,
            height = 60,
            current_selection = last_selection,
            items = {
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play',{isANewDay = true})
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
end

function StartState:exit()
    SOUNDS['start-music']:stop()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    --For Joystick
    if #joysticks > 0 then
        if joystick:isGamepadDown('start') then
            -- stateMachine:change('play',{})
        end
    else
        joysticks = love.joystick.getJoysticks()
        if #joysticks > 0 then
            joystick = joysticks[1]
            self.startMenu.selection.items ={
                {
                    text = 'One Player',
                    onSelect = function()
                        stateMachine:change('play',{isANewDay = true})
                    end
                },
                {
                    text = 'Two Players',
                    onSelect = function()
                        stateMachine:change('play',{twoPlayers = true, isANewDay = true})
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
            joystick = false
        end
    end
    self.startMenu:update(dt)
end

function StartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    love.graphics.setFont(FONTS['medium'])

    love.graphics.setColor(love.math.colorFromBytes(34, 34, 34, 255))
    love.graphics.printf(GAME_TITLE, 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf(GAME_TITLE, 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    -- love.graphics.setFont(FONTS['small'])
    -- love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')

    self.startMenu:render()
end