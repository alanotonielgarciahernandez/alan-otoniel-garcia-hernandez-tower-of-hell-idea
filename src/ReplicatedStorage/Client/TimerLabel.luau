--!strict

-- Copies the shared round clock onto the timer label.
local TimerLabel = {}

function TimerLabel.start(timerGui: Instance)
	local Players = game:GetService('Players') :: Players
	local player = Players.LocalPlayer
	local timeLeft = game:GetService('ReplicatedStorage'):WaitForChild('Value') :: IntValue
	local label = timerGui:WaitForChild('Time') :: TextLabel

	local function show()
		if label.Parent == nil then
			local playerGui = player:FindFirstChild('PlayerGui')
			local timer = if playerGui ~= nil then playerGui:FindFirstChild('Timer') else nil
			local time = if timer ~= nil then timer:FindFirstChild('Time') else nil
			if time == nil or not time:IsA('TextLabel') then
				return
			end
			label = time
		end
		label.Text = tostring(timeLeft.Value)
	end

	-- A respawn used to replace the GUI, leaving the new label at its default 0.
	player.CharacterAdded:Connect(function()
		local playerGui = player:WaitForChild('PlayerGui')
		local timer = playerGui:WaitForChild('Timer', 5)
		if timer == nil then
			return
		end
		local time = timer:WaitForChild('Time', 5)
		if time ~= nil and time:IsA('TextLabel') then
			label = time
			show()
		end
	end)

	show()
	timeLeft.Changed:Connect(show)
end

return TimerLabel
