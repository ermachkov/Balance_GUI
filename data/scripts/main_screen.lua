-- Angle table
local ANGLE_TABLE = {4, 36, 64, 110, 160, 230, 352, NUM_ANGLES}

-- Popup settings
local POPUP_ANIM_DELAY = 200

local mainMenuLoaded = false
local blinkTime = 0
local pressedButton
local pressedButtonText
local errorPopup
local popups

-- Returns the angle index from table
local function getAngleIndex(angle)
	for i, value in ipairs(ANGLE_TABLE) do
		if angle <= value then
			return 9 - i
		end
	end
	return 0
end

-- Returns the angle indices
local function getAngleIndices(currAngle, targetAngle)
	-- check if we are close to weight
	local diff = targetAngle - currAngle
	if math.abs(diff) <= balance:getIntParam("angleepsilon") then
		return 8, 8, 0, 0
	end

	-- select the indices
	local index1, index2
	if diff >= 0 then
		index1, index2 = getAngleIndex(NUM_ANGLES - diff), getAngleIndex(diff)
	else
		index1, index2 = getAngleIndex(-diff), getAngleIndex(NUM_ANGLES + diff)
	end

	-- check if we are opposite to weight
	if index1 == 1 and index2 == 1 then
		return 1, 1, 1, 1
	end

	-- return angle and arrow indices
	return index1, index2, index1 ~= 1 and 1 or 0, index2 ~= 1 and 1 or 0
end

-- Draws left weight indicator
function drawLeftWeight()
	-- retrieve the current wheel angle
	local currAngle = balance:getIntParam("wheelangle")
	local showWeights = balanceState == STATE_IDLE or (balanceState == STATE_BALANCE or (balanceState >= STATE_BALANCE_CAL0 and balanceState <= STATE_BALANCE_CAL3)) and (balanceSubstate == BALANCE_IDLE or balanceSubstate >= BALANCE_DECEL)
	local showAngles = balanceState == STATE_IDLE or (balanceState == STATE_BALANCE or (balanceState >= STATE_BALANCE_CAL0 and balanceState <= STATE_BALANCE_CAL3)) and (balanceSubstate == BALANCE_IDLE or balanceSubstate >= BALANCE_AUTO_ROTATION)

	-- determine weight and angle
	local weight, preciseWeight, angle
	if balanceState ~= STATE_BALANCE_CAL3 then
		weight = balance:getIntParam("rndweight0")
		preciseWeight = balance:getFloatParam("weight0")
		angle = balance:getIntParam("wheelangle0")
	else
		weight = balance:getIntParam("calweight")
		preciseWeight = weight
		angle = NUM_ANGLES / 2
	end

	-- draw indicator
	if showAngles and weight ~= 0 then
		spriteLeftTopAngle.frame, spriteLeftBottomAngle.frame, spriteLeftTopArrow.frame, spriteLeftBottomArrow.frame = getAngleIndices(currAngle, angle)
	else
		spriteLeftTopAngle.frame, spriteLeftBottomAngle.frame, spriteLeftTopArrow.frame, spriteLeftBottomArrow.frame = 0, 0, 0, 0
	end

	drawHorzSplittedSprite(spriteLeftTopAngle, spriteLeftBottomAngle)

	if spriteLeftTopAngle.frame == 8 and spriteLeftBottomAngle.frame == 8 then
		spriteLeftGreenBack:draw()
	end

	spriteLeftTopArrow:draw()
	spriteLeftBottomArrow:draw()

	spriteLeftWeight:draw()

	if showWeights then
		if balanceState == STATE_IDLE and pressedButton == spriteStopButton then
			drawCenteredText(fontWeights, spriteLeftWeight, formatWeight(preciseWeight), 0.0, 0.0, 0.0)
		else
			drawCenteredText(fontWeights, spriteLeftWeight, formatNumber(weight), 0.0, 0.0, 0.0)
		end
	end
end

