local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 188 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

DogTag:AddTag("Unit", "MP", {
	code = UnitMana,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number",
	events = "UNIT_MANA#$unit;UNIT_RAGE#$unit;UNIT_FOCUS#$unit;UNIT_ENERGY#$unit;UNIT_RUNIC_POWER#$unit;UNIT_MAXMANA#$unit;UNIT_MAXRAGE#$unit;UNIT_MAXFOCUS#$unit;UNIT_MAXENERGY#$unit;UNIT_MAXRUNIC_POWER#$unit;UNIT_DISPLAYPOWER#$unit;FastPower#$unit",
	doc = L["Return the current mana/rage/energy of unit"],
	example = ('[MP] => "%d"'):format(UnitManaMax("player")*.632),
	category = L["Power"]
})

DogTag:AddTag("Unit", "MaxMP", {
	code = UnitManaMax,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number",
	events = "UNIT_MANA#$unit;UNIT_RAGE#$unit;UNIT_FOCUS#$unit;UNIT_ENERGY#$unit;UNIT_RUNIC_POWER#$unit;UNIT_MAXMANA#$unit;UNIT_MAXRAGE#$unit;UNIT_MAXFOCUS#$unit;UNIT_MAXENERGY#$unit;UNIT_MAXRUNIC_POWER#$unit;UNIT_DISPLAYPOWER#$unit",
	doc = L["Return the maximum mana/rage/energy of unit"],
	example = ('[MaxMP] => "%d"'):format(UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("Unit", "PercentMP", {
	alias = "[MP(unit=unit) / MaxMP(unit=unit) * 100]:Round(1)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the percentage mana/rage/energy of unit"],
	example = '[PercentMP] => "63.2"; [PercentMP:Percent] => "63.2%"',
	category = L["Power"]
})

DogTag:AddTag("Unit", "MissingMP", {
	alias = "MaxMP(unit=unit) - MP(unit=unit)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the missing mana/rage/energy of unit"],
	example = ('[MissingMP] => "%d"'):format(UnitManaMax("player")*.368),
	category = L["Power"]
})

DogTag:AddTag("Unit", "FractionalMP", {
	alias = "Concatenate(MP(unit=unit), '/', MaxMP(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the current and maximum mana/rage/energy of unit"],
	example = ('[FractionalMP] => "%d/%d"'):format(UnitManaMax("player")*.632, UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("Unit", "Mana", {
	code = UnitMana,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number",
	events = "UNIT_MANA#$unit;UNIT_MAXMANA#$unit;FastPower#$unit",
	doc = L["Return the current mana of unit"],
	example = ('[Mana] => "%d"'):format(UnitManaMax("player")*.632),
	category = L["Power"]
})

DogTag:AddTag("Unit", "MaxMana", {
	code = UnitManaMax,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number",
	events = "UNIT_MANA#$unit;UNIT_MAXMANA#$unit",
	doc = L["Return the maximum mana of unit"],
	example = ('[MaxMana] => "%d"'):format(UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("Unit", "PercentMana", {
	alias = "[Mana(unit=unit) / MaxMana(unit=unit) * 100]:Round(1)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the percentage mana of unit"],
	example = '[PercentMana] => "63.2"; [PercentMana:Percent] => "63.2%"',
	category = L["Power"]
})

DogTag:AddTag("Unit", "MissingMana", {
	alias = "MaxMana(unit=unit) - Mana(unit=unit)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the missing mana of unit"],
	example = ('[MissingMana] => "%d"'):format(UnitManaMax("player")*.368),
	category = L["Power"]
})

DogTag:AddTag("Unit", "FractionalMana", {
	alias = "Concatenate(Mana(unit=unit), '/', MaxMana(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the current and maximum mana of unit"],
	example = ('[FractionalMana] => "%d/%d"'):format(UnitManaMax("player")*.632, UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("Unit", "Rage", {
	code = UnitPower,
	arg = {
		'unit', 'string;undef', 'player',
		'type', 'number;undef', 1
	},
	ret = "number",
	events = "UNIT_RAGE#$unit;UNIT_MAXRAGE#$unit;FastPower#$unit",
	doc = L["Return the current rage of unit"],
	example = ('[Rage] => "%d"'):format(UnitPowerMax("player", 1)*.632),
	category = L["Power"]
})

DogTag:AddTag("Unit", "MaxRage", {
	code = UnitPowerMax,
	arg = {
		'unit', 'string;undef', 'player',
		'type', 'number;undef', 1
	},
	ret = "number",
	events = "UNIT_RAGE#$unit;UNIT_MAXRAGE#$unit;FastPower#$unit",
	doc = L["Return the maximum rage of unit"],
	example = ('[MaxRage] => "%d"'):format(UnitPowerMax("player", 1)),
	category = L["Power"]
})

DogTag:AddTag("Unit", "PercentRage", {
	alias = "[Rage(unit=unit) / MaxRage(unit=unit) * 100]:Round(1)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the percentage rage of unit"],
	example = '[PercentRage] => "63.2"; [PercentRage:Percent] => "63.2%"',
	category = L["Power"]
})

DogTag:AddTag("Unit", "MissingRage", {
	alias = "MaxRage(unit=unit) - Rage(unit=unit)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the missing rage of unit"],
	example = ('[MissingRage] => "%d"'):format(UnitPowerMax("player", 1)*.368),
	category = L["Power"]
})

DogTag:AddTag("Unit", "FractionalRage", {
	alias = "Concatenate(Rage(unit=unit), '/', MaxRage(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the current and maximum rage of unit"],
	example = ('[FractionalRage] => "%d/%d"'):format(UnitPower("player", 1)*.632, UnitPowerMax("player", 1)),
	category = L["Power"]
})

DogTag:AddTag("Unit", "Energy", {
	code = UnitPower,
	arg = {
		'unit', 'string;undef', 'player',
		'type', 'number;undef', 2
	},
	ret = "number",
	events = "UNIT_ENERGY#$unit;UNIT_MAXENERGY#$unit;FastPower#$unit",
	doc = L["Return the current energy of unit"],
	example = ('[Energy] => "%d"'):format(UnitPowerMax("player", 2)*.632),
	category = L["Power"]
})

DogTag:AddTag("Unit", "MaxEnergy", {
	code = UnitPowerMax,
	arg = {
		'unit', 'string;undef', 'player',
		'type', 'number;undef', 2
	},
	ret = "number",
	events = "UNIT_ENERGY#$unit;UNIT_MAXENERGY#$unit;FastPower#$unit",
	doc = L["Return the maximum energy of unit"],
	example = ('[MaxEnergy] => "%d"'):format(UnitPowerMax("player", 2)),
	category = L["Power"]
})

DogTag:AddTag("Unit", "PercentEnergy", {
	alias = "[Energy(unit=unit) / MaxEnergy(unit=unit) * 100]:Round(1)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the percentage energy of unit"],
	example = '[PercentEnergy] => "63.2"; [PercentEnergy:Percent] => "63.2%"',
	category = L["Power"]
})

DogTag:AddTag("Unit", "MissingEnergy", {
	alias = "MaxEnergy(unit=unit) - Energy(unit=unit)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the missing energy of unit"],
	example = ('[MissingEnergy] => "%d"'):format(UnitPowerMax("player", 2)*.368),
	category = L["Power"]
})

DogTag:AddTag("Unit", "FractionalEnergy", {
	alias = "Concatenate(Energy(unit=unit), '/', MaxEnergy(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the current and maximum mana/rage/energy of unit"],
	example = ('[FractionalEnergy] => "%d/%d"'):format(UnitPower("player", 1)*.632, UnitPowerMax("player", 2)),
	category = L["Power"]
})

