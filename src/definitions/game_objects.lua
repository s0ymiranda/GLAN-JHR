GAME_OBJECT_DEFS = {
    -- definition of first-aid-kit as a consumable object type
    ['first-aid-kit'] = {
        type = 'first-aid-kit',
        texture = 'first-aid-kit',
        width = 20,
        height = 20,
        solid = false,
        consumable = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1,
                emptySpaces = {
                    2, 0, 0, 0
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
            player:heal(50)
            -- SOUNDS['heal']:play()
        end,
    },
    ['small-first-aid-kit'] = {
        type = 'small-first-aid-kit',
        texture = 'small-first-aid-kit',
        width = 12,
        height = 12,
        solid = false,
        consumable = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1,
                emptySpaces = {
                    2, 0, 0, 0
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
            player:heal(5)
            -- SOUNDS['heal']:play()
        end,
    },
    ['bush'] = {
        type = 'bush',
        texture = 'bush',
        width = 67,
        height = 68,
        solid = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
            }
        }
    },
    ['light'] = {
        type = 'light',
        texture = 'light',
        width = 53,
        height = 140,
        solid = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
            }
        }
    },
    ['bus'] = {
        type = 'bus',
        texture = 'bus',
        width = 268,
        height = 120,
        solid = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
            }
        }
    },
    ['bus-sign'] = {
        type = 'bus-sign',
        texture = 'bus-sign',
        width = 28,
        height = 99,
        solid = false,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
            }
        }
    },
    ['sushi'] = {
        type = 'sushi',
        texture = 'sushi',
        width = 16,
        height = 45,
        solid = false,
        defaultState = 'off',
        states = {
            ['off'] = {
                frame = 1
            },
            ['on'] = {
                frame = 2
            }
        }
    },
    ['cafe'] = {
        type = 'cafe',
        texture = 'cafe',
        width = 73,
        height = 21,
        solid = false,
        defaultState = 'off',
        states = {
            ['off'] = {
                frame = 1
            },
            ['on'] = {
                frame = 2
            }
        }
    },
    ['neon'] = {
        type = 'neon',
        texture = 'neon',
        width = 76,
        height = 21,
        solid = false,
        defaultState = 'off',
        states = {
            ['off'] = {
                frame = 1
            },
            ['on'] = {
                frame = 2
            }
        }
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
        damage = 2,
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
