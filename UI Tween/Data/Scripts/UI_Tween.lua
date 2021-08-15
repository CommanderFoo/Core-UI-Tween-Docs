-- This is UI_Tween API.
-- This is not documented because you should not need to 
-- modify anything in here unless you really know what you
-- are doing.

local Ticker = {}

function Ticker:tick(fn)
	self.st = time()

	self.ticking_task = Task.Spawn(function()	
		self.dt = time() - self.st

		fn(self.dt)
	end)

	self.ticking_task.repeatCount = -1
end

function Ticker:cancel()
	if(self.ticking_task ~= nil) then
		self.ticking_task:Cancel()
		self.ticking_task = nil
	end
end

function Ticker:new(fn)
	self.__index = self

	return setmetatable({}, self)
end

local UI_Tween = require(script:GetCustomProperty("UI_Tween_Easings"))

function UI_Tween.get_ease(easing, dt, duration, start, to)
	easing = easing or UI_Tween.Linear

	if(type(easing) == "userdata" and easing.type == "SimpleCurve") then
		local val = easing:GetValue(dt / duration)

		return (to - start) * val + start, true
	end

	return easing(dt, start, to - start, duration), false
end

function UI_Tween.fade(obj, from, to, duration, easing, events)
	if(not Object.IsValid(obj)) then
		return
	end

	duration = duration or 0
	events = events or {}

	local ticker = Ticker:new()
	local color = nil
	local start = from
	local use_alpha = false

	if(obj.type == "UIImage" or obj.type == "UIText") then
		use_alpha = true
	end

	if(use_alpha) then
		color = obj:GetColor()
		start = color.a
	else
		start = obj.opacity
	end

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			local val = UI_Tween.get_ease(easing, dt, duration, start, to)

			if(use_alpha) then
				color.a = val

				obj:SetColor(color)
			else
				obj.opacity = val
			end

			if(events.change ~= nil) then
				events.change(obj, val, dt)
			end
		else
			ticker:cancel()
			ticker = nil

			if(use_alpha) then
				color.a = to

				obj:SetColor(color)
			else
				obj.opacity = to
			end

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.move(obj, x_distance, y_distance, duration, easing, events)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}
	
	local start_x = obj.x
	local to_x = start_x + (x_distance or 0)

	local start_y = obj.y
	local to_y = start_y + (y_distance or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			if(x_distance ~= nil) then
				obj.x = UI_Tween.get_ease(easing, dt, duration, start_x, to_x)
			end

			if(y_distance ~= nil) then
				obj.y = UI_Tween.get_ease(easing, dt, duration, start_y, to_y)
			end

			if(events.change ~= nil) then
				events.change(obj, obj.x, obj.y, dt)
			end
		else
			ticker:cancel()
			ticker = nil

			if(x_distance ~= nil) then
				obj.x = to_x
			end

			if(y_distance ~= nil) then
				obj.y = to_y
			end

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.scale(obj, width, height, duration, easing, events)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local start_width = obj.width
	local to_width = start_width + (width or 0)

	local start_height = obj.height
	local to_height = start_height + (height or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			if(width ~= nil) then
				obj.width = math.floor(UI_Tween.get_ease(easing, dt, duration, start_width, to_width))
			end

			if(height ~= nil) then
				obj.height = math.floor(UI_Tween.get_ease(easing, dt, duration, start_height, to_height))
			end

			if(events.change ~= nil) then
				events.change(obj, obj.width, obj.height, dt)
			end
		else
			ticker:cancel()
			ticker = nil

			if(width ~= nil) then
				obj.width = to_width
			end

			if(height ~= nil) then
				obj.height = to_height
			end

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.rotate(obj, amount, duration, easing, events)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local start_amount = obj.rotationAngle
	local to_amount = start_amount + (amount or 0)
	
	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			obj.rotationAngle = UI_Tween.get_ease(easing, dt, duration, start_amount, to_amount)

			if(events.change ~= nil) then
				events.change(obj, obj.rotationAngle, dt)
			end
		else
			ticker:cancel()
			ticker = nil

			if(amount ~= nil) then
				obj.rotationAngle = to_amount
			end

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.shadow(obj, x_offset, y_offset, duration, easing, events)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local cur_offset = obj:GetShadowOffset()

	local start_x = cur_offset.x
	local to_x = start_x + (x_offset or 0)

	local start_y = cur_offset.y
	local to_y = start_y + (y_offset or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			local x = start_x
			local y = start_y

			if(x_offset ~= nil) then
				x = UI_Tween.get_ease(easing, dt, duration, start_x, to_x)
			end

			if(y_offset ~= nil) then
				y = UI_Tween.get_ease(easing, dt, duration, start_y, to_y)
			end

			obj:SetShadowOffset(Vector2.New(x, y))

			if(events.change ~= nil) then
				events.change(obj, x, y, dt)
			end
		else
			ticker:cancel()
			ticker = nil
			
			local x = to_x
			local y = to_y

			if(x_offset ~= nil) then
				x = to_x
			end

			if(y_offset ~= nil) then
				y = to_y
			end

			obj:SetShadowOffset(Vector2.New(x, y))

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.font_size(obj, size, duration, easing, events)
	if(not Object.IsValid(obj) and (obj.type ~= "UIText" and obj.type ~= "UIButton")) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local start_size = obj.fontSize
	local to_size = start_size + (size or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			obj.fontSize = math.floor(UI_Tween.get_ease(easing, dt, duration, start_size, to_size))

			if(events.change ~= nil) then
				events.change(obj, obj.fontSize, dt)
			end
		else
			ticker:cancel()
			ticker = nil
			
			obj.fontSize = to_size

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.progress(obj, amount, duration, easing, events)
	if(not Object.IsValid(obj) or obj.type ~= "UIProgressBar") then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local start = obj.progress
	local to = start + (amount or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			obj.progress = UI_Tween.get_ease(easing, dt, duration, start, to)

			if(events.change ~= nil) then
				events.change(obj, obj.progress, dt)
			end
		else
			ticker:cancel()
			ticker = nil
			
			obj.progress = to

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.scroll(obj, offset, duration, easing, events)
	if(not Object.IsValid(obj) or obj.type ~= "UIScrollPanel") then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local start = obj.scrollPosition
	local to = start + (offset or 0)

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			obj.scrollPosition = UI_Tween.get_ease(easing, dt, duration, start, to)

			if(events.change ~= nil) then
				events.change(obj, obj.scrollPosition, dt)
			end
		else
			ticker:cancel()
			ticker = nil

			obj.scrollPosition = to

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.color(obj, from, to, duration, easing, events, method)
	if(not Object.IsValid(obj) or (obj.type ~= "UIImage" and obj.type ~= "UIText" and obj.type ~= "UIProgressBar" and obj.type ~= "UIButton")) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0
	events = events or {}

	local is_progress = false
	local is_button = false

	if(events.start ~= nil) then
		events.start(obj)
	end

	if(obj.type == "UIProgressBar") then
		is_progress = true
	elseif(obj.type == "UIButton") then
		is_button = true
		method = method or "SetFontColor"
	end

	if(events.start ~= nil) then
		events.start(obj)
	end

	ticker:tick(function(dt)
		if(dt < duration) then
			local r = UI_Tween.get_ease(easing, dt, duration, from.r, to.r)
			local g = UI_Tween.get_ease(easing, dt, duration, from.g, to.g)
			local b = UI_Tween.get_ease(easing, dt, duration, from.b, to.b)
			local a = UI_Tween.get_ease(easing, dt, duration, from.a, to.a)

			if(is_progress) then
				obj:SetFillColor(Color.New(r, g, b, a))
			elseif(is_button) then
				obj[method](obj, Color.New(r, g, b, a))
			else
				obj:SetColor(Color.New(r, g, b, a))
			end

			if(events.change ~= nil) then
				events.change(r, g, b, a, dt)
			end
		else
			ticker:cancel()
			ticker = nil
			
			if(is_progress) then
				obj:SetFillColor(to)
			elseif(is_button) then
				obj[method](obj, to)
			else
				obj:SetColor(to)
			end

			if(events.complete ~= nil) then
				events.complete(obj)
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.button_color(obj, from, to, duration, easing, events)
	return UI_Tween.color(obj, from, to, duration, easing, events, "SetButtonColor")
end

function UI_Tween.button_hover_color(obj, from, to, duration, easing, events)
	return UI_Tween.color(obj, from, to, duration, easing, events, "SetHoveredColor")
end

function UI_Tween.button_pressed_color(obj, from, to, duration, easing, events)
	return UI_Tween.color(obj, from, to, duration, easing, events, "SetPressedColor")
end

function UI_Tween.button_disabled_color(obj, from, to, duration, easing, events)
	return UI_Tween.color(obj, from, to, duration, easing, events, "SetDisabledColor")
end

function UI_Tween.fade_out(obj, duration, easing, events)
	return UI_Tween.fade(obj, 1, 0, duration or 1, easing, events)
end

function UI_Tween.fade_in(obj, duration, easing, events)
	return UI_Tween.fade(obj, 0, 1, duration or 1, easing, events)
end

function UI_Tween.move_x(obj, x_distance, duration, easing, events)
	return UI_Tween.move(obj, x_distance, nil, duration, easing, events)
end

function UI_Tween.move_y(obj, y_distance, duration, easing, events)
	return UI_Tween.move(obj, nil, y_distance, duration, easing, events)
end

function UI_Tween.scale_width(obj, width, duration, easing, events)
	return UI_Tween.scale(obj, width, nil, duration, easing, events)
end

function UI_Tween.scale_height(obj, height, duration, easing, events)
	return UI_Tween.scale(obj, nil, height, duration, easing, events)
end

function UI_Tween.rotate_right(obj, amount, duration, easing, events)
	return UI_Tween.rotate(obj, amount, duration, easing, events)
end

function UI_Tween.rotate_left(obj, amount, duration, easing, events)
	return UI_Tween.rotate(obj, -amount, duration, easing, events)
end

function UI_Tween.shadow_x(obj, x_offset, duration, easing, events)
	return UI_Tween.shadow(obj, x_offset, nil, duration, easing, events)
end

function UI_Tween.shadow_y(obj, y_offset, duration, easing, events)
	return UI_Tween.shadow(obj, nil, y_offset, duration, easing, events)
end

function UI_Tween.pulse(obj, size, duration, count, easing, events)
	duration = duration or 1
	count = count or -1
	events = events or {}

	local t = Task.Spawn(function()
		if(events.start ~= nil) then
			events.start(obj)
		end

		if(obj.type == "UIText") then
			size = size or 5

			UI_Tween.font_size(obj, size, duration / 2, easing or UI_Tween.Out_Sine, { change = events.change })
			Task.Wait(duration / 2)
			UI_Tween.font_size(obj, -size, duration / 2, easing or UI_Tween.Out_Sine, { change = events.change, complete = events.complete })
		else
			size = size or 20

			UI_Tween.scale(obj, size, size, duration / 2, easing or UI_Tween.Out_Sine, { change = events.change })
			Task.Wait(duration / 2)
			UI_Tween.scale(obj, -size, -size, duration / 2, easing or UI_Tween.Out_Sine, { change = events.change, complete = events.complete })
		end
	end)

	if(count) then
		t.repeatCount = count
		t.repeatInterval = duration / 2
	end

	return UI_Tween
end

function UI_Tween.punch(obj, size, duration, easing, events)
	duration = duration or 1
	events = events or {}

	Task.Spawn(function()
		if(events.start ~= nil) then
			events.start(obj)
		end
		
		if(obj.type == "UIText") then
			size = size or 5

			UI_Tween.text_size(obj, size, duration / 2, easing or UI_Tween.In_Quint, { change = events.change })
			Task.Wait(duration / 2)
			UI_Tween.text_size(obj, -size, duration / 2, easing or UI_Tween.In_Quint, { change = events.change, complete = events.complete })
		else
			size = size or 20

			UI_Tween.scale(obj, size, size, duration / 2, easing or UI_Tween.In_Quint, { change = events.change })
			Task.Wait(duration / 2)
			UI_Tween.scale(obj, -size, -size, duration / 2, easing or UI_Tween.In_Quint, { change = events.change, complete = events.complete })
		end
	end)

	return UI_Tween
end

function UI_Tween.write(obj, text, speed, events)
	if(not Object.IsValid(obj) or text == nil) then
		return
	end

	speed = speed or 0.1
	events = events or {}

	Task.Spawn(function()
		if(events.start ~= nil) then
			events.start(obj, text)
		end

		for i = 1, string.len(text) do
			local txt = string.sub(text, 1, i)

			obj.text = txt
					
			if(events.change ~= nil) then
				events.change(obj, txt)
			end

			Task.Wait(speed)
		end

		if(events.complete ~= nil) then
			events.complete(obj)
		end
	end)
end

function UI_Tween.slide_right(obj, distance, duration, easing, events)
	return UI_Tween.move_x(obj, distance, duration, easing, events)
end

function UI_Tween.slide_left(obj, distance, duration, easing, events)
	return UI_Tween.move_x(obj, -distance, duration, easing, events)
end

function UI_Tween.slide_up(obj, distance, duration, easing, events)
	return UI_Tween.move_y(obj, -distance, duration, easing, events)
end

function UI_Tween.slide_down(obj, distance, duration, easing, events)
	return UI_Tween.move_y(obj, distance, duration, easing, events)
end

function UI_Tween.slide_in(obj, distance, duration, easing, events)
	return UI_Tween.move_x(obj, distance, duration, easing, events)
end

return UI_Tween