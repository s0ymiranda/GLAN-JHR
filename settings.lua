Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Camera'
require 'src/Animation'
require 'src/Entity'
require 'src/Hitbox'
require 'src/Player'
require 'src/StateMachine'
require 'src/GameObject'
require 'src/utils'

require 'src/definitions/entity'
require 'src/definitions/game_objects'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityPunchState'
require 'src/states/entity/EntityDeadState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSlapState'
require 'src/states/entity/player/PlayerKneeHitState'
require 'src/states/entity/player/PlayerPickUpState'
require 'src/states/entity/player/PlayerDodgeState'
require 'src/states/entity/player/PlayerCinematicState'

require 'src/states/entity/boss/BossIdleState'
require 'src/states/entity/boss/BossWalkState'
require 'src/states/entity/boss/BossDeadState'
require 'src/states/entity/boss/BossSpankState'
require 'src/states/entity/boss/BossPunchState'

require 'src/states/game/GameOverState'
require 'src/states/game/WinState'
require 'src/states/game/PlayState'
require 'src/states/game/PauseState'
require 'src/states/game/CinematicState'
require 'src/states/game/StartState'

require 'src/utilities/quads'

require 'src/gui/Dialog'
require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/ProgressBar'
require 'src/gui/Selection'

joysticks = love.joystick.getJoysticks()
if #joysticks > 0 then
    joystick = joysticks[1]
else
    joystick = false
end

NUMBER_OF_BARRELS = 10

VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 324

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_TITLE = 'Jitsugyouka: Home Road'
TILE_SIZE = 16

FIRST_AID_KIT_DROP_PROBABILITY = 0.9
GRAVITY = 500

ENTITY_INVULNERABILITY_TIME = 1

CATCALLING_MESSAGES = {
    "So many curves and me with no brakes",
    "I could stare at you all day",
    "Nice legs, what time do they open?",
    "Hey baby, why don't you come over and show me a good time?",
    "Hey sweetheart, I bet you'd look even better without those clothes on",
    "I'd like to mop you up, baby",
    "Hey baby, you got a boyfriend?",
    "What's your hurry, babe?",
    "*Wolf whistle*",
}

WEEK_DAYS = {
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
}

-- map constants

MAP_WIDTH = VIRTUAL_WIDTH*8
MAP_HEIGHT = VIRTUAL_HEIGHT

