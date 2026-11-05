--!strict

-- Owns each player's point balance. Timer only counts the clock down.
local Players = game:GetService('Players') :: Players
local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
local Workspace = game:GetService('Workspace') :: Workspace

-- Round clock. A purchase adds seconds here; Timer.server.luau subtracts them.
local timeLeft = RepStor:WaitForChild('Value') :: IntValue
-- The store button fires this. The number it sends is checked below and is not trusted on its own.
local buyTime = RepStor:WaitForChild('Remotes'):WaitForChild('BTEvent') :: RemoteEvent

local BONUS_TIME = 30 -- Seconds granted for one accepted purchase.
local POINT_COST = 100 -- Points spent on that purchase.
local WIN_REWARD = 100 -- Points given for reaching the end platform.
local WIN_COOLDOWN = 10 -- Seconds before the same player can score again.

-- Authoritative balances. Editing the Points value from a client does not change this table.
local points: { [Player]: number } = {}
-- Players who just scored, so one touch cannot award points on every frame.
local winCooldown: { [Player]: boolean } = {}

-- Records the balance, then copies it to the player's Points value for the store label.
local function setPoints(player: Player, amount: number)
	points[player] = amount

	local pointsValue = player:FindFirstChild('Points')
	if pointsValue and pointsValue:IsA('IntValue') then
		pointsValue.Value = amount
	end
end

-- Gives a new player a zero balance and a Points value the label can read.
local function addPlayer(player: Player)
	-- PlayerAdded and the loop below can both see the same player.
	if points[player] ~= nil then
		return
	end

	points[player] = 0

	local pointsValue = Instance.new('IntValue')
	pointsValue.Name = 'Points'
	pointsValue.Value = 0
	pointsValue.Parent = player
end

Players.PlayerAdded:Connect(addPlayer)
-- Drops stored rows when a player leaves so the tables do not keep growing.
Players.PlayerRemoving:Connect(function(player)
	points[player] = nil
	winCooldown[player] = nil
end)
-- Covers players who joined before this script connected PlayerAdded.
for _, player in Players:GetPlayers() do
	addPlayer(player)
end

-- Grants the win reward once, then ignores that player until the cooldown ends.
local function awardWin(player: Player)
	if winCooldown[player] then
		return
	end

	winCooldown[player] = true
	local balance = points[player]
	assert(balance, 'player has no point balance')
	setPoints(player, balance + WIN_REWARD)
	task.delay(WIN_COOLDOWN, function()
		winCooldown[player] = nil
	end)
end

-- The end platform is cloned into Workspace for each round. Watch its Win part.
local function hookEnd(endModel: Instance)
	local win = endModel:WaitForChild('Win', 5)
	if not win then
		return
	end

	local winPart = win :: BasePart
	winPart.Touched:Connect(function(hit: BasePart)
		-- A limb's parent is the character. Other parts are ignored.
		local player = Players:GetPlayerFromCharacter(hit.Parent :: Model)
		if player then
			awardWin(player)
		end
	end)
end

Workspace.ChildAdded:Connect(function(child)
	if child.Name == 'End' then
		hookEnd(child)
	end
end)
-- Connect an end platform that was already in Workspace when this script started.
local existingEnd = Workspace:FindFirstChild('End')
if existingEnd then
	hookEnd(existingEnd)
end

-- Spends points before adding time. Any other payload is ignored.
buyTime.OnServerEvent:Connect(function(player: Player, addTime: unknown)
	-- The store sends 30. Any other type or amount is rejected.
	if typeof(addTime) ~= 'number' or addTime ~= BONUS_TIME then
		return
	end

	local balance = points[player] or 0
	if balance < POINT_COST then
		return
	end

	setPoints(player, balance - POINT_COST)
	timeLeft.Value += BONUS_TIME
end)
