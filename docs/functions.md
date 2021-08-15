---
title: Animation Functions
name: Animation Functons
id: functions
---

# Animation Functions

**UI Tween** comes with easy to use functions that do all the heavy lifting for you. A custom tweening library under the hood handles all the complex stuff so you can focus on making nice animations.

All functions support an easing argument which can either an enum from a list of easing equations supplied by **UI Tween**, or a **Curve**. See the [Easings](/easings.md) page for a full list of all supported types, and [Curves](/curves.md) for information on how to use a **Curve** with animations.

The **UI Tween** API supports animation chaining if you prefer to have animations grouped together per obj.

```lua
UI_Tween.progress(level_bar, .65, 2, UI_Tween.Out_Bounce).fade_out(level_bar)
```

In the above example, instead of putting the `fade_out` call on a new line, it can be chained on. Chaining doesn't mean it will create a sequence, both animations in the example code above will run at the same time.

If you need to delay animations between each other, then spawn a task to prevent blocking.

```lua
Task.Spawn(function()
	UI_Tween.progress(level_bar, .65, 2, UI_Tween.Out_Bounce)
	Task.Wait(5)
	UI_Tween.fade_out(level_bar)
end)
```

In the above example, the progress bar will be tweened, then 5 seconds later, it will fade out.

## Button Color

`UI_Tween.button_color(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.button_color(obj, obj:GetButtonColor(), Color.RED, 2)
```

## Button Hover Color

`UI_Tween.button_hover_color(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.button_hover_color(obj, obj:GetHoveredColor(), Color.RED, 2)
```

## Button Pressed Color

`UI_Tween.button_pressed_color(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.button_pressed_color(obj, obj:GetPressedColor(), Color.RED, 2)
```

## Button Disabled Color

`UI_Tween.button_disabled_color(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.button_disabled_color(obj, obj:GetDisabledColor(), Color.RED, 2)
```

## Color

`UI_Tween.color(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.color(obj, obj:GetColor(), Color.RED, 2)
```

## Fade

`UI_Tween.fade(obj, from, to, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.fade(obj, 0, .5, 1)
```

## Fade In

`UI_Tween.fade_in(obj, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.fade_in(obj, 1)
```

## Fade Out

`UI_Tween.fade_out(obj, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.fade_out(obj, 1)
```

## Font Size

`UI_Tween.font_size(obj, size, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.font_size(obj, 80, 3)
```

## Move

`UI_Tween.move(obj, x_distance, y_distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.move(obj, 300, -50, 2)
```

## Move X

`UI_Tween.move_x(obj, x_distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.move_x(obj, 300, 2)
```

## Move Y

`UI_Tween.move_y(obj, y_distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.move_y(obj, -100, 2)
```

## Progress

`UI_Tween.progress(obj, amount, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.move_y(obj, .75, 4, UI_Tween.Out_Bounce)
```

## Pulse

`UI_Tween.pulse(obj, size, duration, count, easing, events)`

```lua
-- Pulse constantly

local obj = script:GetCustomProperty("obj")

UI_Tween.pulse(obj)
```

```lua
-- Pulse 5 times with custom size

local obj = script:GetCustomProperty("obj")

UI_Tween.pulse(obj, 50, 1, 5, UI_Tween.Out_Sine)
```

## Punch

`UI_Tween.punch(obj, size, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.punch(obj)
```

## Rotate

`UI_Tween.rotate(obj, amount, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.rotate(obj, 360, .6)
```

## Rotate Right

`UI_Tween.rotate_right(obj, amount, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.rotate_right(obj, 360, .6)
```

## Rotate Left

`UI_Tween.rotate_left(obj, amount, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.rotate_left(obj, 360, .6)
```

## Scale

`UI_Tween.scale(obj, width, height, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.scale(obj, 400, 400, 1, UI_Tween.Out_Bounce)
```

## Scale Width

`UI_Tween.scale_width(obj, width, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.scale_width(obj, 400, 1, UI_Tween.Out_Bounce)
```

## Scale Height

`UI_Tween.scale_height(obj, width, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.scale_height(obj, 400, 1, UI_Tween.Out_Bounce)
```

## Shadow

`UI_Tween.shadow(obj, x_offset, y_offset, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.shadow(obj, 10, 10, 1, UI_Tween.In_Out_Circ)
```

## Shadow X

`UI_Tween.shadow_x(obj, x_offset, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.shadow_x(obj, 10, 1)
```

## Shadow Y

`UI_Tween.shadow_y(obj, y_offset, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.shadow_y(obj, 10, 1)
```

## Slide Right

`UI_Tween.slide_right(obj, distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.slide_right(obj, 500, 1.2, UI_Tween.Out_Bounce)
```

## Slide Left

`UI_Tween.slide_left(obj, distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.slide_left(obj, 500, 1.2, UI_Tween.Out_Bounce)
```

## Slide Up

`UI_Tween.slide_up(obj, distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.slide_up(obj, 200, 1.2)
```

## Slide Down

`UI_Tween.slide_down(obj, distance, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.slide_down(obj, 200, 1.2)
```

## Scroll

`UI_Tween.scroll(obj, offset, duration, easing, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.scroll(obj, 600, 5)
```

## Write

`UI_Tween.write(obj, text, speed, events)`

```lua
local obj = script:GetCustomProperty("obj")

UI_Tween.write(obj, "Hello World!")
```
