local RepStor = game:GetService("ReplicatedStorage");
local LevelModule = require(RepStor.LevelModule);
local level1 = RepStor:WaitForChild("Level1"); local level2 = RepStor:WaitForChild("Level2"); local level3 = RepStor:WaitForChild("Level3"); local level4 = RepStor:WaitForChild("Level4"); local level5 = RepStor:WaitForChild("Level5"); local level6 = RepStor:WaitForChild("Level6"); local level7 = RepStor:WaitForChild("Level7"); local level8 = RepStor:WaitForChild("Level8"); local level9 = RepStor:WaitForChild("Level9"); local level10 = RepStor:WaitForChild("Level10"); local level11 = RepStor:WaitForChild("Level11"); local level12 = RepStor:WaitForChild("Level12"); local End = RepStor:WaitForChild("End");
local Players = game:GetService("Players");
local floor = 23.5;
local rot = false;

local Name = nil;
local Author = nil;

local f1, f2, f3, f4, f5, f6;

while true do
	for i = 1, 6 do
		local random = math.random(1, 12);

		if random == 1 then
			local clon = level1:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level1.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level1.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level1.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 2 then
			local clon = level2:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level2.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level2.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level2.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 3 then
			local clon = level3:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level3.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level3.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level3.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 4 then
			local clon = level4:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level4.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level4.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level4.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 5 then
			local clon = level5:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level5.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level5.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level5.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 6 then
			local clon = level6:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level6.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level6.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level6.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 7 then
			local clon = level7:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level7.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level7.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level7.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 8 then
			local clon = level8:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level8.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level8.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level8.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 9 then
			local clon = level9:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level9.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level9.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level9.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 10 then
			local clon = level10:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level10.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level10.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level10.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 11 then
			local clon = level11:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level11.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level11.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level11.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		elseif random == 12 then
			local clon = level12:Clone();
			clon.Parent = game.Workspace;
			if rot == false then
				clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(112.5), 0));
				rot = true;
			else clon:PivotTo(CFrame.new(0, floor, 0)* CFrame.Angles(0, math.rad(-67.5), 0)); rot = false;
			end;

			wait();
			for _, plr in pairs(Players:GetPlayers()) do
				plr.PlayerGui:WaitForChild("Map")[i].BackgroundColor3 = LevelModule.Level12.Color;
			end;

			clon.Walls.TextWall.SurfaceGui.LevelName.Text = LevelModule.Level12.LevelName;
			clon.Walls.TextWall.SurfaceGui.Author.Text = LevelModule.Level12.Author;
			floor += 15.5;
			
			if i == 1 then
				f1 = clon;
			elseif i == 2 then
				f2 = clon;
			elseif i == 3 then
				f3 = clon;
			elseif i == 4 then
				f4 = clon;
			elseif i == 5 then
				f5 = clon;
			elseif i == 6 then
				f6 = clon;
			end;
		end;
	end;

	local TheEnd = End:Clone();
	TheEnd.Parent = game.Workspace;
	if rot == true then
		TheEnd:PivotTo(CFrame.new(0, floor + 12, 0)* CFrame.Angles(0, math.rad(180), 0));
		rot = false;
	else TheEnd:PivotTo(CFrame.new(0, floor + 12, 0)* CFrame.Angles(0, math.rad(0), 0)); rot = false;
	end;
	
	repeat wait() until game.Workspace.Value.Value == 0;
	
	game.Workspace.Value.Value = 180;
	floor = 23.5;
	
	for i, plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			plr.Character.HumanoidRootPart.CFrame = game.Workspace.Lobby.SpawnLocation.CFrame;
		end;
	end;
	
	f1:Destroy();
	f2:Destroy();
	f3:Destroy();
	f4:Destroy();
	f5:Destroy();
	f6:Destroy();
	TheEnd:Destroy();
end;
