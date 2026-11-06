--!strict

-- The lobby used to carry these two scripts on its parts.
local Lobby = {}

local function cycleColor(part: BasePart)
	while task.wait() do
		part.Color = Color3.new(255 / 255, 0 / 255, 0 / 255)
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(255 / 255, i / 255, 0 / 255)
		end
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(i / 255, 255 / 255, 0 / 255)
		end
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(0 / 255, 255 / 255, i / 255)
		end
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(0 / 255, i / 255, 255 / 255)
		end
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(i / 255, 0 / 255, 255 / 255)
		end
		for i = 0, 255, 10 do
			task.wait()
			part.Color = Color3.new(255 / 255, 0 / 255, i / 255)
		end
	end
end

local function connectTeleport(part: BasePart)
	-- The original script looked up the first end platform and kept that reference.
	task.wait(1)
	local Workspace = game:GetService('Workspace') :: Workspace
	local ending = Workspace:WaitForChild('End')
	local destination = (ending :: any).Start :: BasePart

	part.Touched:Connect(function(hit: BasePart)
		local character = hit.Parent
		if character == nil then
			return
		end

		local root = character:WaitForChild('HumanoidRootPart') :: BasePart
		root.Position = destination.Position
	end)
end

function Lobby.start()
	local Workspace = game:GetService('Workspace') :: Workspace
	local lobby = Workspace:WaitForChild('Lobby')
	local rainbow = lobby:WaitForChild('Logo'):WaitForChild('Rainbow') :: BasePart
	local teleport = lobby:WaitForChild('Teleport') :: BasePart

	task.spawn(cycleColor, rainbow)
	task.spawn(connectTeleport, teleport)
end

return Lobby
