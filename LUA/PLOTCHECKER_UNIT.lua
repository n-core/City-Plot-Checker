print("-------------------------------------------------------");
print("----- START -- Plot Checker for unit procedure---------");
print("-------------------------------------------------------");

function unitCheck (iPlayer, iCity, unitType)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)

	local iCivilSeaUnitClass = {
		GameInfo.UnitClasses.UNITCLASS_CARGO_SHIP,
		GameInfo.UnitClasses.UNITCLASS_WORKBOAT,
		GameInfo.UnitClasses.UNITCLASS_ADMIRAL
	};
	local iCivilSeaUnitClassID = nil;
	if(iCivilSeaUnitClass ~= nil) then
		iCivilSeaUnitClassID = iCivilSeaUnitClass.ID;
	end

	--[[
	local iCargoShipClass = GameInfo.UnitClasses.UNITCLASS_CARGO_SHIP
	local iWorkBoatClass = GameInfo.UnitClasses.UNITCLASS_WORKBOAT
	local iGAdmiralClass = GameInfo.UnitClasses.UNITCLASS_ADMIRAL
	]]--

	--local pUnitType = pPlayer:GetUnitByID(unitTypeID)
	local pUnitType = GameInfo.Units[unitType].Domain;

	--if pUnitType:GetDomainType() == DomainTypes.DOMAIN_SEA and
	if	iCivilSeaUnitClassID ~= nil and
		pUnitType == DomainTypes.DOMAIN_SEA and
		pUnitType:GetUnitClassType() ~= iCivilSeaUnitClassID then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot)
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				not pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) then
					print("--- [", pCity:GetName(), "] has a [Sea] tile on a workable plot. ---");
					print("--- Enabling [", pCity:GetName(),"] to be able to train Sea units. ---");
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