--!strict

local Timer = script.Parent :: TextLabel
local val = game:GetService('ReplicatedStorage'):WaitForChild('Value') :: IntValue

while task.wait(1) do
	Timer.Text = tostring(val.Value)
end
