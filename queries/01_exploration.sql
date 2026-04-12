-- Q: How many records are there?
SELECT COUNT(*) FROM superstore;

-- Q: What are unique regions?
SELECT DISTINCT region FROM superstore;

-- Q: What are unique products?
SELECT DISTINCT product_name FROM superstore;

-- Q: How many unique products are there?
SELECT COUNT(DISTINCT product_name) FROM superstore;

-- Q: How many unique categories and sub-categories are there?
SELECT COUNT(DISTINCT category) AS totalProductCategory, COUNT(DISTINCT sub_category) AS totalProductSubCategory FROM superstore;

-- Q: What are the unique product categories and sub-categories?
SELECT DISTINCT category AS ProductCategory FROM superstore;

-- Q: What are the unique product sub-categories?
SELECT DISTINCT sub_category AS ProductSubCategory FROM superstore;

-- Q: What are unique cities?
SELECT DISTINCT city FROM superstore;

-- Q: How many unique cities are there?
SELECT COUNT(DISTINCT city) FROM superstore;

-- Q: How many orders are there?
SELECT COUNT(*) FROM superstore;

-- Q: What is the date range?
SELECT MIN(order_date), MAX(order_date) FROM superstore;