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

require 'src/definitions/entity'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityPunchState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSlapState'

require 'src/states/game/GameOverState'
require 'src/states/game/WinState'
require 'src/states/game/PlayState'
require 'src/states/game/PauseState'
require 'src/states/game/StartState'

require 'src/utilities/quads'

require 'src/gui/Dialog'
require 'src/gui/ProgressBar'

VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 324

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_TITLE = 'Jitsugyouka: Home Road'
TILE_SIZE = 16

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


-- map constants


MAP_WIDTH = VIRTUAL_WIDTH*4
MAP_HEIGHT = VIRTUAL_HEIGHT

TEXTURES = {

    --Hero
    ['character-walk'] = love.graphics.newImage('graphics/Hero/Walk-Hero.png'),
    ['character-slap'] = love.graphics.newImage('graphics/Hero/Slap-Hero.png'),
    
    --Npc0
    ['enemy-walk'] = love.graphics.newImage('graphics/Npc0/Walk-Npc0.png'),
    ['Npc0-punch'] = love.graphics.newImage('graphics/Npc0/Punch-Npc0.png'),

    --Background1
    ['background'] = love.graphics.newImage('graphics/background.png'),
    
    --Background2
    ['scenary'] = love.graphics.newImage('graphics/Scenary-testing.png')
}


FRAMES = {
    ['character-walk'] = generateQuads(TEXTURES['character-walk'], 24, 73),
    ['character-slap'] = generateQuads(TEXTURES['character-slap'], 32, 73),
    ['enemy-walk'] = generateQuads(TEXTURES['enemy-walk'], 25, 75),
    ['Npc0-punch'] = generateQuads(TEXTURES['Npc0-punch'], 35, 75)
}


FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {

    ['start-music'] = love.audio.newSource('sounds/blood_of_villain.mp3', 'static'),
    ['dungeon-music'] = love.audio.newSource('sounds/scenary_music.mp3', 'static'),
    ['game-over-music'] = love.audio.newSource('sounds/game_over_music.mp3', 'static'),
    ['win-music'] = love.audio.newSource('sounds/win_music.mp3', 'static'),
    ['UOFF'] = love.audio.newSource('sounds/UOFF.mp3', 'static'),
    ['hero-damage'] = love.audio.newSource('sounds/hero_damage.wav', 'static'),
    ['dead'] = love.audio.newSource('sounds/dead.mp3', 'static'),
    ['miss'] = love.audio.newSource('sounds/miss.mp3', 'static'),
    ['slap'] = love.audio.newSource('sounds/slap.mp3', 'static')
}
