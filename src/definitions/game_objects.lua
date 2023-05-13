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
    ['bus'] = {
        type = 'bus',
        texture = 'bus',
        width = 268,
        height = 120,
        solid = false,
        consumable = false,
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
        consumable = false,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 1
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
