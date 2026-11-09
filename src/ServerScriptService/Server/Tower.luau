--!strict

-- Builds a tower, waits out the round, then builds another.
local Tower = {}

-- Half the part's height in world Y. A yaw-only pad uses Size.Y; a tilted pad does not.
local function verticalHalf(part: BasePart): number
	local cf = part.CFrame
	local size = part.Size
	return math.abs(cf.RightVector.Y) * size.X / 2
		+ math.abs(cf.UpVector.Y) * size.Y / 2
		+ math.abs(cf.LookVector.Y) * size.Z / 2
end

local function pad(model: Model, name: string): BasePart
	local part = model:FindFirstChild(name)
	assert(part ~= nil and part:IsA('BasePart'), name .. ' pad is missing')
	return part :: BasePart
end

-- Pivot Y that sets this model's Start bottom on the previous section's End top.
local function pivotAbove(model: Model, previousTop: number): number
	local start = pad(model, 'Start')
	local bottomOffset = (start.Position.Y - verticalHalf(start)) - model:GetPivot().Position.Y
	return previousTop - bottomOffset
end

local function exitTop(model: Model): number
	local ending = pad(model, 'End')
	return ending.Position.Y + verticalHalf(ending)
end

function Tower.start()
	task.spawn(function()
		local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
		local ServerStorage = game:GetService('ServerStorage') :: ServerStorage
		local timeLeft = RepStor:WaitForChild('Value') :: IntValue
		-- The countdown replaces this number. Every round starts from the value set on the object.
		local roundLength = timeLeft.Value
		local Players = game:GetService('Players') :: Players
		local Workspace = game:GetService('Workspace') :: Workspace

		type SectionInfo = {
			LevelName: string,
			Author: string,
			Color: Color3,
		}

		type SectionModel = Model & {
			Walls: {
				TextWall: {
					SurfaceGui: {
						LevelName: TextLabel,
						Author: TextLabel,
					},
				},
			},
		}

		local levelModuleScript = RepStor:WaitForChild('Modules'):WaitForChild('LevelModule') :: ModuleScript
		local LevelModule = require(levelModuleScript) :: { [string]: SectionInfo }

		-- Templates stay on the server. A clone parented to Workspace is what players see.
		local sections: { Model } = {}
		for index = 1, 12 do
			sections[index] = ServerStorage:WaitForChild('Level' .. index) :: Model
		end
		local End = ServerStorage:WaitForChild('End') :: Model

		local floor = 23.5
		-- Alternates the facing of each section so two in a row do not share a direction.
		local rot = false
		-- Colors for the tower that is up now. Slot 1 is filled before most maps exist.
		local colors: { Color3 } = {}
		local roundId = 0

		local function paint(player: Player, seenRound: number)
			local playerGui = player:FindFirstChild('PlayerGui') or player:WaitForChild('PlayerGui', 60)
			if playerGui == nil or seenRound ~= roundId then
				return
			end
			local map = playerGui:WaitForChild('Map', 60)
			if map == nil or seenRound ~= roundId then
				return
			end
			for index, color in colors do
				if seenRound ~= roundId then
					return
				end
				local slot = map:FindFirstChild(tostring(index))
				if slot ~= nil and slot:IsA('GuiObject') then
					slot.BackgroundColor3 = color
				end
			end
		end

		-- A player who joins after the tower is built still needs every slot filled.
		Players.PlayerAdded:Connect(function(player: Player)
			task.spawn(paint, player, roundId)
		end)

		while true do
			local placed: { Model } = {}
			-- World Y of the previous section's End top. The next Start rests on it.
			local previousTop = 0
			roundId += 1
			local seenRound = roundId
			table.clear(colors)

			for i = 1, 6 do
				local random = math.random(1, 12)
				local info = LevelModule['Level' .. random]
				assert(info, 'section info is missing')

				local template = sections[random]
				assert(template, 'section template is missing')
				local clon = template:Clone() :: SectionModel
				local model = clon :: Model
				model.Parent = Workspace
				-- The first section keeps the original pivot. Later ones follow the section below.
				local placeY = if i == 1 then floor else pivotAbove(model, previousTop)
				if rot == false then
					model:PivotTo(CFrame.new(0, placeY, 0) * CFrame.Angles(0, math.rad(112.5), 0))
					rot = true
				else
					model:PivotTo(CFrame.new(0, placeY, 0) * CFrame.Angles(0, math.rad(-67.5), 0))
					rot = false
				end
				previousTop = exitTop(model)

				task.wait()
				-- Keep the color with the round, then paint whoever already has a map.
				colors[i] = info.Color
				for _, plr in Players:GetPlayers() do
					task.spawn(paint, plr, seenRound)
				end

				clon.Walls.TextWall.SurfaceGui.LevelName.Text = info.LevelName
				clon.Walls.TextWall.SurfaceGui.Author.Text = info.Author
				placed[i] = model
			end

			local TheEnd = End:Clone() :: Model
			TheEnd.Parent = Workspace
			local endY = pivotAbove(TheEnd, previousTop)
			if rot == true then
				TheEnd:PivotTo(CFrame.new(0, endY, 0) * CFrame.Angles(0, math.rad(180), 0))
				rot = false
			else
				TheEnd:PivotTo(CFrame.new(0, endY, 0) * CFrame.Angles(0, math.rad(0), 0))
				rot = false
			end

			repeat
				task.wait()
			until timeLeft.Value == 0

			timeLeft.Value = roundLength
			floor = 23.5

			local spawnPad = Workspace:WaitForChild('Lobby'):WaitForChild('SpawnLocation') :: BasePart
			-- The pad's center is inside the lobby floor. A missing root means the character is respawning.
			local aboveSpawn = spawnPad.CFrame + Vector3.new(0, spawnPad.Size.Y / 2 + 3, 0)
			for _, plr in Players:GetPlayers() do
				local character = plr.Character
				local root = if character ~= nil then character:FindFirstChild('HumanoidRootPart') else nil
				if character ~= nil and root ~= nil and root:IsA('BasePart') then
					character:PivotTo(aboveSpawn)
				end
			end

			for _, section in placed do
				section:Destroy()
			end
			TheEnd:Destroy()
		end
	end)
end

return Tower
