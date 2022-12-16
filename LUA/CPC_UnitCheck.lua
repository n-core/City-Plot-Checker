print("-------------------------------------------------------");
print("----- START -- Plot Checker for unit procedure---------");
print("-------------------------------------------------------");

local L = Locale.ConvertTextKey

function CPC_UnitCheck (iPlayer, iCity, unitTypeID)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	--
	local eCivilSeaUnitClass = {
		GameInfo.UnitClasses.UNITCLASS_CARGO_SHIP,
		GameInfo.UnitClasses.UNITCLASS_WORKBOAT,
		GameInfo.UnitClasses.UNITCLASS_GREAT_ADMIRAL
	};
	local iCivilSeaUnitClassID = nil;
	if(eCivilSeaUnitClass ~= nil) then
		iCivilSeaUnitClassID = eCivilSeaUnitClass.ID;
	end--]]

	local eUnitType = GameInfo.Units[unitTypeID];

	local strCityName = pCity:GetName();
	local strSeaWaterName = L("TXT_KEY_CPC_PLOTROLL_SEA");
	if	eUnitType ~= nil and iCivilSeaUnitClassID ~= nil
		then
		--local iUnitID = GameInfoTypes[pUnitType];
		local strUnitName = L(GameInfo.Units[unitTypeID].Description);
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot)
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				not pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) and
				eUnitType:GetDomainType() == DomainTypes.DOMAIN_SEA and
				eUnitType:GetUnitClassType() ~= iCivilSeaUnitClassID then
				print("Unit:", strUnitName);
				--add floating message
				LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_TRAIN"), strCityName, strSeaWaterName, strUnitName);
				return true
			end
		end
		return false
	end

	return true
end

GameEvents.CityCanTrain.Add(CPC_UnitCheck)

print("-------------------------------------------------------");
print("----- DONE --- Plot Checker for unit procedure---------");
print("-------------------------------------------------------");
