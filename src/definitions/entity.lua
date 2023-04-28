ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        animations = {
           ['walk-left'] = {
                frames = {12,11,10,11},
                interval = 0.20,
                texture = 'Hero'
            },
            ['walk-right'] = {
                frames = {5,6,7,6},
                interval = 0.20,
                texture = 'Hero'
            },

            ['walk-up-left'] = {
                frames = {12,11,10,11},
                interval = 0.20,
                texture = 'Hero'
            },
            ['walk-up-right'] = {
                frames = {5,6,7,6},
                interval = 0.20,
                texture = 'Hero'
            },

            ['walk-down-left'] = {
                frames = {12,11,10,11},
                interval = 0.20,
                texture = 'Hero'
            },
            ['walk-down-right'] = {
                frames = {5,6,7,6},
                interval = 0.20,
                texture = 'Hero'
            },

            ['walk-down'] = {
                frames = {1},
                --interval = 0.15,
                texture = 'Hero'
            },
            ['walk-up'] = {
                frames = {1},
                --interval = 0.15,
                texture = 'Hero'
            },
            ['idle-left'] = {
                frames = {1},
                texture = 'Hero'
            },
            ['idle-right'] = {
                frames = {2},
                texture = 'Hero'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'Hero'
            },
            ['idle-up'] = {
                frames = {1},
                texture = 'Hero'
            },
            -- ['walk-left'] = {
            --     frames = {13, 14, 15, 16},
            --     interval = 0.155,
            --     texture = 'character-walk'
            -- },
            -- ['walk-right'] = {
            --     frames = {5, 6, 7, 8},
            --     interval = 0.15,
            --     texture = 'character-walk'
            -- },
            -- ['walk-down'] = {
            --     frames = {1, 2, 3, 4},
            --     interval = 0.15,
            --     texture = 'character-walk'
            -- },
            -- ['walk-up'] = {
            --     frames = {9, 10, 11, 12},
            --     interval = 0.15,
            --     texture = 'character-walk'
            -- },
            -- ['idle-left'] = {
            --     frames = {13},
            --     texture = 'character-walk'
            -- },
            -- ['idle-right'] = {
            --     frames = {5},
            --     texture = 'character-walk'
            -- },
            -- ['idle-down'] = {
            --     frames = {1},
            --     texture = 'character-walk'
            -- },
            -- ['idle-up'] = {
            --     frames = {9},
            --     texture = 'character-walk'
            -- },
            ['slap-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.05,
                looping = false,
                texture = 'Hero'
            },
            ['slap-right'] = {
                frames = {20, 19, 18, 17},
                interval = 0.05,
                looping = false,
                texture = 'Hero'
            },
            ['sword-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-up'] = {
                frames = {5, 6, 7, 8},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['pot-lift-down'] = {
                frames = {1, 2, 3},
                interval = 0.1,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['pot-lift-right'] = {
                frames = {4, 5, 6},
                interval = 0.1,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['pot-lift-up'] = {
                frames = {7, 8, 9},
                interval = 0.1,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['pot-lift-left'] = {
                frames = {10, 11, 12},
                interval = 0.1,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['pot-walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'character-pot-walk'
            },
            ['pot-walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                texture = 'character-pot-walk'
            },
            ['pot-walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                texture = 'character-pot-walk'
            },
            ['pot-walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.15,
                texture = 'character-pot-walk'
            },
            ['pot-idle-down'] = {
                frames = {1},
                texture = 'character-pot-walk'
            },
            ['pot-idle-right'] = {
                frames = {5},
                texture = 'character-pot-walk'
            },
            ['pot-idle-up'] = {
                frames = {9},
                texture = 'character-pot-walk'
            },
            ['pot-idle-left'] = {
                frames = {13},
                texture = 'character-pot-walk'
            }
        }
    },
    ['enemy'] = {
        walkSpeed = 60,
        animations = {
           ['walk-left'] = {
                frames = {1},
                --interval = 0.155,
                texture = 'enemy-walk'
            },
            ['walk-right'] = {
                frames = {1},
                --interval = 0.15,
                texture =  'enemy-walk'
            },
            ['walk-down'] = {
                frames = {1},
                --interval = 0.15,
                texture =  'enemy-walk'
            },
            ['walk-up'] = {
                frames = {1},
                --interval = 0.15,
                texture =  'enemy-walk'
            },
            ['idle-left'] = {
                frames = {1},
                texture = 'enemy-walk'
            },
            ['idle-right'] = {
                frames = {1},
                texture =  'enemy-walk'
            },
            ['idle-down'] = {
                frames = {1},
                texture =  'enemy-walk'
            },
            ['idle-up'] = {
                frames = {1},
                texture =  'enemy-walk'
            },
        }
    }
}