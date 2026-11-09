--!strict

-- Counts down the shared round clock. Points is what adds time.
local Timer = {}

function Timer.start()
	local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
	-- The timer label reads this same IntValue.
	local timeLeft = RepStor:WaitForChild('Value') :: IntValue

	-- One second per loop. At zero, Tower sets the next round back to the starting value.
	-- Stay in the loop so that reset is counted down too.
	task.spawn(function()
		while task.wait(1) do
			if timeLeft.Value > 0 then
				timeLeft.Value -= 1
			end
		end
	end)
end

return Timer
