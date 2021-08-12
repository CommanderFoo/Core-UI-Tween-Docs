local UI_Tween = require(script:GetCustomProperty("UI_Tween"))

local panel = script:GetCustomProperty("panel"):WaitForObject()
local image = script:GetCustomProperty("image"):WaitForObject()

local curve = script:GetCustomProperty("curve")

-- UI_Tween.move_x(panel, 400, 1, UI_Tween.In_Back)
-- UI_Tween.move_y(panel, 400, 1, UI_Tween.In_Back)
-- UI_Tween.fade_out(panel, 1, UI_Tween.In_Back)

--UI_Tween.delay(1).pulse(panel, 1, 20, curve).wait(1).move_x(obj, 400, 1, UI_Tween.In_Back)

--UI_Tween.rotate_left(panel, 360, 1, UI_Tween.In_Back)

UI_Tween.move_x(panel, 400, 1, UI_Tween.In_Back)
UI_Tween.shadow(image, 15, 15, .5, curve).wait(.5).shadow_x(image, -30, .5, curve).pulse(image, 1, -1).wait(1).shadow_x(image, 30, 1, curve).shadow_x(image, -30, 1, curve).rotate(image, 360, 1)