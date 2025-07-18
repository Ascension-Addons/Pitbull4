if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_ManaBar requires PitBull4")
end

local EXAMPLE_VALUE = 0.6

local L = PitBull4.L

local PitBull4_ManaBar = PitBull4:NewModule("ManaBar", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local last_player_mana
local last_pet_mana

PitBull4_ManaBar:SetModuleType("bar")
PitBull4_ManaBar:SetName(L["Mana bar"])
PitBull4_ManaBar:SetDescription(L["Show a mana bar."])
PitBull4_ManaBar.allow_animations = true
PitBull4_ManaBar:SetDefaults({
	position = 3,
	size = 1,
	hide_no_mana = false,
	hide_no_mana = false,
})

local guids_to_update = {}
local predicted_mana = true

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

local PLAYER_GUID
function PitBull4_ManaBar:OnEnable()
	PLAYER_GUID = UnitGUID("player")

	self:RegisterEvent("UNIT_MANA")
	self:RegisterEvent("UNIT_MAXMANA", "UNIT_MANA")

	self:SecureHook("SetCVar")
	self:SetCVar()

	timerFrame:Show()
end

function PitBull4_ManaBar:OnDisable()
	timerFrame:Hide()
end

timerFrame:SetScript("OnUpdate", function()
	if predicted_mana and UnitMana("player") ~= last_player_mana then
		for frame in PitBull4:IterateFramesForGUID(PLAYER_GUID) do
			if not frame.is_wacky then
				PitBull4_ManaBar:Update(frame)
			end
		end
		guids_to_update[PLAYER_GUID] = nil
	end
	if predicted_mana and UnitMana("pet") ~= last_pet_mana then
		local pet_guid = UnitGUID("pet")
		if pet_guid then
			for frame in PitBull4:IterateFramesForGUID(pet_guid) do
				if not frame.is_wacky then
					PitBull4_ManaBar:Update(frame)
				end
			end
			guids_to_update[pet_guid] = nil
		end
	end
	if next(guids_to_update) then
		for frame in PitBull4:IterateFrames() do
			if guids_to_update[frame.guid] then
				PitBull4_ManaBar:Update(frame)
			end
		end
		wipe(guids_to_update)
	end
end)

local function get_mana_and_cache(unit)
	local mana = UnitMana(unit)
	if unit == "player" then
		last_player_mana = mana
	elseif unit == "pet" then
		last_pet_mana = mana
	end
	return mana
end

function PitBull4_ManaBar:GetValue(frame)	
	local unit = frame.unit
	local layout_db = self:GetLayoutDB(frame)

	if layout_db.hide_no_mana and UnitManaMax(unit) <= 0 then
		return nil
	end

	if layout_db.hide_full_mana and UnitManaMax(unit) == UnitMana(unit) then
		return nil
	end

	return get_mana_and_cache(unit) / UnitManaMax(unit)
end

function PitBull4_ManaBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_ManaBar:GetColor(frame, value)
	local db = self:GetLayoutDB(frame)
	local color = PitBull4.PowerColors["MANA"]
	
	if color then
		return color[1], color[2], color[3]
	end
end
function PitBull4_ManaBar:GetExampleColor(frame)
	return unpack(PitBull4.PowerColors.MANA)
end

function PitBull4_ManaBar:UNIT_MANA(event, unit)
	guids_to_update[UnitGUID(unit)] = true
end

function PitBull4_ManaBar:SetCVar()
	predicted_mana = GetCVarBool("predictedMana")
end

PitBull4_ManaBar:SetLayoutOptionsFunction(function(self)
	return 'hide_no_mana', {
		name = L['Hide non-mana'],
		desc = L["Hides the mana bar if the unit has no mana."],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_no_mana
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_no_mana = value

			PitBull4.Options.UpdateFrames()
		end,
	}, 'hide_full_mana', {
		name = L['Hide full mana'],
		desc = L['Hides the power bar if the unit has full mana.  Useful for player frame if not using mana'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_full_mana
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_full_mana = value

			PitBull4.Options.UpdateFrames()
		end,
	}
end)
