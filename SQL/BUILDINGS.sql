--==================================================================================================================
-- Building - Construct Adjustment
--==================================================================================================================

UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaTile = 1
        WHERE BuildingClass IN
        ('BUILDINGCLASS_LIGHTHOUSE',
        'BUILDINGCLASS_HARBOR',
        'BUILDINGCLASS_SEAPORT');

UPDATE  Buildings SET River = 0, IsHasRiver = 1
        WHERE BuildingClass IN
        ('BUILDINGCLASS_WATERMILL',
        'BUILDINGCLASS_HYDRO_PLANT');
        
-- For Vox Populi
UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaTile = 1
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_MINEFIELD')
        AND BuildingClass ='BUILDINGCLASS_MINEFIELD';

-- For Tiles Tweak Overhaul or Water Tiles Enhanced mod
UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaTile = 1
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_OCEAN_MINING')
        AND BuildingClass ='BUILDINGCLASS_OCEAN_MINING';

-- For Enlightenment Era for VP mod
UPDATE  Buildings SET River = 0, IsHasRiver = 1
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_EE_CLOTH_MILL')
        AND BuildingClass ='BUILDINGCLASS_EE_CLOTH_MILL';

-- For Industrial Buildings Pack mod with Community Balance Patch Mod Compatibility
UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaTile = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_INDUSTRIAL' AND Value = 1)
        AND BuildingClass = 'BUILDINGCLASS_COASTAL_BATTERY';

UPDATE  Buildings SET NearbyMountainRequired = 0, IsHasMountain = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_INDUSTRIAL' AND Value = 1)
        AND BuildingClass = 'BUILDINGCLASS_INDUSTRIAL_MINE';

-- For Polar Station for VP mod
UPDATE  Buildings SET NearbyTerrainRequired = NULL, IsHasTerrain = 'TERRAIN_SNOW'
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION')
        AND BuildingClass = 'BUILDINGCLASS_POLAR_STATION';

-- For Ski Resort for VP mod
UPDATE  Buildings SET NearbyTerrainRequired = NULL, IsHasMountain = 1
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_SKI_RESORT')
        AND BuildingClass = 'BUILDINGCLASS_SKI_RESORT';

-- For Marina Building for VP mod
UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasAnyWater = 1
        WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_MARINA')
        AND BuildingClass = 'BUILDINGCLASS_MARINA';

-- Compatibility
CREATE TRIGGER PlotChecker_SeaBuilding
AFTER INSERT ON Civilization_BuildingClassOverrides 
WHEN NEW.BuildingClassType
IN(
        SELECT DISTINCT Type
        FROM Buildings
        WHERE BuildingClass IN
        ('BUILDINGCLASS_LIGHTHOUSE',
        'BUILDINGCLASS_HARBOR',
        'BUILDINGCLASS_SEAPORT',
        'BUILDINGCLASS_MINEFIELD');
)
AND NEW.BuildingType IS NOT NULL
BEGIN
	UPDATE Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaTile = 1
        FROM Buildings
        WHERE Type = NEW.BuildingType
        AND BuildingClass IN
        ('BUILDINGCLASS_LIGHTHOUSE',
        'BUILDINGCLASS_HARBOR',
        'BUILDINGCLASS_SEAPORT',
        'BUILDINGCLASS_MINEFIELD');
END;
