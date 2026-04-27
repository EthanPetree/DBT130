USE MASTER
GO

DROP DATABASE IF EXISTS TriggersDB
GO

CREATE DATABASE TriggersDB
GO

USE TriggersDB
GO

-- create tables
CREATE TABLE Characters
(
    CharID TINYINT IDENTITY(101,1) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL
)

CREATE TABLE AuditLog
(
    LogID INT IDENTITY PRIMARY KEY,
    [Date] SMALLDATETIME,
    ActionType VARCHAR(20),
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL
)
GO

-- create a trigger
CREATE TRIGGER trgCatchInsertDelete
ON Characters
FOR INSERT, DELETE
AS 
    INSERT INTO AuditLog(Date, FirstName, LastName, ActionType)
        SELECT CURRENT_TIMESTAMP, FirstName, LastName, 'INSERTED' FROM inserted
    INSERT INTO AuditLog(Date, FirstName, LastName, ActionType)
        SELECT CURRENT_TIMESTAMP, FirstName, LastName, 'DELETED' FROM deleted
GO

-- add data
INSERT INTO Characters
VALUES ('Bugs', 'Bunny'),
('Mickey', 'Mouse'),
('Donald', 'Duck'),
('Daffy', 'Duck'),
('Minnie', 'Mouse'),
('Wiley', 'Coyote')
GO

SELECT * FROM Characters

-- test deletes

DELETE FROM Characters
WHERE LastName LIKE '%Duck%'
GO

-- Update Tracker
CREATE TRIGGER trgUpdateTracker
ON Characters
FOR UPDATE
AS
    BEGIN
    INSERT INTO AuditLog(Date, FirstName, LastName, ActionType)
        SELECT CURRENT_TIMESTAMP, FirstName, LastName, 'UPDATED FROM' FROM deleted
    INSERT INTO AuditLog(Date, FirstName, LastName, ActionType)
        SELECT CURRENT_TIMESTAMP, FirstName, LastName, 'UPDATED TO' FROM inserted
    END
GO

-- insert new characters
INSERT INTO Characters
VALUES ('Scooby', 'Doo'),
('Shaggy','Rogers'),
('Naruto','Uzumaki'),
('Fred','Flintstone')
GO

SELECT * FROM AuditLog

-- update records
UPDATE Characters
SET LastName = 'Smith'
WHERE FirstName LIKE 'S%'