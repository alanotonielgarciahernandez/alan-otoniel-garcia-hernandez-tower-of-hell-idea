--!strict

-- Owns each player's point balance. Timer only counts the clock down.
local Points = {}

local BONUS_TIME = 30 -- Seconds granted for one accepted purchase.
local POINT_COST = 100 -- Points spent on that purchase.
local WIN_REWARD = 100 -- Points given for reaching the end platform.
local WIN_COOLDOWN = 10 -- Seconds before the same player can score again.

Points.winCooldownSeconds = WIN_COOLDOWN

-- Returns the balance and clock after one purchase request. A rejected request leaves both unchanged.
function Points.applyPurchase(balance: number, clock: number, request: unknown): (number, number)
	if typeof(request) ~= 'number' or request ~= BONUS_TIME then
		return balance, clock
	end
	if balance < POINT_COST then
		return balance, clock
	end
	return balance - POINT_COST, clock + BONUS_TIME
end

-- Returns the balance after a win, and whether the cooldown is active.
function Points.applyWin(balance: number, onCooldown: boolean): (number, boolean)
	if onCooldown then
		return balance, true
	end
	return balance + WIN_REWARD, true
end

function Points.start()
	local Players = game:GetService('Players') :: Players
	local RepStor = game:GetService('ReplicatedStorage') :: ReplicatedStorage
	local Workspace = game:GetService('Workspace') :: Workspace

	-- Round clock. A purchase adds seconds here; Timer subtracts them.
	local timeLeft = RepStor:WaitForChild('Value') :: IntValue
	-- The store button fires this. The number it sends is checked below and is not trusted on its own.
	local buyTime = RepStor:WaitForChild('Remotes'):WaitForChild('BTEvent') :: RemoteEvent
	-- The win pad used to send the character to a fixed point inside the lobby floor.
	local spawnPad = Workspace:WaitForChild('Lobby'):WaitForChild('SpawnLocation') :: BasePart

	-- Authoritative balances. Editing the Points value from a client does not change this table.
	local points: { [Player]: number } = {}
	-- Players who just scored, so one touch cannot award points on every frame.
	local winCooldown: { [Player]: boolean } = {}
	-- A failed read must not be written back over the saved balance.
	local ready: { [Player]: boolean } = {}
	local DataStoreService = game:GetService('DataStoreService') :: DataStoreService
	local pointStore = DataStoreService:GetDataStore('PlayerPoints')

	local function save(player: Player)
		if not ready[player] then
			return
		end
		local amount = points[player]
		if amount == nil then
			return
		end
		local userId = player.UserId
		pcall(function()
			pointStore:SetAsync(tostring(userId), amount)
		end)
	end

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

		task.spawn(function()
			local ok, saved = pcall(function()
				return pointStore:GetAsync(tostring(player.UserId))
			end)
			if player.Parent == nil or not ok then
				return
			end
			if typeof(saved) == 'number' then
				setPoints(player, math.max(0, math.floor(saved)))
			end
			ready[player] = true
		end)
	end

	Players.PlayerAdded:Connect(addPlayer)
	-- Saves the balance, then drops the row so the tables do not keep growing.
	Players.PlayerRemoving:Connect(function(player: Player)
		save(player)
		points[player] = nil
		winCooldown[player] = nil
		ready[player] = nil
	end)
	-- A shutdown can skip PlayerRemoving, so write every loaded balance first.
	game:BindToClose(function()
		for _, player in Players:GetPlayers() do
			save(player)
		end
	end)
	-- Covers players who joined before this script connected PlayerAdded.
	for _, player in Players:GetPlayers() do
		addPlayer(player)
	end

	-- Grants the win reward once, then ignores that player until the cooldown ends.
	local function awardWin(player: Player)
		if not ready[player] then
			return
		end
		local balance = points[player]
		assert(balance, 'player has no point balance')
		local newBalance, cooling = Points.applyWin(balance, winCooldown[player] == true)
		if winCooldown[player] then
			return
		end

		winCooldown[player] = cooling
		setPoints(player, newBalance)
		task.spawn(save, player)
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
			local character = hit.Parent
			if character == nil then
				return
			end

			local player = Players:GetPlayerFromCharacter(character :: Model)
			if player then
				awardWin(player)
			end

			-- Stand above the spawn pad. Its center sits in the lobby floor.
			local root = character:FindFirstChild('HumanoidRootPart')
			if root ~= nil and root:IsA('BasePart') then
				root.CFrame = spawnPad.CFrame + Vector3.new(0, spawnPad.Size.Y / 2 + 3, 0)
			end
		end)
	end

	Workspace.ChildAdded:Connect(function(child: Instance)
		if child.Name == 'End' then
			hookEnd(child)
		end
	end)
	-- Connect an end platform that was already in Workspace when this module started.
	local existingEnd = Workspace:FindFirstChild('End')
	if existingEnd then
		hookEnd(existingEnd)
	end

	-- Spends points before adding time. Any other payload is ignored.
	buyTime.OnServerEvent:Connect(function(player: Player, addTime: unknown)
		-- The store sends 30. Any other type or amount is rejected.
		if not ready[player] then
			return
		end
		local balance = points[player] or 0
		local newBalance, newClock = Points.applyPurchase(balance, timeLeft.Value, addTime)
		if newBalance == balance and newClock == timeLeft.Value then
			return
		end

		setPoints(player, newBalance)
		task.spawn(save, player)
		timeLeft.Value = newClock
	end)
end

return Points
