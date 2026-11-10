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

-- The finish course cloned into Workspace. Its Start pad is the entrance of that floor.
local function endFloorStart(): BasePart?
	local Workspace = game:GetService('Workspace') :: Workspace
	local ending = Workspace:FindFirstChild('End')
	if ending == nil then
		return nil
	end
	local start = ending:FindFirstChild('Start')
	if start ~= nil and start:IsA('BasePart') then
		return start
	end
	return nil
end

local function connectTeleport(part: BasePart)
	part.Touched:Connect(function(hit: BasePart)
		local character = hit.Parent
		if character == nil then
			return
		end

		local root = character:FindFirstChild('HumanoidRootPart')
		if root == nil or not root:IsA('BasePart') then
			return
		end

		-- Look up the current round. The previous finish course is destroyed when the timer ends.
		local start = endFloorStart()
		if start == nil then
			return
		end

		-- Start is a thin pad. The root has to sit above it or the character falls through.
		root.CFrame = start.CFrame + Vector3.new(0, start.Size.Y / 2 + 3, 0)
	end)
end

function Lobby.start()
	local Workspace = game:GetService('Workspace') :: Workspace
	local lobby = Workspace:WaitForChild('Lobby')
	local rainbow = lobby:WaitForChild('Logo'):WaitForChild('Rainbow') :: BasePart
	local teleport = lobby:WaitForChild('Teleport'):WaitForChild('TeleportPad') :: BasePart

	task.spawn(cycleColor, rainbow)
	task.spawn(connectTeleport, teleport)

	-- The end platform's logo uses the same cycle and stops when the round removes it.
	for _, child in Workspace:GetChildren() do
		watchEndRainbow(child)
	end
	Workspace.ChildAdded:Connect(watchEndRainbow)
end

return Lobby
