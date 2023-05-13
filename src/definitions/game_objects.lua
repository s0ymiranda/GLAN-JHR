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
