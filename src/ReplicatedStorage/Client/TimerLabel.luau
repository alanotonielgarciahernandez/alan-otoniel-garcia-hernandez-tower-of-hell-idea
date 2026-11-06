--!strict

-- Copies the shared round clock onto the timer label.
local TimerLabel = {}

function TimerLabel.start(timerGui: Instance)
	local label = timerGui:WaitForChild('Time') :: TextLabel
	local timeLeft = game:GetService('ReplicatedStorage'):WaitForChild('Value') :: IntValue

	task.spawn(function()
		while task.wait(1) do
			label.Text = tostring(timeLeft.Value)
		end
	end)
end

return TimerLabel
