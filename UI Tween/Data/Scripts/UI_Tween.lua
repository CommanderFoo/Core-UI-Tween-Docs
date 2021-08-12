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

function UI_Tween.wait(t)
	Task.Wait(t)

	return UI_Tween
end

function UI_Tween.delay(t)
	Task.Wait(t)

	return UI_Tween
end

function UI_Tween.can_use_alpha(obj)
	if(obj.type == "UIImage" or obj.type == "UIText") then
		return true
	end

	return false
end

function UI_Tween.get_ease(easing, dt, duration, start, to)
	easing = easing or UI_Tween.Linear

	if(type(easing) == "userdata" and easing.type == "SimpleCurve") then
		local val = easing:GetValue(dt / duration)

		return (to - start) * val + start, true
	end

	return easing(dt, start, to - start, duration), false
end

function UI_Tween.fade(obj, from, to, duration, easing)
	if(not Object.IsValid(obj)) then
		return
	end

	duration = duration or 0

	local ticker = Ticker:new()
	local use_alpha = UI_Tween.can_use_alpha(obj)
	local color = nil
	local start = from

	if(use_alpha) then
		color = obj:GetColor()
		start = color.a
	else
		start = obj.opacity
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
		else
			ticker:cancel()
			ticker = nil

			if(use_alpha) then
				color.a = to

				obj:SetColor(color)
			else
				obj.opacity = to
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.move(obj, x_distance, y_distance, duration, easing)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0

	local start_x = obj.x
	local to_x = start_x + (x_distance or 0)

	local start_y = obj.y
	local to_y = start_y + (y_distance or 0)

	ticker:tick(function(dt)
		if(dt < duration) then
			if(x_distance ~= nil) then
				obj.x = UI_Tween.get_ease(easing, dt, duration, start_x, to_x)
			end

			if(y_distance ~= nil) then
				obj.y = UI_Tween.get_ease(easing, dt, duration, start_y, to_y)
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
		end
	end)

	return UI_Tween
end

function UI_Tween.scale(obj, width, height, duration, easing)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0

	local start_width = obj.width
	local to_width = start_width + (width or 0)

	local start_height = obj.height
	local to_height = start_height + (height or 0)

	ticker:tick(function(dt)
		if(dt < duration) then
			if(width ~= nil) then
				obj.width = math.floor(UI_Tween.get_ease(easing, dt, duration, start_width, to_width))
			end

			if(height ~= nil) then
				obj.height = math.floor(UI_Tween.get_ease(easing, dt, duration, start_height, to_height))
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
		end
	end)

	return UI_Tween
end

function UI_Tween.rotate(obj, amount, duration, easing)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0

	local start_amount = obj.rotationAngle
	local to_amount = start_amount + (amount or 0)
	
	ticker:tick(function(dt)
		if(dt < duration) then
			obj.rotationAngle = math.floor(UI_Tween.get_ease(easing, dt, duration, start_amount, to_amount))
		else
			ticker:cancel()
			ticker = nil

			if(amount ~= nil) then
				obj.rotationAngle = to_amount
			end
		end
	end)

	return UI_Tween
end

function UI_Tween.shadow(obj, x_offset, y_offset, duration, easing)
	if(not Object.IsValid(obj)) then
		return
	end

	local ticker = Ticker:new()

	duration = duration or 0

	local cur_offset = obj:GetShadowOffset()

	local start_x = cur_offset.x
	local to_x = start_x + (x_offset or 0)

	local start_y = cur_offset.y
	local to_y = start_y + (y_offset or 0)

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
		end
	end)

	return UI_Tween
end

function UI_Tween.fade_out(obj, duration, easing)
	return UI_Tween.fade(obj, 1, 0, duration, easing)
end

function UI_Tween.fade_in(obj, duration, easing)
	return UI_Tween.fade(obj, 0, 1, duration, easing)
end

function UI_Tween.move_x(obj, x_distance, duration, curve)
	return UI_Tween.move(obj, x_distance, nil, duration, curve)
end

function UI_Tween.move_y(obj, y_distance, duration, curve)
	return UI_Tween.move(obj, nil, y_distance, duration, curve)
end

function UI_Tween.scale_width(obj, width, duration, curve)
	return UI_Tween.scale(obj, width, nil, duration, curve)
end

function UI_Tween.scale_height(obj, height, duration, curve)
	return UI_Tween.scale(obj, nil, height, duration, curve)
end

function UI_Tween.rotate_right(obj, amount, duration, curve)
	return UI_Tween.rotate(obj, amount, duration, curve)
end

function UI_Tween.rotate_left(obj, amount, duration, curve)
	return UI_Tween.rotate(obj, -amount, duration, curve)
end

function UI_Tween.shadow_x(obj, x_offset, duration, curve)
	return UI_Tween.shadow(obj, x_offset, nil, duration, curve)
end

function UI_Tween.shadow_y(obj, y_offset, duration, curve)
	return UI_Tween.shadow(obj, nil, y_offset, duration, curve)
end

function UI_Tween.pulse(obj, duration, count, curve)
	duration = duration or 1

	local t = Task.Spawn(function()
		UI_Tween.scale(obj, 20, 20, duration / 2, curve or UI_Tween.Out_Sine)
		Task.Wait(duration / 2)
		UI_Tween.scale(obj, -20, -20, duration / 2, curve or UI_Tween.Out_Sine)
	end)

	if(count) then
		t.repeatCount = count
		t.repeatInterval = duration / 2
	end

	return UI_Tween
end

function UI_Tween.punch(obj, duration, size, curve)
	duration = duration or 1

	Task.Spawn(function()
		UI_Tween.scale(obj, size, size, duration / 2, curve or UI_Tween.In_Quint)
		Task.Wait(duration / 2)
		UI_Tween.scale(obj, -size, -size, duration / 2, curve or UI_Tween.In_Quint)
	end)

	return UI_Tween
end

return UI_Tween