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