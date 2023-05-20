StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        processAI = function() end,
        processAIFighting = function() end,
        enter = function() end,
        exit = function() end
    }

    self.states = states or {} -- [name] -> [function that returns states]
    self.current = self.empty
    self.currentStateName = ''
end

function StateMachine:change(stateName, enterParams)
    if SHOW_STDOUT and not self.states[stateName] then
        print('Invalid state name: ' .. stateName)
    end
    assert(self.states[stateName]) -- state must exist.
    self.current:exit()
    self.currentStateName = stateName
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

function StateMachine:update(dt, params)
    self.current:update(dt, params)
end

function StateMachine:render()
    self.current:render()
end

function StateMachine:processAI(params, dt)
    self.current:processAI(params, dt)
end

function StateMachine:processAIFighting(params, dt)
    self.current:processAIFighting(params, dt)
end
