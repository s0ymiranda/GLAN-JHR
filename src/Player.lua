Player = Class { __includes = Entity }

function Player:init(def)
    Entity.init(self, def)
    self.respect = 50
    self.afterFigthing = false
    self.score = 0
    self.perverts_defeated = 0
    self.perverts_passed = 0
    self.innocent_beaten = 0
    self.playerNum = 1
    self.numOfPlayersInGame = 1
end

function Player:update(dt, params)
    Entity.update(self, dt, params)
end

function Player:render()
    Entity.render(self)
end
