--!strict

-- Checks the purchase and win rules without joining a server.
local Points = require('../src/ServerScriptService/Server/Points')

local failures = {}

local function check(name: string, passed: boolean)
	if passed then
		print('ok ' .. name)
	else
		print('failed ' .. name)
		table.insert(failures, name)
	end
end

-- A request that is not 30 does not spend points or add time.
local balance, clock = Points.applyPurchase(100, 40, '30')
check('a request that is not the number 30 is ignored', balance == 100 and clock == 40)

balance, clock = Points.applyPurchase(100, 40, 31)
check('a request for a number other than 30 is ignored', balance == 100 and clock == 40)

-- 99 points cannot buy 30 seconds.
balance, clock = Points.applyPurchase(99, 40, 30)
check('a request for 30 with a balance under 100 is ignored', balance == 99 and clock == 40)

-- 100 points buys 30 seconds and leaves 0.
balance, clock = Points.applyPurchase(100, 40, 30)
check('a request for 30 with a balance of 100 spends 100 and adds 30 seconds', balance == 0 and clock == 70)

-- 250 points buys 30 seconds and leaves 150.
balance, clock = Points.applyPurchase(250, 40, 30)
check('a request for 30 with a balance of 250 leaves 150 and adds 30 seconds', balance == 150 and clock == 70)

-- The first win pays and starts the cooldown. The cooldown is 10 seconds in the live game.
local won, cooling = Points.applyWin(0, false)
check('reaching the end adds 100 and starts the cooldown', won == 100 and cooling == true)
check('the cooldown lasts 10 seconds', Points.winCooldownSeconds == 10)

-- A second win while that flag is set pays nothing.
won, cooling = Points.applyWin(100, true)
check('reaching the end again during the cooldown adds nothing', won == 100 and cooling == true)

-- After the live game clears the flag, the next win pays again.
won, cooling = Points.applyWin(100, false)
check('reaching the end after the cooldown adds 100 again', won == 200 and cooling == true)

if #failures > 0 then
	error(tostring(#failures) .. ' point tests failed', 0)
end
