local RepStor = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");

local btn = script.Parent;
local points = Players.LocalPlayer:WaitForChild("Points");
local RemoteEvent = RepStor:WaitForChild("BTEvent");
local addTime = 30;
local pointCost = 100;

btn.MouseButton1Click:Connect(function()
	if points.Value < pointCost then
		return;
	end;
	RemoteEvent:FireServer(addTime);
end);
