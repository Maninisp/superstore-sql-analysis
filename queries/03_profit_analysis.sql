-- 1. Sales and Profit Overview --> Identify overall sales and profit trends, and which categories or segments are most profitable.
--================================================================================================================
-- Q1: Which category is most profitable? -> "Technology"	145454.9480999999
SELECT category, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC
LIMIT 1;

----------------------------------------------------------------------------------
-- Q2: Which segment is most profitable? -> "Consumer"	134119.33
SELECT segment, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC
LIMIT 1;

----------------------------------------------------------------------------------
-- Q3: Profitability by segment and category --> in all sectors technology is most profitable in all categories
--segment	category	total_profit
--"Consumer"	"Technology"	70798.11
--"Consumer"	"Office Supplies"	56330.27
--"Consumer"	"Furniture"	6990.95
--"Corporate"	"Technology"	44167.21
--"Corporate"	"Office Supplies"	40227.33
--"Corporate"	"Furniture"	7584.91
--"Home Office"	"Technology"	30490.34
--"Home Office"	"Office Supplies"	25933.28
--"Home Office"	"Furniture"	3875.39
SELECT segment, category, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY segment, category
ORDER BY segment, total_profit DESC

-------------------------------------------------------------------------------------
-- Q4: Which sub-category is most profitable?
--sub_category	total_profit
--"Copiers"	55617.90
--"Phones"	44516.25
--"Accessories"	41936.78
--"Paper"	34053.34
--"Binders"	30221.64
--"Chairs"	26590.15
--"Storage"	21279.05
--"Appliances"	18138.07

SELECT sub_category, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;

--------------------------------------------------------------------------------------------------
-- Q5: Which sub-categories are making losses? -> "Tables"	-17725.59
SELECT sub_category, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;

--this only gives us one loss making sub-category by having limit 1 , butby removing it we will get loss making first and then profitable sub-categories. So this approach is not what we need
SELECT sub_category, ROUND(SUM(profit), 2) AS revenue
FROM superstore
GROUP BY sub_category
ORDER BY revenue asc
LIMIT 1;

--================================================================================================================
-- 2. Profitability vs Sales --> Identify products with high sales but low profit margins High sales ≠ good business
--================================================================================================================

-- Q1: Which products have high sales but low or negative profit?
--product_name total_sales total_profit
--"Cisco TelePresence System EX90 Videoconferencing Unit"	22638.48	-1811.08
--"GBC DocuBind P400 Electric Binding System"	17965.07	-1878.17
--"High Speed Automatic Electric Letter Opener"	17030.31	-262.00
--"Lexmark MX611dhe Monochrome Laser Printer"	16829.90	-4589.97
--"Martin Yale Chadless Opener Electric Letter Opener"	16656.21	-1299.19
--"Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish"	15610.97	-669.53
--"Bretford Rectangular Conference Table Tops"	12995.28	-327.25
--"Cubify CubeX 3D Printer Double Head Print"	11099.96	-8879.97

SELECT 
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(sales) > 10000 AND SUM(profit) < 0
ORDER BY total_sales DESC;

------------------------------------------------------------------------------
-- Q2: Which products never make a profit?
--product_name Loss
--"Cubify CubeX 3D Printer Triple Head Print"	-3839.99
--"Cisco TelePresence System EX90 Videoconferencing Unit"	-1811.08
--"Zebra GK420t Direct Thermal/Thermal Transfer Printer"	-938.28
--"LG G2"	-374.99
--"Brother MFC-9340CDW LED All-In-One Printer, Copier Scanner"	-319.19
--"Xerox WorkCentre 6505DN Laser Multifunction Printer"	-252.00
--"Okidata B401 Printer"	-251.99
--"Bush Westfield Collection Bookcases, Dark Cherry Finish, Fully Assembled"	-190.85

SELECT product_name, MAX(profit) Loss
FROM superstore
GROUP BY product_name
HAVING MAX(profit) <= 0
order by Loss;


