-- Main menu settings
local MENU_FADE_DELAY = 100

-- Scroll speed in units per ms
local SCROLL_SPEED = 500 / 1000
local SCROLL_THRESHOLD = 10

local menuActive = false
local menuTime = 0
local resourcesLoaded = false
local selMenu
local selMainItem
local pressedButton
local scrollActive
local scrollX, scrollY
local oldUser
local keyboardActive
local menuIcons, menuLabels
local startModeIcons, rotationModeIcons, pedalModeIcons, directionIcons
local languageIcons
local menuButtons
local clipX, clipY, clipWidth, clipHeight
local menus

-- Recursively sets parent for the menu items
local function setParent(item, parent)
	item.parent = parent
	for i, child in ipairs(item) do
		setParent(child, item)
	end
end

-- Formats the floating point parameter
local function showFloat(item)
	return formatNumber(balance:getFloatParam(item.param))
end

-- Formats the voltage
local function showVoltage(item)
	return (item.param ~= "va5" and "+" or "-") .. string.format("%.2f", balance:getFloatParam(item.param) / 100.0) .. tr("V")
end

-- Formats the profile value
local function showProfileValue(item)
	return profile:getString(item.param)
end

-- Initializes the menus table
local function initMenus()
	menus =
	{
		-- user 1 menu
		{
			onClick = function() balance:setIntParam("user", 0) end,
			{
				icon = spriteRoundIcon,
				header = tr("{round_header}"),
				text = tr("{round_text}"),
				format = "%d",
				param = "roundmode",
				type = TYPE_INT
			},
			{
				icon = spriteMinWeightIcon,
				header = tr("{min_weight_header}"),
				text = tr("{min_weight_text}"),
				format = "%d",
				param = "minweight",
				type = TYPE_INT
			},
			{
				header = tr("{start_mode_header}"),
				text = tr("{start_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("startmode") + 1; item.icon = startModeIcons[item.selItem] end,
				{
					icon = spriteStartMode0Icon,
					header = tr("{start_mode_0_header}"),
					text = tr("{start_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("startmode", 0) end
				},
				{
					icon = spriteStartMode1Icon,
					header = tr("{start_mode_1_header}"),
					text = tr("{start_mode_1_text}"),
					onClick = function() balance:setIntParam("startmode", 1) end
				},
				{
					icon = spriteStartMode2Icon,
					header = tr("{start_mode_2_header}"),
					text = tr("{start_mode_2_text}"),
					onClick = function() balance:setIntParam("startmode", 2) end
				}
			},
			{
				header = tr("{rotation_mode_header}"),
				text = tr("{rotation_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("automode") + 1; item.icon = rotationModeIcons[item.selItem] end,
				{
					icon = spriteRotationMode0Icon,
					header = tr("{rotation_mode_0_header}"),
					text = tr("{rotation_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("automode", 0) end
				},
				{
					icon = spriteRotationMode1Icon,
					header = tr("{rotation_mode_1_header}"),
					text = tr("{rotation_mode_1_text}"),
					onClick = function() balance:setIntParam("automode", 1) end
				},
				{
					icon = spriteRotationMode2Icon,
					header = tr("{rotation_mode_2_header}"),
					text = tr("{rotation_mode_2_text}"),
					onClick = function() balance:setIntParam("automode", 2) end
				},
				{
					icon = spriteRotationMode3Icon,
					header = tr("{rotation_mode_3_header}"),
					text = tr("{rotation_mode_3_text}"),
					onClick = function() balance:setIntParam("automode", 3) end
				}
			},
			{
				header = tr("{pedal_mode_header}"),
				text = tr("{pedal_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("pedalmode") + 1; item.icon = pedalModeIcons[item.selItem] end,
				{
					icon = spritePedalMode0Icon,
					header = tr("{pedal_mode_0_header}"),
					text = tr("{pedal_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("pedalmode", 0) end
				},
				{
					icon = spritePedalMode1Icon,
					header = tr("{pedal_mode_1_header}"),
					text = tr("{pedal_mode_1_text}"),
					onClick = function() balance:setIntParam("pedalmode", 1) end
				}
			},
			{
				header = tr("{direction_header}"),
				text = tr("{direction_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("clockwise") + 1; item.icon = directionIcons[item.selItem] end,
				{
					icon = spriteDirection0Icon,
					header = tr("{direction_0_header}"),
					text = tr("{direction_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("clockwise", 0) end
				},
				{
					icon = spriteDirection1Icon,
					header = tr("{direction_1_header}"),
					text = tr("{direction_1_text}"),
					onClick = function() balance:setIntParam("clockwise", 1) end
				}
			}
		},

		-- user 2 menu
		{
			onClick = function() balance:setIntParam("user", 1) end,
			{
				icon = spriteRoundIcon,
				header = tr("{round_header}"),
				text = tr("{round_text}"),
				format = "%d",
				param = "roundmode",
				type = TYPE_INT
			},
			{
				icon = spriteMinWeightIcon,
				header = tr("{min_weight_header}"),
				text = tr("{min_weight_text}"),
				format = "%d",
				param = "minweight",
				type = TYPE_INT
			},
			{
				header = tr("{start_mode_header}"),
				text = tr("{start_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("startmode") + 1; item.icon = startModeIcons[item.selItem] end,
				{
					icon = spriteStartMode0Icon,
					header = tr("{start_mode_0_header}"),
					text = tr("{start_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("startmode", 0) end
				},
				{
					icon = spriteStartMode1Icon,
					header = tr("{start_mode_1_header}"),
					text = tr("{start_mode_1_text}"),
					onClick = function() balance:setIntParam("startmode", 1) end
				},
				{
					icon = spriteStartMode2Icon,
					header = tr("{start_mode_2_header}"),
					text = tr("{start_mode_2_text}"),
					onClick = function() balance:setIntParam("startmode", 2) end
				}
			},
			{
				header = tr("{rotation_mode_header}"),
				text = tr("{rotation_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("automode") + 1; item.icon = rotationModeIcons[item.selItem] end,
				{
					icon = spriteRotationMode0Icon,
					header = tr("{rotation_mode_0_header}"),
					text = tr("{rotation_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("automode", 0) end
				},
				{
					icon = spriteRotationMode1Icon,
					header = tr("{rotation_mode_1_header}"),
					text = tr("{rotation_mode_1_text}"),
					onClick = function() balance:setIntParam("automode", 1) end
				},
				{
					icon = spriteRotationMode2Icon,
					header = tr("{rotation_mode_2_header}"),
					text = tr("{rotation_mode_2_text}"),
					onClick = function() balance:setIntParam("automode", 2) end
				},
				{
					icon = spriteRotationMode3Icon,
					header = tr("{rotation_mode_3_header}"),
					text = tr("{rotation_mode_3_text}"),
					onClick = function() balance:setIntParam("automode", 3) end
				}
			},
			{
				header = tr("{pedal_mode_header}"),
				text = tr("{pedal_mode_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("pedalmode") + 1; item.icon = pedalModeIcons[item.selItem] end,
				{
					icon = spritePedalMode0Icon,
					header = tr("{pedal_mode_0_header}"),
					text = tr("{pedal_mode_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("pedalmode", 0) end
				},
				{
					icon = spritePedalMode1Icon,
					header = tr("{pedal_mode_1_header}"),
					text = tr("{pedal_mode_1_text}"),
					onClick = function() balance:setIntParam("pedalmode", 1) end
				}
			},
			{
				header = tr("{direction_header}"),
				text = tr("{direction_text}"),
				onUpdate = function(item) item.selItem = balance:getIntParam("clockwise") + 1; item.icon = directionIcons[item.selItem] end,
				{
					icon = spriteDirection0Icon,
					header = tr("{direction_0_header}"),
					text = tr("{direction_0_text}"),
					onUpdate = function(item) item.parent.onUpdate(item.parent) end,
					onClick = function() balance:setIntParam("clockwise", 0) end
				},
				{
					icon = spriteDirection1Icon,
					header = tr("{direction_1_header}"),
					text = tr("{direction_1_text}"),
					onClick = function() balance:setIntParam("clockwise", 1) end
				}
			}
		},

		-- calibration menu
		{
			{
				icon = spriteBalanceFastCalIcon,
				header = tr("{balance_fast_cal_header}"),
				text = tr("{balance_fast_cal_text}"),
				onClick = function() hideMainMenu(); balance:setParam("keycal0") end
			},
			{
				icon = spriteBalanceCalIcon,
				header = tr("{balance_cal_header}"),
				text = tr("{balance_cal_text}"),
				{
					icon = spriteBalanceCal0Icon,
					header = tr("{balance_cal_0_header}"),
					text = tr("{balance_cal_0_text}"),
					onClick = function() hideMainMenu(); balance:setParam("cal0") end
				},
				{
					icon = spriteBalanceCal1Icon,
					header = tr("{balance_cal_1_header}"),
					text = tr("{balance_cal_1_text}"),
					onClick = function() hideMainMenu(); balance:setParam("cal1") end
				},
				{
					icon = spriteBalanceCal2Icon,
					header = tr("{balance_cal_2_header}"),
					text = tr("{balance_cal_2_text}"),
					onClick = function() hideMainMenu(); balance:setParam("cal2") end
				},
				{
					icon = spriteBalanceCal3Icon,
					header = tr("{balance_cal_3_header}"),
					text = tr("{balance_cal_3_text}"),
					onClick = function() hideMainMenu(); balance:setParam("cal3") end
				},
				{
					icon = spriteBalanceCalWeightIcon,
					header = tr("{balance_cal_weight_header}"),
					text = tr("{balance_cal_weight_text}"),
					format = "%d",
					param = "calweight",
					type = TYPE_INT
				}
			},
			{
				icon = spriteRulerCalIcon,
				header = tr("{ruler_cal_header}"),
				text = tr("{ruler_cal_text}"),
				{
					icon = spriteRulerCal0Icon,
					header = tr("{ruler_cal_0_header}"),
					text = tr("{ruler_cal_0_text}"),
					onClick = function() hideMainMenu(); balance:setParam("rulercal0") end
				},
				{
					icon = spriteRulerCal1Icon,
					header = tr("{ruler_cal_1_header}"),
					text = tr("{ruler_cal_1_text}"),
					onClick = function() hideMainMenu(); balance:setParam("rulercal1") end
				},
				{
					icon = spriteRulerCal2Icon,
					header = tr("{ruler_cal_2_header}"),
					text = tr("{ruler_cal_2_text}"),
					onClick = function() hideMainMenu(); balance:setParam("rulercal2") end
				},
				{
					icon = spriteRulerCal3Icon,
					header = tr("{ruler_cal_3_header}"),
					text = tr("{ruler_cal_3_text}"),
					onClick = function() hideMainMenu(); balance:setParam("rulercal3") end
				},
				{
					icon = spriteRulerHorzIcon,
					header = tr("{ruler_horz_header}"),
					text = tr("{ruler_horz_text}"),
					format = "%d",
					param = "rulerhorz",
					type = TYPE_INT
				},
				{
					icon = spriteRulerVertIcon,
					header = tr("{ruler_vert_header}"),
					text = tr("{ruler_vert_text}"),
					format = "%d",
					param = "rulervert",
					type = TYPE_INT
				},
				{
					icon = spriteRulerRadiusIcon,
					header = tr("{ruler_radius_header}"),
					text = tr("{ruler_radius_text}"),
					format = "%d",
					param = "rulerrad",
					type = TYPE_INT
				},
				{
					icon = spriteRulerCalOffsetIcon,
					header = tr("{ruler_cal_offset_header}"),
					text = tr("{ruler_cal_offset_text}"),
					format = "%d",
					param = "rulerofs",
					type = TYPE_INT
				},
				{
					icon = spriteRulerCalDiamIcon,
					header = tr("{ruler_cal_diam_header}"),
					text = tr("{ruler_cal_diam_text}"),
					format = showFloat,
					param = "rulerdiam",
					type = TYPE_FLOAT
				}
			}
		},

		-- diagnostics menu
		{
			{
				icon = spriteArmVoltagesIcon,
				header = tr("{arm_voltages_header}"),
				text = tr("{arm_voltages_text}"),
				{
					icon = spritePlus24VIcon,
					header = tr("{+24vd_header}"),
					text = tr("{+24vd_text}"),
					format = showVoltage,
					param = "v0"
				},
				{
					icon = spritePlus5VIcon,
					header = tr("{+5vp_header}"),
					text = tr("{+5vp_text}"),
					format = showVoltage,
					param = "v1"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{vext1_header}"),
					text = tr("{vext1_text}"),
					format = showVoltage,
					param = "v2"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{vext2_header}"),
					text = tr("{vext2_text}"),
					format = showVoltage,
					param = "v3"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{+3.3vp_header}"),
					text = tr("{+3.3vp_text}"),
					format = showVoltage,
					param = "v4"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{+vi2c_header}"),
					text = tr("{+vi2c_text}"),
					format = showVoltage,
					param = "v5"
				}
			},
			{
				icon = spriteDspVoltagesIcon,
				header = tr("{dsp_voltages_header}"),
				text = tr("{dsp_voltages_text}"),
				{
					icon = spritePlus2_5VIcon,
					header = tr("{vrefp_header}"),
					text = tr("{vrefp_text}"),
					format = showVoltage,
					param = "va0"
				},
				{
					icon = spritePlus5VIcon,
					header = tr("{+5va_header}"),
					text = tr("{+5va_text}"),
					format = showVoltage,
					param = "va1"
				},
				{
					icon = spritePlus1_2VIcon,
					header = tr("{+1.2v_header}"),
					text = tr("{+1.2v_text}"),
					format = showVoltage,
					param = "va2"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{vextm_header}"),
					text = tr("{vextm_text}"),
					format = showVoltage,
					param = "va3"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{+3.3v_header}"),
					text = tr("{+3.3v_text}"),
					format = showVoltage,
					param = "va4"
				},
				{
					icon = spriteMinus5VIcon,
					header = tr("{-5va_header}"),
					text = tr("{-5va_text}"),
					format = showVoltage,
					param = "va5"
				},
				{
					icon = spritePlus1_8VIcon,
					header = tr("{+1.8va_header}"),
					text = tr("{+1.8va_text}"),
					format = showVoltage,
					param = "va6"
				},
				{
					icon = spritePlus3_3VIcon,
					header = tr("{+3.3va_header}"),
					text = tr("{+3.3va_text}"),
					format = showVoltage,
					param = "va7"
				}
			}
		},

		-- options menu
		{
			{
				icon = languageIcons[lang + 1],
				selItem = lang + 1,
				header = tr("{language_header}"),
				text = tr("{language_text}"),
				{
					icon = spriteEnglishIcon,
					header = tr("{english_header}"),
					text = tr("{english_text}"),
					onClick = function(item) setLanguage(LANG_EN); item.parent.selItem = lang + 1; item.parent.icon = spriteEnglishIcon; updateSpritesLanguage() end
				},
				{
					icon = spriteRussianIcon,
					header = tr("{russian_header}"),
					text = tr("{russian_text}"),
					onClick = function(item) setLanguage(LANG_RU); item.parent.selItem = lang + 1; item.parent.icon = spriteRussianIcon; updateSpritesLanguage() end
				},
				{
					icon = spriteChineseIcon,
					header = tr("{chinese_header}"),
					text = tr("{chinese_text}"),
					onClick = function(item) setLanguage(LANG_CN); item.parent.selItem = lang + 1; item.parent.icon = spriteChineseIcon; updateSpritesLanguage() end
				}
			},
			{
				icon = spriteThemeIcon,
				header = tr("{theme_header}"),
				text = tr("{theme_text}")
			},
			{
				icon = spriteNetworkIcon,
				header = tr("{network_header}"),
				text = tr("{network_text}"),
				{
					icon = spriteServerAddrIcon,
					header = tr("{server_addr_header}"),
					text = tr("{server_addr_text}"),
					format = showProfileValue,
					param = "server_addr",
					type = TYPE_IP
					--onEnter = function(item, value) balance:setServerAddr(value) end
				},
				{
					icon = spriteLocalAddrIcon,
					header = tr("{local_addr_header}"),
					text = tr("{local_addr_text}"),
					format = showProfileValue,
					param = "local_addr"
				},
				{
					icon = spriteNetmaskIcon,
					header = tr("{netmask_header}"),
					text = tr("{netmask_text}"),
					format = showProfileValue,
					param = "netmask"
				},
				{
					icon = spriteGatewayIcon,
					header = tr("{gateway_header}"),
					text = tr("{gateway_text}"),
					format = showProfileValue,
					param = "gateway"
				},
				{
					icon = spriteDNSIcon,
					header = tr("{dns_header}"),
					text = tr("{dns_text}"),
					format = showProfileValue,
					param = "dns"
				},
				{
					icon = profile:getBool("remote_control") and spriteRemoteControlEnabledIcon or spriteRemoteControlDisabledIcon,
					selItem = profile:getBool("remote_control") and 2 or 1,
					header = tr("{remote_control_header}"),
					text = tr("{remote_control_text}"),
					{
						icon = spriteRemoteControlDisabledIcon,
						header = tr("{remote_control_disabled_header}"),
						text = tr("{remote_control_disabled_text}"),
						onClick = function(item) item.parent.selItem = 1; item.parent.icon = spriteRemoteControlDisabledIcon; profile:setBool("remote_control", false); profile:save() end
					},
					{
						icon = spriteRemoteControlEnabledIcon,
						header = tr("{remote_control_enabled_header}"),
						text = tr("{remote_control_enabled_text}"),
						onClick = function(item) item.parent.selItem = 2; item.parent.icon = spriteRemoteControlEnabledIcon; profile:setBool("remote_control", true); profile:save() end
					}
				}
			},
			{
				icon = spriteSoftwareUpdateIcon,
				header = tr("{software_update_header}"),
				text = tr("{software_update_text}")
			},
			{
				icon = spriteFactorySettingsIcon,
				header = tr("{factory_settings_header}"),
				text = tr("{factory_settings_text}"),
				onClick = function() balance:setParam("loaddef"); hideMainMenu() end
			},
			{
				icon = spriteQuitIcon,
				header = tr("{quit_header}"),
				text = tr("{quit_text}"),
				onClick = function() application:quit() end
			}
		}
	}

	for i, item in ipairs(menus) do
		setParent(item, nil)
	end
end

-- Returns true if main menu is loaded
function isMainMenuLoaded()
	return resourcesLoaded
end

-- Shows the main menu
function showMainMenu()
	if not menuActive and resourcesLoaded then
		menuActive = true
		selMenu = nil
		selMainItem = 0
		pressedButton = nil
		oldUser = balance:getIntParam("user")
		keyboardActive = false
		spriteMenuButton.frame, spriteMenuButtonText.frame = 1, lang * 3 + 1
		spriteMainMenu.frame = 0
	end
end

-- Hides the main menu
function hideMainMenu()
	if menuActive then
		menuActive = false
		menuTime = 0 -- TODO: Remove me when alpha in fonts will be fixed
		balance:setIntParam("user", oldUser)
		spriteMenuButton.frame, spriteMenuButtonText.frame = 0, lang * 3
	end
end

-- Returns the menu item value
function getMenuItemValue(index)
	local item = selMenu[index]
	return item.format and (type(item.format) == "function" and item.format(item) or string.format(item.format, balance:getFloatParam(item.param))) or ""
end

-- Draws the menu item value
function drawMenuItemValue(index, alpha)
	local str = getMenuItemValue(index)
	if str ~= "" then
		local width, height = fontMainMenuItemValue:getTextSize(str)
		fontMainMenuItemValue:drawText(spriteMainMenuItemValue.x + spriteMainMenuItemValue:getWidth() - width, spriteMainMenuItemValue.y - selMenu.scrollPos + (index - 1) * spriteMainMenuItemNormal:getHeight(), str, 1.0, 0.8, 0.0, alpha)
	end
end

-- Draws the menu item
function drawMenuItem(index, state, alpha)
	-- background
	local item = selMenu[index]
	local sprite = state == ITEM_NORMAL and spriteMainMenuItemNormal or (state == ITEM_PRESSED and spriteMainMenuItemPressed or spriteMainMenuItemSelected)
	local pos = (index - 1) * spriteMainMenuItemNormal:getHeight() - selMenu.scrollPos
	sprite.alpha = alpha
	sprite:draw(spriteMainMenuItemNormal.x, spriteMainMenuItemNormal.y + pos)

	-- icon
	item.icon.alpha = alpha
	item.icon:draw(spriteMainMenuItemIcon.x, spriteMainMenuItemIcon.y + pos)

	-- header
	local color = state == ITEM_NORMAL and 1.0 or (state == ITEM_PRESSED and 0.0 or 0.7)
	fontMainMenuItemHeader:drawText(spriteMainMenuItemHeader.x, spriteMainMenuItemHeader.y + pos, tr(item.header), color, color, color, alpha)

	-- text
	fontMainMenuItemText:drawText(spriteMainMenuItemText.x, spriteMainMenuItemText.y + pos, tr(item.text), color, color, color, alpha)

	-- value
	drawMenuItemValue(index, alpha)

	-- triangle
	if #item ~= 0 then
		local triangle = state == ITEM_NORMAL and spriteMainMenuTriangleNormal or spriteMainMenuTrianglePressed
		triangle.alpha = alpha
		triangle:draw(spriteMainMenuTriangleNormal.x, spriteMainMenuTriangleNormal.y + pos)
	end
end

function onMainMenuInit()
	-- start the background loading
	resourceQueue:addAllResources("sprites/main_menu/resources.xml")
	resourceQueue:addAllResources("fonts/main_menu.xml")
	resourceQueue:startLoading()
end

function onMainMenuUpdate(delta)
	-- check the background loading status
	if not resourcesLoaded and not resourceQueue:isLoadingActive() then
		-- load sprites
		include("sprites/main_menu/sprites.lua")
		main_menu_createSprites()

		-- create fonts
		fontMainMenu = CFont("fontMainMenu")
		fontMainMenuItemHeader = CFont("fontMainMenuItemHeader")
		fontMainMenuItemText = CFont("fontMainMenuItemText")
		fontMainMenuItemValue = CFont("fontMainMenuItemValue")

		-- disable translation for menu entries to work properly
		enableTranslation(false)

		-- initialize sprite tables
		menuIcons = {spriteUser1MenuIcon, spriteUser2MenuIcon, spriteCalibrationMenuIcon, spriteDiagnosticsMenuIcon, spriteOptionsMenuIcon}
		menuLabels = {tr("User 1"), tr("User 2"), tr("Calibration"), tr("Diagnostics"), tr("Options")}
		startModeIcons = {spriteStartMode0Icon, spriteStartMode1Icon, spriteStartMode2Icon}
		rotationModeIcons = {spriteRotationMode0Icon, spriteRotationMode1Icon, spriteRotationMode2Icon, spriteRotationMode3Icon}
		pedalModeIcons = {spritePedalMode0Icon, spritePedalMode1Icon}
		directionIcons = {spriteDirection0Icon, spriteDirection1Icon}
		languageIcons = {spriteEnglishIcon, spriteRussianIcon, spriteChineseIcon}
		menuButtons = {spriteMainMenuBackButton, spriteMainMenuCloseButton, spriteMainMenuUpButton, spriteMainMenuDownButton}

		-- determine the clip rectangle
		clipX, clipY = spriteMainMenuItemNormal.x, spriteMainMenuItemNormal.y
		clipWidth, clipHeight = spriteMainMenuItemNormal:getWidth(), spriteMainMenuItemPressed.y + spriteMainMenuItemPressed:getHeight() - clipY

		-- initialize the menus table
		initMenus()

		-- enable translation
		enableTranslation(true)

		-- set the resources loaded flag
		resourcesLoaded = true
	end

	-- check the main menu state
	if menuActive then
		menuTime = math.min(menuTime + delta, MENU_FADE_DELAY)
	elseif menuTime > 0 then
		menuTime = math.max(menuTime - delta, 0)
	else
		return
	end

	-- handle mouse movements
	local selItem = 0
	if menuActive and mousePressed and not keyboardActive then
		-- retrieve current mouse position
		local x, y = mouse:getPosition()

		-- process mouse position
		if pressedButton then
			-- check the pressed button
			if pressedButton:isPointInside(x, y) then
				-- set the pressed frame
				pressedButton.frame = 1

				-- check scroll buttons
				if pressedButton == spriteMainMenuUpButton then
					selMenu.scrollPos = math.max(selMenu.scrollPos - delta * SCROLL_SPEED, 0)
				elseif pressedButton == spriteMainMenuDownButton then
					selMenu.scrollPos = math.min(selMenu.scrollPos + delta * SCROLL_SPEED, math.max(#selMenu * spriteMainMenuItemNormal:getHeight() - clipHeight, 0))
				end
			else
				-- set the normal frame
				pressedButton.frame = 0
			end
		elseif spriteMainMenu:isPointInside(x, y) and not scrollActive then
			-- check main menu icons
			for i, icon in ipairs(menuIcons) do
				if isPointInside(x, y, spriteMainMenu.x, icon.y, spriteMainMenu.x + spriteMainMenu:getWidth(), icon.y + icon:getHeight()) then
					-- execute the click handler
					local item = menus[i]
					if item.onClick then
						item.onClick(item)
					end

					-- enter the menu
					selMenu = item
					selMenu.scrollPos = 0
					selMainItem = i
					spriteMainMenu.frame = i
					break
				end
			end
		elseif selMenu then
			-- check scrolling state
			if scrollActive then
				selMenu.scrollPos = clamp(selMenu.scrollPos + scrollY - y, 0, math.max(#selMenu * spriteMainMenuItemNormal:getHeight() - clipHeight, 0))
				scrollX, scrollY = x, y
			elseif isPointInside(x, y, clipX, clipY, clipX + clipWidth, clipY + clipHeight) and math.abs(y - scrollY) > SCROLL_THRESHOLD then
				scrollActive = true
				scrollX, scrollY = x, y
			end

			-- determine the selected menu item under the cursor
			if isPointInside(x, y, clipX, clipY, clipX + clipWidth, clipY + clipHeight) then
				selItem = math.floor((y - clipY + selMenu.scrollPos) / spriteMainMenuItemNormal:getHeight()) + 1
			end
		end
	end

	-- determine the menu opacity
	local alpha = menuTime / MENU_FADE_DELAY

	-- main menu
	spriteMainMenu.alpha = alpha
	if selMenu then
		-- menu with submenu
		spriteMainSubmenu.alpha = alpha
		drawVertSplittedSprite(spriteMainMenu, spriteMainSubmenu)

		-- set the clip rectangle
		graphics:setClipRect(clipX, clipY, clipX + clipWidth, clipY + clipHeight)

		-- submenu items
		for i = 1, #selMenu do
			-- update item if needed
			local item = selMenu[i]
			if item.onUpdate then
				item.onUpdate(item)
			end

			-- draw item
			drawMenuItem(i, i ~= selItem and (i ~= selMenu.selItem and ITEM_NORMAL or ITEM_SELECTED) or ITEM_PRESSED, alpha)
		end

		-- reset the clip rectangle
		graphics:resetClipRect()

		-- scroll bar
		local totalHeight = #selMenu * spriteMainMenuItemNormal:getHeight()
		spriteMainMenuScrollBack.alpha = alpha
		spriteMainMenuScrollBack:draw()
		spriteMainMenuScrollFront:setScale(1.0, math.min(clipHeight / totalHeight, 1.0))
		spriteMainMenuScrollFront.alpha = alpha
		spriteMainMenuScrollFront:draw(spriteMainMenuScrollFront.x, spriteMainMenuScrollFront.y + selMenu.scrollPos / totalHeight * spriteMainMenuScrollFront:getHeight())

		-- buttons
		for i, button in ipairs(menuButtons) do
			button.alpha = alpha
			button:draw()
		end
	else
		spriteMainMenu:draw()
	end

	-- main menu icons with labels
	for i, icon in ipairs(menuIcons) do
		local color = i == selMainItem and 0.6 or 1.0
		icon.red, icon.green, icon.blue, icon.alpha = color, color, color, alpha
		icon:draw()
		local label = tr(menuLabels[i])
		local width, height = fontMainMenu:getTextSize(label)
		fontMainMenu:drawText(icon.x + icon:getWidth() + 20, icon.y + (icon:getHeight() - height) / 2, label, color, color, color, alpha)
	end
end

function onMainMenuMouseDown(x, y, key)
	-- exit if not active
	if not menuActive then
		return false
	end

	-- reset keyboard active flag
	if keyboardActive then
		keyboardActive = false
		return true
	end

	-- save scrolling information
	scrollActive = false
	scrollX, scrollY = x, y

	-- close menu on menu button press
	if spriteMenuButton:isPointInside(x, y) then
		hideMainMenu()
		soundKey:play()
		return true
	end

	-- check menu buttons
	if selMenu then
		for i, button in ipairs(menuButtons) do
			if button:isPointInside(x, y) then
				pressedButton = button
				pressedButton.frame = 1
				return true
			end
		end
	end

	-- check for clicks outside the menu
	if not selMenu and not spriteMainMenu:isPointInside(x, y) then
		hideMainMenu()
		return false
	end

	return true
end

function onMainMenuMouseUp(x, y, key)
	-- exit if not active
	if not menuActive then
		return false
	end

	-- reset keyboard active flag
	if keyboardActive then
		keyboardActive = false
		return true
	end

	-- release button if needed
	if pressedButton then
		if pressedButton:isPointInside(x, y) then
			if pressedButton == spriteMainMenuBackButton then
				-- return to the previous menu level
				selMenu = selMenu.parent
				if not selMenu then
					selMainItem = 0
					spriteMainMenu.frame = 0
				end
			elseif pressedButton == spriteMainMenuCloseButton then
				-- close the main menu
				hideMainMenu()
			end
		end
		pressedButton.frame = 0
		pressedButton = nil
	elseif selMenu and isPointInside(x, y, clipX, clipY, clipX + clipWidth, clipY + clipHeight) and not scrollActive then
		local selItem = math.floor((y - clipY + selMenu.scrollPos) / spriteMainMenuItemNormal:getHeight()) + 1
		if selItem <= #selMenu then
			-- execute the click handler
			local item = selMenu[selItem]
			if item.onClick then
				item.onClick(item)
			end

			-- check the number of nested items
			if #item ~= 0 then
				-- enter the submenu
				selMenu = item
				selMenu.scrollPos = 0
			elseif item.type then
				-- make the item visible
				local y1, y2 = (selItem - 1) * spriteMainMenuItemNormal:getHeight(), selItem * spriteMainMenuItemNormal:getHeight()
				if selMenu.scrollPos > y1 and selMenu.scrollPos < y2 then
					selMenu.scrollPos = y1
				elseif selMenu.scrollPos + clipHeight > y1 and selMenu.scrollPos + clipHeight < y2 then
					selMenu.scrollPos = y2 - clipHeight
				end

				-- show keyboard
				local posY = spriteMainMenuItemValue.y + spriteMainMenuItemValue:getHeight() - selMenu.scrollPos + (selItem - 1) * spriteMainMenuItemNormal:getHeight()
				if posY + spriteKeyboardBack.y + spriteKeyboardBack:getHeight() < SCREEN_HEIGHT then
					local left = SCREEN_WIDTH - (spriteRightFasteners.x + spriteRightFasteners:getWidth())
					local top = posY
					showKeyboard(left, top, SCREEN_WIDTH, top, item.param, item.type, spriteRightFasteners, selItem)
				else
					local width, height = fontMainMenuItemValue:getTextSize(getMenuItemValue(selItem))
					local left = spriteMainMenuItemValue.x + spriteMainMenuItemValue:getWidth() - width - (spriteRightFasteners.x + spriteRightFasteners:getWidth())
					local top = SCREEN_HEIGHT - (spriteBottomFasteners.y + spriteBottomFasteners:getHeight())
					showKeyboard(left, top, left, SCREEN_HEIGHT, item.param, item.type, spriteBottomFasteners, selItem)
				end

				-- set the keyboard active flag
				keyboardActive = true
			end
		end
	end

	return true
end
