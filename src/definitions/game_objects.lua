GAME_OBJECT_DEFS = {
   
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
                frame = 1
            }
        },
        onConsume = function(player)
            player:heal(2)
            SOUNDS['heart-taken']:play()
        end
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
        width = 29,
        height = 38,
        solid = true,
        consumable = false,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
            }
        },
        onConsume = function(player)
            player:heal(2)
            SOUNDS['heart-taken']:play()
        end
    }
}
