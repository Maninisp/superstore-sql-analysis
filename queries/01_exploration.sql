--===============================================================================
-- 1. Dataset Overview → Understand size and basic structure
--===============================================================================

-- Q1: How many records are there? --> 9994
SELECT COUNT(*) FROM superstore;

-- Q2: What is the date range of the dataset? --> "2011-01-04" to "2014-12-31""2011-01-04"	"2014-12-31"
SELECT MIN(order_date), MAX(order_date) FROM superstore;

--===============================================================================
-- 2. Geographic Coverage → Understand location spread
--===============================================================================

-- Q1: What are the unique regions? --> "South", "West", "East", "Central"
SELECT DISTINCT region FROM superstore;

-- Q2: What are the unique cities? --> output contains 531 unique cities names 
SELECT DISTINCT city FROM superstore;

-- Q3: How many unique cities are there? --> 531
SELECT COUNT(DISTINCT city) FROM superstore;


--===============================================================================
-- 3. Product Structure → Understand product hierarchy
--===============================================================================

-- Q1: What are the unique product categories? --> "Furniture", "Office Supplies", "Technology"
SELECT DISTINCT category FROM superstore;

-- Q2: What are the unique product sub-categories? --> output contains 17unique sub-category names
SELECT DISTINCT sub_category FROM superstore;

-- Q3: How many unique categories and sub-categories are there? 
--totalProductCategory	totalProductSubCategory
--3    17 
SELECT 
    COUNT(DISTINCT category) AS totalProductCategory, 
    COUNT(DISTINCT sub_category) AS totalProductSubCategory 
FROM superstore;

-- Q4: What are the unique products? --> output contains 1841 unique product names
SELECT DISTINCT product_name FROM superstore;

-- Q5: How many unique products are there? --> 1841
SELECT COUNT(DISTINCT product_name) FROM superstore;



--===============================================================================
-- 4. Data Quality Check → Identify missing values
--===============================================================================

-- Q1: Check for NULL values in key columns
--null_postal_codes	null_cities	null_sales	null_profits
--0	0	0	0
SELECT 
    COUNT(*) - COUNT(postal_code)  AS null_postal_codes,
    COUNT(*) - COUNT(city)         AS null_cities,
    COUNT(*) - COUNT(sales)        AS null_sales,
    COUNT(*) - COUNT(profit)       AS null_profits
FROM superstore;