-- Draws right weight indicator
function drawRightWeight()
	-- retrieve the current wheel angle
	local currAngle = balance:getIntParam("wheelangle")
	local showWeights = balanceState == STATE_IDLE or (balanceState == STATE_BALANCE or (balanceState >= STATE_BALANCE_CAL0 and balanceState <= STATE_BALANCE_CAL3)) and (balanceSubstate == BALANCE_IDLE or balanceSubstate >= BALANCE_DECEL)
	local showAngles = balanceState == STATE_IDLE or (balanceState == STATE_BALANCE or (balanceState >= STATE_BALANCE_CAL0 and balanceState <= STATE_BALANCE_CAL3)) and (balanceSubstate == BALANCE_IDLE or balanceSubstate >= BALANCE_AUTO_ROTATION)

	-- determine weight and angle
	local weight, preciseWeight, angle
	local weight2, preciseWeight2, angle2
	local showPrimaryAngle = true
	if balanceState ~= STATE_BALANCE_CAL2 then
		weight = balance:getIntParam("rndweight1")
		preciseWeight = balance:getFloatParam("weight1")
		angle = balance:getIntParam("wheelangle1")

		weight2 = balance:getIntParam("rndweight2")
		preciseWeight2 = balance:getFloatParam("weight2")
		angle2 = balance:getIntParam("wheelangle2")

		-- select between primary and secondary angles
		if weight2 ~= 0 then
			local diff1 = math.abs(currAngle - angle)
			if diff1 > NUM_ANGLES / 2 then
				diff1 = NUM_ANGLES - diff1
			end
			local diff2 = math.abs(currAngle - angle2)
			if diff2 > NUM_ANGLES / 2 then
				diff2 = NUM_ANGLES - diff2
			end
			showPrimaryAngle = diff1 <= diff2
		end
	else
		weight = balance:getIntParam("calweight")
		preciseWeight = weight
		angle = 0

		weight2 = 0
		preciseWeight2 = 0.0
		angle2 = 0
	end

	-- draw indicator
	if showAngles and weight ~= 0 then
		if showPrimaryAngle then
			spriteRightTopAngle.frame, spriteRightBottomAngle.frame, spriteRightTopArrow.frame, spriteRightBottomArrow.frame = getAngleIndices(currAngle, angle)
		else
			spriteRightTopAngle.frame, spriteRightBottomAngle.frame, spriteRightTopArrow2.frame, spriteRightBottomArrow2.frame = getAngleIndices(currAngle, angle2)
		end
	else
		spriteRightTopAngle.frame, spriteRightBottomAngle.frame, spriteRightTopArrow.frame, spriteRightBottomArrow.frame = 0, 0, 0, 0
	end

	drawHorzSplittedSprite(spriteRightTopAngle, spriteRightBottomAngle)
	if weight2 ~= 0 then
		spriteRightBack2:draw()
	end

	if spriteRightTopAngle.frame == 8 and spriteRightBottomAngle.frame == 8 then
		if showPrimaryAngle then
			spriteRightGreenBack:draw()
		else
			spriteRightGreenBack2:draw()
		end
	end

	if showPrimaryAngle then
		spriteRightTopArrow:draw()
		spriteRightBottomArrow:draw()
	else
		spriteRightTopArrow2:draw()
		spriteRightBottomArrow2:draw()
	end

	spriteRightWeight:draw()
	if weight2 ~= 0 then
		spriteRightWeight2:draw()
	end

	if showWeights then
		if balanceState == STATE_IDLE and pressedButton == spriteStopButton then
			drawCenteredText(fontWeights, spriteRightWeight, formatWeight(preciseWeight), 0.0, 0.0, 0.0)
			if weight2 ~= 0 then
				drawCenteredText(fontWeights, spriteRightWeight2, formatWeight(preciseWeight2), 0.0, 0.0, 0.0)
			end
		else
			drawCenteredText(fontWeights, spriteRightWeight, formatNumber(weight), 0.0, 0.0, 0.0)
			if weight2 ~= 0 then
				drawCenteredText(fontWeights, spriteRightWeight2, formatNumber(weight2), 0.0, 0.0, 0.0)
			end
		end
	end
