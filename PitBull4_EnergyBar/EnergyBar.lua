if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_EnergyBar requires PitBull4")
end

local EXAMPLE_VALUE = 0.6

local L = PitBull4.L

local PitBull4_EnergyBar = PitBull4:NewModule("EnergyBar", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local last_player_energy
local last_pet_energy

PitBull4_EnergyBar:SetModuleType("bar")
PitBull4_EnergyBar:SetName(L["Energy bar"])
PitBull4_EnergyBar:SetDescription(L["Show an energy bar."])
PitBull4_EnergyBar.allow_animations = true
PitBull4_EnergyBar:SetDefaults({
	position = 5,
	size = 1,
	hide_no_energy = false,
	hide_no_energy = false,
})

local guids_to_update = {}

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

local PLAYER_GUID
function PitBull4_EnergyBar:OnEnable()
	PLAYER_GUID = UnitGUID("player")

	self:RegisterEvent("UNIT_ENERGY")
	self:RegisterEvent("UNIT_MAXENERGY", "UNIT_ENERGY")

	timerFrame:Show()
end

function PitBull4_EnergyBar:OnDisable()
	timerFrame:Hide()
end

timerFrame:SetScript("OnUpdate", function()
	if next(guids_to_update) then
		for frame in PitBull4:IterateFrames() do
			if guids_to_update[frame.guid] then
				PitBull4_EnergyBar:Update(frame)
			end
		end
		wipe(guids_to_update)
	end
end)

local function get_energy_and_cache(unit)
	local energy = UnitPower(unit, 2)
	if unit == "player" then
		last_player_energy = energy
	elseif unit == "pet" then
		last_pet_energy = energy
	end
	return energy
end

function PitBull4_EnergyBar:GetValue(frame)	
	local unit = frame.unit
	local layout_db = self:GetLayoutDB(frame)

	if layout_db.hide_no_energy and UnitPowerMax(unit, 2) <= 0 then
		return nil
	end

	if layout_db.hide_empty_energy and UnitPower(unit, 2) <= 0 then
		return nil
	end

	if layout_db.hide_full_energy and UnitPower(unit, 2) == UnitPowerMax(unit, 2) then
		return nil
	end

	return get_energy_and_cache(unit) / UnitPowerMax(unit, 2)
end

function PitBull4_EnergyBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_EnergyBar:GetColor(frame, value)
	local db = self:GetLayoutDB(frame)
	local color = PitBull4.PowerColors["ENERGY"]
	
	if color then
		return color[1], color[2], color[3]
	end
end
function PitBull4_EnergyBar:GetExampleColor(frame)
	return unpack(PitBull4.PowerColors.ENERGY)
end

function PitBull4_EnergyBar:UNIT_ENERGY(event, unit)
	guids_to_update[UnitGUID(unit)] = true
end

PitBull4_EnergyBar:SetLayoutOptionsFunction(function(self)
	return 'hide_no_energy', {
		name = L['Hide non-energy'],
		desc = L["Hides the energy bar if the unit has no energy."],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_no_energy
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_no_energy = value

			PitBull4.Options.UpdateFrames()
		end,
	}, 'hide_full_energy', {
		name = L['Hide full energy'],
		desc = L['Hides the power bar if the unit has full energy.  Useful for player frame if not using energy'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_full_energy
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_full_energy = value

			PitBull4.Options.UpdateFrames()
		end,
	}, 'hide_empty_energy', {
		name = L['Hide empty energy'],
		desc = L['Hides the power bar if the unit has empty energy.  Useful for player frame if not using energy'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_empty_energy
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_empty_energy = value

			PitBull4.Options.UpdateFrames()
		end,
	}
end)
