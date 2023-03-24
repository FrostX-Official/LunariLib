# Начинаем скриптить

## Как импортировать LunariLib?
Вы можете импортировать LunariLib из директории своего скрипта на гитхабе вот так:

```lua
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/LunariLib/main/luaCode/MainLib.lua"))()
```

## Ваш первый GUI
После импортирования библиотеки вы можете начать

## Сделайте окно

Используйте метод `.Load()` чтобы создать окно
```lua
local MainWindow = GuiLib.Load("Ваш GUI")
```

## Сделайте свою первую вкладку

Используйте метод `.AddTab()` на вашем окне, для того чтобы создать вкладку
```lua
local MainTab = MainWindow.AddTab("Tab1", "IconId")
```

## Добавьте кнопку с скриптом в вашу вкладку

Используйте метод `.AddButton()` на вкладке, чтобы сделать кнопку
```lua
local SomeButton = MainWindow.AddButton("Написать что-то", function() -- callback
    print("что-то")
end)
```

## Пример РЕАЛЬНОГО скрипта

Используйте метод `.AddButton()` на вкладке, чтобы сделать кнопку<br>
Мы сделаем скрипт который будет делать скорость игрока 50

```lua
local SomeButton = MainWindow.AddButton("Сделать скорость игрока 50", function() -- callback
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.WalkSpeed = 50
end)
```

### Вернёмся к штукам с GUI
## Добавить переключатели/чекеры ;O
Используйте метод `.AddCheckbox()` на вкладке, для того чтобы сделать переключатель.

```lua
local SomeToggle = MainWindow.AddCheckbox("Сделать что-то", function(value) -- callback
    print(value)
end)
```

## Добавим палитру цветов

Используйте метод `.AddColorpicker()` на вкладке, для того чтобы сделать палитру.

```lua
local SomeColorpicker = MainWindow.AddColorpicker(
    "Выберите цвет своего ника",
    function(colorValue) -- callback
        print(colorValue)
    end)
```
Аргументы `.AddColorpicker()`:
```lua
AddColorpicker(text, callback: func, default: Color3?)
```

## Добавим слайдеры <small>или же ползунки</small>

Используйте метод `.AddSlider()` на вкладке, для того чтобы сделать слайдер.

```lua
local SomeSlider = MainWindow.AddSlider(
    "Дальность Килл-Ауры",
    function(value) -- callback
        print(value)
    end, NumberRange.new(0, 200), 50)
```
Аргументы `.AddSlider()`:
```lua
AddSlider(text, callback, rangeValue: NumberRange?, default: number?)
```

## Добавим селекторы <small>или же дропдауны</small>

Используйте метод `.AddSelector()` на вкладке, для того чтобы сделать селектор.

<strong>ВНИМАНИЕ! параметр `onlyOne` до сих пор в разработке
<br>Поэтому я вам рекомендую вовсе его не использовать.</strong>

```lua
local SomeSelector = MainWindow.AddSelector(
    "Вещи чтобы поднимать", 
    {"Банан", "Яблоко", "Клубника", "Арбуз"}, 
    function(selected_values) -- callback
        for i, value in pairs(selected_values) do
            print(tostring(i)..". "..tostring(value))
        end
    end, false) -- false at the end means `onlyOne` parameter.
```