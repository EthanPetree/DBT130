USE HeroesAndVillains
GO

SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') AS [IsWindowsAuthOnly];


CREATE TABLE Mission (
   MissionID INT IDENTITY(1,1) PRIMARY KEY,
   MissionName VARCHAR(50) NOT NULL,
   DifficultyLevel TINYINT NOT NULL,
   Location VARCHAR(50) NOT NULL
)
GO

INSERT INTO Mission (MissionName, DifficultyLevel, Location)
VALUES ('Infinity War', 10, 'Titan')
, ('Endgame', 10, 'Outer Space')
, ('Ragnarok', 9, 'Asgard')
, ('No Way Home', 8, 'New York')
, ('Multiverse Madness', 10, 'Multiverse')
, ('Quantum Realm', 9, 'Quantum Realm')
, ('Weapon X Project', 7, 'Canada')
, ('Phoenix Saga', 9, 'Earth')
, ('Deadpool 2 Mission', 8, 'Earth')
, ('Doomsday Protocol', 9, 'Latveria')



CREATE LOGIN HeroAdmin WITH PASSWORD = 'Heros&Villain$321'
CREATE USER HeroAdmin FOR LOGIN HeroAdmin
GRANT SELECT, INSERT, UPDATE ON Character TO HeroAdmin

CREATE LOGIN MissionReporter WITH PASSWORD = 'Mission321!'
CREATE USER MissionReporter FOR LOGIN MissionReporter
GRANT SELECT ON Mission TO MissionReporter

GRANT DELETE ON [Character] TO HeroAdmin
