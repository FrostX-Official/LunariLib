local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local getGradientColor = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/LunariLib/main/luaCode/GetGradientOnSliderLib.lua"))()

local MainFont = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local MainFontBold = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local MainFontBlack = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)


local ColorPickerColorSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(1,0,0)),
	ColorSequenceKeypoint.new(0.2, Color3.new(1,1,0)),
	ColorSequenceKeypoint.new(0.4, Color3.new(0,1,0)),
	ColorSequenceKeypoint.new(0.6, Color3.new(0,1,1)),
	ColorSequenceKeypoint.new(0.8, Color3.new(0,0,1)),
	ColorSequenceKeypoint.new(1, Color3.new(1,0,1))
})

local LunariLib = {}

-- 2 functions below isn't used yet. Planning on adding proper elements sorting
-- so basically... TODO: Save GUI elements order and make them visible in order ;)

function csvToTable(list)
	local out = {}
	for entry in string.gmatch(list, "[^,]+") do
		table.insert(out, entry)
	end
	return out
end

function tableToCsv(list)
	return table.concat(list, ",")
end

local function GetXY(GuiObject)
	local X, Y = Mouse.X - GuiObject.AbsolutePosition.X, Mouse.Y - GuiObject.AbsolutePosition.Y
	local MaxX, MaxY = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	X, Y = math.clamp(X, 0, MaxX), math.clamp(Y, 0, MaxY)
	return X, Y, X/MaxX, Y/MaxY
end

local function UIFrame()
	local NewFrame = Instance.new("Frame")
	NewFrame.BorderSizePixel = 0
	return NewFrame
end

local function UIScrollingFrame()
	local NewScrollingFrame = Instance.new("ScrollingFrame")
	NewScrollingFrame.BackgroundTransparency = 1
	NewScrollingFrame.BorderSizePixel = 0
	NewScrollingFrame.ScrollBarThickness = 0
	return NewScrollingFrame
end

local function UITextButton(Text, Size)
	local NewTextButton = Instance.new("TextButton")
	NewTextButton.Text = Text
	NewTextButton.AutoButtonColor = false
	NewTextButton.FontFace = MainFont
	NewTextButton.TextColor3 = Color3.fromRGB(255,255,255)
	NewTextButton.BackgroundTransparency = 1
	NewTextButton.TextSize = Size or 12
	NewTextButton.Position = UDim2.new(0, 0, 0, 0)
	NewTextButton.Size = UDim2.new(1,0,1,0)
	return NewTextButton
end


local function UITextBox(Text, Size)
	local NewTextBox = Instance.new("TextBox")
	NewTextBox.PlaceholderText = Text
	NewTextBox.Text = ""
	NewTextBox.FontFace = MainFont
	NewTextBox.TextColor3 = Color3.fromRGB(255,255,255)
	NewTextBox.BackgroundTransparency = 1
	NewTextBox.TextSize = Size or 12
	NewTextBox.Size = UDim2.new(1,0,1,0)
	return NewTextBox
end

local function UITextLabel(Text, Size)
	local NewTextLabel = Instance.new("TextLabel")
	NewTextLabel.Text = Text
	NewTextLabel.FontFace = MainFont
	NewTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	NewTextLabel.BackgroundTransparency = 1
	NewTextLabel.TextSize = Size or 12
	
	NewTextLabel.Size = UDim2.new(0, 250, 0, 80)
	NewTextLabel.Position = UDim2.new(0, 0, 0, 0)
	
	return NewTextLabel
end

local function UIImageButton(Name, Icon)
	local NewImageButton = Instance.new("ImageButton")
	NewImageButton.Name = Name
	NewImageButton.Image = Icon


	NewImageButton.Size = UDim2.new(0, 50, 0, 50)
	NewImageButton.Position = UDim2.new(0, 0, 0, 0)

	return NewImageButton
end

local function UIPadding()
	local NewUIPadding = Instance.new("UIPadding")
	NewUIPadding.PaddingBottom = UDim.new(0, 0)
	NewUIPadding.PaddingTop = UDim.new(0, 11)
	NewUIPadding.PaddingRight = UDim.new(0, 11)
	NewUIPadding.PaddingLeft = UDim.new(0, 11)
	
	return NewUIPadding
end

