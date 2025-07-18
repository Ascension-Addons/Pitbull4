if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_RageBar requires PitBull4")
end

local EXAMPLE_VALUE = 0.6

local L = PitBull4.L

local PitBull4_RageBar = PitBull4:NewModule("RageBar", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local last_player_rage
local last_pet_rage

PitBull4_RageBar:SetModuleType("bar")
PitBull4_RageBar:SetName(L["Rage bar"])
PitBull4_RageBar:SetDescription(L["Show a rage bar."])
PitBull4_RageBar.allow_animations = true
PitBull4_RageBar:SetDefaults({
	position = 4,
	size = 1,
	hide_no_rage = false,
	hide_no_rage = false,
})

local guids_to_update = {}

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

local PLAYER_GUID
function PitBull4_RageBar:OnEnable()
	PLAYER_GUID = UnitGUID("player")

	self:RegisterEvent("UNIT_RAGE")
	self:RegisterEvent("UNIT_MAXRAGE", "UNIT_RAGE")

	timerFrame:Show()
end

function PitBull4_RageBar:OnDisable()
	timerFrame:Hide()
end

timerFrame:SetScript("OnUpdate", function()
	if next(guids_to_update) then
		for frame in PitBull4:IterateFrames() do
			if guids_to_update[frame.guid] then
				PitBull4_RageBar:Update(frame)
			end
		end
		wipe(guids_to_update)
	end
end)

local function get_rage_and_cache(unit)
	local rage = UnitPower(unit, 1)
	if unit == "player" then
		last_player_rage = rage
	elseif unit == "pet" then
		last_pet_rage = rage
	end
	return rage
end

function PitBull4_RageBar:GetValue(frame)	
	local unit = frame.unit
	local layout_db = self:GetLayoutDB(frame)

	if layout_db.hide_no_rage and UnitPower(unit, 1) <= 0 then
		return nil
	end

	if layout_db.hide_full_rage and UnitPower(unit, 1) == UnitPowerMax(unit, 1) then
		return nil
	end

	return get_rage_and_cache(unit) / UnitPowerMax(unit, 1)
end

function PitBull4_RageBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_RageBar:GetColor(frame, value)
	local db = self:GetLayoutDB(frame)
	local color = PitBull4.PowerColors["RAGE"]
	
	if color then
		return color[1], color[2], color[3]
	end
end
function PitBull4_RageBar:GetExampleColor(frame)
	return unpack(PitBull4.PowerColors.RAGE)
end

function PitBull4_RageBar:UNIT_RAGE(event, unit)
	guids_to_update[UnitGUID(unit)] = true
end

PitBull4_RageBar:SetLayoutOptionsFunction(function(self)
	return 'hide_no_rage', {
		name = L['Hide non-rage'],
		desc = L["Hides the rage bar if the unit has no rage."],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_no_rage
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_no_rage = value

			PitBull4.Options.UpdateFrames()
		end,
	}, 'hide_full_rage', {
		name = L['Hide full rage'],
		desc = L['Hides the power bar if the unit has full rage.  Useful for player frame if not using rage'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_full_rage
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_full_rage = value

			PitBull4.Options.UpdateFrames()
		end,
	}
end)