--------------------------------------------------------------------------------------------------------------
-- Q: Top 5 loss-making products
SELECT product_name, ROUND(SUM(profit), 2) AS total_loss
FROM superstore
GROUP BY product_name
ORDER BY total_loss ASC
LIMIT 5;
--More precise as it gives us all loss making products, not just top 5, and we can see the profit values for all of them, which can be helpful in understanding the extent of losses across different products. and in case if only 2 product are loss making then we will get only those 2 products instead of getting 5 products with some of them having profit and some having loss.
--product_name total_loss
--"Cubify CubeX 3D Printer Double Head Print"	-8879.97
--"Lexmark MX611dhe Monochrome Laser Printer"	-4589.97
--"Cubify CubeX 3D Printer Triple Head Print"	-3839.99
--"Chromcraft Bull-Nose Wood Oval Conference Tables & Bases"	-2876.11
--"Bush Advantage Collection Racetrack Conference Table"	-1934.40
--"GBC DocuBind P400 Electric Binding System"	-1878.17

SELECT product_name, ROUND(SUM(profit), 2) AS total_loss
FROM superstore
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY SUM(profit);


--================================================================================================================
-- 3. Discount Impact Analysis --> Identify main driver of losses
--================================================================================================================

-- Q1: Does discount affect profit?
--discount	avg_profit
--0.00	66.90
--0.10	96.06
--0.15	27.29
--0.20	24.70
--0.30	-45.68
--0.32	-88.56
--0.40	-111.93

SELECT discount, ROUND(AVG(profit), 2) AS avg_profit
FROM superstore
GROUP BY discount
ORDER BY discount;


--------------------------------------------------------------------------------------------
-- Q2: Does discount affect profit and quantity sold?
--sub_category	discount	totalQuantity	total_profit -> mini snapshot of the result
--"Accessories"	0.20	1141	6647.45
--"Accessories"	0.00	1835	35289.33
--"Appliances"	0.80	235	-8629.67
--"Appliances"	0.20	418	2497.88
--"Appliances"	0.10	55	1086.09
--"Appliances"	0.00	1021	23183.77
--"Art"	0.20	1096	1147.25
--"Art"	0.00	1904	5380.71
--"Binders"	0.80	953	-21909.46
--"Binders"	0.70	1503	-16601.18
SELECT sub_category, discount,
sum(quantity) as totalQuantity,
    SUM(profit) AS total_profit,
    AVG(profit) AS avg_profit
FROM superstore
GROUP BY sub_category,discount
ORDER BY sub_category, avg_profit;



-----------------------------------------------------------------------------------
-- Q3: How do discounts impact quantity sold and profitability?
--sub_category	discount	total_quantity	total_profit	profit_per_unit
--"Accessories"	0.00	1835	35289.33	19.23
--"Accessories"	0.20	1141	6647.45	5.83
--"Appliances"	0.00	1021	23183.77	22.71
--"Appliances"	0.10	55	1086.09	19.75
--"Appliances"	0.20	418	2497.88	5.98
--"Appliances"	0.80	235	-8629.67	-36.72
--"Art"	0.00	1904	5380.71	2.83

SELECT 
    sub_category,
    discount,
    SUM(quantity) AS total_quantity,
    SUM(profit) AS total_profit,
    round((SUM(profit) / SUM(quantity)), 2) AS profit_per_unit
FROM superstore
GROUP BY sub_category, discount
ORDER BY sub_category, discount;



--================================================================================================================
-- 4. Customer & Segment Analysis --> Identify which customer segments are most profitable and how they respond to discounts and shipping modes.
--================================================================================================================

-- Q1: Customer segmentation — which segment (Consumer/Corporate/Home Office) is most profitable?
--segment total_customers total_sales total_profit avg_profit_per_order	profit_margin
--"Consumer"	409	1161401.34	134119.33	25.84  11.55
--"Corporate"	236	706146.44	91979.45	30.46  13.03
--"Home Office"	148	429653.29	60299.01	33.82  14.03

