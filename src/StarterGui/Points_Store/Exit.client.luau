local btn = script.Parent;
local store = btn.Parent.ScrollingFrame;

btn.MouseButton1Click:Connect(function()
	btn.Visible = false;
	store.Visible = false;
end);
