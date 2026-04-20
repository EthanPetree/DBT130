-- Basic SQL Queries

/*
DDL - Data Definition Language
- DROP CREATE ALTER

DML - Data Manipulation Language
- CRUD
Create Read Update Delete
INSERT INTO - SELECT - UPDATE - DELETE FROM

DCL - Data Control Language
- Security and permissions
- GRANT DENY REVOKE 
*/

USE GalacticDepot
GO

-- Explore all Employees
SELECT * 
FROM Employees;
GO
-- 84 rows

-- List the Employees first name, last name, alias, job title

SELECT FirstName, LastName, Alias, JobTitle 
FROM Employees;

-- list the employeeid, city, country from the employees table
-- List only employees that live in the Netherlands
SELECT EmployeeID, City, Country 
FROM Employees
WHERE Country = 'Netherlands';
-- 11 rows

-- list employees who were born before 1960;

SELECT FirstName, LastName, BirthDate
FROM Employees
WHERE BirthDate < '1960-01-01';
-- 11 rows

-- Employees hired after december 1st 2022
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE HireDate >= '2022-12-01';
-- 3

-- determine which employee has worked the longest
SELECT FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate ASC;
-- default sort order is ASC, can do DESC

-- Customers
SELECT * FROM Customers;

--Return First, last
SELECT ContactName
FROM Customers;
-- 215

-- return the count of Customers
SELECT COUNT(*) AS [Count of Customers] -- Spaces or single quotes 'Count of Customers'
FROM Customers;

--find customers in Brazil
-- sort by city 
SELECT *
FROM Customers
WHERE Country = 'Brazil'
ORDER BY City ASC;

-- customers who do NOT live in Brazil

SELECT *
FROM Customers
WHERE Country != 'Brazil' -- OR <>
ORDER BY Country, City ASC;


-- Find a customer named Victor Shade

SELECT *
FROM Customers
WHERE ContactName = 'Victor Shade';

-- find all customers that are named Victor

SELECT *
FROM Customers
WHERE ContactName LIKE '%Victor%'; -- % is a wildcard

-- find all Victor S
SELECT *
FROM Customers
WHERE ContactName LIKE 'Victor S%';

-- Find all customers without Sales in their title with -78
SELECT *
FROM Customers
WHERE ContactTitle NOT LIKE '%Sales%';
-- 137

--find all customers with Sales in their title AND live in Germany
SELECT *
FROM Customers
WHERE ContactTitle LIKE '%Sales%' AND Country = 'Germany';
-- 10

-- find Customers who live in Berlin, London, Brisbane, SLC
SELECT * 
FROM Customers
WHERE City = 'Berlin' 
    OR City = 'London' 
    OR City = 'Brisbane'
    OR City = 'Salt Lake City';
--17

-- customers who do not live in USA, Venezuela, France
SELECT * 
FROM Customers
WHERE Country != 'USA' 
    AND Country != 'Venezuela' 
    AND Country != 'France';
-- 162

SELECT *
FROM Customers
WHERE Country NOT IN (
    'USA',
    'Venezuela',
    'France'
);

--Products Table

--find all products that cost more than 500 dollars
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 500
ORDER BY UnitPrice DESC;

-- top 5 most expensive items
SELECT TOP 5 ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 500
ORDER BY UnitPrice DESC; -- other languages its limit

-- least expensive
SELECT TOP 5 ProductName, UnitPrice
FROM Products
-- WHERE UnitPrice > 500
ORDER BY UnitPrice ASC;