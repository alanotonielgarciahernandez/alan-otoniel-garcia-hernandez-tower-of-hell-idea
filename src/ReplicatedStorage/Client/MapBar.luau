--!strict

-- Moves the map marker with the local character's height.
local MapBar = {}

function MapBar.start(mapGui: Instance)
	local Players = game:GetService('Players') :: Players
	local RunService = game:GetService('RunService') :: RunService
	local bar = mapGui:WaitForChild('Player') :: GuiObject
	local player = Players.LocalPlayer
	local root: BasePart? = nil

	-- The map GUI does not reset on spawn, so this has to follow each new character.
	local function bind(character: Model)
		local found = character:WaitForChild('HumanoidRootPart', 5)
		if found == nil or not found:IsA('BasePart') then
			return
		end
		if player.Character ~= character then
			return
		end
		root = found
	end

	player.CharacterAdded:Connect(bind)
	if player.Character ~= nil then
		task.spawn(bind, player.Character)
	end

	RunService.RenderStepped:Connect(function()
		if root == nil or root.Parent == nil then
			return
		end
		local height = root.Position.Y
		bar.Position = UDim2.fromScale(0.995, 0.9 - height / 250)
	end)
end

return MapBar
