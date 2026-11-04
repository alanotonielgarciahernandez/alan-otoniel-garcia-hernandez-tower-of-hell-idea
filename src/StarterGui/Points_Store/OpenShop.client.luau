local UI = script.Parent;
local store = UI.Parent.ScrollingFrame;
local exit = UI.Parent.Exit;

UI.MouseButton1Click:Connect(function()
	store.Visible = true;
	exit.Visible = true;
end);
