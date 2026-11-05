--!strict

local UI = script.Parent :: GuiButton
local parent = UI.Parent :: GuiObject & {
	ScrollingFrame: ScrollingFrame,
	Exit: GuiButton,
}
local store = parent.ScrollingFrame
local exit = parent.Exit

UI.MouseButton1Click:Connect(function()
	store.Visible = true
	exit.Visible = true
end)