end

function onMainScreenInit()
	-- load sprites
	resourceManager:loadAllResources("sprites/main_screen/resources.xml")
	include("sprites/main_screen/sprites.lua")
	main_screen_createSprites()

	-- update button labels
	updateSpritesLanguage()

	-- disable functional buttons
	spriteMenuButton.frame, spriteLoadButton.frame, spriteSaveButton.frame, spriteHelpButton.frame = 2, 2, 2, 2
	spriteMenuButtonText.frame, spriteLoadButtonText.frame, spriteSaveButtonText.frame, spriteHelpButtonText.frame = lang * 3 + 2, lang * 3 + 2, lang * 3 + 2, lang * 3 + 2

	-- load fonts
	resourceManager:loadAllResources("fonts/main_screen.xml")
	fontSizes = CFont("fontSizes")
	fontWeights = CFont("fontWeights")
	fontWheel = CFont("fontWheel")
	fontMessageHeader = CFont("fontMessageHeader")
	fontMessageText = CFont("fontMessageText")
	fontKeyboardDisplay = CFont("fontKeyboardDisplay")
	fontSpeedometer = CFont("fontSpeedometer")

	-- load sounds
	resourceManager:loadAllResources("sounds/sounds.xml")
	soundKey = Sound("soundKey")
	soundStartKey = Sound("soundStartKey")
	soundStopKey = Sound("soundStopKey")
	soundBalanceSuccess = Sound("soundBalanceSuccess")
	soundRulerSuccess = Sound("soundRulerSuccess")

	-- init popups
	errorPopup = {back = spriteErrorPopupBack, icon = spriteErrorPopupIcon, label = spriteErrorPopupText, active = false, time = 0, text = "13"}
	popups = {errorPopup}
end

