USE master;
GO

ALTER DATABASE EsportsDB
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE IF EXISTS EsportsDB;
GO

CREATE DATABASE EsportsDB;
GO

USE EsportsDB;
GO

CREATE TABLE Tournaments
(
    TournamentID TINYINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    Game VARCHAR(20) NOT NULL,
    StartDate DATE NOT NULL,
    RegistrationDate DATE NOT NULL,
    RegistrationFee TINYINT NULL,
    PrizePool SMALLINT NULL
)
GO

CREATE TABLE Teams
(
    TeamID SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    TeamName VARCHAR(20) NOT NULL,
    Region VARCHAR(25) NOT NULL,
    Ranking SMALLINT NULL
)
GO

CREATE TABLE Players -- had to increase the size of the ID, there could realistically be more than 255 players in a big tournament
(
    PlayerID SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    IGN VARCHAR(30) NOT NULL,
    Role VARCHAR(30) NULL,
    Nationality VARCHAR(30) NOT NULL,
    TeamID SMALLINT NOT NULL FOREIGN KEY
    REFERENCES Teams(TeamID)
)
GO


CREATE TABLE Matches
(
    MatchID TINYINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    MatchDateTime DATETIME NOT NULL,
    TournamentID TINYINT NOT NULL FOREIGN KEY REFERENCES Tournaments(TournamentID),
    WinnerID SMALLINT NOT NULL FOREIGN KEY REFERENCES Teams(TeamID)
)
GO

CREATE TABLE Sponsors
(
    SponsorID TINYINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    SponsorName VARCHAR(30) NOT NULL,
    Sector VARCHAR(10) NOT NULL,
    SponsorshipAmount int NOT NULL
)
GO

--Many-to-Many Junction Table

CREATE TABLE TournamentsTeams
(
    TournamentID TINYINT NOT NULL,
    TeamID SMALLINT NOT NULL,
    PRIMARY KEY (TournamentID, TeamID)
)
GO

CREATE TABLE TeamMatches
(
    TeamID SMALLINT NOT NULL,
    MatchID TINYINT NOT NULL,
    PRIMARY KEY(TeamID, MatchID)
)
GO

CREATE TABLE TeamSponsor
(
    TeamID SMALLINT NOT NULL,
    SponsorID TINYINT NOT NULL,
    PRIMARY KEY(TeamID, SponsorID)
)
GO

--Example
-- ALTER TABLE DriverSponsor
--     ADD CONSTRAINT FK_DriverSponsor_Driver
--     FOREIGN KEY(DriverID)
--     REFERENCES Driver(DriverID)
-- GO

-- ALTER TABLE DriverSponsor
--     ADD CONSTRAINT FK_DriverSponsor_Sponsor
--     FOREIGN KEY(SponsorID)
--     REFERENCES Sponsor(SponsorID)
-- GO

--Foreign keys for Juction Tables
ALTER TABLE TournamentsTeams
    ADD CONSTRAINT FK_TournamentsTeams_Tournaments
    FOREIGN KEY(TournamentID)
    REFERENCES Tournaments(TournamentID)
GO

ALTER TABLE TournamentsTeams
    ADD CONSTRAINT FK_TournamentsTeams_Teams
    FOREIGN KEY(TeamID)
    REFERENCES Teams(TeamID)
GO


ALTER TABLE TeamMatches
    ADD CONSTRAINT FK_TeamMatches_Teams
    FOREIGN KEY(TeamID)
    REFERENCES Teams(TeamID)
GO

ALTER TABLE TeamMatches
    ADD CONSTRAINT FK_TeamMatches_Matches
    FOREIGN KEY(MatchID)
    REFERENCES Matches(MatchID)
GO


ALTER TABLE TeamSponsor
    ADD CONSTRAINT FK_TeamSponor_Teams
    FOREIGN KEY(TeamID)
    REFERENCES Teams(TeamID)
GO

ALTER TABLE TeamSponsor
    ADD CONSTRAINT FK_TeamSponsor_Sponsor
    FOREIGN KEY(SponsorID)
    REFERENCES Sponsors(SponsorID)
GO

--Add Data
INSERT Tournaments(Game, StartDate, RegistrationDate, RegistrationFee, PrizePool)
    VALUES ('Splatoon 3', '2026-06-01', '2026-05-15', 50, 500),
    ('Valorant', '2026-07-10', '2026-06-20', 25, 1000),
    ('Rocket League', '2026-08-05', '2026-07-25', 10, 250),
    ('League of Legends', '2026-09-15', '2026-09-01', 15, 1500),
    ('Fortnite', '2026-10-20', '2026-10-05', 100, 5000)

INSERT Teams(TeamName, Region, Ranking)
    VALUES ('Bucketeers', 'NA', 4),
    ('Decavitators', 'EU', 4),
    ('BuffGuys', 'Asia', 4),
    ('Racket', 'SA', 4),
    ('Eelectric', 'NA', 4)

INSERT Players(IGN, Role, Nationality, TeamID)
    VALUES ('Faker', 'Mid', 'South Korea', 3),
    ('Tenz', 'Duelist', 'Canada', 1),
    ('Boaster', 'IGL', 'UK', 2),
    ('aspas', 'Duelist', 'Brazil', 4),
    ('nAts', 'Sentinel', 'Russia', 5)

INSERT Matches(TournamentID, MatchDateTime, WinnerID)
    VALUES(1, '2026-06-02 14:00:00', 1),
    (1, '2026-06-03 16:00:00', 2),
    (2, '2026-07-11 12:00:00', 3),
    (4, '2026-09-16 10:00:00', 5),
    (5, '2026-10-21 18:00:00', 4)

INSERT Sponsors(SponsorName, Sector, SponsorshipAmount)
    VALUES ('Red Bull', 'Energy', 50000),
    ('Intel', 'Tech', 75000),
    ('Secretlab', 'Furniture', 25000),
    ('Logitech', 'Tech', 40000),
    ('Monster', 'Energy', 45000)

INSERT TournamentsTeams(TournamentID, TeamID)
    VALUES(1 , 1),
    (1 , 2),
    (2 , 3),
    (4 , 5),
    (5 , 4)

INSERT TeamMatches(TeamID, MatchID)
    VALUES(1, 1),
    (2, 1),
    (2, 2),
    (3, 2),
    (3, 3),
    (4, 3),
    (5, 4),
    (1, 4),
    (4, 5),
    (5, 5)

INSERT TeamSponsor(TeamID, SponsorID)
    VALUES(1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5)

