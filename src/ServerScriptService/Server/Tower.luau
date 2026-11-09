--!strict

-- Builds a tower, waits out the round, then builds another.
local Tower = {}

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

		while true do
			local placed: { Model } = {}

			for i = 1, 6 do
				local random = math.random(1, 12)
				local info = LevelModule['Level' .. random]
				assert(info, 'section info is missing')

				local template = sections[random]
				assert(template, 'section template is missing')
				local clon = template:Clone() :: SectionModel
				local model = clon :: Model
				model.Parent = Workspace
				if rot == false then
					model:PivotTo(CFrame.new(0, floor, 0) * CFrame.Angles(0, math.rad(112.5), 0))
					rot = true
				else
					model:PivotTo(CFrame.new(0, floor, 0) * CFrame.Angles(0, math.rad(-67.5), 0))
					rot = false
				end

				task.wait()
				for _, plr in Players:GetPlayers() do
					-- Map slots are numbered 1 through 6, matching this section's place in the tower.
					local map = plr.PlayerGui:WaitForChild('Map') :: any
					local slot = map[i] :: GuiObject
					slot.BackgroundColor3 = info.Color
				end

				clon.Walls.TextWall.SurfaceGui.LevelName.Text = info.LevelName
				clon.Walls.TextWall.SurfaceGui.Author.Text = info.Author
				floor += 15.5
				placed[i] = model
			end

			local TheEnd = End:Clone() :: Model
			TheEnd.Parent = Workspace
			if rot == true then
				TheEnd:PivotTo(CFrame.new(0, floor + 12, 0) * CFrame.Angles(0, math.rad(180), 0))
				rot = false
			else
				TheEnd:PivotTo(CFrame.new(0, floor + 12, 0) * CFrame.Angles(0, math.rad(0), 0))
				rot = false
			end

			repeat
				task.wait()
			until timeLeft.Value == 0

			timeLeft.Value = roundLength
			floor = 23.5

			local lobby = Workspace:WaitForChild('Lobby') :: Folder & { SpawnLocation: SpawnLocation }
			for _, plr in Players:GetPlayers() do
				local character = plr.Character
				if character then
					local root = character:FindFirstChild('HumanoidRootPart') :: BasePart
					root.CFrame = lobby.SpawnLocation.CFrame
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
