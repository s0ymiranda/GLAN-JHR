ENTITY_DEFS = {
    ['player'] = {
        health = 100,
        walkSpeed = 70,
        animations = {
            ['win'] = {
                frames = { 1, 2, 3, 4 },
                interval = 0.20,
                looping = true,
                texture = 'character-win'
            },
            ['walk-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-up-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-down-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character-walk'
            },

            ['held-walk-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character-held'
            },
            ['held-walk-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-held'
            },
            ['held-walk-up-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character-held'
            },
            ['held-walk-up-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-held'
            },
            ['held-walk-down-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character-held'
            },
            ['held-walk-down-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character-held'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'character-walk'
            },
            ['idle-left-mad'] = {
                frames = { 4 },
                texture = 'character-walk'
            },
            ['idle-right-mad'] = {
                frames = { 3 },
                texture = 'character-walk'
            },

            ['held-idle-left'] = {
                frames = { 9 },
                texture = 'character-held'
            },
            ['held-idle-right'] = {
                frames = { 10 },
                texture = 'character-held'
            },

            ['slap-left'] = {
                frames = { 4, 3, 2, 1 },
                interval = 0.06,
                looping = false,
                texture = 'character-slap'
            },
            ['slap-right'] = {
                frames = { 5, 6, 7, 8 },
                interval = 0.06,
                looping = false,
                texture = 'character-slap'
            },
            ['knee-hit-left'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.12,
                looping = false,
                texture = 'character-knee-hit'
            },
            ['knee-hit-right'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.12,
                looping = false,
                texture = 'character-knee-hit'
            },
            ['falling'] = {
                frames = { 2, 3 },
                interval = 0.20,
                looping = false,
                texture = 'character-pick-up'
            },
            ['defeated'] = {
                frames = { 1, 2, 3, 4, 3, 2 },
                interval = 0.30,
                looping = true,
                texture = 'character-defeated'
            },
            ['dodge-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.12,
                looping = false,
                texture = 'character-dodge'
            },
            ['dodge-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.12,
                looping = false,
                texture = 'character-dodge'
            },

            ['pick-up-left'] = {
                frames = { 1, 2, 3, 2, 1 },
                interval = 0.12,
                looping = false,
                texture = 'character-pick-up'
            },
            ['pick-up-right'] = {
                frames = { 4, 5, 6, 5, 4 },
                interval = 0.12,
                looping = false,
                texture = 'character-pick-up'
            },

            ['throw-left'] = {
                frames = { 1 },
                texture = 'character-pick-up'
            },
            ['throw-right'] = {
                frames = { 4 },
                texture = 'character-pick-up'
            },
        }
    },
    ['player2'] = {
        health = 100,
        walkSpeed = 70,
        animations = {
            ['win'] = {
                frames = { 1, 2, 3, 4 },
                interval = 0.20,
                looping = true,
                texture = 'character2-win'
            },
            ['win-reverse'] = {
                frames = { 3, 4, 1, 2 },
                interval = 0.20,
                looping = true,
                texture = 'character2-win'
            },
            ['walk-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-walk'
            },
            ['walk-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character2-walk'
            },
            ['walk-up-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character2-walk'
            },
            ['walk-down-left'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 11, 12, 11 },
                interval = 0.20,
                texture = 'character2-walk'
            },

            ['held-walk-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character2-held'
            },
            ['held-walk-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-held'
            },
            ['held-walk-up-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character2-held'
            },
            ['held-walk-up-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-held'
            },
            ['held-walk-down-left'] = {
                frames = { 1, 3, 4, 3 },
                interval = 0.20,
                texture = 'character2-held'
            },
            ['held-walk-down-right'] = {
                frames = { 5, 7, 8, 7 },
                interval = 0.20,
                texture = 'character2-held'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'character2-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'character2-walk'
            },
            ['idle-left-mad'] = {
                frames = { 4 },
                texture = 'character2-walk'
            },
            ['idle-right-mad'] = {
                frames = { 3 },
                texture = 'character2-walk'
            },

            ['held-idle-left'] = {
                frames = { 9 },
                texture = 'character2-held'
            },
            ['held-idle-right'] = {
                frames = { 10 },
                texture = 'character2-held'
            },

            ['slap-left'] = {
                frames = { 4, 3, 2, 1 },
                interval = 0.06,
                looping = false,
                texture = 'character2-slap'
            },
            ['slap-right'] = {
                frames = { 5, 6, 7, 8 },
                interval = 0.06,
                looping = false,
                texture = 'character2-slap'
            },
            ['knee-hit-left'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.12,
                looping = false,
                texture = 'character2-knee-hit'
            },
            ['knee-hit-right'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.12,
                looping = false,
                texture = 'character2-knee-hit'
            },
            ['falling'] = {
                frames = { 2, 3 },
                interval = 0.20,
                looping = false,
                texture = 'character2-pick-up'
            },
            ['defeated'] = {
                frames = { 1, 2, 3, 4, 3, 2 },
                interval = 0.30,
                looping = true,
                texture = 'character2-defeated'
            },
            ['dodge-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.12,
                looping = false,
                texture = 'character2-dodge'
            },
            ['dodge-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.12,
                looping = false,
                texture = 'character2-dodge'
            },

            ['pick-up-left'] = {
                frames = { 1, 2, 3, 2, 1 },
                interval = 0.12,
                looping = false,
                texture = 'character2-pick-up'
            },
            ['pick-up-right'] = {
                frames = { 4, 5, 6, 5, 4 },
                interval = 0.12,
                looping = false,
                texture = 'character2-pick-up'
            },

            ['throw-left'] = {
                frames = { 1 },
                texture = 'character2-pick-up'
            },
            ['throw-right'] = {
                frames = { 4 },
                texture = 'character2-pick-up'
            },
        }
    },
    ['boss'] = {
        walkSpeed = 80,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3 },
                interval = 0.25,
                texture = 'Boss-walk'
            },
            ['walk-right'] = {
                frames = { 5, 6, 7 },
                interval = 0.25,
                texture = 'Boss-walk'
            },

            ['walk-up-left'] = {
                frames = { 1, 2, 3 },
                interval = 0.25,
                texture = 'Boss-walk'
            },
            ['walk-up-right'] = {
                frames = { 5, 6, 7 },
                interval = 0.25,
                texture = 'Boss-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3 },
                interval = 0.25,
                texture = 'Boss-walk'
            },
            ['walk-down-right'] = {
                frames = { 5, 6, 7 },
                interval = 0.25,
                texture = 'Boss-walk'
            },

            ['idle-left'] = {
                frames = { 9, 10, 11, 12, 11, 10 },
                interval = 0.5,
                looping = true,
                texture = 'Boss-walk'
            },
            ['idle-right'] = {
                frames = { 13, 14, 15, 16, 15, 14 },
                looping = true,
                interval = 0.8,
                texture = 'Boss-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'Boss-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'Boss-punch'
            },
            ['spank-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'Boss-spank'
            },
            ['spank-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'Boss-spank'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'Boss-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'Boss-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'Boss-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'Boss-dead'
            },
        }
    },
    ['npc0'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'Npc0-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'Npc0-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'Npc0-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'Npc0-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'Npc0-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'Npc0-dead'
            },
            ['cinematic-spank'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'Npc0-spank-cinematic'
            },
        }
    },
    ['npc0-blackskin-blond'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blackskin-blond-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blackskin-blond-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-blond-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-blond-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blackskin-blond-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blackskin-blond-dead'
            },
        }
    },
    ['npc0-blackskin-blond-noglasses'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blackskin-blond-noglasses-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-blond-noglasses-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blackskin-blond-noglasses-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blackskin-blond-noglasses-dead'
            },
        }
    },
    ['npc0-blackskin-whiteclothes'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blackskin-whiteclothes-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blackskin-whiteclothes-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blackskin-whiteclothes-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blackskin-whiteclothes-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blackskin-whiteclothes-dead'
            },
        }
    },
    ['npc0-blond'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blond-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blond-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blond-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blond-dead'
            },
        }
    },
    ['npc0-blond-chinese'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-chinese-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blond-chinese-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blond-chinese-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-chinese-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-chinese-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-chinese-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-chinese-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blond-chinese-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blond-chinese-dead'
            },
        }
    },
    ['npc0-blond-noglasses'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-noglasses-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blond-noglasses-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blond-noglasses-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-noglasses-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-noglasses-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-noglasses-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-noglasses-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blond-noglasses-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blond-noglasses-dead'
            },
        }
    },
    ['npc0-blond-otherclothes'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['walk-up-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-up-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['walk-down-left'] = {
                frames = { 8, 7, 5, 7 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['walk-down-right'] = {
                frames = { 9, 10, 12, 10 },
                interval = 0.20,
                texture = 'npc0-blond-otherclothes-walk'
            },

            ['idle-left'] = {
                frames = { 1 },
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['idle-right'] = {
                frames = { 2 },
                texture = 'npc0-blond-otherclothes-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-otherclothes-punch'
            },
            ['punch-right'] = {
                frames = { 4, 3, 4 },
                interval = 0.30,
                looping = false,
                texture = 'npc0-blond-otherclothes-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-otherclothes-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc0-blond-otherclothes-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc0-blond-otherclothes-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc0-blond-otherclothes-dead'
            },
        }
    },
    ['npc1-0'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-0-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-0-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-0-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-0-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-0-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-0-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-0-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-0-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-0-dead'
            },
        }
    },
    ['npc1-1'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-1-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-1-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-1-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-1-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-1-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-1-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-1-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-1-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-1-dead'
            },
        }
    },
    ['npc1-2'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-2-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-2-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-2-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-2-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-2-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-2-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-2-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-2-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-2-dead'
            },
        }
    },
    ['npc1-3'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-3-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-3-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-3-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-3-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-3-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-3-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-3-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-3-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-3-dead'
            },
        }
    },
    ['npc1-4'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-4-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-4-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-4-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-4-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-4-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-4-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-4-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-4-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-4-dead'
            },
        }
    },
    ['npc1-5'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-5-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-5-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-5-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-5-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-5-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-5-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-5-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-5-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-5-dead'
            },
        }
    },
    ['npc1-6'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-6-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-6-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-6-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-6-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-6-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-6-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-6-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-6-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-6-dead'
            },
        }
    },
    ['npc1-7'] = {
        walkSpeed = 60,
        animations = {
            ['walk-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['walk-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['walk-up-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['walk-up-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['walk-down-left'] = {
                frames = { 1, 2, 3, 2 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['walk-down-right'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.20,
                texture = 'npc1-7-walk'
            },
            ['idle-left'] = {
                frames = { 2 },
                texture = 'npc1-7-walk'
            },
            ['idle-right'] = {
                frames = { 4 },
                texture = 'npc1-7-walk'
            },
            ['punch-left'] = {
                frames = { 1, 2, 1 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-7-punch'
            },
            ['punch-right'] = {
                frames = { 3, 4, 3 },
                interval = 0.30,
                looping = false,
                texture = 'npc1-7-punch'
            },
            ['die-left'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-7-dead'
            },
            ['die-right'] = {
                frames = { 6, 7, 8, 9, 10 },
                interval = 0.12,
                looping = false,
                texture = 'npc1-7-dead'
            },
            ['dead-left'] = {
                frames = { 5 },
                texture = 'npc1-7-dead'
            },
            ['dead-right'] = {
                frames = { 10 },
                texture = 'npc1-7-dead'
            },
        }
    },
}