SELECT 
    segment,
    COUNT(DISTINCT customer_id)  AS total_customers,
    ROUND(SUM(sales), 2)         AS total_sales,
    ROUND(SUM(profit), 2)        AS total_profit,
    ROUND(AVG(profit), 2)        AS avg_profit_per_order,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS profit_margin
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;


----------------------------------------------------------------------------------
-- Q2: Top 10 most frequent customers by order count
--customer_name	segment	total_orders	total_revenue	total_profit	avg_discount_given
--"Emily Phan"	"Consumer"	17	5478.06	144.94	0.197
--"Chloris Kastensmidt"	"Consumer"	13	3154.83	141.25	0.234
--"Joel Eaton"	"Consumer"	13	6760.81	221.77	0.146
--"Noel Staavos"	"Corporate"	13	2964.82	-234.76	0.215
--"Sally Hughsby"	"Corporate"	13	3406.86	558.45	0.136
--"Zuschuss Carroll"	"Consumer"	13	8025.70	-1032.13	0.255
--"Patrick Gardner"	"Consumer"	13	3086.90	137.48	0.169
--"Erin Ashbrook"	"Corporate"	13	2846.71	-52.73	0.300
--"Chris Selesnick"	"Corporate"	12	2754.22	738.37	0.057
--"Bart Pistole"	"Corporate"	12	2442.05	433.98	0.165
SELECT 
    customer_name,
    segment,
    COUNT(DISTINCT order_id)     AS total_orders,
    ROUND(SUM(sales), 2)         AS total_revenue,
    ROUND(SUM(profit), 2)        AS total_profit,
    ROUND(AVG(discount), 3)      AS avg_discount_given
FROM superstore
GROUP BY customer_name, segment
ORDER BY total_orders DESC
LIMIT 10;

--------------------------------------------------------------------------
-- Q3: Customer segmentation — which segment is most profitable?
--segment total_customers total_sales total_profit avg_profit_per_order	profit_margin_pct
--"Consumer"	409	1161401.34	134119.33	25.84	11.55
--"Corporate"	236	706146.44	91979.45	30.46	13.03
--"Home Office"	148	429653.29	60299.01	33.82	14.03
SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit_per_order,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;



--================================================================================================================
-- 5. Shipping Mode Analysis --> Identify which shipping modes are most profitable and how they relate to discounts and product categories.
--================================================================================================================

-- Q1: Which shipping modeis used most vs which is most profitable?
--ship_mode	total_orders	total_sales	total_profit	avg_profit	profit_margin_pct
--"Standard Class"	5968	1358216.08	164089.45	27.49	12.08
--"Second Class"	1945	459193.44	57446.49	29.54	12.51
--"First Class"	1538	351428.43	48969.95	31.84	13.93
--"Same Day"	543	128363.12	15891.90	29.27	12.38

select ship_mode, 
COUNT(*) total_orders,
round(SUM(sales), 2) totalSales, 
round(SUM(profit), 2) totalProfit, 
round(AVG(profit), 2) avgProfit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct
from superstore
group by ship_mode
order by totalProfit desc;

--since "Standard Class" is most used and profitable shipping mode we will understand it why cause when we see at profit margins the story is different, will check if region or discount is playing a role in this or not.
--ship_mode total_orders state discount profit_margin_pct total_sales total_profit avg_profit -- mini snapshot of the result
--"First Class"	9	"Alabama"	0.00	41.14	3973.49	1634.82	181.65
--"First Class"	32	"Arizona"	0.20	5.09	4789.19	243.80	7.62
--"First Class"	1	"Arizona"	0.50	-52.00	393.17	-204.45	-204.45
--"First Class"	9	"Arizona"	0.70	-134.23	627.25	-841.94	-93.55
--"First Class"	10	"Arkansas"	0.00	43.15	1465.76	632.47	63.25
--"First Class"	198	"California"	0.00	30.16	23164.12	6987.05	35.29
--"Standard Class"	33	"Alabama"	0.00	26.42	7637.80	2017.62	61.14
--"Standard Class"	108	"Arizona"	0.20	9.54	17042.66	1625.32	15.05
--"Standard Class"	7	"Arizona"	0.50	-56.80	3419.65	-1942.35	-277.48
--"Standard Class"	24	"Arizona"	0.70	-83.40	2756.05	-2298.43	-95.77
--"Standard Class"	38	"Arkansas"	0.00	33.68	8588.45	2892.77	76.13
--"Standard Class"	737	"California"	0.00	27.21	99149.96	26983.35	36.61

