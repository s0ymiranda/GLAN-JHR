Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Camera'
require 'src/Animation'
require 'src/Entity'
-- require 'src/GameObject'
require 'src/Hitbox'
require 'src/Player'
-- require 'src/Projectile'
require 'src/StateMachine'

require 'src/definitions/entity'
-- require 'src/definitions/game_objects'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
-- require 'src/states/entity/player/PlayerSwingSwordState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSlapState'
-- require 'src/states/entity/player/PlayerPotLiftState'
-- require 'src/states/entity/player/PlayerPotIdleState'
-- require 'src/states/entity/player/PlayerPotWalkState'
-- require 'src/states/entity/player/PlayerShootArrowState'

require 'src/states/game/GameOverState'
require 'src/states/game/WinState'
require 'src/states/game/PlayState'
require 'src/states/game/PauseState'
require 'src/states/game/StartState'

require 'src/utilities/quads'

-- require 'src/world/Doorway'
-- require 'src/world/Dungeon'
-- require 'src/world/Room'

-- require 'src/world/Boss_Room'
-- require 'src/ProgressBar'

require 'src/gui/ProgressBar'

VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 324

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_TITLE = 'Jitsugyouka: Home Road'
TILE_SIZE = 16

-- --
-- -- map constants
-- --
-- MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 2
-- MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

MAP_WIDTH = VIRTUAL_WIDTH*4
MAP_HEIGHT = VIRTUAL_HEIGHT

--MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
--MAP_RENDER_OFFSET_Y = VIRTUAL_HEIGHT*0.6

-- --
-- -- tile IDs
-- --
-- TILE_TOP_LEFT_CORNER = 4
-- TILE_TOP_RIGHT_CORNER = 5
-- TILE_BOTTOM_LEFT_CORNER = 23
-- TILE_BOTTOM_RIGHT_CORNER = 24

-- TILE_EMPTY = 19

-- TILE_FLOORS = {
--     7, 8, 9, 10, 11, 12, 13,
--     26, 27, 28, 29, 30, 31, 32,
--     45, 46, 47, 48, 49, 50, 51,
--     64, 65, 66, 67, 68, 69, 70,
--     88, 89, 107, 108
-- }

-- TILE_TOP_WALLS = {58, 59, 60}
-- TILE_BOTTOM_WALLS = {79, 80, 81}
-- TILE_LEFT_WALLS = {77, 96, 115}
-- TILE_RIGHT_WALLS = {78, 97, 116}

TEXTURES = {
    --['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['bg-play'] = love.graphics.newImage('graphics/bg-play-2.png'),
    --['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character-walk'] = love.graphics.newImage('graphics/Walk-Hero.png'),
    ['enemy-walk'] = love.graphics.newImage('graphics/Walk-Npc0.png'),
    ['character-slap'] = love.graphics.newImage('graphics/Slap-Hero.png'),
    ['scenary'] = love.graphics.newImage('graphics/Scenary.png')
}


FRAMES = {
    ['character-walk'] = generateQuads(TEXTURES['character-walk'], 24, 73),
    ['character-slap'] = generateQuads(TEXTURES['character-slap'], 32, 73),
    ['enemy-walk'] = generateQuads(TEXTURES['enemy-walk'], 25, 75),
}
-- FRAMES = {
--     ['tiles'] = generateQuads(TEXTURES['tiles'], 16, 16),
--     ['character-walk'] = generateQuads(TEXTURES['character-walk'], 16, 32),
--     ['character-swing-sword'] = generateQuads(TEXTURES['character-swing-sword'], 32, 32),
--     ['hearts'] = generateQuads(TEXTURES['hearts'], 16, 16),
--     ['switches'] = generateQuads(TEXTURES['switches'], 16, 18),
--     ['chest2'] = generateQuads(TEXTURES['chest2'], 32, 32),
--     ['entities'] = generateQuads(TEXTURES['entities'], 16, 16),
--     ['character-pot-lift'] = generateQuads(TEXTURES['character-pot-lift'], 16, 32),
--     ['character-pot-walk'] = generateQuads(TEXTURES['character-pot-walk'], 16, 32),
--     ['rotbow'] = generateQuads(TEXTURES['rotbow'], 20, 20),
--     ['boss_walk'] = generateQuads(TEXTURES['boss_walk'], 75, 75),
--     ['test'] = generateQuads(TEXTURES['test'], 75, 75),
--     ['test_2'] = generateQuads(TEXTURES['test_2'], 75, 75)
-- }

FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {
    ['start-music'] = love.audio.newSource('sounds/start_music.mp3', 'static'),
    ['dungeon-music'] = love.audio.newSource('sounds/dungeon_music.mp3', 'static'),
    ['game-over-music'] = love.audio.newSource('sounds/game_over_music.mp3', 'static'),
    ['win-music'] = love.audio.newSource('sounds/win_music.mp3', 'static')
    -- ['sword'] = love.audio.newSource('sounds/sword.wav', 'static'),
    -- ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    -- ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    -- ['door'] = love.audio.newSource('sounds/door.wav', 'static'),
    -- ['heart-taken'] = love.audio.newSource('sounds/heart_taken.wav', 'static'),
    -- ['pot-wall'] = love.audio.newSource('sounds/pot_wall.wav', 'static'),
    -- ['boss-music'] = love.audio.newSource('sounds/boss_battle.mp3', 'static')
}
