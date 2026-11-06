--!strict

-- Starts every client system once this player's GUI has loaded.
local Players = game:GetService('Players') :: Players
local player = Players.LocalPlayer
local playerGui = player:WaitForChild('PlayerGui')

local TimerLabel = require(script:WaitForChild('TimerLabel')) :: { start: (gui: Instance) -> () }
local Store = require(script:WaitForChild('Store')) :: { start: (gui: Instance) -> () }
local MapBar = require(script:WaitForChild('MapBar')) :: { start: (gui: Instance) -> () }

TimerLabel.start(playerGui:WaitForChild('Timer'))
Store.start(playerGui:WaitForChild('Points_Store'))
MapBar.start(playerGui:WaitForChild('Map'))