TEXTURES = {
    --Cursor
    ['cursor-right'] = love.graphics.newImage('graphics/cursor.png'),
    --Hero
    ['character-walk'] = love.graphics.newImage('graphics/Hero/Walk-Hero.png'),
    ['character-slap'] = love.graphics.newImage('graphics/Hero/Slap-Hero.png'),
    ['character-knee-hit'] = love.graphics.newImage('graphics/Hero/KneeHit-Hero.png'),
    ['character-held'] = love.graphics.newImage('graphics/Hero/Held-Hero.png'),
    ['character-pick-up'] = love.graphics.newImage('graphics/Hero/PickUp-Hero.png'),
    ['character-defeated'] = love.graphics.newImage('graphics/Hero/Defeated-Hero.png'),
    ['character-dodge'] = love.graphics.newImage('graphics/Hero/Dodge-Hero.png'),
    ['character-win'] = love.graphics.newImage('graphics/Hero/Win-Hero.png'),

    --Hero2
    ['character2-walk'] = love.graphics.newImage('graphics/Hero2/Walk-Hero2.png'),
    ['character2-slap'] = love.graphics.newImage('graphics/Hero2/Slap-Hero2.png'),
    ['character2-knee-hit'] = love.graphics.newImage('graphics/Hero2/KneeHit-Hero2.png'),
    ['character2-held'] = love.graphics.newImage('graphics/Hero2/Held-Hero2.png'),
    ['character2-pick-up'] = love.graphics.newImage('graphics/Hero2/PickUp-Hero2.png'),
    ['character2-defeated'] = love.graphics.newImage('graphics/Hero2/Defeated-Hero2.png'),
    ['character2-dodge'] = love.graphics.newImage('graphics/Hero2/Dodge-Hero2.png'),
    ['character2-win'] = love.graphics.newImage('graphics/Hero2/Win-Hero2.png'),

    --Background
    ['background'] = love.graphics.newImage('graphics/Background/background.png'),
    ['cloud1'] = love.graphics.newImage('graphics/Background/cloud1.png'),
    ['estructure1'] = love.graphics.newImage('graphics/Background/edificio1.png'),
    ['cloud2'] = love.graphics.newImage('graphics/Background/cloud2.png'),
    ['estructure2'] = love.graphics.newImage('graphics/Background/edificio2.png'),

    --Scenary
    ['scenary'] = love.graphics.newImage('graphics/Scenary.png'),

    --Npc0
    ['npc0-walk'] = love.graphics.newImage('graphics/Npc0/Walk-Npc0.png'),
    ['Npc0-punch'] = love.graphics.newImage('graphics/Npc0/Punch-Npc0.png'),
    ['Npc0-dead'] = love.graphics.newImage('graphics/Npc0/dead-Npc0.png'),

    --Npc1
    ['npc1-walk'] = love.graphics.newImage('graphics/Npc1/Walk-Npc1.png'),
    ['npc1-punch'] = love.graphics.newImage('graphics/Npc1/Punch-Npc1.png'),
    ['npc1-dead'] = love.graphics.newImage('graphics/Npc1/dead-npc1.png'),

    --Adding the NPC0 Versions
    ['npc0-blackskin-blond-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond/Walk-Npc0-BlackSkin-Blond.png'),
    ['npc0-blackskin-blond-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond/Punch-Npc0-BlackSkin-Blond.png'),
    ['npc0-blackskin-blond-dead'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond/Dead-Npc0-BlackSkin-Blond.png'),

    ['npc0-blackskin-blond-noglasses-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond-NoGlasses/Walk-Npc0-BlackSkin-Blond-NoGlasses.png'),
    ['npc0-blackskin-blond-noglasses-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond-NoGlasses/Punch-Npc0-BlackSkin-Blond-NoGlasses.png'),
    ['npc0-blackskin-blond-noglasses-dead'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond-NoGlasses/Dead-Npc0-BlackSkin-Blond-NoGlasses.png'),

    ['npc0-blackskin-whiteclothes-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-WhiteClothes/Walk-Npc0-BlackSkin-WhiteClothes.png'),
    ['npc0-blackskin-whiteclothes-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-WhiteClothes/Punch-Npc0-BlackSkin-WhiteClothes.png'),
    ['npc0-blackskin-whiteclothes-dead'] = love.graphics.newImage('graphics/Npc0-BlackSkin-WhiteClothes/Dead-Npc0-BlackSkin-WhiteClothes.png'),

    ['npc0-blond-walk'] = love.graphics.newImage('graphics/Npc0-Blond/Walk-Npc0-Blond.png'),
    ['npc0-blond-punch'] = love.graphics.newImage('graphics/Npc0-Blond/Punch-Npc0-Blond.png'),
    ['npc0-blond-dead'] = love.graphics.newImage('graphics/Npc0-Blond/Dead-Npc0-Blond.png'),

    ['npc0-blond-chinese-walk'] = love.graphics.newImage('graphics/Npc0-Blond-Chinese/Walk-Npc0-Blond-Chinese.png'),
    ['npc0-blond-chinese-punch'] = love.graphics.newImage('graphics/Npc0-Blond-Chinese/Punch-Npc0-Blond-Chinese.png'),
    ['npc0-blond-chinese-dead'] = love.graphics.newImage('graphics/Npc0-Blond-Chinese/Dead-Npc0-Blond-Chinese.png'),

    ['npc0-blond-noglasses-walk'] = love.graphics.newImage('graphics/Npc0-Blond-NoGlasses/Walk-Npc0-Blond-NoGlasses.png'),
    ['npc0-blond-noglasses-punch'] = love.graphics.newImage('graphics/Npc0-Blond-NoGlasses/Punch-Npc0-Blond-NoGlasses.png'),
    ['npc0-blond-noglasses-dead'] = love.graphics.newImage('graphics/Npc0-Blond-NoGlasses/Dead-Npc0-Blond-NoGlasses.png'),

    ['npc0-blond-otherclothes-walk'] = love.graphics.newImage('graphics/Npc0-Blond-OtherClothes/Walk-Npc0-Blond-OtherClothes.png'),
    ['npc0-blond-otherclothes-punch'] = love.graphics.newImage('graphics/Npc0-Blond-OtherClothes/Punch-Npc0-Blond-OtherClothes.png'),
    ['npc0-blond-otherclothes-dead'] = love.graphics.newImage('graphics/Npc0-Blond-OtherClothes/Dead-Npc0-Blond-OtherClothes.png'),

    --Boss
    ['Boss-walk'] = love.graphics.newImage('graphics/Sumo-Boss/walk-Sumo.png'),
    ['Boss-punch'] = love.graphics.newImage('graphics/Sumo-Boss/Punch-Sumo.png'),
    ['Boss-spank'] = love.graphics.newImage('graphics/Sumo-Boss/spank-Sumo.png'),
    ['Boss-dead'] = love.graphics.newImage('graphics/Sumo-Boss/Dead-Sumo.png'),

    -- Game objects
    ['first-aid-kit'] = love.graphics.newImage('graphics/Game-Objects/first-aid-kit.png'),
    ['bus'] = love.graphics.newImage('graphics/Game-Objects/bus.png'),
    ['bus-sign'] = love.graphics.newImage('graphics/Game-Objects/Bus-sign.png'),
    ['light'] = love.graphics.newImage('graphics/Game-Objects/light.png'),
    ['bush'] = love.graphics.newImage('graphics/Game-Objects/bush.png'),
    ['sushi'] = love.graphics.newImage('graphics/Game-Objects/Sushi.png'),
    ['cafe'] = love.graphics.newImage('graphics/Game-Objects/Cafe.png'),
    ['neon'] = love.graphics.newImage('graphics/Game-Objects/NeonSign.png'),
    ['barrel'] = love.graphics.newImage('graphics/Game-Objects/barrel.png'),
}


FRAMES = {
    ['character-walk'] = generateQuads(TEXTURES['character-walk'], 24, 73),
    ['character-slap'] = generateQuads(TEXTURES['character-slap'], 32, 73),
    ['character-knee-hit'] = generateQuads(TEXTURES['character-knee-hit'], 32, 73),
    ['character-held'] = generateQuads(TEXTURES['character-held'], 24, 73),
    ['character-pick-up'] = generateQuads(TEXTURES['character-pick-up'], 32, 73),
    ['character-defeated'] = generateQuads(TEXTURES['character-defeated'], 32, 57),
    ['character-dodge'] = generateQuads(TEXTURES['character-dodge'], 39, 73),
    ['character-win'] = generateQuads(TEXTURES['character-win'], 38, 73),

    ['character2-walk'] = generateQuads(TEXTURES['character2-walk'], 24, 73),
    ['character2-slap'] = generateQuads(TEXTURES['character2-slap'], 32, 73),
    ['character2-knee-hit'] = generateQuads(TEXTURES['character2-knee-hit'], 32, 73),
    ['character2-held'] = generateQuads(TEXTURES['character2-held'], 24, 73),
    ['character2-pick-up'] = generateQuads(TEXTURES['character2-pick-up'], 32, 73),
    ['character2-defeated'] = generateQuads(TEXTURES['character2-defeated'], 32, 57),
    ['character2-dodge'] = generateQuads(TEXTURES['character2-dodge'], 39, 73),
    ['character2-win'] = generateQuads(TEXTURES['character2-win'], 38, 73),

    ['npc0-walk'] = generateQuads(TEXTURES['npc0-walk'], 25, 75),
    ['Npc0-punch'] = generateQuads(TEXTURES['Npc0-punch'], 35, 75),
    ['Npc0-dead'] = generateQuads(TEXTURES['Npc0-dead'], 75, 75),

    ['npc1-walk'] = generateQuads(TEXTURES['npc1-walk'], 25, 74),
    ['npc1-punch'] = generateQuads(TEXTURES['npc1-punch'], 32, 74),
    ['npc1-dead'] = generateQuads(TEXTURES['npc1-dead'], 74, 74),

    --Adding the NPC0 Versions
    ['npc0-blackskin-blond-walk'] = generateQuads(TEXTURES['npc0-blackskin-blond-walk'], 25, 75),
    ['npc0-blackskin-blond-punch'] = generateQuads(TEXTURES['npc0-blackskin-blond-punch'], 35, 75),
    ['npc0-blackskin-blond-dead'] = generateQuads(TEXTURES['npc0-blackskin-blond-dead'], 75, 75),

    ['npc0-blackskin-blond-noglasses-walk'] = generateQuads(TEXTURES['npc0-blackskin-blond-noglasses-walk'], 25, 75),
    ['npc0-blackskin-blond-noglasses-punch'] = generateQuads(TEXTURES['npc0-blackskin-blond-noglasses-punch'], 35, 75),
    ['npc0-blackskin-blond-noglasses-dead'] = generateQuads(TEXTURES['npc0-blackskin-blond-noglasses-dead'], 75, 75),

    ['npc0-blackskin-whiteclothes-walk'] = generateQuads(TEXTURES['npc0-blackskin-whiteclothes-walk'], 25, 75),
    ['npc0-blackskin-whiteclothes-punch'] = generateQuads(TEXTURES['npc0-blackskin-whiteclothes-punch'], 35, 75),
    ['npc0-blackskin-whiteclothes-dead'] = generateQuads(TEXTURES['npc0-blackskin-whiteclothes-dead'], 75, 75),

    ['npc0-blond-walk'] = generateQuads(TEXTURES['npc0-blond-walk'], 25, 75),
    ['npc0-blond-punch'] = generateQuads(TEXTURES['npc0-blond-punch'], 35, 75),
    ['npc0-blond-dead'] = generateQuads(TEXTURES['npc0-blond-dead'], 75, 75),

    ['npc0-blond-chinese-walk'] = generateQuads(TEXTURES['npc0-blond-chinese-walk'], 25, 75),
    ['npc0-blond-chinese-punch'] = generateQuads(TEXTURES['npc0-blond-chinese-punch'], 35, 75),
    ['npc0-blond-chinese-dead'] = generateQuads(TEXTURES['npc0-blond-chinese-dead'], 75, 75),

    ['npc0-blond-noglasses-walk'] = generateQuads(TEXTURES['npc0-blond-noglasses-walk'], 25, 75),
    ['npc0-blond-noglasses-punch'] = generateQuads(TEXTURES['npc0-blond-noglasses-punch'], 35, 75),
    ['npc0-blond-noglasses-dead'] = generateQuads(TEXTURES['npc0-blond-noglasses-dead'], 75, 75),

    ['npc0-blond-otherclothes-walk'] = generateQuads(TEXTURES['npc0-blond-otherclothes-walk'], 25, 75),
    ['npc0-blond-otherclothes-punch'] = generateQuads(TEXTURES['npc0-blond-otherclothes-punch'], 35, 75),
    ['npc0-blond-otherclothes-dead'] = generateQuads(TEXTURES['npc0-blond-otherclothes-dead'], 75, 75),

    --Boss
    ['Boss-walk'] = generateQuads(TEXTURES['Boss-walk'], 37, 84),
    ['Boss-punch'] = generateQuads(TEXTURES['Boss-punch'], 45, 84),
    ['Boss-spank'] = generateQuads(TEXTURES['Boss-spank'], 39, 84),
    ['Boss-dead'] = generateQuads(TEXTURES['Boss-dead'], 84, 84),

    -- Game objects
    ['first-aid-kit'] = generateQuads(TEXTURES['first-aid-kit'], 20, 20),
    ['barrel'] = generateQuads(TEXTURES['barrel'], 32, 48),
    ['sushi'] = generateQuads(TEXTURES['sushi'], 16, 45),
    ['cafe'] = generateQuads(TEXTURES['cafe'], 73, 21),
    ['neon'] = generateQuads(TEXTURES['neon'], 76, 21),
}


FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {
    ['start-music'] = love.audio.newSource('sounds/blood_of_villain.mp3', 'static'),
    ['dungeon-music'] = love.audio.newSource('sounds/scenary_music.mp3', 'static'),
    ['game-over-music'] = love.audio.newSource('sounds/hollow_knight.mp3', 'static'),
    ['win-music'] = love.audio.newSource('sounds/win_music.mp3', 'static'),
    ['UOFF'] = love.audio.newSource('sounds/UOFF.mp3', 'static'),
    ['hero-damage'] = love.audio.newSource('sounds/hero_damage.wav', 'static'),
    ['dead'] = love.audio.newSource('sounds/dead.mp3', 'static'),
    ['miss'] = love.audio.newSource('sounds/miss.mp3', 'static'),
    ['slap'] = love.audio.newSource('sounds/slap.mp3', 'static'),
    ['knee-hit'] = love.audio.newSource('sounds/knee_hit.mp3', 'static'),
    ['punch-eco'] = love.audio.newSource('sounds/punch_eco.mp3', 'static'),
    ['dodge'] = love.audio.newSource('sounds/dodge.mp3', 'static'),
    ['blip'] = love.audio.newSource('sounds/blip.wav', 'static'),
    ['boss_music'] = love.audio.newSource('sounds/the_dark_one.mp3', 'static'),
    ['end_day_music'] = love.audio.newSource('sounds/end_day_music.mp3', 'static'),
    ['bus'] = love.audio.newSource('sounds/bus.mp3', 'static'),
    ['spank'] = love.audio.newSource('sounds/spank.mp3', 'static')
}
