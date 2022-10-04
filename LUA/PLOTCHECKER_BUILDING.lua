print("-------------------------------------------------------");
print("----- START -- Plot Checker for building procedure-----");
print("-------------------------------------------------------");

function buildingCheck (iPlayer, iCity, buildingTypeID)
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCityByID(iCity);

	local iHasTerrain = GameInfo.Buildings[buildingTypeID].IsHasTerrain;
	local iHasFeature = GameInfo.Buildings[buildingTypeID].IsHasTerrain;
	local iHasMountain = GameInfo.Buildings[buildingTypeID].IsHasMountain;
	local iHasHill = GameInfo.Buildings[buildingTypeID].IsHasHill;
	local iHasAnyWater = GameInfo.Buildings[buildingTypeID].IsHasAnyWater;
	local iHasSeaTile = GameInfo.Buildings[buildingTypeID].IsHasSeaTile;
	local iHasLake = GameInfo.Buildings[buildingTypeID].IsHasLake;
	local iHasRiver = GameInfo.Buildings[buildingTypeID].IsHasRiver;

	-- If the building has IsHasTerrain check
	if iHasTerrain ~= NULL then
		local iTerrainID = GameInfoTypes[iHasTerrain];
		--trying to fetch building name from the database using DB.Query, but not working properly
		--local buildingName = DB.Query("SELECT Text FROM Language_en_US WHERE Tag = (SELECT Description FROM Buildings WHERE ID = ?", buildingTypeID)
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:GetTerrainType() == iTerrainID and
				pPlot:GetOwner() == iPlayer) then
					--print("--- [", pCity:GetName(), "] has a workable [", pPlot:GetTerrainType() == iTerrainID, "Terrain	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs the [", pPlot:GetTerrainType() == iTerrainID, "Terrain	] tile. ---");
				return true
			end
		end
		return false
	end

	-- If the building has IsHasFeature check
	if iHasFeature ~= NULL then
		local iFeatureID = GameInfoTypes[iHasFeature];
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:GetFeatureType() == iFeatureID and
				pPlot:GetOwner() == iPlayer) then
					--print("--- [", pCity:GetName(), "] has a workable [", pPlot:GetFeatureType() == iFeatureID, "Feature	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs the [", pPlot:GetFeatureType() == iFeatureID, "Feature	] tile. ---");
				return true
			end
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
					--print("--- [", pCity:GetName(), "] has a workable plot adjacent to a [	River	]. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a tile that is adjacent to a [	River	]. ---");
				return true
			end
		end
		return false
	end

	-- If the building has IsHasRiver check
	if iHasHill == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsHills() and
				pPlot:GetOwner() == iPlayer) then
					--print("--- ", pCity:GetName(), "] has a workable [	Hill	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a [	Hill	] tile. ---");
				return true
			end
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
					--print("--- [", pCity:GetName(), "] has a workable [	Mountain	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a [	Mountain	] tile. ---");
				return true
			end
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
					--print("--- [", pCity:GetName(), "] has a workable [	Water	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a [	Water	] tile. ---");
				return true
			end
		end
		return false
	end

	-- If the building has IsHasSeaTile check
	if iHasSeaTile == 1 then
		for iCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do	
			local pPlot = pCity:GetCityIndexPlot(iCityPlot);
			if (pPlot and
				pCity:CanWork(pPlot) and
				pPlot:IsWater() and
				not pPlot:IsLake() and
				pPlot:GetOwner() == iPlayer) then
					--print("--- [", pCity:GetName(), "] has a workable [	Sea	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a [	Sea	] tile. ---");
				return true
			end
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
					--print("--- [", pCity:GetName(), "] has a workable [	Lake	] plot. Enabling [", pCity:GetName(),"] to be able to build [	Building ID:", buildingTypeID, "] that needs a [	Lake	] tile. ---");
				return true
			end
		end
		return false
	end
	return true
end

GameEvents.CityCanConstruct.Add(buildingCheck)

print("------------------------------------------------------");
print("----- DONE --- Plot Checker for building procedure----");
print("------------------------------------------------------");