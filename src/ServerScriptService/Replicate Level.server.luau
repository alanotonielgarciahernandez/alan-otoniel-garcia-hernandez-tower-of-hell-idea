local RepStor = game:GetService("ReplicatedStorage");
local timeLeft = RepStor:WaitForChild("Value");
local LevelModule = require(RepStor.LevelModule);
local Players = game:GetService("Players");

-- Section models in the same order math.random(1, 12) used to pick.
local sections = {};
for index = 1, 12 do
	sections[index] = RepStor:WaitForChild("Level" .. index);
end;
local End = RepStor:WaitForChild("End");

local floor = 23.5;
-- Alternates the facing of each section so two in a row do not share a direction.
local rot = false;

while true do
	local placed = {};

	for i = 1, 6 do
		local random = math.random(1, 12);
		local info = LevelModule["Level" .. random];

		local clon = sections[random]:Clone();
		clon.Parent = game.Workspace;
		if rot == false then
			clon:PivotTo(CFrame.new(0, floor, 0) * CFrame.Angles(0, math.rad(112.5), 0));
			rot = true;
		else
			clon:PivotTo(CFrame.new(0, floor, 0) * CFrame.Angles(0, math.rad(-67.5), 0));
			rot = false;
		end;

		wait();
		for _, plr in pairs(Players:GetPlayers()) do
			-- Map slots are numbered 1 through 6, matching this section's place in the tower.
			plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = info.Color;
		end;

		clon.Walls.TextWall.SurfaceGui.LevelName.Text = info.LevelName;
		clon.Walls.TextWall.SurfaceGui.Author.Text = info.Author;
		floor += 15.5;
		placed[i] = clon;
	end;

	local TheEnd = End:Clone();
	TheEnd.Parent = game.Workspace;
	if rot == true then
		TheEnd:PivotTo(CFrame.new(0, floor + 12, 0) * CFrame.Angles(0, math.rad(180), 0));
		rot = false;
	else
		TheEnd:PivotTo(CFrame.new(0, floor + 12, 0) * CFrame.Angles(0, math.rad(0), 0));
		rot = false;
	end;

	repeat wait() until timeLeft.Value == 0;

	timeLeft.Value = 100;
	floor = 23.5;

	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			plr.Character.HumanoidRootPart.CFrame = game.Workspace.Lobby.SpawnLocation.CFrame;
		end;
	end;

	for _, section in placed do
		section:Destroy();
	end;
	TheEnd:Destroy();
end;
