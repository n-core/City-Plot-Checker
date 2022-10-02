-- City can build a building if the city have a specific tile inside the workable city plot.
-- If the city have a specific terrain tile inside the city working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasTerrain' TEXT REFERENCES Terrains('Type') DEFAULT NULL;

-- If the city have a specific feature tile inside the city working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasFeature' TEXT REFERENCES Features('Type') DEFAULT NULL;

-- If the city have a tile adjacent to a river inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasRiver' BOOLEAN DEFAULT 0;

-- If the city have a hill tile inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasHill' BOOLEAN DEFAULT 0;

-- If the city have a mountain tile inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasMountain' BOOLEAN DEFAULT 0;

-- If the city have any water tile inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasAnyWater' BOOLEAN DEFAULT 0;

-- If the city have a sea water tile inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasSeaTile' BOOLEAN DEFAULT 0;

-- If the city have a lake tile inside the working plot.
ALTER TABLE Buildings ADD COLUMN 'IsHasLake' BOOLEAN DEFAULT 0;
