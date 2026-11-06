--!strict

-- Moves the map marker with the character's height.
local MapBar = {}

function MapBar.start(mapGui: Instance)
	local Players = game:GetService('Players') :: Players
	local bar = mapGui:WaitForChild('Player') :: GuiObject
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild('HumanoidRootPart') :: BasePart

	task.spawn(function()
		while task.wait(0.00001) do
			local height = root.Position.Y
			bar.Position = UDim2.fromScale(0.995, 0.9 - height / 250)
		end
	end)
end

return MapBar
