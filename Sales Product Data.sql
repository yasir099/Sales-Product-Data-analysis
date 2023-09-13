use [Sales Product Data]

select *
from Sales_April_2019

-- Create a table to consolidate data from multiple tables for the year 2019.
CREATE TABLE Sales_2019 
(
	"Order ID"  NVARCHAR(255),
	Product NVARCHAR(255),
	"Quantity Ordered" nvarchar(255),
	"Price Each" nvarchar(255),
	"Order Date" nvarchar(255),
	"Purchase Address" NVARCHAR(255)
);



-- Combine data from multiple monthly sales tables and insert it into the consolidated "Sales_2019" table.
insert into  Sales_2019 
select *
from Sales_April_2019  UNION ALL
select *
from Sales_August_2019  UNION ALL
select *
from Sales_December_2019  UNION ALL
select *
from Sales_February_2019  UNION ALL
select *
from Sales_January_2019  UNION ALL
select *
from Sales_July_2019  UNION ALL
select *
from Sales_June_2019  UNION ALL 
select *
from Sales_March_2019 UNION ALL
select *
from Sales_May_2019  UNION ALL
select *
from Sales_November_2019  UNION ALL
select *
from Sales_October_2019 UNION ALL
select *
from Sales_September_2019  ;



select *
from Sales_2019


-- Count the number of NULL values in the "Order ID" column of the "Sales_2019" table.
SELECT COUNT(CASE WHEN [Order ID] IS NULL THEN 1 ELSE NULL END) AS NullCount
from Sales_2019

-- Delete rows with NULL values in the "Order ID" column from the "Sales_2019" table.
Delete from Sales_2019
where [Order ID] is Null

-- Delete the rows has name of column
Delete from Sales_2019
where isnumeric([Order ID]) = 0

-- Keep rows only in 2019
delete from Sales_2019
WHERE YEAR([Order Date]) <> 2019



-- Change the date type for columns
ALTER TABLE sales_2019
ALTER COLUMN [Price Each] DECIMAL(10, 2);

ALTER TABLE sales_2019
ALTER COLUMN [Order ID] INT

ALTER TABLE sales_2019
ALTER COLUMN [Order Date] DATETIME;

ALTER TABLE sales_2019
ALTER COLUMN [Quantity Ordered] INT;

Select *
from sales_2019

-----------------------------------------------------
EXPLORATION
-----------------------------------------------------

--- Showing the total revenue
SELECT SUM([Quantity Ordered] * [Price Each]) AS TotalRevenue
FROM sales_2019;


--- Showing the top-selling products
SELECT Product, SUM([Quantity Ordered]) AS TotalQuantityOrdered
FROM sales_2019
GROUP BY Product
ORDER BY TotalQuantityOrdered DESC;


-- The numbers of order and revenue for each month
Select COUNT([Order ID]) as [Number Of Orders], SUM([Quantity Ordered] * [Price Each]) as TotalRevenue,MONTH([Order Date]) as Month
from sales_2019
group by MONTH([Order Date])
order by COUNT([Order ID]) desc


-- Showing numbers of oeder for each Product 
Select  Product, COUNT([Order ID]) as [Number Of Orders]
from sales_2019
group by Product
order by COUNT([Order ID]) desc

-- Showing numbers of oeder and revenue for each State
SELECT
    SUBSTRING([Purchase Address], CHARINDEX(',', [Purchase Address]) + 2, CHARINDEX(',', [Purchase Address], CHARINDEX(',', [Purchase Address]) + 2) - CHARINDEX(',', [Purchase Address]) - 2) AS State, COUNT([Order ID]) as [Number Of Orders], SUM([Quantity Ordered] * [Price Each]) as TotalRevenue
FROM sales_2019
group by SUBSTRING([Purchase Address], CHARINDEX(',', [Purchase Address]) + 2, CHARINDEX(',', [Purchase Address], CHARINDEX(',', [Purchase Address]) + 2) - CHARINDEX(',', [Purchase Address]) - 2)

