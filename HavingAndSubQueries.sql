USE GalacticDepot
GO

/*
    HAVING
    -- filter for groups
*/

-- list all orders with freight over $100
-- order id, cust id, freight
SELECT OrderID, CustomerID, Freight
FROM Orders
WHERE Freight > 100
-- 830 --> 187

-- total frieght charges per customer
-- cust id frieght total
SELECT CustomerID, SUM(Freight) as [Freight Total]
FROM Orders
GROUP BY CustomerID
-- 211

-- total freight per customer
-- list only freight over $1000
SELECT CustomerID, SUM(Freight) as [Freight Total]
FROM Orders
GROUP BY CustomerID
HAVING SUM(Freight) > 1000
-- HAVING filters GROUPs

-- list customers with freight over $500 and order date > 1/1/2024
SELECT CustomerID, SUM(Freight) as [Freight Total], OrderDate
FROM Orders
WHERE OrderDate > '1/1/2024'
GROUP BY CustomerID, OrderDate
HAVING SUM(Freight) > 500
ORDER BY [Freight Total] DESC

-- Subqueries

-- number of orders from customers in the USA
SELECT COUNT(*) as [USA Customers]
FROM Customers as c
JOIN Orders as o
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
-- 151

SELECT CustomerID
FROM Customers
WHERE Country = 'USA'

SELECT COUNT(*)
FROM Orders
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Customers
    WHERE Country = 'USA'
)
-- Non-Correlated Subquery
-- inner query is not dependant on the outer query

-- Correlated Subquery
SELECT COUNT(*)
FROM Orders as o
WHERE EXISTS 
(
    SELECT CustomerID
    FROM Customers as c
    WHERE c.Country = 'USA'
    AND c.CustomerID = o.CustomerID
)

-- EXISTS
SELECT CustomerID
FROM Customers
WHERE Country = 'USA'

SELECT 1
FROM Customers as c
WHERE Country = 'USA'
    AND c.CustomerID = 1398

SELECT TOP(10) *
FROM Orders as o
WHERE EXISTS
(
    SELECT 1
    FROM Customers as c
    WHERE Country = 'USA'
        AND c.CustomerID = o.CustomerID
)

-- create a sorted list of USA customers by the number of orders 
-- JOIN
SELECT c.CompanyName, COUNT(o.OrderID) as [Order Count]
FROM Customers as c
JOIN Orders as o
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
GROUP BY c.CompanyName
ORDER BY [Order Count] DESC


-- rewrite as subquery in the SELECT
SELECT c.CompanyName, (
    SELECT COUNT(*)
    FROM Orders as o
    WHERE c.CustomerID = o.CustomerID
) as [Order Count]
FROM Customers as c
WHERE c.Country = 'USA'
ORDER BY [Order Count] DESC