local function MainUIPadding()
	local NewUIPadding = Instance.new("UIPadding")
	NewUIPadding.PaddingBottom = UDim.new(0.025, 0)
	NewUIPadding.PaddingTop = UDim.new(0.025, 0)
	NewUIPadding.PaddingRight = UDim.new(0.025, 0)
	NewUIPadding.PaddingLeft = UDim.new(0.025, 0)

	return NewUIPadding
end

local function UIPaddingZero()
	local NewUIPadding = Instance.new("UIPadding")
	NewUIPadding.PaddingBottom = UDim.new(0, 0)
	NewUIPadding.PaddingTop = UDim.new(0, 0)
	NewUIPadding.PaddingRight = UDim.new(0, 0)
	NewUIPadding.PaddingLeft = UDim.new(0, 0)

	return NewUIPadding
end

local function MainUIStroke()
	local NewUIStroke = Instance.new("UIStroke")
	NewUIStroke.Transparency = 0.24
	NewUIStroke.Thickness = 8
	NewUIStroke.LineJoinMode = Enum.LineJoinMode.Bevel
	NewUIStroke.Color = Color3.new(0, 0, 0)
	
	NewUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	return NewUIStroke
end

local function MainUICorner()
	local NewUICorner = Instance.new("UICorner")
	NewUICorner.CornerRadius = UDim.new(0, 16)

	return NewUICorner
end
local function UICorner1()
	local NewUICorner = Instance.new("UICorner")
	NewUICorner.CornerRadius = UDim.new(0.025, 0)

	return NewUICorner
end
local function UICorner2()
	local NewUICorner = Instance.new("UICorner")
	NewUICorner.CornerRadius = UDim.new(0, 8)

	return NewUICorner
end

local function UIRainbowGradient()
	local NewUIGradient = Instance.new("UIGradient")
	NewUIGradient.Color = ColorPickerColorSequence

	return NewUIGradient
end

local function UIListLayout()
	local NewUIListLayout = Instance.new("UIListLayout")
	NewUIListLayout.Padding = UDim.new(0.02, 0)
	NewUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	return NewUIListLayout
end

local function TabFrameListLayout()
	local NewUIListLayout = Instance.new("UIListLayout")
	NewUIListLayout.Padding = UDim.new(0, 11)
	NewUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	return NewUIListLayout
end

local function DefaultButton(Text, Size)
	local NewTextButton = Instance.new("TextButton")
	NewTextButton.Text = Text
	NewTextButton.AutoButtonColor = true
	NewTextButton.FontFace = MainFont
	NewTextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	NewTextButton.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	NewTextButton.TextSize = Size or 14
	NewTextButton.Size = UDim2.new(1, 0, 0, 35)

	local CornerForNextTextButton = UICorner2()
	CornerForNextTextButton.Parent = NewTextButton

	return NewTextButton
end