function onMainScreenUpdate(delta)
	-- exit if not active
	if startScreenActive then
		return
	end

	-- increment blink counter
	blinkTime = blinkTime + delta
	if blinkTime >= 1000 then
		blinkTime = blinkTime - 1000
	end

	-- retrieve current mouse position
	local x, y = mouse:getPosition()

	-- check the background loading status
	if not mainMenuLoaded and isMainMenuLoaded() then
		mainMenuLoaded = true
		spriteMenuButton.frame, spriteLoadButton.frame, spriteSaveButton.frame, spriteHelpButton.frame = 0, 0, 0, 0
		spriteMenuButtonText.frame, spriteLoadButtonText.frame, spriteSaveButtonText.frame, spriteHelpButtonText.frame = lang * 3, lang * 3, lang * 3, lang * 3
	end

	-- handle currently pressed button
	if pressedButton then
		pressedButton.frame = pressedButton:isPointInside(x, y) and 1 or 0
		if pressedButton == spriteUser1 then
			spriteUser2.frame = pressedButton.frame
		end
		if pressedButtonText then
			pressedButtonText.frame = pressedButton:isPointInside(x, y) and (lang * 2 + 1) or (lang * 2)
		end
	end

	-- determine current mode and layout
	local mode = balance:getIntParam("mode")
	local layout = unpackLayout(balance:getIntParam("layout"), mode)

	-- background
	graphics:setBlendMode(BLEND_DISABLE)
	spriteMainScreenBack20:draw()
	spriteMainScreenBack21:draw()
	graphics:setBlendMode(BLEND_ALPHA)

	-- wheel
	spriteWheelBack:draw()
	if balanceState == STATE_RULER then
		if balanceSubstate == RULER_MEASURE or balanceSubstate == RULER_DONTSHOW then
			if (mode ~= MODE_STAT and (layout == LAYOUT_1_3 or layout == LAYOUT_1_4 or layout == LAYOUT_1_5)) or (mode == MODE_STAT and layout == LAYOUT_1) then
				spriteWheelOffsetArrow:draw()
				spriteWheelOffsetTarget1:draw()
			elseif (mode ~= MODE_STAT and (layout == LAYOUT_2_3 or layout == LAYOUT_2_4 or layout == LAYOUT_2_5)) or (mode == MODE_STAT and layout == LAYOUT_2) then
				spriteWheelLeftArrow.frame = 0
				spriteWheelLeftArrow:draw()
				spriteWheelOffsetTarget2:draw()
			elseif mode == MODE_STAT and layout == LAYOUT_3 then
				spriteWheelRightArrow.frame = 0
				spriteWheelRightArrow:draw()
				spriteWheelOffsetTarget3:draw()
			end
			fontWheel:drawText(spriteWheelText.x, spriteWheelText.y, balance:getIntParam("rofs"), 0.0, 0.0, 0.0)
		elseif balanceSubstate == RULER_MEASURE_L then
			spriteWheelRightArrow.frame = 0
			spriteWheelRightArrow:draw()
			spriteWheelOffsetTarget3:draw()
			fontWheel:drawText(spriteWheelText.x, spriteWheelText.y, balance:getIntParam("rstick"), 0.0, 0.0, 0.0)
		elseif balanceSubstate == RULER_SHOW_L1 then
			local dist = balance:getIntParam("weightdist")
			spriteWheelLeftArrow.frame = dist >= 0 and 0 or 1
			spriteWheelLeftArrow:draw()
			spriteWheelLeftCircle:draw()
			if math.abs(balance:getIntParam("wheelangle") - balance:getIntParam("wheelangle0")) <= balance:getIntParam("angleepsilon") then
				spriteWheelLeftWeight:draw()
			end
			fontWheel:drawText(spriteWheelText.x, spriteWheelText.y, dist, 0.0, 0.0, 0.0)
		elseif balanceSubstate == RULER_SHOW_L2 or balanceSubstate == RULER_SHOW_L3 then
			local dist = balance:getIntParam("weightdist")
			spriteWheelRightArrow.frame = dist >= 0 and 0 or 1
			spriteWheelRightArrow:draw()
			spriteWheelRightCircle:draw()
			if math.abs(balance:getIntParam("wheelangle") - (balanceSubstate == RULER_SHOW_L2 and balance:getIntParam("wheelangle1") or balance:getIntParam("wheelangle2"))) <= balance:getIntParam("angleepsilon") then
				spriteWheelRightWeight:draw()
			end
			fontWheel:drawText(spriteWheelText.x, spriteWheelText.y, dist, 0.0, 0.0, 0.0)
		end
	end

	-- functional buttons
	spriteMenuButton:draw()
	spriteMenuButtonText:draw()
	spriteLoadButton:draw()
	spriteLoadButtonText:draw()
	spriteSaveButton:draw()
	spriteSaveButtonText:draw()
	spriteHelpButton:draw()
	spriteHelpButtonText:draw()

	-- layout button
	spriteLayoutButton:draw()
	spriteLayoutButtonText:draw()
	spriteLayoutIcon.frame = (mode ~= MODE_STAT) and layout or (layout + 6)
	spriteLayoutIcon:draw()

	-- disk button
	spriteDiskButton:draw()
	spriteDiskButtonText:draw()
	spriteDiskIcon.frame = (mode == MODE_ALU and balance:getIntParam("split") ~= 0) and (balance:getIntParam("numsp") + 2) or mode
	spriteDiskIcon:draw()

	-- start button
	spriteStartButton:draw()
	spriteStartButtonText:draw()

	-- stop button
	spriteStopButton:draw()
	spriteStopButtonText:draw()

	-- width/stick size
	local red = math.floor(balanceErrors0 / 64) % 2 ~= 0 and blinkTime < 500
	spriteWidthStickBack:draw()
	spriteWidthStickButton.frame, spriteWidthIcon.frame, spriteStickIcon.frame = 0, 0, 0
	if mode == MODE_ALU and (layout == LAYOUT_1_3 or layout == LAYOUT_2_3) then
		drawVertSplittedSprite(red and spriteStickIconRed or spriteStickIcon, red and spriteWidthStickButtonRed or spriteWidthStickButton)
		local stick = balance:getIntParam("stick")
		if stick ~= 0 then
			drawCenteredText(fontSizes, spriteWidthStickButton, formatNumber(stick), 0.0, 0.0, 0.0)
		else
			drawCenteredText(fontSizes, spriteWidthStickButton, "Auto", 0.0, 0.0, 0.0)
		end
	else
		drawVertSplittedSprite(red and spriteWidthIconRed or spriteWidthIcon, red and spriteWidthStickButtonRed or spriteWidthStickButton)
		drawCenteredText(fontSizes, spriteWidthStickButton, formatNumber(balance:getFloatParam("width")), 0.0, 0.0, 0.0)
	end

	-- diameter size
	red = math.floor(balanceErrors0 / 16) % 2 ~= 0 and blinkTime < 500
	spriteDiamBack:draw()
	spriteDiamButton.frame, spriteDiamIcon.frame = 0, 0
	drawVertSplittedSprite(red and spriteDiamButtonRed or spriteDiamButton, red and spriteDiamIconRed or spriteDiamIcon)
	drawCenteredText(fontSizes, spriteDiamButton, formatNumber(balance:getFloatParam("diam")), 0.0, 0.0, 0.0)

	-- offset size
	red = math.floor(balanceErrors0 / 32) % 2 ~= 0 and blinkTime < 500
	spriteOfsBack:draw()
	spriteOfsButton.frame, spriteOfsIcon.frame = 0, 0
	drawVertSplittedSprite(red and spriteOfsButtonRed or spriteOfsButton, red and spriteOfsIconRed or spriteOfsIcon)
	drawCenteredText(fontSizes, spriteOfsButton, formatNumber(balance:getIntParam("offset")), 0.0, 0.0, 0.0)

	-- users switch
	spriteUsersBack:draw()
	spriteUsersLed:draw()
	if balance:getIntParam("user") == 0 then
		spriteUser1:draw()
		spriteUser1Text:draw()
	else
		spriteUser2:draw()
		spriteUser2Text:draw()
	end

	-- weight indicators
	drawLeftWeight()
	drawRightWeight()

	-- update error popup
	errorPopup.active = numErrors ~= 0
	errorPopup.text = tostring(numErrors)

	-- popups
	for i, popup in ipairs(popups) do
		-- update popup state
		if popup.active then
			popup.time = math.min(popup.time + delta, POPUP_ANIM_DELAY)
		elseif popup.time > 0 then
			popup.time = math.max(popup.time - delta, 0)
		end

		-- draw popup
		if popup.time > 0 then
			local posY = (popup.time / POPUP_ANIM_DELAY - 1.0) * popup.back:getHeight()
			popup.back:draw(popup.back.x, posY + popup.back.y)
			popup.icon:draw(popup.icon.x, posY + popup.icon.y)
			if popup.text then
				local textWidth, textHeight = fontMessageText:getTextSize(popup.text)
				fontMessageText:drawText(popup.label.x + (popup.label:getWidth() - textWidth) / 2, posY + popup.label.y + (popup.label:getHeight() - textHeight) / 2, popup.text, 95 / 255, 136 / 255, 160 / 255)
			end
		end
	end
