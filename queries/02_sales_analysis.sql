-- 1. Overall Sales Distribution --> Understand where revenue is coming from geographically
--===============================================================================

-- Q1: Which region generates the highest sales? -> "West"	725457.93
SELECT region, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC
LIMIT 1;

---------------------------------------------------------------------------------
-- Q2: Which state has the highest sales? -> "California"	457687.68
SELECT state, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 1;


---------------------------------------------------------------------------------
-- Q3: Which state has the highest sales, region-wise?
--region	state	total_sales -> mini snapshot of the result
--"Central"	"Texas"	170187.98
--"Central"	"Illinois"	80166.16
--"Central"	"Michigan"	76269.61
--"Central"	"Indiana"	53555.36
--"Central"	"Wisconsin"	32114.61
--"Central"	"Minnesota"	29863.15
--"Central"	"Missouri"	22205.15
--"Central"	"Oklahoma"	19683.39
--"Central"	"Nebraska"	7464.93
--"Central"	"Iowa"	4579.76
--this query is wrong because it is giving the top 10 states by sales, but it is not giving the top state for each region which is asked in question. 
SELECT state, region ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY state, region
ORDER BY total_sales DESC
LIMIT 10;

--simple version without CTE
--region state total_sales
--"West"	"California"	457687.68
--"East"	"New York"	310876.20
--"Central"	"Texas"	170187.98
--"South"	"Florida"	89473.73

SELECT region, state, total_sales
FROM (
    SELECT 
        region, state,
        ROUND(SUM(sales), 2) AS total_sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
    FROM superstore
    GROUP BY region, state
) state_sales
WHERE rnk = 1
ORDER BY total_sales DESC;

-----------------------OR with CTE -------------------
WITH state_sales AS (
    SELECT 
        region, state,
        ROUND(SUM(sales), 2) AS total_sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
    FROM superstore
    GROUP BY region, state
)
SELECT region, state, total_sales
FROM state_sales
WHERE rnk = 1
ORDER BY total_sales DESC;


--===============================================================================
--2. Product Performance --> Identify best-performing products
--===============================================================================

-- Q1: Sales by category
--category	        total_sales
--"Technology"	836154.10
--"Furniture"	741999.98
--"Office Supplies"	719046.99
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


---------------------------------------------------------------------------------
-- Q2: Sales by sub-category
--sub_category	category	total_sales
--"Phones"	"Technology"	330007.10
--"Chairs"	"Furniture"	328449.13
--"Storage"	"Office Supplies"	223843.59
--"Tables"	"Furniture"	206965.68
--"Binders"	"Office Supplies"	203412.77
SELECT sub_category, category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category, category
ORDER BY total_sales DESC;


-----------------------------------------------------------------------------------
-- Q3: Top 10 products by sales
--product_name	                                        total_sales
--"Canon imageCLASS 2200 Advanced Copier"	            61599.83
--"Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind"	27453.38
--"Cisco TelePresence System EX90 Videoconferencing Unit"	22638.48
--"HON 5400 Series Task Chairs for Big and Tall"	        21870.57
--"GBC DocuBind TL300 Electric Binding System"	            19823.48
--"GBC Ibimaster 500 Manual ProClick Binding System"	    19024.50
--"Hewlett Packard LaserJet 3310 Copier"	                18839.68
--"HP Designjet T520 Inkjet Large Format Printer - 24"" Color"	18374.90
--"GBC DocuBind P400 Electric Binding System"	            17965.07
--"High Speed Automatic Electric Letter Opener"	            17030.31

SELECT product_name, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

--===============================================================================
--3. Customer Contribution --> Identify top customers and their contribution to revenue
--===============================================================================

-- Q1: Top 5 customers by revenue
--customer_name     revenue
--"Sean Miller"	25043.07
--"Tamara Chand"	19052.22
--"Raymond Buch"	15117.35
--"Tom Ashbrook"	14595.62
--"Adrian Barton"	14473.57

SELECT customer_name, ROUND(SUM(sales), 2) AS revenue
FROM superstore
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 5;


--===============================================================================
--4. Time-Based Analysis --> Identify trends and seasonality in sales
--===============================================================================

-- Q1: Monthly sales trend
SELECT DATE_TRUNC('month', order_date) AS month,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;
---------------------- OR ----------------------
--month       total_sales
--"01-2011"	13946.23
--"02-2011"	4810.59
--"03-2011"	55691.04
--"04-2011"	28295.35
--"05-2011"	23648.28
--"06-2011"	34595.14
SELECT to_char(order_date, 'MM-YYYY') AS month,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY month
ORDER BY MIN(order_date);

--This won't work because the month is extracted as a number, so it will be grouped by month number regardless of the year. For example, all January sales from different years will be grouped together, which may not be the intended result if you want to analyze sales trends over time.
SELECT EXTRACT(month from order_date) AS month,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;


