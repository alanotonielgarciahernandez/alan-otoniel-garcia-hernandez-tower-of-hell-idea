--!strict

local bar = script.Parent :: GuiObject
local plr = (bar.Parent :: Instance).Parent.Parent :: Player
local character = plr.Character :: Model
local hrp = character:WaitForChild('HumanoidRootPart') :: BasePart

while task.wait(0.00001) do
	local height = hrp.Position.Y
	bar.Position = UDim2.fromScale(0.995, 0.9 - height / 250)
end
