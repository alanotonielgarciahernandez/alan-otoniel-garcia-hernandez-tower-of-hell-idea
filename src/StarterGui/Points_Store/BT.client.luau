--!strict

local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
local Players = game:GetService('Players') :: Players

local btn = script.Parent :: GuiButton
local points = Players.LocalPlayer:WaitForChild('Points') :: IntValue
local RemoteEvent = RepStor:WaitForChild('BTEvent') :: RemoteEvent
local addTime = 30
local pointCost = 100

btn.MouseButton1Click:Connect(function()
	if points.Value < pointCost then
		return
	end
	RemoteEvent:FireServer(addTime)
end)
