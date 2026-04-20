USE master;
GO

ALTER DATABASE CoolSeaCreatures
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE IF EXISTS CoolSeaCreatures;
GO

CREATE DATABASE CoolSeaCreatures;
GO

USE CoolSeaCreatures;
GO

CREATE TABLE Habitat (
    habitat_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    zone_name VARCHAR(50) NULL,
    depth_range VARCHAR(50) NULL,
    light_level VARCHAR(50) NULL
)

CREATE TABLE Diet (
    diet_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    diet_type VARCHAR(50) NULL,
    food_source VARCHAR(50) NULL
)

CREATE TABLE Sea_Creature (
    creature_id INT IDENTITY(101,1) NOT NULL PRIMARY KEY,
    common_name VARCHAR(50) NULL,
    scientific_name VARCHAR(50) NULL,
    habitat_id INT NOT NULL FOREIGN KEY REFERENCES Habitat(habitat_id),
    diet_id INT NOT NULL FOREIGN KEY REFERENCES Diet(diet_id)
)

CREATE TABLE Observation_Log(
    log_id INT IDENTITY(1001,1) NOT NULL PRIMARY KEY,
    creature_id INT NOT NULL FOREIGN KEY REFERENCES Sea_Creature(creature_id),
    observation_date DATE NULL,
    ocean_region VARCHAR(50) NULL,
    quantity_spotted INT
    )

INSERT INTO Habitat (zone_name, depth_range, light_level)
VALUES 
('Epipelagic', '0 - 200m', 'Sunlight'),
('Mesopelagic', '200 - 1000m', 'Twilight'),
('Bathypelagic', '1000 - 4000m', 'Midnight'),
('Abyssopelagic', '4000 - 6000m', 'Abyss'),
('Benthic', 'Ocean Floor', 'None')

INSERT INTO Diet (diet_type, food_source)
VALUES
('Filter Feeder', 'Plankton and Krill'),
('Apex Predator', 'Large fish and marine mammals'),
('Mesopredator', 'Small fish and crustaceans'),
('Teuthophage', 'Specializes in eating squid'),
('Detritivore', 'Marine snow and dead organic matter')

INSERT INTO Sea_Creature (common_name, scientific_name, habitat_id, diet_id)
VALUES
('Whale Shark', 'Rhincodon typus', 1, 1),
('Narwhal', 'Monodon monoceros', 1, 3),
('Giant Squid', 'Architeuthis dux', 2, 3),
('Colossal Squid', 'Mesonychoteuthis hamiltoni', 3, 3),
('Vampire Squid', 'Vampyroteuthis infernalis', 3, 5),
('Sperm Whale', 'Physeter macrocephalus', 2, 4),
('Great White Shark', 'Carcharodon carcharias', 1, 2)

INSERT INTO Observation_Log (creature_id, observation_date, ocean_region, quantity_spotted)
VALUES
(101, '2025-05-12', 'Indian Ocean', 3),
(101, '2025-08-21', 'Pacific Ocean', 1),
(102, '2025-11-03', 'Arctic Ocean', 12),
(103, '2024-02-14', 'Southern Ocean', 1),
(106, '2025-07-07', 'Atlantic Ocean', 4),
(107, '2025-09-15', 'Pacific Ocean', 2),
(102, '2026-01-10', 'Arctic Ocean', 8)


-- queries
-- where
SELECT *
FROM Observation_Log
WHERE observation_date >= '2025/1/1' AND observation_date <= '2025/12/31'

-- inner join
-- quick glance of information about a creature
SELECT s.common_name, h.light_level, h.depth_range
FROM Sea_Creature as s
JOIN Habitat as h
    ON s.habitat_id = h.habitat_id

-- left join
-- finds the creatures we have yet to log in our book
SELECT s.scientific_name as [Creatures not yet tracked], s.common_name as [Also Known As]
FROM Sea_Creature as s
LEFT JOIN Observation_Log as o
    ON s.creature_id = o.creature_id
WHERE log_id IS NULL

-- multi join
-- an encyclopedia for all the basic information about a creature
SELECT s.common_name, s.scientific_name, h.light_level, h.zone_name, h.depth_range, d.diet_type, d.food_source
FROM Sea_Creature as s
JOIN Habitat as h
    ON s.habitat_id = h.habitat_id
JOIN Diet as d
    ON s.diet_id = d.diet_id

-- group by
-- to log the amount of each type of creature spotted
SELECT s.common_name, s.scientific_name, SUM(o.quantity_spotted) as [Times Spotted]
FROM Sea_Creature as s
JOIN Observation_Log as o
    ON s.creature_id = o.creature_id
GROUP BY s.common_name, s.scientific_name

-- cross join
-- to find all possible combinations of types of fish in each zone
SELECT h.zone_name, d.diet_type
FROM Habitat as h
CROSS JOIN Diet as d