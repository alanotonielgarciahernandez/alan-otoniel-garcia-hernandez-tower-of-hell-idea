--!strict

-- Deadly parts are tagged Kill. Touching one removes the character's health.
local Kill = {}

local function hook(part: Instance)
	if not part:IsA('BasePart') then
		return
	end

	part.Touched:Connect(function(hit: BasePart)
		local character = hit.Parent
		if character == nil then
			return
		end

		local humanoid = character:FindFirstChild('Humanoid')
		if humanoid ~= nil and humanoid:IsA('Humanoid') then
			humanoid.Health = 0
		end
	end)
end

function Kill.start()
	local CollectionService = game:GetService('CollectionService')
	for _, part in CollectionService:GetTagged('Kill') do
		hook(part)
	end
	CollectionService:GetInstanceAddedSignal('Kill'):Connect(hook)
end

return Kill
