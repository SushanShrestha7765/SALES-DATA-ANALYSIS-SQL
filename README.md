# SALES DATA ANALYSIS SQL

This project demonstrates a comprehensive analysis of sales data using **PostgreSQL SQL queries**, ranging from basic retrieval to advanced analytics.

## Dataset Overview

The `sales` table contains the following key columns:

- **transactions_id** – Unique transaction ID
- **customer_id** – Customer identifier
- **age** – Customer age
- **gender** – Customer gender
- **sale_date** – Date of transaction
- **sale_time** – Time of transaction
- **total_sale** – Total sale amount
- **cogs** – Cost of goods sold
- **category** – Product category
- **quantiy** – Quantity sold

## Queries and Analysis

### Basic Data Retrieval
- Display all transactions or specific columns (`transactions_id`, `sale_date`, `total_sale`).  
- Filter transactions by gender, age range, category, total_sale, quantity, or specific sale date.  
- List distinct product categories and sort transactions by total_sale.

### Aggregation and Summaries
- Total revenue (`SUM(total_sale)`), average age (`AVG(age)`), total transactions (`COUNT(total_sale)`).  
- Aggregate total sales, total quantity, total profit per category.  
- Filter grouped results using `HAVING` (e.g., categories with revenue > 10,000).  
- Handle NULL values using `COALESCE`.  
- Monthly sales analysis using `DATE_TRUNC` and identify the month with peak revenue.

### Advanced Analysis
- **Age Groups:** Classify customers as Young (18–30), Adult (31–45), or Senior (46+) using `CASE`.  
- **Peak Sales Hour:** Identify the hour with the highest sales using `EXTRACT(HOUR FROM sale_time)`.  
- **Top Transactions:** Retrieve the top 5 highest sales and the second highest sale.  
- **Customer Ranking:** Rank customers based on total spending using `RANK()`.  
- **Profit Margin:** Calculate per transaction:
```sql
(total_sale - cogs) / total_sale * 100
