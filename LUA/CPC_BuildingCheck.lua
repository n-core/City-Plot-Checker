print("-------------------------------------------------------");
print("----- START -- Plot Checker for building procedure-----");
print("-------------------------------------------------------");

local L = Locale.ConvertTextKey;

function CPC_BuildingCheck (iPlayer, iCity, buildingTypeID)
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCityByID(iCity);

	local sHasTerrain = GameInfo.Buildings[buildingTypeID].IsHasTerrain;
	local bHasHill = GameInfo.Buildings[buildingTypeID].IsHasHill;
	local bHasMountain = GameInfo.Buildings[buildingTypeID].IsHasMountain;
	local bHasAnyWater = GameInfo.Buildings[buildingTypeID].IsHasAnyWater;
	local bHasSeaWater = GameInfo.Buildings[buildingTypeID].IsHasSeaWater;
	local bHasLake = GameInfo.Buildings[buildingTypeID].IsHasLake;
	local bHasRiver = GameInfo.Buildings[buildingTypeID].IsHasRiver;
	local bHasFreshWater = GameInfo.Buildings[buildingTypeID].IsHasFreshWater;

	local strCityName = pCity:GetName();
	local strBuildingName = L(GameInfo.Buildings[buildingTypeID].Description);
	local strHillName = L("TXT_KEY_PLOTROLL_HILL");
	local strMountainName = L("TXT_KEY_PLOTROLL_MOUNTAIN");
	local strAnyWaterName = L("TXT_KEY_CPC_PLOTROLL_ANYWATER");
	local strSeaWaterName = L("TXT_KEY_CPC_PLOTROLL_SEA");
	local strRiverName = L("TXT_KEY_PLOTROLL_RIVER");
	local strLakeName = L("TXT_KEY_PLOTROLL_LAKE");
	local strFreshWaterName = L("TXT_KEY_PLOTROLL_FRESH_WATER");

	-- If the building has IsHasTerrain check
	if sHasTerrain ~= nil then
		local eTerrainID = GameInfoTypes[sHasTerrain];
		local strTerrainName = L(GameInfo.Terrains[eTerrainID].Description);
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:GetTerrainType() == eTerrainID and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strTerrainName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasHill check
	if bHasHill == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsHills() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strHillName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasMountain check
	if bHasMountain == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsMountain() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strMountainName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasAnyWater check
	if bHasAnyWater == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strAnyWaterName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasSeaTile check
	if bHasSeaWater == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				not pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strSeaWaterName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasRiver check
	if bHasRiver == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsRiver() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD_ADJACENT"), strCityName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasLake check
	if bHasLake == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strLakeName, strBuildingName);
		end
		return false
	end

	-- If the building has IsHasFreshWater check
	if bHasFreshWater == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				(pPlot:IsRiver() or pPlot:IsLake()) and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), strCityName, strFreshWaterName, strBuildingName);
		end
		return false
	end

	return true
end

GameEvents.CityCanConstruct.Add(CPC_BuildingCheck)

print("------------------------------------------------------");
print("----- DONE --- Plot Checker for building procedure----");
print("------------------------------------------------------");
