--!strict

-- Sizes the map from the live tower and moves the marker with the character.
local MapBar = {}

-- The column stays where the original map was drawn. Y scale grows downward.
local COLUMN_X = 0.995
local BAR_WIDTH = 0.02
local BOTTOM_EDGE = 0.8725
local TOP_EDGE = 0.3964
local START_HEIGHT = 0.05

local function verticalHalf(part: BasePart): number
	local cf = part.CFrame
	local size = part.Size
	return math.abs(cf.RightVector.Y) * size.X / 2
		+ math.abs(cf.UpVector.Y) * size.Y / 2
		+ math.abs(cf.LookVector.Y) * size.Z / 2
end

local function bottomY(part: BasePart): number
	return part.Position.Y - verticalHalf(part)
end

local function topY(part: BasePart): number
	return part.Position.Y + verticalHalf(part)
end

local function place(gui: GuiObject, center: number, height: number)
	gui.Position = UDim2.fromScale(COLUMN_X, center)
	gui.Size = UDim2.fromScale(BAR_WIDTH, height)
end

function MapBar.start(mapGui: Instance)
	local Players = game:GetService('Players') :: Players
	local RunService = game:GetService('RunService') :: RunService
	local Workspace = game:GetService('Workspace') :: Workspace
	local marker = mapGui:WaitForChild('Player') :: GuiObject
	local startBar = mapGui:WaitForChild('Start') :: GuiObject
	local endBar = mapGui:WaitForChild('End') :: GuiObject
	local slots: { GuiObject } = {}
	for index = 1, 6 do
		slots[index] = mapGui:WaitForChild(tostring(index)) :: GuiObject
	end

	-- The original bar is the template. Each player gets a copy with their headshot beside it.
	marker.Visible = false
	local markers: { [Player]: GuiObject } = {}

	local function markerFor(subject: Player): GuiObject
		local existing = markers[subject]
		if existing ~= nil and existing.Parent ~= nil then
			return existing
		end

		local frame = marker:Clone() :: GuiObject
		frame.Name = 'Player_' .. subject.UserId
		frame.Visible = false
		-- The map compares ZIndex across the whole GUI, so the headshot needs its own layer.
		local layer = if subject == Players.LocalPlayer then 10 else 1
		frame.ZIndex = layer
		-- Yellow stays readable on the section colors. Other players stay a flat gray.
		if subject == Players.LocalPlayer then
			frame.BackgroundColor3 = Color3.fromRGB(255, 220, 40)
			frame.BorderSizePixel = 1
			frame.BorderColor3 = Color3.fromRGB(40, 30, 0)
		else
			frame.BackgroundColor3 = Color3.fromRGB(196, 200, 206)
			frame.BorderSizePixel = 0
		end

		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.BackgroundTransparency = 1
		icon.AnchorPoint = Vector2.new(1, 0.5)
		icon.Position = UDim2.new(0, -4, 0.5, 0)
		icon.Size = UDim2.fromOffset(36, 36)
		icon.ZIndex = layer
		icon.ScaleType = Enum.ScaleType.Fit
		icon.Image = 'rbxthumb://type=AvatarHeadShot&id=' .. subject.UserId .. '&w=48&h=48'
		icon.Parent = frame

		frame.Parent = mapGui
		markers[subject] = frame
		return frame
	end

	local function drop(subject: Player)
		local frame = markers[subject]
		if frame ~= nil then
			frame:Destroy()
		end
		markers[subject] = nil
	end

	Players.PlayerAdded:Connect(markerFor)
	Players.PlayerRemoving:Connect(drop)
	for _, subject in Players:GetPlayers() do
		markerFor(subject)
	end

	-- World Y of the current stack, and the screen scale those edges use.
	local towerBottom: number? = nil
	local towerTop: number? = nil
	local scaleBottom = BOTTOM_EDGE - START_HEIGHT
	local scaleTop = TOP_EDGE

	-- Sections are ordered from the ground up. Their bars share the column by height.
	local function layout()
		local levels: { Model } = {}
		for _, child in Workspace:GetChildren() do
			if child:IsA('Model') and string.match(child.Name, '^Level%d+$') ~= nil then
				local startPad = child:FindFirstChild('Start')
				local endPad = child:FindFirstChild('End')
				if startPad ~= nil and startPad:IsA('BasePart') and endPad ~= nil and endPad:IsA('BasePart') then
					table.insert(levels, child)
				end
			end
		end
		table.sort(levels, function(a: Model, b: Model)
			local aStart = a:FindFirstChild('Start') :: BasePart
			local bStart = b:FindFirstChild('Start') :: BasePart
			return bottomY(aStart) < bottomY(bStart)
		end)

		local finish = Workspace:FindFirstChild('End')
		local finishStart = if finish ~= nil then finish:FindFirstChild('Start') else nil
		local finishEnd = if finish ~= nil then finish:FindFirstChild('End') else nil
		local hasFinish = finishStart ~= nil
			and finishStart:IsA('BasePart')
			and finishEnd ~= nil
			and finishEnd:IsA('BasePart')

		local heights: { number } = {}
		local total = 0
		for index, level in levels do
			if index > 6 then
				break
			end
			local startPad = level:FindFirstChild('Start') :: BasePart
			local endPad = level:FindFirstChild('End') :: BasePart
			local height = math.max(topY(endPad) - bottomY(startPad), 0.1)
			heights[index] = height
			total += height
		end
		local finishHeight = 0
		if hasFinish and #heights > 0 then
			finishHeight = math.max(topY(finishEnd :: BasePart) - bottomY(finishStart :: BasePart), 0.1)
			total += finishHeight
		end

		place(startBar, BOTTOM_EDGE - START_HEIGHT / 2, START_HEIGHT)
		if #heights == 0 then
			towerBottom = nil
			towerTop = nil
			return
		end

		local stack = BOTTOM_EDGE - TOP_EDGE - START_HEIGHT
		local cursor = BOTTOM_EDGE - START_HEIGHT
		for index = 1, 6 do
			local height = heights[index]
			if height == nil then
				place(slots[index], cursor, 0)
			else
				local barHeight = stack * (height / total)
				place(slots[index], cursor - barHeight / 2, barHeight)
				cursor -= barHeight
			end
		end
		if hasFinish then
			local barHeight = stack * (finishHeight / total)
			place(endBar, cursor - barHeight / 2, barHeight)
			cursor -= barHeight
		else
			place(endBar, cursor, 0)
		end

		local first = levels[1]
		local firstStart = first:FindFirstChild('Start') :: BasePart
		towerBottom = bottomY(firstStart)
		if hasFinish then
			towerTop = topY(finishEnd :: BasePart)
		else
			local last = levels[math.min(#levels, 6)]
			local lastEnd = last:FindFirstChild('End') :: BasePart
			towerTop = topY(lastEnd)
		end
		scaleBottom = BOTTOM_EDGE - START_HEIGHT
		scaleTop = cursor
	end

	local function markerCenter(worldY: number): number
		local center = BOTTOM_EDGE - START_HEIGHT / 2
		if towerBottom ~= nil and towerTop ~= nil and towerTop > towerBottom then
			local alpha = math.clamp((worldY - towerBottom) / (towerTop - towerBottom), 0, 1)
			center = scaleBottom + (scaleTop - scaleBottom) * alpha
		end
		return center
	end

	RunService.RenderStepped:Connect(function()
		layout()
		for _, subject in Players:GetPlayers() do
			local frame = markers[subject]
			if frame == nil then
				continue
			end
			local character = subject.Character
			local root = if character ~= nil then character:FindFirstChild('HumanoidRootPart') else nil
			if root == nil or not root:IsA('BasePart') then
				frame.Visible = false
			else
				frame.Visible = true
				frame.Position = UDim2.fromScale(COLUMN_X, markerCenter(root.Position.Y))
			end
		end
	end)
end

return MapBar
