local RepStor = game:GetService("ReplicatedStorage");

local val = script.Parent;
local RemoteEvent = RepStor:WaitForChild("BTEvent");

RemoteEvent.OnServerEvent:Connect(function(plr, addTime)
	val.Value += addTime;
end);

while wait(1) do
	if val.Value <= 0 then
		break;
	end;
	val.Value -= 1;
end;
