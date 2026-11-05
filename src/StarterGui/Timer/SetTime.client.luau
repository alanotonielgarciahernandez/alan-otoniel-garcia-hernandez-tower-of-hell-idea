local Timer = script.Parent;
local val = game:GetService("ReplicatedStorage"):WaitForChild("Value");

while task.wait(1) do
	Timer.Text = tostring(val.Value);
end;
