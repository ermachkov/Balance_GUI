-- Stats screen settings
local STATS_FADE_DELAY = 200

-- Number of days in months
local MONTHS = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

local statsActive = false
local statsTime = 0
local pressedButton
local day, month, year
local currMonth, currYear
local currDate = {}
local monthNames
local stats = {}
local numDays

-- Updates the statistics
local function updateStats()
	-- calculate current number of days
	if currMonth == month and currYear == year then
		numDays = day
	elseif currMonth == 2 and currYear % 4 == 0 then
		numDays = 29
	else
		numDays = MONTHS[currMonth]
	end

	-- fill the current statistics
	for i = 1, numDays do
		-- determine the weekend
		currDate.day, currDate.month, currDate.year = i, currMonth, currYear
		local date = os.date("*t", os.time(currDate))
		stats[i].weekend = date.wday == 1 or date.wday == 7

		-- determine the value
		stats[i].value = math.random()
	end
end

-- Returns true if the stats window is active
function isStatsActive()
	return statsActive
end

-- Shows the stats
function showStats()
	if not statsActive and isMainMenuLoaded() then
		statsActive = true
		pressedButton = nil
		local date = os.date("*t")
		day, month, year = date.day, date.month, date.year
		currMonth, currYear = month, year

		spriteStatsCloseButton.frame = 0

		updateStats()
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

	for i = 1, 31 do
		stats[i] = {}
	end
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
	drawHorzCenteredText(fontStatsHeader, spriteStatsHeader, tr("HEADER"), 110 / 255, 110 / 255, 110 / 255)
	drawHorzCenteredText(fontStatsMonth, spriteStatsMonth, tr(monthNames[currMonth]), 80 / 255, 80 / 255, 80 / 255)
	drawHorzCenteredText(fontStatsMonth, spriteStatsYear, tostring(currYear), 80 / 255, 80 / 255, 80 / 255)

	-- bars
	local left = spriteStatsBar1.x
	local step = (spriteStatsBar31.x - spriteStatsBar1.x) / 30
	for i = 1, numDays do
		-- bar
		local value = 1.0 - stats[i].value
		local barWidth, barHeight = spriteStatsBar1:getWidth(), spriteStatsBar1:getHeight()
		spriteStatsBar1:draw(left, spriteStatsBar1.y + value * barHeight, left + barWidth, spriteStatsBar1.y + barHeight, 0, value * barHeight, barWidth, barHeight)

		-- text
		local text = tostring(i)
		local textWidth, textHeight = fontStatsTextX:getTextSize(text)
		if stats[i].weekend then
			fontStatsTextX:drawText(left + (spriteStatsBar1:getWidth() - textWidth) / 2, spriteStatsTextX1.y + (spriteStatsTextX1:getHeight() - textHeight) / 2, text, 1.0, 0.0, 0.0)
		else
			fontStatsTextX:drawText(left + (spriteStatsBar1:getWidth() - textWidth) / 2, spriteStatsTextX1.y + (spriteStatsTextX1:getHeight() - textHeight) / 2, text, 0.0, 0.0, 0.0)
		end

		-- increment the bar coordinate
		left = left + step
	end

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
				-- decrement current month
				if currYear > 2010 or currMonth > 1 then
					currMonth = currMonth - 1
					if currMonth < 1 then
						currMonth = 12
						currYear = currYear - 1
					end
					updateStats()
				end
			elseif pressedButton == spriteStatsNextButton then
				-- increment current month
				if currYear < year or currMonth < month then
					currMonth = currMonth + 1
					if currMonth > 12 then
						currMonth = 1
						currYear = currYear + 1
					end
					updateStats()
				end
			elseif pressedButton == spriteStatsCloseButton then
				hideStats()
			end
		end

		pressedButton.frame = 0
		pressedButton = nil
	end

	return true
end