--this query wasn't useful as expected because it grouped data across multiple variables, which introduced noise so in following queries we will try to analyse by controlling variables like category and discount to isolate the true drivers of profitability.
select ship_mode, 
COUNT(*) total_orders,
state, discount,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct,
round(SUM(sales), 2) totalSales, 
round(SUM(profit), 2) totalProfit, 
round(AVG(profit), 2) avgProfit
from superstore
group by ship_mode, state, discount
order by ship_mode, state, profit_margin_pct desc;



-- Q1.1: Do different ship modes attract different discount levels?
--ship_mode	total_orders	avg_discount	profit_margin_pct	avg_order_value
--"First Class"	1538	0.165	13.93	228.50
--"Standard Class"	5968	0.160	12.08	227.58
--"Same Day"	543	0.152	12.38	236.40
--"Second Class"	1945	0.139	12.51	236.09
SELECT 
    ship_mode,
    COUNT(*)                        AS total_orders,
    ROUND(AVG(discount), 3)         AS avg_discount,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct,
    ROUND(AVG(sales), 2)            AS avg_order_value
FROM superstore
GROUP BY ship_mode
ORDER BY avg_discount DESC;

-- Q1.2: Does product category mix differ by ship mode?
--ship_mode	category	total_orders	avg_discount	profit_margin_pct	total_profit    
--"First Class"	"Technology"	301	0.134	19.73	27502.69
--"First Class"	"Office Supplies"	910	0.169	18.16	18400.25
--"First Class"	"Furniture"	327	0.180	2.77	3067.01
--"Same Day"	"Office Supplies"	326	0.144	22.08	6423.60
--"Same Day"	"Technology"	98	0.141	14.42	8670.91
--"Same Day"	"Furniture"	119	0.186	2.04	797.39
--"Second Class"	"Technology"	366	0.130	18.39	26152.35
--"Second Class"	"Office Supplies"	1152	0.129	16.85	27067.97
--"Second Class"	"Furniture"	427	0.172	2.70	4226.17
--"Standard Class"	"Technology"	1082	0.132	16.81	83129.71
--"Standard Class"	"Office Supplies"	3638	0.164	16.50	70599.06
--"Standard Class"	"Furniture"	1248	0.172	2.38	10360.68
SELECT 
    ship_mode,
    category,
    COUNT(*)                             AS total_orders,
    ROUND(AVG(discount), 3)              AS avg_discount,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct,
    ROUND(SUM(profit), 2)                AS total_profit
FROM superstore
GROUP BY ship_mode, category
ORDER BY ship_mode, profit_margin_pct DESC;


-- Q1.3: For the same category and same discount, does ship mode still affect margin?
-- Using Technology + 0% discount as a controlled comparison
--ship_mode	category	discount	total_orders	avg_order_value	profit_margin_pct
--"First Class"	"Technology"	0.00	141	418.53	36.66
--"Same Day"	"Technology"	0.00	41	620.60	35.61
--"Standard Class"	"Technology"	0.00	488	494.29	34.08
--"Second Class"	"Technology"	0.00	163	393.02	30.34
SELECT 
    ship_mode,
    category,
    discount,
    COUNT(*)                             AS total_orders,
    ROUND(AVG(sales), 2)                 AS avg_order_value,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct
FROM superstore
WHERE category = 'Technology' AND discount = 0
GROUP BY ship_mode, category, discount
ORDER BY profit_margin_pct DESC;

