-- Require the UI_Tween API

local UI_Tween = require(script:GetCustomProperty("UI_Tween"))

-- Props

local abilities = script:GetCustomProperty("abilities"):WaitForObject()
local hud = script:GetCustomProperty("hud"):WaitForObject()
local profile_photo = script:GetCustomProperty("profile_photo"):WaitForObject()
local player_name = script:GetCustomProperty("player_name"):WaitForObject()
local level_bar = script:GetCustomProperty("level_bar"):WaitForObject()
local health_bar = script:GetCustomProperty("health_bar"):WaitForObject()
local level_text = script:GetCustomProperty("level_text"):WaitForObject()
local banner = script:GetCustomProperty("banner"):WaitForObject()
local banner_text = script:GetCustomProperty("banner_text"):WaitForObject()
local weapon_holder = script:GetCustomProperty("weapon_holder"):WaitForObject()
local weapon_name = script:GetCustomProperty("weapon_name"):WaitForObject()
local sprint = script:GetCustomProperty("sprint"):WaitForObject()
local collectables = script:GetCustomProperty("collectables"):WaitForObject()
local shop = script:GetCustomProperty("shop"):WaitForObject()
local shop_button_1 = script:GetCustomProperty("shop_button_1"):WaitForObject()
local shop_button_2 = script:GetCustomProperty("shop_button_2"):WaitForObject()
local close_button = script:GetCustomProperty("close_button"):WaitForObject()
local sprint_button = script:GetCustomProperty("sprint_button"):WaitForObject()

-- Enable UI controls

UI.SetCanCursorInteractWithUI(true)
UI.SetCursorVisible(true)

-- Vars

local local_player = Game.GetLocalPlayer()
local shop_open = false

-- Functions

local function show_abilities()
	Task.Spawn(function()
		for i, a in pairs(abilities:GetChildren()) do
			local button = a:FindChildByType("UIButton")
			local outline = a:FindChildByName("White Center")

			button.hoveredEvent:Connect(function()
				UI_Tween.color(outline, outline:GetColor(), Color.GRAY, .3)
				UI_Tween.scale(a, 10, 10, .2, UI_Tween.Out_Circ)
			end)

			button.unhoveredEvent:Connect(function()
				UI_Tween.color(outline, outline:GetColor(), Color.WHITE, .3)
				UI_Tween.scale(a, -10, -10, .2, UI_Tween.Out_Circ)
			end)

			UI_Tween.fade_in(a, 1).move_y(a, -100, .5, UI_Tween.In_Circ)
			Task.Wait(.2)
		end
	end)
end

local function show_hud()
	profile_photo:SetPlayerProfile(local_player)
	UI_Tween.slide_right(hud, 530, 1.2, UI_Tween.Out_Back)
	
	Task.Spawn(function()
		UI_Tween.write(player_name, local_player.name)
		UI_Tween.write(level_text, "Level 33")
		UI_Tween.progress(level_bar, .65, 2, UI_Tween.Out_Bounce)
		UI_Tween.progress(health_bar, 1, 2, UI_Tween.Out_Bounce)
	end, .6)
end

local function show_banner()
	UI_Tween.slide_down(banner, 185, 1, UI_Tween.Out_Bounce)
	UI_Tween.fade_in(banner_text, .7)

	Task.Spawn(function()
		UI_Tween.slide_down(banner, -185, 1, UI_Tween.In_Back)
	end, 5)
end

local function show_weapon()
	UI_Tween.slide_left(weapon_holder, 250, 1, UI_Tween.Out_Bounce, {

		complete = function()
			UI_Tween.pulse(weapon_holder)
			UI_Tween.pulse(weapon_name)
		end

	})
end

local function show_sprint()
	UI_Tween.slide_right(sprint, 150, 1, UI_Tween.Out_Bounce)
end

local function open_shop()
	if(not shop_open) then
		UI_Tween.fade_in(shop, .5)
		shop_open = true
	end
end

local function close_shop()
	if(shop_open) then
		UI_Tween.fade_out(shop, .5, nil, {

			complete = function()
				shop_open = false
			end
		})
	end
end

local function show_collectables()
	UI_Tween.slide_left(collectables, 480, 1, UI_Tween.Out_Bounce)

	shop_button_1.clickedEvent:Connect(open_shop)
	shop_button_2.clickedEvent:Connect(open_shop)
end

close_button.clickedEvent:Connect(close_shop)

sprint_button.clickedEvent:Connect(function()
	UI_Tween.rotate(sprint:GetChildren()[1], 360, .6)
end)

-- Function calls

--[[
show_abilities()
show_hud()
show_banner()
show_weapon()
show_sprint()
show_collectables()
--]]

-- Below is used for testing, ignore.
-- [[
local_player.bindingPressedEvent:Connect(function(_, binding)
	if(binding == "ability_extra_17") then
		show_abilities()
		show_hud()
		show_banner()
		show_weapon()
		show_sprint()
		show_collectables()
	end
end)
--]]