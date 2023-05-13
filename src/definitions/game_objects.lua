GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 16,
        width = 16,
        height = 16,
        solid = true,
        consumable = false,
        defaultState = 'default',
        takeable = true,
        states = {
            ['default'] = {
                frame = 16
            }
        }
    },
    -- definition of heart as a consumable object type
    ['heart'] = {
        type = 'heart',
        texture = 'heart',
        width = 13,
        height = 12,
        solid = false,
        consumable = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1,
                emptySpaces = {
                    0, 0, 0, 0
                },
            },
        },
        bottomCollisionDistance = 6,
        getBottom = function(self)
            return {
                x = math.floor(self.x),
                y = math.floor(self.y + 3*self.height/4),
                width = self.states[self.state].width or self.width
            }
        end,
        onConsume = function(player)
            player:heal(2)
            SOUNDS['heart-taken']:play()
        end,
    },
    -- definition of barrel as a solid object type
    ['barrel'] = {
        type = 'barrel',
        texture = 'barrel',
        width = 26,
        height = 36,
        solid = true,
        consumable = false,
        defaultState = 'default',
        takeable = true,
        states = {
            ['default'] = {
                frame = 1,
                emptySpaces = {
                    9, 4, 3, 2
                },
                width = 26,
                height = 36,
            },
            ['damaged'] = {
                frame = 2,
                emptySpaces = {
                    9, 2, 1, 1
                },
                width = 29,
                height = 38,
            },
            ['default-noshadow'] = {
                frame = 3,
                emptySpaces = {
                    9, 4, 3, 2
                },
                width = 26,
                height = 36,
            },
        },
        bottomCollisionDistance = 8,
        getBottom = function(self)
            return {
                x = math.floor(self.x),
                y = math.floor(self.y + 33),
                width = self.states[self.state].width or self.width
            }
        end,
    }
}
