print("-------------------------------------------------------");
print("----- START -- Plot Checker for unit procedure---------");
print("-------------------------------------------------------");

local L = Locale.ConvertTextKey

function unitCheck (iPlayer, iCity, unitTypeID)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	--
	local iCivilSeaUnitClass = {
		GameInfo.UnitClasses.UNITCLASS_CARGO_SHIP,
		GameInfo.UnitClasses.UNITCLASS_WORKBOAT,
		GameInfo.UnitClasses.UNITCLASS_GREAT_ADMIRAL
	};
	local iCivilSeaUnitClassID = nil;
	if(iCivilSeaUnitClass ~= nil) then
		iCivilSeaUnitClassID = iCivilSeaUnitClass.ID;
	end--]]


	local pUnitType = GameInfo.Units[unitTypeID].Type;

	local iCityName = pCity:GetName();
	local seaWaterName = L("TXT_KEY_CPC_PLOTROLL_SEA");
	if	pUnitType ~= nil
		then
		--local iUnitID = GameInfoTypes[pUnitType];
		local unitName = L(GameInfo.Units[unitTypeID].Description);
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot)
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				not pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) and
				unitTypeID:GetDomainType() == DomainTypes.DOMAIN_SEA and
				unitTypeID:GetUnitClassType() ~= iCivilSeaUnitClassID then
				print("Unit:", unitName);
				--add floating message
				LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_TRAIN"), iCityName, seaWaterName, unitName);
				return true
			end
		end
		return false
	end

	return true
end

GameEvents.CityCanTrain.Add(unitCheck)

print("-------------------------------------------------------");
print("----- DONE --- Plot Checker for unit procedure---------");
print("-------------------------------------------------------");