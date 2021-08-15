-- Require the UI Tween API by dropping it on your script as a custom property.

local UI_Tween = require(script:GetCustomProperty("UI_Tween"))

-- Everything below is for the examples

local eye_image = script:GetCustomProperty("eye_image"):WaitForObject()
local stick_panel = script:GetCustomProperty("stick_panel"):WaitForObject()
local heart_image = script:GetCustomProperty("heart_image"):WaitForObject()
local panel_notification = script:GetCustomProperty("panel_notification"):WaitForObject()
local progress_panel = script:GetCustomProperty("progress_panel"):WaitForObject()
local hello = script:GetCustomProperty("hello"):WaitForObject()
local funky_curve = script:GetCustomProperty("funky_curve")

-- Some bools just to prevent some animations from running before others
-- have been set in case the use presses the buttons out of order.

-- These are setup for the example, so might be a little confusing, so check the docs
-- for better examples for each effect and the properties.

local has_faded_in_eye = false
local has_slided_in_stick = false
local is_pulsing_heart = false
local is_rotating = false
local has_slide_down_fade_in = false
local has_progressed = false
local has_hello = false
local notification_scale = false
local has_punched = false
local is_curving = false

script:GetCustomProperty("fade_in_eye"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	UI_Tween.fade_in(eye_image, 1)
	has_faded_in_eye = true
end)

script:GetCustomProperty("fade_out_eye"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(has_faded_in_eye) then
		UI_Tween.fade_out(eye_image, 1)
	end
end)

script:GetCustomProperty("slide_right_stick"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(not has_slided_in_stick) then
		UI_Tween.slide_right(stick_panel, 475, .7, UI_Tween.Out_Bounce)
		has_slided_in_stick = true
	end
end)

script:GetCustomProperty("slide_left_stick"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(has_slided_in_stick) then
		UI_Tween.slide_left(stick_panel, 475, .7, UI_Tween.In_Back)
	end
end)

script:GetCustomProperty("image_pulse"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(not is_pulsing_heart) then
		UI_Tween.fade_in(heart_image, .6).pulse(heart_image)
		is_pulsing_heart = true
	end
end)

script:GetCustomProperty("image_rotate"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(is_pulsing_heart and not is_rotating) then
		is_rotating = true
		UI_Tween.rotate(heart_image, 360, 2, UI_Tween.In_Out_Circ, {

			complete = function()
				is_rotating = false
			end

		})
	end
end)

script:GetCustomProperty("slide_down_fade_in"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(not has_slide_down_fade_in) then
		UI_Tween.slide_down(panel_notification, 250, 1, UI_Tween.Out_Bounce).fade_in(panel_notification, 2).rotate(panel_notification, 360, 1, nil, {

			complete = function()
				has_slide_down_fade_in = true
			end

		})
	end
end)

script:GetCustomProperty("punch"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(has_slide_down_fade_in and not has_punched) then
		has_punched = true
		UI_Tween.punch(panel_notification, 50, .3, nil, {

			complete = function()
				has_punched = false
			end

		})
	end
end)

script:GetCustomProperty("progress"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(not has_progressed) then
		has_progressed = true
		UI_Tween.fade_in(progress_panel, 1, nil, {

			start = function()
				progress_panel:GetChildren()[1].progress = 0
			end,

			complete = function()
				UI_Tween.progress(progress_panel:GetChildren()[1], .75, 2, UI_Tween.Out_Bounce, {

					complete = function(obj)
						UI_Tween.fade_out(progress_panel, .6, nil, {

							complete = function()
								has_progressed = false
							end

						})
					end
				})
			end
		})
	end
end)

script:GetCustomProperty("shadow"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(not has_hello) then
		has_hello = true

		UI_Tween.fade_in(hello, 1, nil, {

			complete = function(obj)
				UI_Tween.shadow(obj, 10, 10, 1, UI_Tween.In_Out_Circ, { 

					complete = function(obj)
						UI_Tween.shadow(obj, -20, 10, 1, UI_Tween.In_Out_Circ, {

							complete = function(obj)
								UI_Tween.shadow(obj, 10, -20, 1, UI_Tween.In_Out_Circ).color(obj, obj:GetColor(), Color.WHITE, 1, nil, {

									complete = function()
										UI_Tween.fade_out(hello, 1, nil, {

											complete = function()
												has_hello = false
											end

										})
									end

								})
							end

						})
					end

				})
			end

		}).color(hello, hello:GetColor(), Color.PURPLE, 2)
	end
end)

script:GetCustomProperty("scale"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(has_slide_down_fade_in and not notification_scale) then
		UI_Tween.scale_width(panel_notification, 200, .5, UI_Tween.Out_Back, {

			complete = function(obj)
				UI_Tween.scale_width(obj, -200, 1, nil, {
					
					complete = function(obj)
						UI_Tween.slide_up(obj, 250, .8, UI_Tween.Out_Back, {

							complete = function()
								panel_notification.opacity = 0
								has_slide_down_fade_in = false
							end

						})
					end

				})
			end

		})
	end
end)

script:GetCustomProperty("curve"):WaitForObject():FindChildByType("Trigger").interactedEvent:Connect(function()
	if(is_pulsing_heart and not is_rotating and not is_curving) then
		is_curving = true

		UI_Tween.rotate(heart_image, 360, 2, funky_curve, {

			complete = function()
				is_curving = false
			end

		})
	end
end)