local function DefaultSelector(Text: string, Table: table, callback: func, onlyOne: bool?)
	local NewSelectorFrame = UIFrame()
	NewSelectorFrame.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	NewSelectorFrame.Size = UDim2.new(1, 0, 0, 150)

	local CornerForNewSelectorFrame = UICorner2()
	CornerForNewSelectorFrame.Parent = NewSelectorFrame
	
	--[[local SelectedValues = Instance.new("StringValue")
	SelectedValues.Name = "SelectedValues"--]]
	
	local SelectorName = UITextLabel(Text, 24)
	SelectorName.Position = UDim2.new(0, 0, 0.1, 0)
	SelectorName.Size = UDim2.new(1, 0, 0, 20)
	
	SelectorName.Name = "Name"
	SelectorName.Parent = NewSelectorFrame
	
	local SelectorItems = UIScrollingFrame()
	SelectorItems.Position = UDim2.new(0.037, 0, 0.357, 0)
	SelectorItems.Size = UDim2.new(0, 373, 0, 81)
	SelectorItems.BackgroundTransparency = 1
	
	SelectorItems.CanvasSize = UDim2.new(0,0,0,0)
	SelectorItems.AutomaticCanvasSize = Enum.AutomaticSize.Y
	
	SelectorItems.ScrollBarThickness = 3
	SelectorItems.ScrollBarImageColor3 = Color3.new(0.129412, 0.129412, 0.129412)
	
	SelectorItems.Name = "TableItems"
	SelectorItems.Parent = NewSelectorFrame
	
	local SelectorItemsListLayout = UIListLayout()
	SelectorItemsListLayout.Parent = SelectorItems
	
	local SelectorItemsStroke = MainUIStroke()
	SelectorItemsStroke.Thickness = 3
	SelectorItemsStroke.LineJoinMode = Enum.LineJoinMode.Round
	SelectorItemsStroke.Transparency = 0
	SelectorItemsStroke.Color = Color3.new(0.129412, 0.129412, 0.129412)
	
	SelectorItemsStroke.Parent = SelectorItems
	
	local selectedItemsTableOrig = {}
	
	for i, item in pairs(Table) do
		local NewItemButton = UITextButton(item, 18)
		NewItemButton.Size = UDim2.new(1, 0, 0, 27)
		NewItemButton.FontFace = MainFont
		
		NewItemButton.Name = item.." | SELECT"
		NewItemButton.Parent = SelectorItems
		
		NewItemButton.MouseButton1Click:Connect(function()	
			if not onlyOne then
				if table.find(selectedItemsTableOrig, item) then
					NewItemButton.FontFace = MainFont
					table.remove(selectedItemsTableOrig, selectedItemsTableOrig[item])
					
					callback(selectedItemsTableOrig)
				else
					table.insert(selectedItemsTableOrig, item)
					NewItemButton.FontFace =  MainFontBlack
					
					callback(selectedItemsTableOrig)
				end
			else
				selectedItemsTableOrig = {item}
				NewItemButton.FontFace =  MainFontBlack
				callback(selectedItemsTableOrig)
				
				warn("onlyOne bool indev.")
			end
		end)
	end

	return NewSelectorFrame
end

local function DefaultCheckbox(Text, toggled)
	local NewCheckbox = UIFrame()
	NewCheckbox.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	NewCheckbox.Size = UDim2.new(1, 0, 0, 35)
	
	local CheckboxName = UITextLabel(Text, 24)
	CheckboxName.TextColor3 = Color3.new(1, 1, 1)
	CheckboxName.BackgroundTransparency = 1
	CheckboxName.Position = UDim2.new(0.084, 0, 0, 0)
	CheckboxName.Size = UDim2.new(0, 370, 0, 35)
	
	CheckboxName.Parent = NewCheckbox

	local CornerForNewCheckbox = UICorner2()
	CornerForNewCheckbox.Parent = NewCheckbox
	
	local ToggleColorFrame = UIFrame()
	ToggleColorFrame.Size = UDim2.new(0, 35, 0, 35)
	ToggleColorFrame.BackgroundColor3 = Color3.new(1, 0.352941, 0.352941)
	ToggleColorFrame.BackgroundTransparency = 0
	
	ToggleColorFrame.Name = "ToggleColor"
	
	ToggleColorFrame.Parent = NewCheckbox
	
	local CornerForToggleButton = UICorner2()
	CornerForToggleButton.Parent = ToggleColorFrame
	
	local TriggerButton = UITextButton("", 1)
	TriggerButton.Size = UDim2.new(1, 0, 1, 0)
	TriggerButton.BackgroundColor3 = Color3.new(0, 0, 0)
	TriggerButton.TextTransparency = 1

	TriggerButton.Name = "TriggerButton"
	TriggerButton.Parent = NewCheckbox

	local CornerForTriggerButton = UICorner2()
	CornerForTriggerButton.Parent = TriggerButton

	return NewCheckbox
end

