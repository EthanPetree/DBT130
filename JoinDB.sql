USE master
GO

DROP DATABASE IF EXISTS JoinDB
GO

CREATE DATABASE JoinDB
GO

USE JoinDB
GO

CREATE TABLE Employees
(
        EmployeeId INT IDENTITY(101, 1) NOT NULL PRIMARY KEY,
        FirstName VARCHAR(20) NOT NULL,
        LastName VARCHAR(30) NOT NULL,
        State CHAR(2) NOT NULL
)
GO

CREATE TABLE Tasks
(
        TaskId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        EmployeeId INT NULL FOREIGN KEY REFERENCES Employees(EmployeeId),
        TaskName VARCHAR(100) NOT NULL,
        EstimatedHours INT NOT NULL DEFAULT 0,
        WorkedHours INT NOT NULL DEFAULT 0
)
GO

-- Add Employees
INSERT INTO Employees(FirstName, LastName, State)
	VALUES ('Victor', 'Shade', 'VA')
			,('Stephen', 'Strange', 'NY')
			,('Bruce', 'Wayne', 'NJ')
			,('Tony', 'Stark', 'CA')
			,('Sue', 'Storm', 'NY')
			,('Steve', 'Rogers', 'DC')
			,('Jean', 'Grey', 'NY')
			,('Wanda', 'Maximoff', 'NJ')
			,('Clark', 'Kent', 'NY')
			,('Ben', 'Grimm', 'NY')
			,('Reed', 'Richards', 'NY')
			,('Johnny', 'Storm', 'NY')


-- Add Tasks
INSERT INTO Tasks (EmployeeId, TaskName, EstimatedHours, WorkedHours)
	VALUES (102, 'Create Website Artwork',32, 24)
			,(106, 'Create Database',40, 42)
			,(103, 'Program API',38, 12)
			,(105, 'Develop Front End',36, 16)
			,(NULL, 'User Testing',32, 0)
			,(NULL, 'Front-End Testing',36, 0)
			,(NULL, 'Create Reports',48, 0)

select * from Employees
select * from Tasks