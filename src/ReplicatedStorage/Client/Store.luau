--!strict

-- The points store: open it, close it, show the balance, and ask the server for time.
local Store = {}

function Store.start(storeGui: Instance)
	local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
	local Players = game:GetService('Players') :: Players

	local openButton = storeGui:WaitForChild('ImageButton') :: GuiButton
	local pointsLabel = storeGui:WaitForChild('TextLabel') :: TextLabel
	local scrolling = storeGui:WaitForChild('ScrollingFrame') :: ScrollingFrame
	local buyButton = scrolling:WaitForChild('TextButton') :: GuiButton
	local exitButton = storeGui:WaitForChild('Exit') :: GuiButton
	local buyTime = RepStor:WaitForChild('Remotes'):WaitForChild('BTEvent') :: RemoteEvent
	local points = Players.LocalPlayer:WaitForChild('Points') :: IntValue

	local addTime = 30
	local pointCost = 100

	local function showPoints()
		pointsLabel.Text = tostring(points.Value)
	end

	points.Changed:Connect(showPoints)
	showPoints()

	openButton.MouseButton1Click:Connect(function()
		scrolling.Visible = true
		exitButton.Visible = true
	end)

	exitButton.MouseButton1Click:Connect(function()
		exitButton.Visible = false
		scrolling.Visible = false
	end)

	buyButton.MouseButton1Click:Connect(function()
		if points.Value < pointCost then
			return
		end
		buyTime:FireServer(addTime)
	end)
end

return Store
