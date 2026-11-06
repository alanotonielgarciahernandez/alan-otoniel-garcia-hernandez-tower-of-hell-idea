--!strict

-- The lobby used to carry these two scripts on its parts.
local Lobby = {}

local function stillThere(part: BasePart): boolean
	return part.Parent ~= nil
end

local function cycleColor(part: BasePart)
	while stillThere(part) and task.wait() do
		if not stillThere(part) then
			return
		end
		part.Color = Color3.new(255 / 255, 0 / 255, 0 / 255)
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(255 / 255, i / 255, 0 / 255)
		end
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(i / 255, 255 / 255, 0 / 255)
		end
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(0 / 255, 255 / 255, i / 255)
		end
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(0 / 255, i / 255, 255 / 255)
		end
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(i / 255, 0 / 255, 255 / 255)
		end
		for i = 0, 255, 10 do
			if not stillThere(part) then
				return
			end
			task.wait()
			if not stillThere(part) then
				return
			end
			part.Color = Color3.new(255 / 255, 0 / 255, i / 255)
		end
	end
end

local function watchEndRainbow(child: Instance)
	if child.Name ~= 'End' then
		return
	end
	local logo = child:FindFirstChild('Logo')
	if logo == nil then
		return
	end
	local rainbow = logo:FindFirstChild('Rainbow')
	if rainbow ~= nil and rainbow:IsA('BasePart') then
		task.spawn(cycleColor, rainbow)
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

	-- The end platform's logo uses the same cycle and stops when the round removes it.
	for _, child in Workspace:GetChildren() do
		watchEndRainbow(child)
	end
	Workspace.ChildAdded:Connect(watchEndRainbow)
end

return Lobby
