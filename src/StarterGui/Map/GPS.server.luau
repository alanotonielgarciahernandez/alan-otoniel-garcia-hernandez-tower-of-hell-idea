local bar = script.Parent;
local maxa = 100;
local plr = bar.Parent.Parent.Parent;
local hrp = plr.Character:WaitForChild("HumanoidRootPart");

while task.wait(.00001) do
	local height = hrp.Position.Y
	bar.Position = UDim2.new(0.995, 0,0.9 - height / 250, 0);
end

