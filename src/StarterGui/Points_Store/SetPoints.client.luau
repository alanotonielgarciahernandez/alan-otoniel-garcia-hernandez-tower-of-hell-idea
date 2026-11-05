--!strict

local textlabel = script.Parent :: TextLabel
local plr = game:GetService('Players').LocalPlayer
local points = plr:WaitForChild('Points') :: IntValue

local function showPoints()
	textlabel.Text = tostring(points.Value)
end

points.Changed:Connect(showPoints)
showPoints()
