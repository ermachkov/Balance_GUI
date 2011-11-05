-- Stats screen settings
local STATS_FADE_DELAY = 200

-- Number of days in months
local MONTHS = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

local statsActive = false
local statsTime = 0
local statsMode, statsSubmode
local pressedButton
local day, month, year
local currMonth, currYear
local currDate = {}
local statsTitles, statsModes, monthNames
local stats = {}
local numValues

-- Updates the statistics
local function updateStats()
	if statsMode == STATS_DISKS or statsMode == STATS_WEIGHTS then
		-- calculate current number of days
		if currMonth == month and currYear == year then
			numValues = day
		elseif currMonth == 2 and currYear % 4 == 0 then
			numValues = 29
		else
			numValues = MONTHS[currMonth]
		end

		-- fill the current statistics
		for i = 1, numValues do
			-- determine the value
			stats[i].text = tostring(i)
			stats[i].value = math.random()

			-- determine the weekend
			currDate.day, currDate.month, currDate.year = i, currMonth, currYear
			local date = os.date("*t", os.time(currDate))
			stats[i].weekend = date.wday == 1 or date.wday == 7
		end
	else
		-- set up inches
		numValues = 13
		for i = 1, numValues do
			-- determine the value
			stats[i].text = tostring(i + 11)
			stats[i].value = math.random()
			stats[i].weekend = false
		end
	end
end

-- Returns true if the stats window is active
function isStatsActive()
	return statsActive
end

-- Shows the stats
function showStats(mode)
	if not statsActive and isMainMenuLoaded() then
		statsActive = true
		statsMode, statsSubmode = mode, 0
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
	statsTitles = {tr("{stats_disks_title}"), tr("{stats_inches_title}"), tr("{stats_weights_title}")}
	statsModes = {{tr("{stats_all}"), tr("{stats_alu}"), tr("{stats_steel}")}, {tr("{stats_all}"), tr("{stats_alu}"), tr("{stats_steel}")}, {tr("{stats_all}"), tr("{stats_normal}"), tr("{stats_stick}")}}
	monthNames = {tr("JANUARY"), tr("FEBRUARY"), tr("MARCH"), tr("APRIL"), tr("MAY"), tr("JUNE"), tr("JULY"), tr("AUGUST"), tr("SEPTEMBER"), tr("OCTOBER"), tr("NOVEMBER"), tr("DECEMBER")}
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
	drawHorzCenteredText(fontStatsHeader, spriteStatsHeader, tr(statsTitles[statsMode + 1]), 110 / 255, 110 / 255, 110 / 255)
	drawHorzCenteredText(fontStatsMonth, spriteStatsMonth, tr(monthNames[currMonth]), 80 / 255, 80 / 255, 80 / 255)
	drawHorzCenteredText(fontStatsMonth, spriteStatsYear, tostring(currYear), 80 / 255, 80 / 255, 80 / 255)

	-- bars
	local left = spriteStatsBar1.x
	local step = (spriteStatsBar31.x - spriteStatsBar1.x) / ((statsMode == STATS_DISKS or statsMode == STATS_WEIGHTS) and 30 or (numValues - 1))
	for i = 1, numValues do
		-- bar
		local value = 1.0 - stats[i].value
		local barWidth, barHeight = spriteStatsBar1:getWidth(), spriteStatsBar1:getHeight()
		spriteStatsBar1:draw(left, spriteStatsBar1.y + value * barHeight, left + barWidth, spriteStatsBar1.y + barHeight, 0, value * barHeight, barWidth, barHeight)

		-- text
		local text = stats[i].text
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

	-- submode
	drawCenteredText(fontStatsMode, spriteStatsSelectButton, tr(statsModes[statsMode + 1][statsSubmode + 1]), 1.0, 1.0, 1.0)
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
				-- increment submode
				statsSubmode = statsSubmode + 1
				if statsSubmode > 2 then
					statsSubmode = 0
				end
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