DogTag:AddTag("Unit", "TypePower", {
	code = function(unit)
		local p = UnitPowerType(unit)
		if p == 1 then
			return L["Rage"]
		elseif p == 2 then
		 	return L["Focus"]
		elseif p == 3 then
			return L["Energy"]
		elseif p == 6 then
			return L["Runic Power"]
		else
			return L["Mana"]
		end
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "string",
	events = "UNIT_DISPLAYPOWER#$unit",
	doc = L["Return whether unit currently uses Rage, Focus, Energy, or Mana"],
	example = ('[TypePower] => %q; [TypePower] => %q'):format(L["Rage"], L["Mana"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsPowerType", {
	alias = [=[Boolean(TypePower(unit=unit) = type)]=],
	arg = {
		'type', 'string', '@req',
		'unit', 'string;undef', 'player'
	},
	ret = "boolean",
	events = "UNIT_DISPLAYPOWER#$unit",
	doc = L["Return True if unit currently uses the power of argument"],
	example = ('[HasPower(%q)] => %q; [HasPower(%q)] => ""'):format(L["Rage"], L["True"], L["Mana"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsRage", {
	alias = ("IsPowerType(type=%q, unit=unit)"):format(L["Rage"]),
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit currently uses rage"],
	example = ('[IsRage] => %q; [IsRage] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsFocus", {
	alias = ("IsPowerType(type=%q, unit=unit)"):format(L["Focus"]),
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit currently uses focus"],
	example = ('[IsFocus] => %q; [IsFocus] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsEnergy", {
	alias = ("IsPowerType(type=%q, unit=unit)"):format(L["Energy"]),
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit currently uses energy"],
	example = ('[IsEnergy] => %q; [IsEnergy] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsMana", {
	alias = ("IsPowerType(type=%q, unit=unit)"):format(L["Mana"]),
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit currently uses mana"],
	example = ('[IsMana] => %q; [IsMana] => ""'):format(L["True"]),
	category = L["Power"]
})

if RUNIC_POWER then
	DogTag:AddTag("Unit", "IsRunicPower", {
		alias = ("IsPowerType(type=%q, unit=unit)"):format(L["Runic Power"]),
		arg = {
			'unit', 'string;undef', 'player'
		},
		doc = L["Return True if unit currently uses runic power"],
		example = ('[IsRunicPower] => %q; [IsRunicPower] => ""'):format(L["True"]),
		category = L["Power"]
	})
end

DogTag:AddTag("Unit", "IsMaxMP", {
	alias = "Boolean(MP(unit=unit) = MaxMP(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit is at full rage/mana/energy"],
	example = ('[IsMaxMP] => %q; [IsMaxMP] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "HasMP", {
	alias = "Boolean(MaxMP(unit=unit) > 0)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit has any power type at all"],
	example = ('[HasMP] => %q; [HasMP] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsMaxMana", {
	alias = "Boolean(Mana(unit=unit) = MaxMana(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit is at full mana"],
	example = ('[IsMaxMana] => %q; [IsMaxMana] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "HasMana", {
	alias = "Boolean(MaxMana(unit=unit) > 0)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit has any mana at all"],
	example = ('[HasMana] => %q; [HasMana] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsMaxRage", {
	alias = "Boolean(Rage(unit=unit) = MaxRage(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit is at full rage"],
	example = ('[IsMaxRage] => %q; [IsMaxRage] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "HasRage", {
	alias = "Boolean(MaxRage(unit=unit) > 0)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit has rage at all"],
	example = ('[HasRage] => %q; [HasRage] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "IsMaxEnergy", {
	alias = "Boolean(Energy(unit=unit) = MaxEnergy(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit is at full energy"],
	example = ('[IsMaxEnergy] => %q; [IsMaxEnergy] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "HasEnergy", {
	alias = "Boolean(MaxEnergy(unit=unit) > 0)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return True if unit has energy at all"],
	example = ('[HasEnergy] => %q; [HasEnergy] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("Unit", "PowerColor", {
	code = function(value, unit)
		local powerType = UnitPowerType(unit)
		local r,g,b
		if powerType == 0 then
			r,g,b = unpack(DogTag.__colors.mana)
		elseif powerType == 1 then
			r,g,b = unpack(DogTag.__colors.rage)
		elseif powerType == 2 then
			r,g,b = unpack(DogTag.__colors.focus)
		elseif powerType == 3 then
			r,g,b = unpack(DogTag.__colors.energy)
		elseif powerType == 6 then
			r,g,b = unpack(DogTag.__colors.runicPower)
		else
			r,g,b = unpack(DogTag.__colors.unknown)
		end
		if value then
			return ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		else
			return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		end
	end,
	arg = {
		'value', 'string;undef', '@undef',
		'unit', 'string;undef', 'player'
	},
	ret = "string",
	events = "UNIT_DISPLAYPOWER#$unit",
	doc = L["Return the color or wrap value with current power color of unit, whether rage, mana, or energy"],
	example = '["Hello":PowerColor] => "|cff3071bfHello|r"; [PowerColor "Hello"] => "|cff3071bfHello"',
	category = L["Power"]
})

end