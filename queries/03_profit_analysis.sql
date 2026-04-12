-- Q: Which category is most profitable? -> "Technology"	145454.9480999999
SELECT category, SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;
limit 1

-------------------------------------------------------------------------------------
-- Q: Which sub-category is most profitable?
--sub_category	total_profit
--"Copiers"	55617.90
--"Phones"	44516.25
--"Accessories"	41936.78
--"Paper"	34053.34
--"Binders"	30221.64
--"Chairs"	26590.15
--"Storage"	21279.05
--"Appliances"	18138.07
SELECT sub_category, SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;

--------------------------------------------------------------------------------------------------
-- Q: Which sub-categories are making losses? -> "Tables"	-17725.59
SELECT sub_category, SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;

--this only gives us one loss making sub-category by having limit 1 , butby removing it we will get loss making first and then profitable sub-categories. So this approach is not what we need
SELECT sub_category, SUM(profit) AS revenue
FROM superstore
GROUP BY sub_category
ORDER BY revenue asc
LIMIT 1;


------------------------------------------------------------------------------------------------------
-- Q: Does discount affect profit?
--discount	avg_profit
--0.00	66.9003501458941226
--0.10	96.0554255319148936
--0.15	27.2880769230769231
--0.20	24.7028055783429040
--0.30	-45.6799118942731278
--0.32	-88.5614814814814815
--0.40	-111.9275728155339806
SELECT discount, AVG(profit) AS avg_profit
FROM superstore
GROUP BY discount
ORDER BY discount;

--------------------------------------------------------------------------------------------------------------
-- Q: Top 5 loss-making products
SELECT product_name, SUM(profit) AS total_loss
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
SELECT product_name, SUM(profit) AS total_loss
FROM superstore
GROUP BY product_name
HAVING sum(profit)<0
ORDER BY sum(profit);

--------------------------------------------------------------------------------------------
-- Q: Does discount affect profit and quantity sold?
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
-- Q: How do discounts impact quantity sold and profitability?
SELECT 
    sub_category,
    discount,
    SUM(quantity) AS total_quantity,
    SUM(profit) AS total_profit,
    SUM(profit) / SUM(quantity) AS profit_per_unit
FROM superstore
GROUP BY sub_category, discount
ORDER BY sub_category, discount;


----------------------------------------------------------------------------------
-- Q: Which products have high sales but low or negative profit?
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
-- Q: Which products never make a profit?
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