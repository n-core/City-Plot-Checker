print("-------------------------------------------------------");
print("----- START -- Plot Checker for building procedure-----");
print("-------------------------------------------------------");

local L = Locale.ConvertTextKey

function buildingCheck (iPlayer, iCity, buildingTypeID)
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCityByID(iCity);

	local iHasTerrain = GameInfo.Buildings[buildingTypeID].IsHasTerrain;
	--local iHasFeature = GameInfo.Buildings[buildingTypeID].IsHasFeature; --Scrapped, I forgot that Building_LocalFeatureOrs table exists
	local iHasHill = GameInfo.Buildings[buildingTypeID].IsHasHill;
	local iHasMountain = GameInfo.Buildings[buildingTypeID].IsHasMountain;
	local iHasAnyWater = GameInfo.Buildings[buildingTypeID].IsHasAnyWater;
	local iHasSeaWater = GameInfo.Buildings[buildingTypeID].IsHasSeaWater;
	local iHasLake = GameInfo.Buildings[buildingTypeID].IsHasLake;
	local iHasRiver = GameInfo.Buildings[buildingTypeID].IsHasRiver;
	local iHasFreshWater = GameInfo.Buildings[buildingTypeID].IsHasFreshWater;

	local iCityName = pCity:GetName();
	local buildingName = L(GameInfo.Buildings[buildingTypeID].Description);
	local hillName = L("TXT_KEY_PLOTROLL_HILL");
	local mountainName = L("TXT_KEY_PLOTROLL_MOUNTAIN");
	local anyWaterName = L("TXT_KEY_CPC_PLOTROLL_ANYWATER");
	local seaWaterName = L("TXT_KEY_CPC_PLOTROLL_SEA");
	local riverName = L("TXT_KEY_PLOTROLL_RIVER");
	local lakeName = L("TXT_KEY_PLOTROLL_LAKE");
	local freshWaterName = L("TXT_KEY_PLOTROLL_FRESH_WATER");

	-- If the building has IsHasTerrain check
	if iHasTerrain ~= nil then
		local iTerrainID = GameInfoTypes[iHasTerrain];
		local terrainName = L(GameInfo.Terrains[iTerrainID].Description);
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:GetTerrainType() == iTerrainID and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, terrainName, buildingName);
		end
		return false
	end

	--[[ If the building has IsHasFeature check --Scrapped, I forgot that Building_LocalFeatureOrs table exists
	if iHasFeature ~= NULL then
		local iFeatureID = GameInfoTypes[iHasFeature];
		local featureName = L(GameInfo.Features[iFeatureID].Description);
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:GetFeatureType() == iFeatureID and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, featureName, buildingName);
		end
		return false
	end]]

	-- If the building has IsHasHill check
	if iHasHill == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsHills() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, hillName, buildingName);
		end
		return false
	end

	-- If the building has IsHasMountain check
	if iHasMountain == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsMountain() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, mountainName, buildingName);
		end
		return false
	end

	-- If the building has IsHasAnyWater check
	if iHasAnyWater == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, anyWaterName, buildingName);
		end
		return false
	end

	-- If the building has IsHasSeaTile check
	if iHasSeaWater == 1 then
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
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, seaWaterName, buildingName);
		end
		return false
	end

	-- If the building has IsHasRiver check
	if iHasRiver == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsRiver() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD_ADJACENT"), iCityName, buildingName);
		end
		return false
	end

	-- If the building has IsHasLake check
	if iHasLake == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, lakeName, buildingName);
		end
		return false
	end

	-- If the building has IsHasFreshWater check
	if iHasFreshWater == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				(pPlot:IsRiver() or pPlot:IsLake()) and
				pPlot:GetOwner() == iPlayer) then
				return true
			end
			--add floating message
			LuaEvents.CPC_FloatingMessage(L("TXT_KEY_CPC_CITY_BUILD"), iCityName, freshWaterName, buildingName);
		end
		return false
	end

	return true
end

GameEvents.CityCanConstruct.Add(buildingCheck)

print("------------------------------------------------------");
print("----- DONE --- Plot Checker for building procedure----");
print("------------------------------------------------------");