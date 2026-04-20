-- Order of Operations Notes

/*
    order that we write a query
- SELECT (What is the data we want returned?)
FROM (Where the information comes from)
JOIN (For information from multiple tables)
WHERE (Filter or modify the data coming back)
GROUP BY (How would you like the data ggregated?)
HAVING (How would you like the groups filtered)
ORDER BY (How the data that is coming back is sorted)

-- SQL Order
1 - FROM / JOIN
2 - WHERE
3 - GROUP BY
4 - HAVING
5 - SELECT
6 - DISTINCT
7 - UNION / INTERSECT / EXCEPT
8 - ORDER BY
9 - TOP (LIMIT)
*/

-- VIEWS
-- create a list of categories, products, and prices
-- cat id, cat name, prod id, prod name, price
USE GalacticDepot
GO

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.UnitPrice
FROM Categories as c
INNER JOIN Products as p
    ON c.CategoryID = p.CategoryID
GO

-- save as a VIEW
CREATE VIEW vCategoriesAndProducts
AS
(
    SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.UnitPrice
    FROM Categories as c
    INNER JOIN Products as p
        ON c.CategoryID = p.CategoryID

)
GO

SELECT * FROM vCategoriesAndProducts;
GO

--Customer Orders View
CREATE VIEW vCustomerOrders
AS
(
    SELECT c.CustomerID, c.CompanyName, o.OrderID, o.OrderDate, od.ProductID, od.UnitPrice, od.Quantity, od.Discount, (od.Quantity * od.UnitPrice) * (1 - od.Discount) as [LineTotal]
    FROM Customers as c
    INNER JOIN Orders as o
        ON c.CustomerID = o.CustomerID
    INNER JOIN OrderDetails as od
        ON o.OrderID = od.OrderID
)
GO

-- North American Customers
CREATE VIEW vNACustomers
AS
(
    SELECT *
    FROM Customers
    WHERE Customers.SalesTerritory = 'North America'
)
GO

