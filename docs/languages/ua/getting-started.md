# Починаємо скриптити

## Як імпортувати LunariLib?
Ви можете імпортувати LunariLib з директорії свого скрипту на гітхабі:

```lua
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/LunariLib/main/luaCode/MainLib.lua"))()
```

## Ваш перший GUI
Після імпортування бібліотеки ви можете почати
## Зробіть вікно
Використовуйте метод `.Load()` щоб створити вікно
```lua
local MainWindow = GuiLib.Load("Ваш GUI")
```

## Зробіть свою першу вкладку

Використовуйте метод `.AddTab()` на вашому вікні, щоб створити вкладку
```lua
local MainTab = MainWindow.AddTab("Tab1", "IconId")
```

## Додати кнопку зі скриптом у вашу вкладку

Використовуйте метод `.AddButton()` на вкладці, щоб зробити кнопку
```lua
local SomeButton = MainWindow.AddButton("Написати щось", function() -- callback
    print("Щось")
end)
```

## Приклад РЕАЛЬНОГО Скрипту

Використовуйте метод `.AddButton()` на вкладці, щоб зробити кнопку<br>
Ми зробимо скрипт який робитиме швидкість гравця 50

```lua
local SomeButton = MainWindow.AddButton("Зробити швидкість гравця 50", function() -- callback
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.WalkSpeed = 50
end)
```

### Повернемося до штук з GUI
## Додати перемикачі/чекери
Використовуйте метод `.AddCheckbox()` на вкладці для того, щоб зробити перемикач

```lua
local SomeToggle = MainWindow.AddCheckbox("Зробити щось", function(value) -- callback
    print(value)
end)
```

## Додамо палітру кольорів

Використовуйте метод `.AddColorpicker()` на вкладці, щоб зробити палітру.

```lua
local SomeColorpicker = MainWindow.AddColorpicker(
    "Виберіть колір свого ніка",
    function(colorValue) -- callback
        print(colorValue)
    end)
```
Аргументи `.AddColorpicker()`:
```lua
AddColorpicker(text, callback: func, default: Color3?)
```

## Додамо слайдери <small>або повзунки</small>

Використовуйте метод `.AddSlider()` на вкладці, щоб зробити слайдер.

```lua
local SomeSlider = MainWindow.AddSlider(
    "Дальність Кілл-Аури",
    function(value) -- callback
        print(value)
    end, NumberRange.new(0, 200), 50)
```
Аргументи `.AddSlider()`:
```lua
AddSlider(text, callback, rangeValue: NumberRange?, default: number?)
```

## Додамо селектори <small>або дропдауни</small>

Використовуйте метод `.AddSelector()` на вкладці, щоб зробити селектор.

<strong>УВАГА! параметр `onlyOne` досі у розробці
<br>Тому я вам рекомендую його зовсім не використовувати.</strong>

```lua
local SomeSelector = MainWindow.AddSelector(
    "Речі щоб піднімати", 
    {"Банан", "Яблуко", "Полуниця", "Кавун"},
    function(selected_values) -- callback
        for i, value in pairs(selected_values) do
            print(tostring(i)..". "..tostring(value))
        end
    end, false)  -- false at the end means `onlyOne` parameter.
```