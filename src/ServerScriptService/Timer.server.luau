-- Counts down the shared round clock. Points.server.luau is what adds time.
local RepStor = game:GetService( 'ReplicatedStorage' );

-- The timer label reads this same IntValue.
local timeLeft = RepStor:WaitForChild( 'Value' );

-- One second per loop. Replicate Level sets the value back to 180 after it hits zero.
while wait( 1 ) do
	if timeLeft.Value <= 0 then
		break;
	end;

	timeLeft.Value -= 1;
end;