end

function onMainScreenMouseDown(x, y, key)
	if spriteStartButton:isPointInside(x, y) then
		-- send "start" command
		pressedButton, pressedButtonText = spriteStartButton, spriteStartButtonText
		pressedButton.frame, pressedButtonText.frame = lang * 2 + 1, lang * 2 + 1
		balance:setParam("start")
		soundStartKey:play()
	elseif spriteStopButton:isPointInside(x, y) then
		-- send "stop" command
		pressedButton, pressedButtonText = spriteStopButton, spriteStopButtonText
		pressedButton.frame, pressedButtonText.frame = lang * 2 + 1, lang * 2 + 1
		balance:setParam("stop")
		soundStopKey:play()
	elseif spriteLeftWeight:isPointInside(x, y) and balance:getIntParam("rndweight0") ~= 0 then
		-- send "rotate 0" command
		pressedButton, pressedButtonText = spriteLeftWeight, nil
		pressedButton.frame = 1
		balance:setIntParam("rotate", 0)
		soundKey:play()
	elseif spriteRightWeight:isPointInside(x, y) and balance:getIntParam("rndweight1") ~= 0 then
		-- send "rotate 1" command
		pressedButton, pressedButtonText = spriteRightWeight, nil
		pressedButton.frame = 1
		balance:setIntParam("rotate", 1)
		soundKey:play()
	elseif spriteRightWeight2:isPointInside(x, y) and balance:getIntParam("rndweight2") ~= 0 then
		-- send "rotate 2" command
		pressedButton, pressedButtonText = spriteRightWeight2, nil
		pressedButton.frame = 1
		balance:setIntParam("rotate", 2)
		soundKey:play()
	elseif spriteUser1:isPointInside(x, y) then
		-- send "user n" command
		pressedButton, pressedButtonText = spriteUser1, nil
		pressedButton.frame = 1
		balance:setIntParam("user", 1 - balance:getIntParam("user"))
		soundKey:play()
	elseif spriteLayoutButton:isPointInside(x, y) then
		-- enter the layout menu
		showLayoutMenu()
		soundKey:play()
	elseif spriteDiskButton:isPointInside(x, y) then
		-- enter the disk menu
		showDiskMenu()
		soundKey:play()
	elseif spriteMenuButton:isPointInside(x, y) and mainMenuLoaded then
		-- enter the main menu
		showMainMenu()
		soundKey:play()
	elseif spriteWidthIcon:isPointInside(x, y) or spriteWidthStickButton:isPointInside(x, y) then
		local mode = balance:getIntParam("mode")
		local layout = unpackLayout(balance:getIntParam("layout"), mode)
		local param, type
		if mode == MODE_ALU and (layout == LAYOUT_1_3 or layout == LAYOUT_2_3) then
			param, type = "stick", TYPE_INT
		else
			param, type = "width", TYPE_FLOAT
		end
		local left = SCREEN_WIDTH - (spriteRightFasteners.x + spriteRightFasteners:getWidth())
		local top = spriteWidthStickButton.y + spriteWidthStickButton:getHeight()
		showKeyboard(left, top, SCREEN_WIDTH, top, param, type, spriteRightFasteners)
		soundKey:play()
	elseif spriteDiamIcon:isPointInside(x, y) or spriteDiamButton:isPointInside(x, y) then
		local left = spriteDiamIcon.x + spriteDiamIcon:getWidth()
		local top = SCREEN_HEIGHT - (spriteBottomFasteners.y + spriteBottomFasteners:getHeight())
		showKeyboard(left, top, left, SCREEN_HEIGHT, "diam", TYPE_FLOAT, spriteBottomFasteners)
		soundKey:play()
	elseif spriteOfsIcon:isPointInside(x, y) or spriteOfsButton:isPointInside(x, y) then
		local left = 0
		local top = spriteOfsButton.y + spriteOfsButton:getHeight()
		showKeyboard(left, top, -(spriteKeyboardBack.x + spriteKeyboardBack:getWidth()), top, "offset", TYPE_INT, spriteLeftFasteners)
		soundKey:play()
	elseif errorPopup.active and errorPopup.back:isPointInside(x, y) then
		-- show error journal
		showErrorJournal()
	end
end

function onMainScreenMouseUp(x, y, key)
	if pressedButton then
		pressedButton.frame = 0
		if pressedButton == spriteUser1 then
			spriteUser2.frame = 0
		end
		if pressedButtonText then
			pressedButtonText.frame = lang * 2
		end
		pressedButton, pressedButtonText = nil, nil
	end
end
