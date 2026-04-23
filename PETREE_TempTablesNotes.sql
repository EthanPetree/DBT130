USE GalacticDepot


-- TEMP Tables


SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.UnitPrice
INTO #TempProductsCategories
FROM Products as p
JOIN Categories as c
    ON p.CategoryID = c.CategoryID


-- CREATE TABLE #TempProductsCategories

SELECT *
FROM #TempProductsCategories

DROP TABLE IF EXISTS #TempProductsCategories

USE AveragePrice
GO

SELECT * FROM gasoline
SELECT * FROM food
SELECT * FROM household_fuels

-- Add all Gasoline to All Products
SELECT series_id, year, period, value
INTO #all_products
FROM gasoline

SELECT * FROM #all_products

-- Add all food to our temp table
INSERT INTO #all_products
SELECT series_id, year, period, value
FROM food

INSERT INTO #all_products
SELECT series_id, year, period, value
FROM household_fuels

DROP TABLE IF EXISTS #all_products

-- Common Table Expressions (CTE)
-- singe-use temp table
USE GalacticDepot
GO

WITH CTE_ProdCat AS
(
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.UnitPrice
FROM Products as p
JOIN Categories as c
    ON p.CategoryID = c.CategoryID
)

SELECT * FROM CTE_ProdCat
GO
-- useful in recursive functions 

WITH CTE_AvgPrice AS
(
    SELECT AVG(UnitPrice) as Average
    FROM Products
)

SELECT p.CategoryID, p.ProductID, p.ProductName, p.UnitPrice
FROM Products as p
JOIN  CTE_AvgPrice as a
    ON p.UnitPrice > a.Average
GO

-- combine CTE with UNION ALL

WITH CTE_EmployeeHierarchy AS (
    -- Establishes the Starting Point (The Boss)
    -- This runs once to determine the top of the tree
    SELECT EmployeeID, FirstName, LastName, ReportsTo,
    1 AS ManagementLevel -- Start as Level 1
    FROM Employees
    WHERE ReportsTo IS NULL -- The Boss

UNION ALL

    -- Recursive Member: This references the CTE
    -- Finds the 'children' 
    SELECT e.EmployeeID, e.FirstName, e.LastName, e.ReportsTo as 'Manager', cte.ManagementLevel + 1 -- increment the level as we go down the tree
    FROM Employees as e
    JOIN CTE_EmployeeHierarchy as cte
        ON e.ReportsTo = cte.EmployeeID
)
-- Execute the CTE
SELECT * FROM CTE_EmployeeHierarchy
ORDER BY ManagementLevel, ReportsTo