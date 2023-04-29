ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        animations = {
           ['walk-left'] = {
                frames = {5,7,8,7},
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = {9,11,12,11},
                interval = 0.20,
                texture = 'character-walk'
            },

            ['walk-up-left'] = {
                frames = {5,7,8,7},
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-up-right'] = {
                frames = {9,11,12,11},
                interval = 0.20,
                texture = 'character-walk'
            },

            ['walk-down-left'] = {
                frames = {5,7,8,7},
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-down-right'] = {
                frames = {9,11,12,11},
                interval = 0.20,
                texture = 'character-walk'
            },

            ['walk-down'] = {
                frames = {1},
                --interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-up'] = {
                frames = {1},
                --interval = 0.15,
                texture = 'character-walk'
            },
            ['idle-left'] = {
                frames = {1},
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture = 'character-walk'
            },
            -- ['idle-down'] = {
            --     frames = {1},
            --     texture = 'character-walk'
            -- },
            -- ['idle-up'] = {
            --     frames = {1},
            --     texture = 'character-walk'
            -- },
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
                frames = {4,3,2,1},
                interval = 0.06,
                looping = false,
                texture = 'character-slap'
            },
            ['slap-right'] = {
                frames = {5,6,7,8},
                interval = 0.06,
                looping = false,
                texture = 'character-slap'
            }
        }
    },
    ['enemy'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                --frames = {5,7,8,7},
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'enemy-walk'
            },
            ['walk-right'] = {
                --frames = {9,11,12,11},
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'enemy-walk'
            },
            
            ['walk-up-left'] = {
                --frames = {5,7,8,7},
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'enemy-walk'
            },
            ['walk-up-right'] = {
                --frames = {9,11,12,11},
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'enemy-walk'
            },

            ['walk-down-left'] = {
                --frames = {5,7,8,7},
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'enemy-walk'
            },
            ['walk-down-right'] = {
                --frames = {9,11,12,11},
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'enemy-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'enemy-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'enemy-walk'
            }
            -- ['idle-down'] = {
            --     frames = {1},
            --     texture =  'enemy-walk'
            -- },
            -- ['idle-up'] = {
            --     frames = {1},
            --     texture =  'enemy-walk'
            -- },
        }
    }
}
