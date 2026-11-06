--!strict

-- Starts every server system. Each module does its own work inside start.
local Timer = require(script:WaitForChild('Timer')) :: { start: () -> () }
local Points = require(script:WaitForChild('Points')) :: { start: () -> () }
local Tower = require(script:WaitForChild('Tower')) :: { start: () -> () }
local Lobby = require(script:WaitForChild('Lobby')) :: { start: () -> () }
local Kill = require(script:WaitForChild('Kill')) :: { start: () -> () }

-- Points and Kill watch Workspace before the tower builds into it.
Kill.start()
Points.start()
Timer.start()
Tower.start()
Lobby.start()
