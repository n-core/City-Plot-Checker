--==================================================================================================================
-- City Plot Checker
--==================================================================================================================

--======================================================================================--
-- IsHasTerrain
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET
                NearbyTerrainRequired = NULL,
                IsHasTerrain = (SELECT NearbyTerrainRequired FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING')
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';
        */

        -- For Polar Station for VP mod
        UPDATE  Buildings SET 
                NearbyTerrainRequired = NULL,
                IsHasTerrain = (SELECT NearbyTerrainRequired FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_POLAR_STATION')
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION')
                AND BuildingClass = 'BUILDINGCLASS_POLAR_STATION';

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_Terrain
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasTerrain NOT NULL
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET
                NearbyTerrainRequired = NULL,
                IsHasTerrain = (SELECT NearbyTerrainRequired FROM Buildings WHERE BuildingClass = NEW.BuildingClassType)
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasHill
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET Hill = 0, IsHasHill = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';
        */

        -- insert your functions here

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_Hill
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasHill = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET Hill = 0, IsHasHill = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasMountain
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET NearbyMountainRequired = 0, IsHasMountain = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';
        */

        -- For Industrial Buildings Pack mod with Community Balance Patch Mod Compatibility
        UPDATE  Buildings SET NearbyMountainRequired = 0, IsHasMountain = 1
                WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_INDUSTRIAL' AND Value = 1)
                AND BuildingClass = 'BUILDINGCLASS_INDUSTRIAL_MINE';

        -- For Ski Resort for VP mod
        UPDATE  Buildings SET NearbyTerrainRequired = NULL, IsHasMountain = 1
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_SKI_RESORT')
                AND BuildingClass = 'BUILDINGCLASS_SKI_RESORT';

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_Mountain
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasMountain = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET NearbyMountainRequired = 0, IsHasMountain = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasAnyWater
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasAnyWater = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';

        */

        -- For Marina Building for VP mod
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasAnyWater = 1
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_MARINA')
                AND BuildingClass = 'BUILDINGCLASS_MARINA';

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_AnyWater
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasAnyWater = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET Water = 0, MinAreaSize = 0, IsHasAnyWater = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasSeaWater
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';

        */

        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE BuildingClass IN
                ('BUILDINGCLASS_LIGHTHOUSE',
                'BUILDINGCLASS_HARBOR',
                'BUILDINGCLASS_SEAPORT');

        -- For Vox Populi
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_MINEFIELD')
                AND BuildingClass ='BUILDINGCLASS_MINEFIELD';

        -- For Industrial Buildings Pack mod with Community Balance Patch Mod Compatibility
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_INDUSTRIAL' AND Value = 1)
                AND BuildingClass = 'BUILDINGCLASS_COASTAL_BATTERY';

        -- For Tiles Tweak Overhaul or Water Tiles Enhanced mod
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_OCEAN_MINING')
                AND BuildingClass ='BUILDINGCLASS_OCEAN_MINING';

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_SeaWater
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasSeaWater = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET Water = 0, MinAreaSize = 0, IsHasSeaWater = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasLake
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasLake = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';

        */

        -- insert your functions here

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_Lake
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasLake = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET Water = 0, MinAreaSize = 0, IsHasLake = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasRiver
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET River = 0, IsHasRiver = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';

        */

        UPDATE  Buildings SET River = 0, IsHasRiver = 1
                WHERE BuildingClass IN
                ('BUILDINGCLASS_WATERMILL',
                'BUILDINGCLASS_HYDRO_PLANT');
                
        -- For Enlightenment Era for VP mod
        UPDATE  Buildings SET River = 0, IsHasRiver = 1
                WHERE EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_EE_CLOTH_MILL')
                AND BuildingClass ='BUILDINGCLASS_EE_CLOTH_MILL';

        -- Bunch of triggers for compatibility with other mods
        CREATE TRIGGER CPCBuilding_River
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasRiver = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET River = 0, IsHasRiver = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
--======================================================================================--
-- IsHasFreshWater
        --==============================================================================--
        /*
        --template:
        UPDATE  Buildings SET Water = 0, MinAreaSize = 0, IsHasFreshWater = 1
                WHERE BuildingClass = 'BUILDINGCLASS_CUSTOMBUILDING';

        */

        -- insert your functions here

        -- Compatibility with other mods
        CREATE TRIGGER CPCBuilding_FreshWater
        AFTER INSERT ON Civilization_BuildingClassOverrides 
        WHEN NEW.BuildingClassType
        IN(
                SELECT DISTINCT BuildingClass
                FROM Buildings
                WHERE IsHasFreshWater = 1
        )
        AND NEW.BuildingType IS NOT NULL
        BEGIN
                UPDATE Buildings SET Water = 0, MinAreaSize = 0, IsHasFreshWater = 1
                WHERE Type = NEW.BuildingType
                AND BuildingClass = NEW.BuildingClassType;
        END;

--======================================================================================--
