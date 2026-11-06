--!strict

-- Counts down the shared round clock. Points is what adds time.
local Timer = {}

function Timer.start()
	local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
	-- The timer label reads this same IntValue.
	local timeLeft = RepStor:WaitForChild('Value') :: IntValue

	-- One second per loop. Tower sets the value back to 180 after it hits zero.
	task.spawn(function()
		while task.wait(1) do
			if timeLeft.Value <= 0 then
				break
			end

			timeLeft.Value -= 1
		end
	end)
end

return Timer
