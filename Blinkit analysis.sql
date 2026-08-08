CREATE DATABASE blinkit_data;
USE blinkit_data;

SELECT * FROM `blinkit grocery data`;

UPDATE `blinkit grocery data`
SET Item_Fat_Content =
    CASE
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

SELECT DISTINCT Item_Fat_Content FROM `blinkit grocery data`;

-- TOTAL SALES
SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM `blinkit grocery data`;

-- AVERAGE SALES
SELECT CAST(AVG(Total_Sales) AS SIGNED) AS Avg_Sales
FROM `blinkit grocery data`;

-- NO OF ITEMS
SELECT COUNT(*) AS No_of_Orders
FROM `blinkit grocery data`;

-- AVG RATING
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM `blinkit grocery data`;

-- Total Sales by Fat Content
SELECT `Item Fat Content`, CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales
FROM `blinkit grocery data`
GROUP BY `Item Fat Content`;

-- Total Sales by Item Type
SELECT `Item Type`, CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales
FROM `blinkit grocery data`
GROUP BY `Item Type`
ORDER BY Total_Sales DESC;

-- Fat Content by Outlet for Total Sales
SELECT
    `Outlet Location Type`,
    IFNULL(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` END), 0) AS Low_Fat,
    IFNULL(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` END), 0) AS Regular
FROM `blinkit grocery data`
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

-- Total Sales by Outlet Establishment
SELECT `Outlet Establishment Year`, CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales
FROM `blinkit grocery data`
GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;

-- Percentage of Sales by Outlet Size
SELECT
    `Outlet Size`,
    CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(`Total Sales`) * 100.0 / SUM(SUM(`Total Sales`)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM `blinkit grocery data`
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC;

-- Sales by Outlet Location
SELECT `Outlet Location Type`, CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales
FROM `blinkit grocery data`
GROUP BY `Outlet Location Type`
ORDER BY Total_Sales DESC;


-- All Metrics by Outlet Type
SELECT `Outlet Type`,
    CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
    CAST(AVG(`Item Visibility`) AS DECIMAL(10,2)) AS Item_Visibility
FROM `blinkit grocery data`
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;



