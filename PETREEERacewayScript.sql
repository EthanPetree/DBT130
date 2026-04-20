USE master;
GO

ALTER DATABASE Eraceway2026
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE IF EXISTS Eraceway2026;
GO

CREATE DATABASE Eraceway2026;
GO

USE Eraceway2026;
GO

CREATE TABLE Driver
(
    DriverID TINYINT IDENTITY(101, 1) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    BirthDate DATE NOT NULL,
    Age AS DATEDIFF(YY, BirthDate, GETDATE()), --Calculate Age
    Crashes TINYINT NULL
)
GO

CREATE TABLE RaceCar
(
    CarID SMALLINT IDENTITY(1001,1) NOT NULL PRIMARY KEY,
    CarMake VARCHAR(20) NOT NULL,
    CarModel VARCHAR(25) NOT NULL,
    Year SMALLINT NOT NULL,
    Color VARCHAR(30) NOT NULL,
    CarName VARCHAR(30) NULL,
    DriverID TINYINT NOT NULL FOREIGN KEY REFERENCES Driver(DriverID)
)
GO

CREATE TABLE Race
(
    RaceID int NOT NULL PRIMARY KEY,
    Date DATE NOT NULL,
    Location varchar(20) NOT NULL,
    Name varchar(40) NOT NULL,
    WinnerID tinyint NULL
)
GO

CREATE TABLE Sponsor
(
    SponsorID tinyint IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name VARCHAR(30) NOT NULL
)
GO

--Create Many-to-Many Junction Table

CREATE TABLE DriverSponsor
(
    DriverID tinyint NOT NULL,
    SponsorID tinyint NOT NULL,
    PRIMARY KEY (DriverID, SponsorID)
)


--Create Foreign Key Constraints
ALTER TABLE Race
    ADD CONSTRAINT FK_Race_Driver
    FOREIGN KEY(WinnerID)
    REFERENCES Driver(DriverID)
GO

ALTER TABLE DriverSponsor
    ADD CONSTRAINT FK_DriverSponsor_Driver
    FOREIGN KEY(DriverID)
    REFERENCES Driver(DriverID)
GO

ALTER TABLE DriverSponsor
    ADD CONSTRAINT FK_DriverSponsor_Sponsor
    FOREIGN KEY(SponsorID)
    REFERENCES Sponsor(SponsorID)
GO

-- ADD Data
--Driver Table
INSERT Driver (FirstName, LastName, BirthDate, Crashes)
VALUES ('Lando', 'Norris', '1999-11-13', '2'),
    ('Lewis', 'Hamilton', '1-Jul-85', NULL),
    ('Valentino', 'Rossi', '16-Feb-79', NULL),
    ('Aryton', 'Senna',	'21-Mar-60', 2),
    ('Danica', 'Patrick', '25-Mar-82', 1),
    ('Travis', 'Pastrana', '8-Oct-83',	2),
    ('Mario', 'Andretti', '28-Feb-40', 2),
    ('Collete', 'Davis', '27-Dec-93', NULL),
    ('Max', 'Verstappen', '30-Sep-97', 2),
    ('Lia', 'Block', '1-Oct-06', 1),
    ('Michele', 'Mouton', '23-Jun-51', NULL),
    ('Adam', 'LZ', '5-May-95', 1)

--RaceCar Table
INSERT RaceCar (CarMake, CarModel, Year, Color, CarName, DriverID)
VALUES ('Maserati',	'GranTurismoEV', 2025, 'Green',	'Navigator', 101),
('Audi', 'E-Tron GTR', 2022, 'Black', 'Sparks', 102),
('Aston Martin', 'Valhalla', 2022, 'Green', 'High Side', 103),
('Lotus', 'Evija', 2020, 'Blue', 'Pistola', 104),
('Pininfarina',	'Battista',	2021, 'Black',	'Empower', 105),
('Drako', 'GTE',	2023, 'Black', 'Nitro', 106),
('Rimac', 'C_Two', 2024, 'White', 'Shiver', 107),
('Dendrobium', 'D-1', 2020,	'White', 'Neon Flash', 108),
('DEUS', 'Vayanne', 2025, 'Silver', 'Mad Max',	109),
('Aspark', 'Owl', 2020, 'Yellow', 'Hoonigan', 110),
('Tesla', 'Roadster',	2018, 'Red', 'Rev-Limiter', 111),
('Nio',	'EP9',	2020, 'Silver',	'Two-step',	112)

--Race Table
INSERT Race(RaceID, Date, Location, Name, WinnerID)
VALUES (202501,	'1/1/2025',	'California', 'Grapes Cup',	105),
(202502, '1/20/2025', 'California',	'Redwood Run', 110),
(202503, '2/13/2025', 'Texas', 'BBQ Rally', 106),
(202504, '3/1/2025', 'Arizona',	'Catus Grand Prix', 101),
(202505, '4/2/2025', 'Utah', 'Salt Rally', 102),
(202506, '5/10/2025', 'Hawaii', 'Pineapple Cup', 102),
(202507, '5/25/2025', 'New York', 'Big Apple', 108),
(202508, '6/3/2025','Oregon', 'Wildflower Rally', 111),
(202509, '6/18/2025', 'Louisiana', 'Bayou 500', 102),
(202510, '7/15/2025', 'Idaho', 'Potato Race', 112),
(202511, '8/4/2025', 'Missouri', 'Arch Race', 111),
(202512, '9/10/2025', 'Florida', 'Sunshine Rally', 108)

--Sponsor Table
--Manually add Indetity values into an IDENTITY collumn
SET IDENTITY_INSERT Sponsor ON
INSERT Sponsor(SponsorID, Name)
VALUES (1, 'Doritos'),
(2,	'Coke'),
(3,	'Monster'),
(4,	'LG Energy'),
(5,	'Lenovo'),
(6,	'Gatorade'),
(7,	'GoDaddy'),
(8,	'Rockstar'),
(9,	'Red Bull'),
(10, 'Nitro Circus'),
(11, 'Energizer'),
(12, 'Duracell'),
(13, 'House of PRIX'),
(14, 'Block House Racing'),
(15, 'Tesla'),
(16, 'EverReady'),
(17, 'LZMFG')

SET IDENTITY_INSERT Sponsor OFF

--DriverSponsor
INSERT DriverSponsor (DriverID, SponsorID)
VALUES (101, 1),
        (101, 2),
        (102, 3),
        (102, 4),
        (103, 5),
        (103, 1),
        (104, 6),
        (104, 1),
        (105, 7),
        (105, 8),
        (106, 9),
        (106, 10),
        (107, 11),
        (107, 2),
        (108, 12),
        (108, 13),
        (109, 8),
        (109, 1),
        (110, 14),
        (110, 9),
        (111, 15),
        (111, 9),
        (112, 16),
        (112, 17)