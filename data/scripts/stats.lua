-- Stats screen settings
local STATS_FADE_DELAY = 200

local statsActive = false
local statsTime = 0
local pressedButton
local month
local year
local monthNames

-- Shows the stats
function showStats()
	if not statsActive and isMainMenuLoaded() then
		statsActive = true
		pressedButton = nil
		local date = os.date("*t")
		month, year = date.month, date.year

		spriteStatsCloseButton.frame = 0
	end
end

-- Hides the stats
function hideStats()
	statsActive = false
	statsTime = 0 -- TODO: Remove me when alpha in fonts will be fixed
end

function onStatsInit()
	enableTranslation(false)
	monthNames = {tr("JANUARY"), tr("FEBRUARY"), tr("MARCH"), tr("APRIL"), tr("MAY"), tr("JUNE"), tr("JULY"), tr("AUGUST"), tr("SEPTEMBER"), tr("OCTOBER"), tr("NOVEMBER"), tr("DEADCEMBER")}
	enableTranslation(true)
end

function onStatsUpdate(delta)
	-- check the stats state
	if statsActive then
		statsTime = math.min(statsTime + delta, STATS_FADE_DELAY)
	elseif statsTime > 0 then
		statsTime = math.max(statsTime - delta, 0)
	else
		return
	end

	-- handle currently pressed button
	if pressedButton then
		local x, y = mouse:getPosition()
		pressedButton.frame = pressedButton:isPointInside(x, y) and 1 or 0
	end

	-- fade the main screen
	local alpha = statsTime / STATS_FADE_DELAY
	graphics:fillRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0.0, 0.0, 0.0, alpha * 0.75)

	-- stats background
	spriteStatsBack0.alpha = alpha
	spriteStatsBack1.alpha = alpha
	spriteStatsBack0:draw()
	spriteStatsBack1:draw()

	-- text
	drawCenteredText(fontMainMenuItemHeader, spriteStatsHeader, tr("HEADER"), 0, 0, 0)
	drawCenteredText(fontMainMenuItemHeader, spriteStatsMonth, tr(monthNames[month]), 0, 0, 0)
	drawCenteredText(fontMainMenuItemHeader, spriteStatsYear, tostring(year), 0, 0, 0)

	-- buttons
	spriteStatsSelectButton.alpha = alpha
	spriteStatsSelectButton:draw()
	spriteStatsPrevButton.alpha = alpha
	spriteStatsPrevButton:draw()
	spriteStatsNextButton.alpha = alpha
	spriteStatsNextButton:draw()
	spriteStatsCloseButton.alpha = alpha
	spriteStatsCloseButton:draw()
end

function onStatsMouseDown(x, y, key)
	-- exit if not active
	if not statsActive then
		return false
	end

	-- check stats buttons
	if spriteStatsSelectButton:isPointInside(x, y) then
		pressedButton = spriteStatsSelectButton
		pressedButton.frame = 1
		soundKey:play()
	elseif spriteStatsPrevButton:isPointInside(x, y) then
		pressedButton = spriteStatsPrevButton
		pressedButton.frame = 1
		soundKey:play()
	elseif spriteStatsNextButton:isPointInside(x, y) then
		pressedButton = spriteStatsNextButton
		pressedButton.frame = 1
		soundKey:play()
	elseif spriteStatsCloseButton:isPointInside(x, y) then
		pressedButton = spriteStatsCloseButton
		pressedButton.frame = 1
		soundKey:play()
	end

	return true
end

function onStatsMouseUp(x, y, key)
	-- exit if not active
	if not statsActive then
		return false
	end

	-- release the pressed button if any
	if pressedButton then
		-- check pressed buttons
		if pressedButton:isPointInside(x, y) then
			if pressedButton == spriteStatsSelectButton then
			elseif pressedButton == spriteStatsPrevButton then
			elseif pressedButton == spriteStatsNextButton then
			elseif pressedButton == spriteStatsCloseButton then
				hideStats()
			end
		end

		pressedButton.frame = 0
		pressedButton = nil
	end

	return true
end
