USE AveragePrice
GO


-- BLT prices over the last decade — is someone driving up sandwich inflation?

-- Filters the blt ingredients from series and finds the average to be copmared
SELECT series_title, year, FORMAT(AVG(TRY_CAST(c.value AS FLOAT)), 'C','en-US') as [AveragePrice]
FROM series as s
JOIN [current] as c
    ON s.series_id = c.series_id
WHERE series_title LIKE '%Bacon%' OR series_title LIKE '%Lettuce%' OR series_title LIKE '%Tomato%'
GROUP BY year, series_title
ORDER BY year, series_title
-- bacon jumped up the most, significantly higher than lettuce or tomatoes



--Seasonal fruit prices spiking every July — supply chain sabotage?
-- joins series and current, filters for fruits and finds the avg price per month per year
SELECT series_title, c.[period], c.[year], FORMAT(AVG(TRY_CAST(c.[value] AS FLOAT)), 'C', 'en-US') as [Average Price]
FROM series as s
JOIN [current] as c
    ON s.series_id = c.series_id
WHERE series_title LIKE 'Apples%'
OR series_title LIKE '%Banana%'
OR series_title LIKE '%Oranges%'
GROUP BY c.[period], c.[year], series_title
-- HAVING [period] = 'M08'
ORDER BY series_title, c.[year], c.[period]
GO
-- the prices seem to spike in general over the summer, but it doesn't usually peak in july, I imagine many of these fruits are just out of season then


-- The most expensive cut of steak in every region — laundering cash in T-bones?
-- CTE to find the maximum steak price per area and then joins to the main query to find the title of the steaks with the highest price
WITH MaxPricePerRegion AS (
    SELECT area_code, MAX(TRY_CAST(c.value AS FLOAT)) as [Highest Price]
    FROM series as s
    JOIN [current] as c
        ON s.series_id = c.series_id
    WHERE series_title LIKE '%steak%'
    GROUP BY area_code
)

SELECT series_title, s.area_code, c.[value] as [Highest Price], c.year
FROM series as s
JOIN [current] as c
    ON s.series_id = c.series_id
JOIN MaxPricePerRegion as mp
    ON s.area_code = mp.area_code AND TRY_CAST(c.[value] AS fLOAT) = mp.[Highest Price]
WHERE series_title LIKE '%steak%'
ORDER BY area_code, [Highest Price]
-- the U.S. city average had the highest steak per region total
-- sirloin was 3 out of five results, the other two were just normal beef steaks



-- Gasoline vs. groceries — who spiked hardest during the pandemic years?
-- compares the avg prices of eggs and gasoline between 2019 and 2021, and compares the percentage difference
WITH Prices_2019 AS (
    SELECT CASE
    WHEN series_title LIKE '%egg%' THEN 'Eggs'
    WHEN series_title LIKE '%gasoline%' THEN 'Gasoline'
    END as [Product]
    , AVG(TRY_CAST(c.value AS float)) as [AveragePrice]
    FROM series as s
    JOIN [current] as c
        on s.series_id = c.series_id
    WHERE (series_title LIKE '%egg%' OR series_title LIKE '%gasoline%')
    AND c.year = '2019'
    GROUP BY CASE
    WHEN series_title LIKE '%egg%' THEN 'Eggs'
    WHEN series_title LIKE '%gasoline%' THEN 'Gasoline'
    END
), Prices_2021 AS (
    SELECT CASE
    WHEN series_title LIKE '%egg%' THEN 'Eggs'
    WHEN series_title LIKE '%gasoline%' THEN 'Gasoline'
    END as [Product]
    , AVG(TRY_CAST(c.value AS float)) as [AveragePrice]
    FROM series as s
    JOIN [current] as c
        on s.series_id = c.series_id
    WHERE (series_title LIKE '%egg%' OR series_title LIKE '%gasoline%')
    AND c.year = '2021'
    GROUP BY CASE
    WHEN series_title LIKE '%egg%' THEN 'Eggs'
    WHEN series_title LIKE '%gasoline%' THEN 'Gasoline'
    END
)

SELECT Prices_2019.Product, ((Prices_2021.AveragePrice - Prices_2019.AveragePrice) /Prices_2019.AveragePrice) * 100 as [Percentage Increase]
FROM Prices_2019
JOIN Prices_2021
    ON Prices_2019.Product = Prices_2021.Product
GO
-- gasoline went up about 5 percent more than eggs did over a two year period.


--Do beef, pork, and chicken prices rise and fall together, or do they fluctuate independently?
-- case statement to group meats into clean categories and finds the average per year for comparison
SELECT CASE
WHEN series_title LIKE '%beef%' THEN 'Beef'
WHEN series_title LIKE '%chicken%' THEN 'Chicken'
WHEN series_title LIKE '%pork%' THEN 'Pork'
END, c.year, FORMAT(AVG(TRY_CAST(c.value AS FLOAT)), 'C', 'en-US') as [Average Price]
FROM series as s
JOIN [current] as c
    ON s.series_id = c.series_id
WHERE 
s.series_title LIKE '%beef%' 
OR s.series_title LIKE '%pork%' 
OR s.series_title LIKE '%chicken%'
GROUP BY year, CASE
WHEN series_title LIKE '%beef%' THEN 'Beef'
WHEN series_title LIKE '%chicken%' THEN 'Chicken'
WHEN series_title LIKE '%pork%' THEN 'Pork'
END
ORDER BY year

-- pork and chicken have stayed pretty closely together but beef starting rocketing up after a decade or so