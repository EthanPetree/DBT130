/*
Unions, Intersects, Except Set Operators

Unions return all records without duplicates
Union ALL does duplicates
EXCEPT returns all records from one but not any from the other
INTERSECT returns all records that match between both, excluding duplicates

1. The number and order columns must be the same in both queries
The data types must be the same or compatible

*/

USE GalacticDepot
GO

-- list full name of all customers and their phone numbers

SELECT ContactName, Phone
FROM Customers

-- list full name of all employees

SELECT CONCAT(FirstName, ' ', LastName) as [Employee Name], HomePhone
FROM Employees

-- combine 

SELECT ContactName as People, Phone
FROM Customers
UNION
SELECT CONCAT(FirstName, ' ', LastName) as [Employee Name], HomePhone
FROM Employees
GO

-- sort by phone?
SELECT ContactName as People, Phone
FROM Customers
UNION
SELECT CONCAT(FirstName, ' ', LastName) as [Employee Name], HomePhone
FROM Employees
ORDER BY Phone
GO

-- DISTINCT
SELECT Country
FROM Customers
--215

SELECT DISTINCT Country
FROM Customers
--29

SELECT DISTINCT Country
FROM Employees
--19

--combine
SELECT Country
FROM Customers
UNION
SELECT Country
FROM Employees
--35


--union all
SELECT Country
FROM Customers
UNION ALL
SELECT Country
FROM Employees
-- 299

-- INTERSECT
SELECT Country
FROM Customers
INTERSECT
SELECT Country
FROM Employees
-- 13

-- EXCEPT
SELECT Country
FROM Customers
EXCEPT
SELECT Country
FROM Employees
-- 16

SELECT Country
FROM Employees
EXCEPT
SELECT Country
FROM Customers
-- 6


SELECT FirstName + ' ' + LastName as 'Employee Name', HomePhone
FROM Employees