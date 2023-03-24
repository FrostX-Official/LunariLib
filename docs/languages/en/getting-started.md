# Getting Started

## How to import LunariLib?

You can import LunariLib from yours github script directory like that:
```lua
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/LunariLib/main/luaCode/MainLib.lua"))()
```

## Your First GUI
After importing the library you can start

## Make your window

Use `.Load()` method to make window
```lua
local MainWindow = GuiLib.Load("Your GUI")
```

## Make your first tab

Use `.AddTab()` method on window to make a tab
```lua
local MainTab = MainWindow.AddTab("Tab1", "IconId")
```

## Add a button with script in your tab

Use `.AddButton()` method on tab to make a button
```lua
local SomeButton = MainWindow.AddButton("Print something", function() -- callback
    print("something")
end)
```

## Real script example

Use `.AddButton()` method on tab to make a button<br>
We'll make a script that makes player speed go to 50.

```lua
local SomeButton = MainWindow.AddButton("Make player's walkspeed 50", function() -- callback
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.WalkSpeed = 50
end)
```

### Back to the GUI thingies.
## Add Toggles/Checkboxes
Use `.AddCheckbox()` method on tab to make a checkbox/toggle

```lua
local SomeToggle = MainWindow.AddCheckbox("Do Something", function(value) -- callback
    print(value)
end)
```

## Add Colorpickers

Use `.AddColorpicker()` method on tab to make a colorpicker

```lua
local SomeColorpicker = MainWindow.AddColorpicker(
    "Select your nickname color",
    function(colorValue) -- callback
        print(colorValue)
    end)
```
`.AddColorpicker()` Arguments:
```lua
AddColorpicker(text, callback: func, default: Color3?)
```

## Add Sliders

Use `.AddSlider()` method on tab to make a slider

```lua
local SomeSlider = MainWindow.AddSlider(
    "Kill Aura Range",
    function(value) -- callback
        print(value)
    end, NumberRange.new(0, 200), 50)
```
`.AddSlider()` Arguments:
```lua
AddSlider(text, callback, rangeValue: NumberRange?, default: number?)
```

## Add Selectors <small>or dropdowns</small>

Use `.AddSelector()` method on tab to make a selector

<strong>WARNING! `onlyOne` parameter is still in developement
<br>so I recommend you to not use it at all</strong>

```lua
local SomeSelector = MainWindow.AddSelector(
    "Select Items to pickup", 
    {"Banana", "Apple", "Strawberry", "Watermelon"}, 
    function(selected_values) -- callback
        for i, value in pairs(selected_values) do
            print(tostring(i)..". "..tostring(value))
        end
    end, false) -- false at the end means `onlyOne` parameter.
```