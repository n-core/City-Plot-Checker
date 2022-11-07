--==================================================================================================================
-- City Plot Checker
--==================================================================================================================

--======================================================================================--
-- Test
        --==============================================================================--

        UPDATE Units SET MinAreaSize = -1 WHERE Domain = 'DOMAIN_SEA' AND Combat > 0;

        -- Compatibility with other mods
        CREATE TRIGGER CPC_SeaUnitCheck
        AFTER INSERT ON Civilization_UnitClassOverrides
        WHEN NEW.UnitClassType
        IN(
                SELECT DISTINCT Class
                FROM Units
                WHERE Domain = 'DOMAIN_SEA'
                AND Combat > 0
        )
        AND NEW.UnitType IS NOT NULL
        BEGIN     
            UPDATE Units SET MinAreaSize = -1
            WHERE Domain = 'DOMAIN_SEA' AND Combat > 0 AND Type = NEW.UnitType;
        END;

--======================================================================================--