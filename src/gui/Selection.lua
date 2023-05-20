Selection = Class {}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width

    self.showCursor = def.showCursor == nil or def.showCursor

    self.font = def.font or FONTS['medium']

    self.gapHeight = self.height / #self.items

    self.currentSelection = def.current_selection or 1

    self.alpha = def.alpha or 255

    self.controllerButtoms = { a = false, x = false, start = false, up = false, down = false }
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end

        SOUNDS['blip']:stop()
        SOUNDS['blip']:play()
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end

        SOUNDS['blip']:stop()
        SOUNDS['blip']:play()
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()

        SOUNDS['blip']:stop()
        SOUNDS['blip']:play()
    elseif #joysticks > 0 then
        if joystick:isGamepadDown('dpup') then
            self.controllerButtoms.up = true
        elseif self.controllerButtoms.up then
            if self.currentSelection == 1 then
                self.currentSelection = #self.items
            else
                self.currentSelection = self.currentSelection - 1
            end
            SOUNDS['blip']:stop()
            SOUNDS['blip']:play()
            self.controllerButtoms.up = false
        elseif joystick:isGamepadDown('dpdown') then
            self.controllerButtoms.down = true
        elseif self.controllerButtoms.down then
            if self.currentSelection == #self.items then
                self.currentSelection = 1
            else
                self.currentSelection = self.currentSelection + 1
            end
            SOUNDS['blip']:stop()
            SOUNDS['blip']:play()
            self.controllerButtoms.down = false
        elseif joystick:isGamepadDown('a') then
            self.controllerButtoms.a = true
        elseif self.controllerButtoms.a then
            self.items[self.currentSelection].onSelect()
            SOUNDS['blip']:stop()
            SOUNDS['blip']:play()
            self.controllerButtoms.a = false
        end
    end
end

function Selection:render()
    love.graphics.setFont(self.font)
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.currentSelection and self.showCursor then
            love.graphics.draw(TEXTURES['cursor-right'], math.max(self.width / 3, self.x - 8), paddedY)
        end

        love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, self.alpha))
        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, self.alpha))
        love.graphics.printf(self.items[i].text, self.x, paddedY - 2, self.width, 'center')
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))

        currentY = currentY + self.gapHeight
    end
end
