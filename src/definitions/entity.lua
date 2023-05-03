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
            ['idle-left'] = {
                frames = {1},
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture = 'character-walk'
            },
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
            },
            ['knee-hit-left'] = {
                frames = {4,5,6,5},
                interval = 0.06,
                looping = false,
                texture = 'character-knee-hit'
            },
            ['knee-hit-right'] = {
                frames = {1,2,3,2},
                interval = 0.06,
                looping = false,
                texture = 'character-knee-hit'
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
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'Npc0-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'Npc0-punch'
            }
        }
    },
    ['npc0-blackskin-blond'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blackskin-blond-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blackskin-blond-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-punch'
            }
        }
    },
    ['npc0-blackskin-blond-noglasses'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blackskin-blond-noglasses-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-punch'
            }
        }
    },
    ['npc0-blackskin-whiteclothes'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blackskin-whiteclothes-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-punch'
            }
        }
    },
    ['npc0-blond'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blond-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blond-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-punch'
            }
        }
    },
    ['npc0-blond-chinese'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blond-chinese-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blond-chinese-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-chinese-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-chinese-punch'
            }
        }
    },
    ['npc0-blond-noglasses'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blond-noglasses-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blond-noglasses-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-noglasses-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-noglasses-punch'
            }
        }
    },
    ['npc0-blond-otherclothes'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['walk-up-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-up-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['walk-down-left'] = {
                frames = {8,7,5,7},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-down-right'] = {
                frames = {9,10,12,10},
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['idle-left'] = {
                frames = {1},
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['idle-right'] = {
                frames = {2},
                texture =  'npc0-blond-otherclothes-walk'
            },
            ['punch-left'] = {
                frames = {1,2,1},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-otherclothes-punch'
            },
            ['punch-right'] = {
                frames = {4,3,4},
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-otherclothes-punch'
            }
        }
    }

}
