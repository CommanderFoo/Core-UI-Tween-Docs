---
title: Easings
name: Easings
id: easings
---

# Easings

All functions in the **UI Tween** API support all the easings that can be previewed at [Easings.net](https://easings.net/). Below is a full list of the enums that can be passed into the functions used from the **UI Tween** API.

```lua
UI_Tween.progress(level_bar, .65, 2, UI_Tween.Out_Bounce)
```

In the above example, the progress bar will move to `.65` and bounce as it approaches the end because of the `UI_Tween.Out_Bounce` easing equation.

As well as the easings below, a **Curve** can also be passed to the function in replace of the easing.

- UI_Tween.Linear
- UI_Tween.In_Quad
- UI_Tween.Out_Quad
- UI_Tween.In_Out_Quad
- UI_Tween.Out_In_Quad
- UI_Tween.In_Cubic
- UI_Tween.Out_Cubic
- UI_Tween.In_Out_Cubic
- UI_Tween.Out_In_Cubic
- UI_Tween.In_Quart
- UI_Tween.Out_Quart
- UI_Tween.In_Out_Quart
- UI_Tween.Out_In_Quart
- UI_Tween.In_Quint
- UI_Tween.Out_Quint
- UI_Tween.In_Out_Quint
- UI_Tween.Out_In_Quint
- UI_Tween.In_Sine
- UI_Tween.Out_Sine
- UI_Tween.In_Out_Sine
- UI_Tween.Out_In_Sine
- UI_Tween.In_Expo
- UI_Tween.Out_Expo
- UI_Tween.In_Out_Expo
- UI_Tween.Out_In_Expo
- UI_Tween.In_Circ
- UI_Tween.Out_Circ
- UI_Tween.In_Out_Circ
- UI_Tween.Out_In_Circ
- UI_Tween.In_Elastic
- UI_Tween.Out_Elastic
- UI_Tween.In_Out_Elastic
- UI_Tween.Out_In_Elastic
- UI_Tween.In_Back
- UI_Tween.Out_Back
- UI_Tween.In_Out_Back
- UI_Tween.Out_In_Back
- UI_Tween.In_Bounce
- UI_Tween.Out_Bounce
- UI_Tween.In_Out_Bounce
- UI_Tween.Out_In_Bounce
