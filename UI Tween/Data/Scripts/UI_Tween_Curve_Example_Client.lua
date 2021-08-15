local UI_Tween = require(script:GetCustomProperty("UI_Tween"))
local image = script:GetCustomProperty("image"):WaitForObject()
local curve = script:GetCustomProperty("curve")

UI_Tween.rotate(image, 360, 4, curve)