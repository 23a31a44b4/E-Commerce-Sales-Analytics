-- E-Commerce Sales & Profitability Analytics
-- Project: E-Commerce-Sales-Analytics
-- Dataset: Superstore
-- Database: superstore_db
-- Table: superstore

USE superstore_db;

-- 1. BASIC DATA CHECKS
SELECT COUNT(*) AS total_rows FROM superstore;
SELECT MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date FROM superstore;

-- 2. KEY BUSINESS KPIs
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_percentage
FROM superstore;

-- 3. SALES AND PROFIT BY CATEGORY
SELECT category, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percentage
FROM superstore GROUP BY category ORDER BY total_sales DESC;

-- 4. SALES AND PROFIT BY REGION
SELECT region, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY region ORDER BY total_sales DESC;

-- 5. SALES AND PROFIT BY SEGMENT
SELECT segment, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY segment ORDER BY total_sales DESC;

-- 6. CATEGORY + REGION ANALYSIS
SELECT region, category, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY region, category ORDER BY region, total_sales DESC;

-- 7. SUB-CATEGORY ANALYSIS
SELECT sub_category, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY sub_category ORDER BY total_profit DESC;

-- 8. LOSS-MAKING SUB-CATEGORIES
SELECT sub_category, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY sub_category HAVING SUM(profit) < 0 ORDER BY total_profit ASC;

-- 9. YEARLY SALES AND PROFIT
SELECT YEAR(order_date) AS sale_year, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY YEAR(order_date) ORDER BY sale_year;

-- 10. MONTHLY SALES AND PROFIT
SELECT YEAR(order_date) AS sale_year, MONTH(order_date) AS sale_month,
       ROUND(SUM(sales),2) AS monthly_sales, ROUND(SUM(profit),2) AS monthly_profit
FROM superstore GROUP BY YEAR(order_date), MONTH(order_date) ORDER BY sale_year, sale_month;

-- 11. RUNNING TOTAL OF MONTHLY SALES
SELECT YEAR(order_date) AS sale_year, MONTH(order_date) AS sale_month,
       SUM(sales) AS monthly_sales,
       SUM(SUM(sales)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS total_running
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sale_year, sale_month;

-- 12. PREVIOUS MONTH SALES USING LAG()
SELECT YEAR(order_date) AS sale_year, MONTH(order_date) AS sale_month,
       SUM(sales) AS monthly_sales,
       LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS previous_month_sales
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sale_year, sale_month;

-- 13. MONTH-OVER-MONTH SALES GROWTH
WITH monthly_sales AS (
    SELECT YEAR(order_date) AS sale_year, MONTH(order_date) AS sale_month, SUM(sales) AS monthly_sales
    FROM superstore GROUP BY YEAR(order_date), MONTH(order_date)
), monthly_with_previous AS (
    SELECT sale_year, sale_month, monthly_sales,
           LAG(monthly_sales) OVER (ORDER BY sale_year, sale_month) AS previous_month_sales
    FROM monthly_sales
)
SELECT sale_year, sale_month, ROUND(monthly_sales,2) AS monthly_sales,
       ROUND(previous_month_sales,2) AS previous_month_sales,
       ROUND((monthly_sales-previous_month_sales)/NULLIF(previous_month_sales,0)*100,2) AS mom_growth_percentage
FROM monthly_with_previous ORDER BY sale_year, sale_month;

-- 14. YEAR-OVER-YEAR SALES GROWTH
WITH yearly_sales AS (
    SELECT YEAR(order_date) AS sale_year, SUM(sales) AS total_sales
    FROM superstore GROUP BY YEAR(order_date)
)
SELECT sale_year, ROUND(total_sales,2) AS total_sales,
       ROUND(LAG(total_sales) OVER (ORDER BY sale_year),2) AS previous_year_sales,
       ROUND((total_sales-LAG(total_sales) OVER (ORDER BY sale_year)) /
             NULLIF(LAG(total_sales) OVER (ORDER BY sale_year),0)*100,2) AS yoy_growth_percentage
FROM yearly_sales ORDER BY sale_year;

-- 15. TOP 10 CUSTOMERS BY SALES
SELECT customer_name, ROUND(SUM(sales),2) AS total_sales
FROM superstore GROUP BY customer_name ORDER BY total_sales DESC LIMIT 10;

-- 16. TOP 10 CUSTOMERS BY PROFIT
SELECT customer_name, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY customer_name ORDER BY total_profit DESC LIMIT 10;

-- 17. TOP 10 PRODUCTS BY SALES
SELECT product_name, ROUND(SUM(sales),2) AS total_sales
FROM superstore GROUP BY product_name ORDER BY total_sales DESC LIMIT 10;

-- 18. TOP 10 PRODUCTS BY PROFIT
SELECT product_name, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY product_name ORDER BY total_profit DESC LIMIT 10;

-- 19. LOSS-MAKING PRODUCTS
SELECT product_name, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY product_name HAVING SUM(profit) < 0 ORDER BY total_profit ASC;

-- 20. SALES AND PROFIT BY DISCOUNT
SELECT discount, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit,
       ROUND(AVG(profit),2) AS average_profit, COUNT(DISTINCT order_id) AS orders
FROM superstore GROUP BY discount ORDER BY discount;

-- 21. TOP 3 CUSTOMERS BY SALES WITHIN EACH REGION
WITH customer_region_sales AS (
    SELECT region, customer_name, SUM(sales) AS total_sales
    FROM superstore GROUP BY region, customer_name
), ranked_customers AS (
    SELECT region, customer_name, total_sales,
           RANK() OVER (PARTITION BY region ORDER BY total_sales DESC) AS sales_rank
    FROM customer_region_sales
)
SELECT region, customer_name, ROUND(total_sales,2) AS total_sales, sales_rank
FROM ranked_customers WHERE sales_rank <= 3 ORDER BY region, sales_rank;

-- 22. RANK PRODUCTS BY PROFIT
SELECT product_name, ROUND(SUM(profit),2) AS total_profit,
       RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM superstore GROUP BY product_name ORDER BY profit_rank;

-- 23. CATEGORY RANKING WITHIN EACH REGION
SELECT region, category, ROUND(SUM(sales),2) AS total_sales,
       RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS category_rank
FROM superstore GROUP BY region, category ORDER BY region, category_rank;

-- 24. PROFITABILITY STATUS USING CASE
SELECT category, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit,
       CASE WHEN SUM(profit)>0 THEN 'Profitable'
            WHEN SUM(profit)<0 THEN 'Loss'
            ELSE 'Break-even' END AS profitability_status
FROM superstore GROUP BY category ORDER BY total_profit DESC;

-- 25. CITY-LEVEL SALES AND PROFIT
SELECT city, region, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM superstore GROUP BY city, region ORDER BY total_sales DESC;
