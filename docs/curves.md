---
title: Curves
name: Curves
id: curves
---

# Curves

**UI Tween** supports custom curves by passing in a **Simple Curve**. Below is an example of how to use a curve by creating a custom property and then passing it to one of the functions in the **UI Tween** API.

In the video below, you will see when the animation is played for the first time, it's rather boring. This is because it's using a Linear equation. A curve is created and passed to the function, which can create some interesting effects.

<iframe width="560" height="315" src="https://www.youtube.com/embed/mtGxd1rPO6k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

```lua
local UI_Tween = require(script:GetCustomProperty("UI_Tween"))
local image = script:GetCustomProperty("image"):WaitForObject()
local curve = script:GetCustomProperty("curve")

UI_Tween.rotate(image, 360, 4, curve)
```

Learn more about [Curves](https://docs.coregames.com/references/curves/).
