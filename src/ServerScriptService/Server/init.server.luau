--!strict

-- Starts every server system. Each module does its own work inside start.
local Timer = require(script:WaitForChild('Timer')) :: { start: () -> () }
local Points = require(script:WaitForChild('Points')) :: { start: () -> () }
local Tower = require(script:WaitForChild('Tower')) :: { start: () -> () }
local Lobby = require(script:WaitForChild('Lobby')) :: { start: () -> () }

-- Points watches for the end platform before the tower builds one.
Points.start()
Timer.start()
Tower.start()
Lobby.start()
