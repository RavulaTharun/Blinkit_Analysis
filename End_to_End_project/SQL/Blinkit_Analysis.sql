USE Blinkitdb

SELECT * FROM blinkit_data

SELECT COUNT(*) FROM blinkit_data

UPDATE blinkit_data
SET Item_Fat_Content =
CASE 
WHEN Item_Fat_Content='LF' THEN 'Low Fat'
WHEN Item_Fat_Content='reg' THEN 'Regular'
ELSE Item_Fat_Content
END  

SELECT DISTINCT(Item_Fat_Content)
FROM blinkit_data

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_in_Million
FROM blinkit_data

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Average_Sales
FROM blinkit_data

SELECT COUNT(*) AS No_Of_Items
FROM blinkit_data

SELECT CAST(AVG(Rating)AS DECIMAL(10,1)) AS Avg_Rating 
FROM blinkit_data



SELECT Item_Fat_Content,
       CONCAT(CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)),' ','K') AS Total_Sales_In_Thousand,
	   CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	   COUNT(Item_Fat_Content) AS No_Of_Items,
	   CAST(AVG(Rating)AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
--WHERE Outlet_Establishment_Year=2022
GROUP BY Item_Fat_Content
--HAVING Item_Fat_Content='Low Fat'
ORDER BY Total_Sales_In_Thousand DESC




SELECT Item_Type,
       CONCAT(CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)),' ','K') AS Total_Sales_In_Thousand,
	   CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	   COUNT(*) AS No_Of_Items,
	   CAST(AVG(Rating)AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
--WHERE Outlet_Establishment_Year=2022
GROUP BY Item_Type
--HAVING Item_Type='Hard Drinks'
ORDER BY Total_Sales_In_Thousand DESC


-- FOR BLOW ONE YOU NEED TO DO W/ PIVOT TO AVOID DUPLICATES.

SELECT Outlet_Location_Type,Item_Fat_Content,
       CONCAT(CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)),' ','K') AS Total_Sales_In_Thousand,
	   CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	   COUNT(*) AS No_Of_Items,
	   CAST(AVG(Rating)AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
--WHERE Outlet_Establishment_Year=2022
GROUP BY Outlet_Location_Type,Item_Fat_Content
--HAVING Item_Fat_Content='Low Fat' AND Outlet_Type='Supermarket Type1'
ORDER BY Avg_Sales DESC



SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;



SELECT Outlet_Establishment_Year,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating		
FROM blinkit_data
--WHERE Outlet_Establishment_Year=2020 --> Before GroupBy,Row by Row ( Entire Data ).
GROUP BY Outlet_Establishment_Year
--HAVING Outlet_Establishment_Year=2022 --> After GroupBy applied, GroupbyGroup each year and sort out.
ORDER BY Total_Sales DESC



SELECT 
  Outlet_Size,
  CAST(SUM(Total_Sales)AS DECIMAL(10,2)) AS Total_Sales,
  CAST((SUM(Total_Sales) * 100.0) / (SELECT SUM(Total_Sales) FROM blinkit_data) AS DECIMAL(10,2)) AS Total_Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales_Percentage DESC


SELECT Outlet_Location_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Total_Sales) * 100.0) / (SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Total_Sales_Percentage,
		CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating		
FROM blinkit_data
WHERE Outlet_Establishment_Year=2022
GROUP BY Outlet_Location_Type
--HAVING Outlet_Establishment_Year=2022
ORDER BY Total_Sales DESC



SELECT Outlet_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Total_Sales) * 100.0) / (SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Total_Sales_Percentage,
		CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating		
FROM blinkit_data
--WHERE Outlet_Establishment_Year=2022
GROUP BY Outlet_Type
--HAVING Outlet_Establishment_Year=2022
ORDER BY Total_Sales DESC