local function DefaultColorpicker(Text, default)
	local NewColorpicker = UIFrame()
	NewColorpicker.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	NewColorpicker.Size = UDim2.new(1, 0, 0, 102)
	
	local CornerForNewColorpicker = UICorner2()
	CornerForNewColorpicker.Parent = NewColorpicker

	local ColorpickerName = UITextLabel(Text, 20)
	ColorpickerName.TextColor3 = Color3.new(1, 1, 1)
	ColorpickerName.BackgroundTransparency = 1
	ColorpickerName.Position = UDim2.new(0.251, 0, 0.147, 0)
	ColorpickerName.Size = UDim2.new(0, 287, 0, 15)
	ColorpickerName.TextXAlignment = Enum.TextXAlignment.Left
	
	ColorpickerName.Name = "PickerName"
	ColorpickerName.Parent = NewColorpicker
	
	local PickedColor = UIFrame()
	PickedColor.Size = UDim2.new(0, 72, 0, 72)
	PickedColor.Position = UDim2.new(0.037, 0, 0.147, 0)
	PickedColor.BackgroundColor3 = default
	
	PickedColor.Name = "PickedColor"
	PickedColor.Parent = NewColorpicker
	
	local CornerForPickedColor = UICorner2()
	CornerForPickedColor.CornerRadius = UDim.new(0.2, 0)
	CornerForPickedColor.Parent = PickedColor
	
	local ColorFrame = UIFrame()
	ColorFrame.Position = UDim2.new(0.251, 0, 0.402, 0)
	ColorFrame.Size = UDim2.new(0, 287, 0, 46)
	ColorFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	
	ColorFrame.Name = "Color"
	ColorFrame.Parent = NewColorpicker
	
	local Gradient = UIRainbowGradient()
	Gradient.Name = "Rainbow"
	Gradient.Parent = ColorFrame
	
	local Picker = UIFrame()
	Picker.BackgroundColor3 = Color3.new(0, 0, 0)
	Picker.Size = UDim2.new(0.015, 0, 1, 0)
	
	Picker.Name = "Picker"
	Picker.Parent = ColorFrame
	
	local TriggerButton = UITextButton("", 1)
	TriggerButton.Size = UDim2.new(1, 0, 1, 0)
	
	TriggerButton.Name = "TriggerButton"
	TriggerButton.Parent = ColorFrame

	return NewColorpicker
end

local function DefaultSlider(Text, value, valuesRange: NumberRange)
	local NewSlider = UIFrame()
	NewSlider.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	NewSlider.Size = UDim2.new(1, 0, 0, 82)

	local SliderName = UITextLabel(Text, 24)
	SliderName.TextColor3 = Color3.new(1, 1, 1)
	SliderName.BackgroundTransparency = 1
	SliderName.Position = UDim2.new(0, 0, 0.15, 0)
	SliderName.Size = UDim2.new(1, 0, 0.135, 0)
	
	SliderName.Name = "Name"
	SliderName.Parent = NewSlider

	local CornerForNewSlider = UICorner2()
	CornerForNewSlider.Parent = NewSlider
	
	local ValueText = UITextLabel(value.."/"..valuesRange.Max, 18)
	ValueText.Position = UDim2.new(0, 0, 0.37, 0)
	ValueText.Size = UDim2.new(1, 0, 0.19, 0)
	ValueText.BackgroundTransparency = 1
	ValueText.TextColor3 = Color3.new(0.392157, 0.392157, 0.392157)
	
	ValueText.Name = "ValueText"
	ValueText.Parent = NewSlider
	
	local SliderBar = UIFrame()
	SliderBar.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
	SliderBar.Position = UDim2.new(0.04, 0, 0.68, 0)
	SliderBar.Size = UDim2.new(0, 370, 0, 16)
	SliderBar.BorderSizePixel = 0
	
	SliderBar.Name = "SliderBar"
	SliderBar.Parent = NewSlider
	
	local CornerForSliderBar = UICorner2()
	CornerForSliderBar.CornerRadius = UDim.new(0, 6)
	CornerForSliderBar.Parent = SliderBar
	
	local Slider = UIFrame()
	Slider.BackgroundColor3 = Color3.new(1, 1, 1)
	Slider.Size = UDim2.new(0, 0, 1, 0)
	Slider.BorderSizePixel = 0
	
	Slider.Name = "Slider"
	Slider.Parent = SliderBar
	
	local CornerForSlider = UICorner2()
	CornerForSlider.CornerRadius = UDim.new(0, 6)
	CornerForSlider.Parent = Slider
	
	local SliderButton = UITextButton("", 1)
	SliderButton.BackgroundTransparency = 1
	SliderButton.Position = UDim2.new(0.04, 0, 0.68, 0)
	SliderButton.Size = UDim2.new(0, 370, 0, 16)

	SliderButton.Name = "SliderButton"
	SliderButton.Parent = NewSlider
	
	local X, Y, XScale, YScale = GetXY(SliderButton)
	local finalSliderSize = (valuesRange.Min + ((valuesRange.Max - valuesRange.Min) * XScale))
	
	Slider.Size = UDim2.new(finalSliderSize/valuesRange.Max, 0, 1, 0)
	
	return NewSlider
end

