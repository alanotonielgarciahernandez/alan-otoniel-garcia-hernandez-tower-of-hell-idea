local textlabel = script.Parent;
local plr = game:GetService("Players").LocalPlayer;
local points = plr:WaitForChild("Points");

local function showPoints()
	textlabel.Text = tostring(points.Value);
end;

points.Changed:Connect(showPoints);
showPoints();
