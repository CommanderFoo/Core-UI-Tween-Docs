---
title: Events
name: Events
id: events
---

# Events

All functions in the **UI Tween** API support 3 events. Most useful being `complete`, which allows you to easily perform additional animations one after the other when they complete.

- `start`

	Parameters: `obj`

	This event is called when the animation starts.

- `Change`

	Parameters: `obj, value, delta_time`

	This event will constantly get called while the animation is in progress.

- `complete`

	Parameters: `obj`

	This event will be called when the animation has completed.

Below is an example of using all 3 events.

```lua
UI_Tween.progress(level_bar, .65, 2, UI_Tween.Out_Bounce, {

	start = function(obj)
		print("Animation Started")
	end,

	change = function(obj, value, dt)
		print("Animating", value)
	end,

	complete = function()
		print("Complete")

		-- Fade out bar

		UI_Tween.fade_out(level_bar)
	end
})
```
