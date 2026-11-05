--!strict

local btn = script.Parent :: GuiButton
local parent = btn.Parent :: GuiObject & { ScrollingFrame: ScrollingFrame }
local store = parent.ScrollingFrame

btn.MouseButton1Click:Connect(function()
	btn.Visible = false
	store.Visible = false
end)
