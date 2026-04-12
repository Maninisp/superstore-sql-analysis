-- Q: Which region generates the highest sales? -> "New York City"	256368.161
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

---------------------------------------------------------------------------------
-- Q: Which state has the highest sales? -> "California"	457687.631500001
SELECT state, SUM(sales) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

---------------------------------------------------------------------------------
-- Q: Top 5 customers by revenue
--customer_name     revenue
--"Sean Miller"	25043.07
--"Tamara Chand"	19052.22
--"Raymond Buch"	15117.35
--"Tom Ashbrook"	14595.62
--"Adrian Barton"	14473.57

SELECT customer_name, SUM(sales) AS revenue
FROM superstore
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 5;

---------------------------------------------------------------------------------
-- Q: Sales by category
--category	        total_sales
--"Technology"	836154.10
--"Furniture"	741999.98
--"Office Supplies"	719046.99
SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


---------------------------------------------------------------------------------
-- Q: Sales by sub-category
--sub_category	    total_sales
--"Storage"	223843.59
--"Tables"	206965.68
--"Binders"	203412.77
--"Machines"	189238.68
--"Accessories"	167380.31
SELECT sub_category, SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;


-- Q: Monthly sales trend
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(sales) AS total_sales
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
       SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY Min(order_date);

--This won't work because the month is extracted as a number, so it will be grouped by month number regardless of the year. For example, all January sales from different years will be grouped together, which may not be the intended result if you want to analyze sales trends over time.
SELECT EXTRACT(month from order_date) AS month,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;

-----------------------------------------------------------------------------------
-- Q: Top 10 products by sales
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

SELECT product_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


---------------------------------------------------------------------------
-- Q: Which months perform best overall?
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
       SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY total_sales DESC;


-------------------------------------------------------------------------
-- Q: Which months in which years perform best overall?
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
    SUM(sales) AS total_sales
FROM superstore
GROUP BY month, year
ORDER BY month, total_sales DESC;


--------------------------------------------------------------------
-- Q: Loss-making 
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
    SUM(profit) AS total_loss
FROM superstore
GROUP BY 
    product_name,
    EXTRACT(MONTH FROM order_date),
    EXTRACT(YEAR FROM order_date)
HAVING SUM(profit) < 0
ORDER BY product_name, total_loss;


---------------------------------------------------------------------------
-- Q: Loss-making sub-categories
--sub_category total_loss
--"Tables"	-17725.59
--"Bookcases"	-3472.56
--"Supplies"	-1188.99
SELECT sub_category, SUM(profit) AS total_loss
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_loss;