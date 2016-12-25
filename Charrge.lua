--[[
	Charrge

	By: Danjo.
]]--

-- Helpers

function ActiveStance()
	--Detect the active stance
	for i = 1, 3 do
		local _, _, active = GetShapeshiftFormInfo(i);
		if (active) then
			return i;
		end
	end
	return nil;
end

function Charrge()
  if (not CharrgeCombat and ActiveStance() == 1) then
    CastSpellByName(ABILITY_CHARGE_CHARRGE);
  elseif (not CharrgeCombat and ActiveStance() ~= 1) then
    CastShapeshiftForm(1);
  elseif (CharrgeCombat and ActiveStance() ~= 3) then
    CastShapeshiftForm(3);
  elseif (CharrgeCombat and ActiveStance() == 3) then
    CastSpellByName(ABILITY_INTERCEPT_CHARRGE);
  end
end

-- Event Handlers

function Charrge_OnLoad()
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	--this:RegisterEvent("PLAYER_ENTER_COMBAT");
	--this:RegisterEvent("PLAYER_LEAVE_COMBAT");
  CharrgeCombat = nil;
end

function Charrge_OnEvent(event)
	if (event == "PLAYER_REGEN_DISABLED") then
		CharrgeCombat = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		CharrgeCombat = nil;
	end
end
