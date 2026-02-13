-- Display all records from the dataset.
--SELECT * FROM sales
-- Show only transactions_id, sale_date, and total_sale.
SELECT transactions_id,sale_date,total_sale
FROM sales;
-- Find all transactions made by Female customers.
SELECT * FROM sales
WHERE gender='Female';
-- Retrieve transactions where category = 'Beauty'.
SELECT * FROM sales
WHERE category='Beauty';
-- Find all sales where total_sale is greater than 1000.
SELECT * FROM sales
WHERE total_sale>1000;
-- Display customers whose age is between 25 and 40.
SELECT * FROM sales
WHERE age BETWEEN 25 AND 40;
-- Show distinct product categories.
SELECT DISTINCT category FROM sales;
-- Sort all transactions by total_sale in descending order.
SELECT * FROM sales
ORDER BY total_sale DESC;
-- Find transactions made on a specific date (e.g., '2022-11-05').
SELECT * FROM sales
WHERE sale_date='2022-11-05';
-- Retrieve sales where quantity is greater than 3.
SELECT * FROM sales
WHERE quantiy > 3;

--Intermediate Level START Bhayo
-- Calculate the total revenue (sum of total_sale).
SELECT SUM(total_sale)
FROM sales;
-- Find the average customer age.
SELECT AVG(age)
FROM sales;
-- Count total number of transactions.
SELECT COUNT(total_sale) FROM sales;
-- Find total sales grouped by category.
SELECT  category,SUM(total_sale) AS Total_sales
FROM sales
GROUP BY category;
-- Find the maximum and minimum total_sale.
SELECT MAX(total_sale),MIN(total_sale)
FROM sales;
-- Count number of transactions per category.
SELECT category,
COUNT(transactions_id) AS total_transaction
FROM sales
GROUP BY category
ORDER BY  total_transaction ASC;
-- Calculate total quantity sold per category.
SELECT category,COUNT(quantiy) 
AS Total_sales_quantiy
FROM sales
GROUP BY category
ORDER BY Total_sales_quantiy DESC;
-- Find categories where total revenue is greater than 10,000.
SELECT category,SUM(total_sale) AS total_revenue
FROM sales
GROUP BY category
HAVING SUM(total_sale)>10000
ORDER BY total_revenue ASC;
-- Calculate total profit per category (SUM(total_sale - cogs)).
SELECT category,
SUM(total_sale-cogs) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

--garo bhayo my lord
--Replace NULL with 0
SELECT category,
SUM(COALESCE(total_sale, 0) - COALESCE(cogs, 0)) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

-- Extract the month from sale_date and calculate monthly total sales.
SELECT DATE_TRUNC('month', sale_date) AS month,
SUM(COALESCE(total_sale, 0)) AS monthly_total_sales
FROM sales
WHERE sale_date IS NOT NULL
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY month;
-- Identify the month with the highest revenue.
-- LIMIT 1 IS USED TO RESTRICT THE RESULT SET TO ONLY ONE HIGHEST ROW....
-- Create age groups using CASE:
-- .18–30 → Young
-- .31–45 → Adult
-- .46+ → Senior
SELECT
    CASE
        WHEN age BETWEEN 18 AND 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 45 THEN 'Adult'
        WHEN age >= 46 THEN 'Senior'
        ELSE 'Unknown'
    END AS age_group,
    SUM(total_sale) AS total_sales
FROM sales
GROUP BY age_group
ORDER BY total_sales DESC;
--Identify peak sales hour
SELECT
 EXTRACT(HOUR FROM sale_time) AS sale_hour,
 SUM(total_sale) AS total_sales
FROM sales
GROUP BY sale_hour
ORDER BY total_sales DESC
LIMIT 1;
--Top 5 highest sales transactions
SELECT *
FROM sales
ORDER BY total_sale DESC
LIMIT 5;
--Rank customers based on total spending (window function)
SELECT customer_id,
SUM(total_sale) AS total_spending,
RANK() OVER (ORDER BY SUM(total_sale) DESC) AS rank
FROM sales
GROUP BY customer_id
ORDER BY rank;
--Second highest total_sale
SELECT DISTINCT total_sale
FROM sales
ORDER BY total_sale DESC
OFFSET 1
LIMIT 1;
--Calculate profit margin for each transaction
SELECT *,
ROUND(((total_sale - cogs) / total_sale * 100)::numeric, 2) AS profit_margin_percent
FROM sales;
--Percentage contribution of each category to total revenue
SELECT
category,
SUM(total_sale) AS category_sales,
ROUND((SUM(total_sale) * 100 / (SELECT SUM(total_sale) FROM sales))::numeric, 2) AS percentage_of_total
FROM sales
GROUP BY category
ORDER BY percentage_of_total DESC;