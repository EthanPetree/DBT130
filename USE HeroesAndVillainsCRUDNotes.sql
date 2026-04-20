USE HeroesAndVillains
GO

SELECT * FROM Character;
SELECT * FROM CharacterPower;
SELECT * FROM Power;

--add new characters

INSERT INTO Character(FirstName, LastName)
VALUES ('Barbara', 'Gordon'),
    ('Kate', 'Kane'),
    ('Carole', 'Danvers')

--Alignment is NOT NULL
-- Option 1 -- add a value for alignment
-- Option 2 Redefine Alignment to allow null values

ALTER TABLE Character
    ALTER COLUMN Alignment VARCHAR(20) NULL
GO

-- Add AlterEgo for each character
-- create a new collumn

ALTER TABLE Character
    ADD AlterEgo VARCHAR(20) NULL -- dont put COLUMN here unless you are altering it

-- update the Alter Egos
-- Scott Lang
UPDATE Character
    SET AlterEgo = 'Ant Man'
    WHERE FirstName = 'Scott' AND LastName = 'Lang'

-- update barbara, kate, and carole
--  >= 23
-- alignment is null
-- use first and last name
-- IN()
UPDATE Character 
    SET Alignment = 'Good'
    WHERE CharacterID IN (124, 125, 126)


-- remove a character
DELETE FROM Character 
    WHERE CharacterID > 126

-- remove all bad guys
DELETE FROM Character 
    WHERE Alignment != 'Good'


USE GalacticDepot
GO

SELECT * FROM Orders
SELECT * FROM OrderDetails

SELECT c.CompanyName, o.OrderID
FROM Customers as c
INNER JOIN Orders as o
    ON c.CustomerID = o.CustomerID;
--830 --INNER JOIN

SELECT c.CompanyName, o.OrderID
FROM Customers as c
LEFT JOIN Orders as o
    ON c.CustomerID = o.CustomerID;
--834
-- 4 customers have not placed orders
-- null ORDER ID

-- list company name, orderid, country, order quantity
--sort by company name

SELECT c.CompanyName, o.OrderID, c.Country, od.Quantity
FROM Customers as c
INNER JOIN Orders as o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails as od
    ON o.OrderID = od.OrderID

    -- left inner
SELECT c.CompanyName, o.OrderID, c.Country, od.Quantity
FROM Customers as c
LEFT JOIN Orders as o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails as od
    ON o.OrderID = od.OrderID

-- left / left
SELECT c.CompanyName, o.OrderID, c.Country, od.Quantity
FROM Customers as c
LEFT JOIN Orders as o
    ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails as od
    ON o.OrderID = od.OrderID
    -- if you ALL, use LEFT for all JOINs