---------------------------------------------------------------------------
-- Q2: Which months perform best overall?
--month  total_sales
--11	 349120.08
--12	 332177.20
--9	     309770.12
--3	     199253.01
--10	 197115.24
--8	     159589.38
--5	     156122.31
--7	     149580.84
--6	     147082.66
--4	     141851.59
--1	     95365.98
--2	     60172.66
SELECT EXTRACT(MONTH FROM order_date) AS month,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY month
ORDER BY total_sales DESC;


-------------------------------------------------------------------------
-- Q3: Which months in which years perform best overall?
--month  year  total_sales
--1	2014	44703.15
--1	2013	18542.52
--1	2012	18174.08
--1	2011	13946.23
--2	2013	22867.72
--2	2014	20283.50

SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY month, year
ORDER BY month, total_sales DESC;

--===============================================================================
--5. Growth Analysis
--===============================================================================
-- Q1: Year-over-year sales growth
--SQL query structure: FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY so any thing before select won't take the alias name. so in formula we have to use the full query instead of alias name.
--year    current_year_sales	previous_year_sales	yoy_growth_percentage
--2011	484247.56		
--2012	470532.46	484247.56	-2.83
--2013	608474.08	470532.46	29.32
--2014	733946.97	608474.08	20.62

SELECT current_year.year,
       current_year.totalSales AS current_year_sales,
       previous_year.totalSales AS previous_year_sales,
       ROUND(((current_year.totalSales - previous_year.totalSales) / previous_year.totalSales) * 100,2) as yoy_growth_percentage
FROM (Select 
    EXTRACT(YEAR FROM order_date) as year,
    SUM(sales) AS totalSales
    FROM superstore
    GROUP BY year
    ORDER BY year) current_year
LEFT JOIN (SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    SUM(sales) AS totalSales  
FROM superstore
GROUP BY year
ORDER BY year) previous_year
ON current_year.year = previous_year.year + 1
ORDER BY current_year.year;


--===============================================================================
--Sales vs Profit Bridge
--===============================================================================

-- Q: Which products/sub-categories generate losses despite sales?
--product_name	                                category	        total_sales	total_profit
--"Cubify CubeX 3D Printer Double Head Print"	"Technology"	11099.96	-8879.97
--"Lexmark MX611dhe Monochrome Laser Printer"	"Technology"	16829.90	-4589.97
--"Cubify CubeX 3D Printer Triple Head Print"	"Technology"	7999.98	-3839.99
--"Chromcraft Bull-Nose Wood Oval Conference Tables & Bases"	"Furniture"	9917.64	-2876.11
--"Bush Advantage Collection Racetrack Conference Table"	"Furniture"	9544.72	-1934.40
--"GBC DocuBind P400 Electric Binding System"	"Office Supplies"	17965.07	-1878.17
--"Cisco TelePresence System EX90 Videoconferencing Unit"	"Technology"	22638.48	-1811.08
--"Martin Yale Chadless Opener Electric Letter Opener"	"Office Supplies"	16656.21	-1299.19

SELECT 
    product_name, 
    category,
    ROUND(SUM(sales), 2) AS total_sales, 
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_name, category
HAVING SUM(profit) < 0
ORDER BY total_profit;


---------------------------------------------------------------------------
-- Q: Loss-making sub-categories
--sub_category total_loss
--"Tables"	-17725.59
--"Bookcases"	-3472.56
--"Supplies"	-1188.99
SELECT sub_category, ROUND(SUM(profit), 2) AS total_loss
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_loss;

--------------------------------------------------------------------
-- Q: Loss-making produts by month and year
--product_name month year total_loss
--"12-1/2 Diameter Round Wall Clock"	12	2011	-38.37
--"12-1/2 Diameter Round Wall Clock"	6	2014	-14.39
--"2300 Heavy-Duty Transfer File Systems by Perma"	9	2012	-1.50
--"2300 Heavy-Duty Transfer File Systems by Perma"	4	2011	-1.25
--"3.6 Cubic Foot Counter Height Office Refrigerator"	12	2014	-766.01
--"3.6 Cubic Foot Counter Height Office Refrigerator"	3	2011	-459.61
--"3.6 Cubic Foot Counter Height Office Refrigerator"	8	2013	-153.20
--"36X48 HARDFLOOR CHAIRMAT"	8	2014	-22.24
SELECT 
    product_name,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(profit), 2) AS total_loss
FROM superstore
GROUP BY 
    product_name,
    EXTRACT(MONTH FROM order_date),
    EXTRACT(YEAR FROM order_date)
HAVING SUM(profit) < 0
ORDER BY product_name, total_loss;


