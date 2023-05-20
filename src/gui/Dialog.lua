Dialog = Class {}

function Dialog:init(centerX, bottomY, message)
    self.outlineWidth = 1
    self.margin = 1
    self.leading = 1
    self.font = FONTS['small']
    self.textHeight = self.font:getHeight()
    self:set(centerX, bottomY, message)
end

function Dialog:set(centerX, bottomY, message)
    self.textWidth, self.textChunks = self.font:getWrap(message, 70)
    self.width = self.textWidth + 2 * (self.outlineWidth + self.margin)
    self.height = (#self.textChunks - 1) * (self.textHeight + self.leading) + self.textHeight +
    2 * (self.outlineWidth + self.margin)
    self.x = math.floor(centerX - self.width / 2)
    self.y = math.floor(bottomY - self.height)
end

function Dialog:update(centerX, bottomY)
    self.x = math.floor(centerX - self.width / 2)
    self.y = math.floor(bottomY - self.height)
end

function Dialog:render()
    -- Layout
    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    love.graphics.rectangle('fill', self.x + self.outlineWidth, self.y + self.outlineWidth,
        self.width - 2 * self.outlineWidth, self.height - 2 * self.outlineWidth, 3)
    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))

    -- Text
    love.graphics.setFont(self.font)
    for i = 1, #self.textChunks do
        love.graphics.print(self.textChunks[i], self.x + self.outlineWidth + self.margin,
            self.y + self.outlineWidth + self.margin + (self.textHeight + self.leading) * (i - 1))
    end
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end
