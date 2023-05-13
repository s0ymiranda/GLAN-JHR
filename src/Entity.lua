Entity = Class{}

function Entity:init(def)

    -- in top-down games, there are four directions instead of two

    self.stateMachine = StateMachine(def.states or {})

    self.direction = 'right'

    self.animations = self:createAnimations(def.animations)

    self.pervertFactor = def.pervertFactor or 1

    local random = math.random(math.floor((2/self.pervertFactor)+0.5))
    --print(random)

    if random == 1 then
        self.pervert = false
    else
        self.pervert = true
    end
    self.fighting = false
    self.punching = false
    self.justWalking = false
    -- self.angry = false
    self.prevHealth = 3

    self.leftLimit = 0
    self.rightLimit = VIRTUAL_WIDTH*4

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.z = 0
    self.z_base = VIRTUAL_HEIGHT*0.55
    self.width = def.width
    self.height = def.height

    self.walkSpeed = def.walkSpeed

    self.health = def.health

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0

    --  track whether entity has dropped items or not
    self.dropped = false
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:heal(life)
    self.health = math.min(self.health + life, 6)
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    self.z = math.floor(((self.y+self.height)-self.z_base)/10)
end

function Entity:processAI(params, dt)
    if self.fighting and self.pervert then
        self.stateMachine:processAIFighting(params, dt)
    else
        self.stateMachine:processAI(params, dt)
    end
end

function Entity:render()
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 0, 255))
    end

    self.x, self.y = self.x, self.y
    self.stateMachine:render()
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    -- self.x, self.y = self.x, self.y
end