local abbs = {
	K = 4,
	M = 7,
	B = 10,
	T = 13,
	Qa = 16,
	Qu = 19
}

function LunariLib.Abbreviate(number)
	local text = tostring(math.floor(number))
	local chosenAbb
	for abb, digits in pairs(abbs) do
		if #text >= digits and #text < (digits + 3) then
			chosenAbb = abb
			break
		end
	end
	if chosenAbb then
		local digits = abbs[chosenAbb]
		local rounded = math.floor(tonumber(number) / 10 ^ (digits - 2)) * 10 ^ (digits - 2)
		local return_data = string.format("%.1f", rounded / 10 ^ (digits - 1))..chosenAbb
		text = return_data
	else
		local return_data = number
		text = return_data
	end
	return text
end

local function updateVisible(TabFrame, focusedTab)
	for i, container in next, TabFrame.TabContentContainers:GetChildren() do
		if container.Name == focusedTab.." Container" then
			for i, thing in next, container:GetChildren() do
				if thing:IsA("GuiObject") then
					thing.Visible = true
				end
			end
		else
			for i, thing in next, container:GetChildren() do
				if thing:IsA("GuiObject") then
					thing.Visible = false
				end
			end
		end
	end
end

function LunariLib.Load(GUITitle)
	local TargetedParent = RunService:IsStudio() and Player:WaitForChild("PlayerGui") or CoreGuiService

	local FindOldInstance = TargetedParent:FindFirstChild(GUITitle)

	if FindOldInstance then
		FindOldInstance:Destroy()
	end

	local NewInstance, MainFrame

	NewInstance = Instance.new("ScreenGui")
	NewInstance.Name = GUITitle
	NewInstance.Parent = TargetedParent

	MainFrame = UIFrame()
	MainFrame.Name = "Main"
	MainFrame.Size = UDim2.new(0, 537, 0, 344)
	MainFrame.Position = UDim2.new(0.248, 0, 0.227, 0)
	MainFrame.Parent = NewInstance
	
	MainFrame.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176)
	MainFrame.BackgroundTransparency = 0
	
	
	
	--[[ m a i n   t h i n g s ]] --
	
	
	local MainLib = {}
	
	
	local MainFramePadding = MainUIPadding()
	MainFramePadding.Parent = MainFrame
	local MainFrameCorner = MainUICorner()
	MainFrameCorner.Parent = MainFrame
	local MainFrameStroke = MainUIStroke()
	MainFrameStroke.Parent = MainFrame
	
	
	
	local GuiName = UITextLabel(GUITitle, 20)
	GuiName.Parent = MainFrame
	
	GuiName.Name = "GuiName"
	GuiName.TextColor3 = Color3.new(1, 1, 1)
	GuiName.FontFace.Weight = Enum.FontWeight.SemiBold
	GuiName.BackgroundTransparency = 0.8
	GuiName.BackgroundColor3 = Color3.new(0, 0, 0)
	
	GuiName.BorderSizePixel = 0
	
	local font = MainFont
	font.Weight = Enum.FontWeight.SemiBold
	GuiName.FontFace = font
	
	GuiName.Position = UDim2.new(0, 0, 0, 0)
	GuiName.Size = UDim2.new(0, 514, 0, 28)
	
	-- [[ m o v i n   t h e   g u i  ]] --	
	
	local DragButton = UITextButton("", 1)
	DragButton.Position = UDim2.new(-0.025, 0, -0.035, 0)
	DragButton.Size = UDim2.new(0, 537, 0, 40)
	DragButton.TextTransparency = 1
	DragButton.BackgroundTransparency = 1
	
	DragButton.Name = "DragButton"
	DragButton.Parent = MainFrame
	
	DragButton.MouseButton1Down:Connect(function()
		local LastMX, LastMY = Mouse.X, Mouse.Y
		local Move, Kill

		Move = Mouse.Move:Connect(function()
			local NewMX, NewMY = Mouse.X, Mouse.Y
			local DX, DY = NewMX - LastMX, NewMY - LastMY
			MainFrame.Position += UDim2.new(0,DX,0,DY)
			LastMX, LastMY = NewMX, NewMY
		end)

		Kill = UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Move:Disconnect()
				Kill:Disconnect()
			end
		end)
	end)
	
	--[[ t a b s ]] --
	
	local Tabs = UIScrollingFrame()
	Tabs.BackgroundColor3 = Color3.new(0,0,0)
	Tabs.BackgroundTransparency = 0.8
	Tabs.Size = UDim2.new(0, 85, 0, 286)
	Tabs.Position = UDim2.new(0, 0, 0.1, 0)
	Tabs.ScrollBarThickness = 0
	Tabs.ScrollBarImageTransparency = 1
	
	Tabs.Name = "Tabs"
	
	Tabs.Parent = MainFrame
	
	local TabsPadding = UIPaddingZero()
	TabsPadding.PaddingTop = UDim.new(0.02, 0)
	TabsPadding.Parent = Tabs

	local TabsLayout = UIListLayout()
	TabsLayout.Parent = Tabs
	

	local TabFrame = UIScrollingFrame()
	TabFrame.Position = UDim2.new(0, 90, 0.1, 0)
	TabFrame.Size = UDim2.new(0, 425, 0, 285)
	TabFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	TabFrame.BackgroundTransparency = 0.8
	TabFrame.ScrollBarThickness = 3
	TabFrame.ScrollBarImageTransparency = 0.5
	TabFrame.Name = "TabFrame"
	TabFrame.Parent = MainFrame
	
	TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	
	TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	
	local TabFramePadding = UIPaddingZero()
	TabFramePadding.PaddingTop = UDim.new(0, 11)
	TabFramePadding.PaddingRight = UDim.new(0, 11)
	TabFramePadding.PaddingLeft = UDim.new(0, 11)
	TabFramePadding.PaddingBottom = UDim.new(0, 16)
	
	TabFramePadding.Parent = TabFrame
	
	local TabFrameListLayout = TabFrameListLayout()
	TabFrameListLayout.Parent = TabFrame
	
	function MainLib.Delete()
		NewInstance:Destroy()
	end
	
	
	local Containers = Instance.new("Folder")
	Containers.Name = "TabContentContainers"
	Containers.Parent = TabFrame
	
	local focusedTab = ""
	
	function MainLib.AddTab(TabTitle, TabIcon)
		local TabLib = {}
		
		local Tab = UIImageButton(TabTitle.." Button", TabIcon)
		Tab.BackgroundTransparency = 0.8
		Tab.BackgroundColor3 = Color3.new(0, 0, 0)
		Tab.Parent = Tabs
		
		local TabCorner = UICorner1()
		TabCorner.CornerRadius = UDim.new(0.2, 0)
		TabCorner.Parent = Tab
		
		local TabContentContainer = Instance.new("Folder")
		TabContentContainer.Name = TabTitle.." Container"
		
		TabContentContainer.Parent = Containers
		
		local TabContentContainerPadding = TabFramePadding:Clone()
		TabContentContainerPadding.Parent = TabContentContainer
		
		local TabContentContainerListLayout = TabFrameListLayout:Clone()
		TabContentContainerListLayout.Parent = TabContentContainer--]]
		
		if not focusedTab then
			focusedTab = TabTitle
			
			updateVisible(TabFrame, focusedTab)
		end
		
		Tab.MouseButton1Click:Connect(function()
			focusedTab = TabTitle
			
			updateVisible(TabFrame, focusedTab)
		end)
		
		function TabLib.AddButton(text, callback)
			local Button = DefaultButton(text)
			Button.Name = text.." | BUTTON"
			
			Button.Parent = TabContentContainer
			
			Button.MouseButton1Click:Connect(function()
				callback()
			end)
			
			updateVisible(TabFrame, focusedTab)
		end
		
		function TabLib.AddSelector(text, itemsTable, callback, onlyOne)
			local Selector = DefaultSelector(text, itemsTable, callback)
			
			Selector.Name = text.." | SELECTOR"
			Selector.Parent = TabContentContainer

			updateVisible(TabFrame, focusedTab)
		end
		
		function TabLib.AddCheckbox(text, callback, default)
			local CheckBoxLib = {}
			
			local thisCheckbox = default or false

			local Checkbox = DefaultCheckbox(text, thisCheckbox)
			
			Checkbox.Name = text.." | CHECKBOX"

			Checkbox.Parent = TabContentContainer

			Checkbox.TriggerButton.MouseButton1Click:Connect(function()
				if thisCheckbox then
					callback(false)
					
					thisCheckbox = false
					
					Checkbox.ToggleColor.BackgroundColor3 = Color3.new(1, 0.352941, 0.352941)
				else
					callback(true)
					
					thisCheckbox = true
					
					Checkbox.ToggleColor.BackgroundColor3 = Color3.new(0.352941, 1, 0.352941)
				end
			end)
			
			function CheckBoxLib.GetValue()
				return thisCheckbox
			end
			
			updateVisible(TabFrame, focusedTab)
			
			return CheckBoxLib
		end
		
		function TabLib.AddColorpicker(text, callback, default: Color3?)
			local ColorpickerLib = {}

			local thisColorpicker = default or Color3.new(1, 0, 0)

			local Colorpicker = DefaultColorpicker(text, thisColorpicker)
			Colorpicker.Name = text.." | COLORPICKER"
			Colorpicker.Parent = TabContentContainer

			local PickerArea = Colorpicker.Color
			local Picker = PickerArea.Picker

			local minXPos = PickerArea.AbsolutePosition.X
			local maxXPos = minXPos+PickerArea.AbsoluteSize.X
			local xPixelSize = maxXPos-minXPos

			local ColorKeyPoints = PickerArea.Rainbow.Color.Keypoints

			local PickedColorFrame = Colorpicker.PickedColor

			Colorpicker.Color.TriggerButton.MouseButton1Down:Connect(function()
				local xPos = (Mouse.X-minXPos)/xPixelSize
				
				print(xPos)
				
				if xPos < 1 and xPos > 0 then
					Picker.Position = UDim2.new(xPos,0,0,0)

					thisColorpicker = getGradientColor(xPos, ColorKeyPoints)
					callback(thisColorpicker)

					PickedColorFrame.BackgroundColor3 = thisColorpicker
				end

				local Move, Kill

				Move = Mouse.Move:Connect(function()
					local xPos = (Mouse.X-minXPos)/xPixelSize
					
					print(xPos)
					
					if xPos < 1 and xPos > 0 then
						Picker.Position = UDim2.new(xPos,0,0,0)

						thisColorpicker = getGradientColor(xPos, ColorKeyPoints)
						callback(thisColorpicker)

						PickedColorFrame.BackgroundColor3 = thisColorpicker
					end
				end)

				Kill = UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Move:Disconnect()
						Kill:Disconnect()
					end
				end)
			end)


			function ColorpickerLib.GetValue()
				return thisColorpicker
			end

			return ColorpickerLib
		end
		
		function TabLib.AddSlider(text, callback, rangeValue: NumberRange?, default: number?)
			local SliderLib = {}
			
			-- if you don't provide min and max values table it will be 0 to 100 by default.
			-- if you don't provide default value, default value will be minValue
			
			local minValue = rangeValue.Min or 0
			local maxValue = rangeValue.Max or 100
			
			local thisSlider = default or minValue

			local Slider = DefaultSlider(text, thisSlider, rangeValue)

			Slider.Name = text.." | SLIDER"
			Slider.Parent = TabContentContainer
			
			Slider.SliderButton.MouseButton1Down:Connect(function(input)
				local X, Y, XScale, YScale = GetXY(Slider.SliderButton)
				thisSlider = (minValue + ((maxValue - minValue) * XScale))
				
				Slider.SliderBar.Slider.Size = UDim2.new(thisSlider/maxValue, 0, 1, 0)
				Slider.ValueText.Text = string.format("%.1f", thisSlider)
				
				callback(thisSlider)
				
				local SliderMove, SliderKill
				
				SliderMove = Mouse.Move:Connect(function()
					local X, Y, XScale, YScale = GetXY(Slider.SliderButton)
					thisSlider = (minValue + ((maxValue - minValue) * XScale))
					callback(thisSlider)
					Slider.ValueText.Text = string.format("%.1f", thisSlider)
					Slider.SliderBar.Slider.Size = UDim2.new(thisSlider/maxValue, 0, 1, 0)
				end)
				
				SliderKill = UserInputService.InputEnded:Connect(function(UserInput)
					if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
						SliderMove:Disconnect()
						SliderKill:Disconnect()
					end
				end)
			end)

			function SliderLib.GetValue()
				return thisSlider
			end
			
			updateVisible(TabFrame, focusedTab)

			return SliderLib
		end
		
		return TabLib
	end
	
	return MainLib
end


return LunariLib