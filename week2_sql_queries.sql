-- Week 2: SQL for Data Analysis
-- Dataset columns: order_id, customer_name, order_date, category,
-- sub_category, product_name, quantity, unit_price, total_price, region.
-- SQLite-compatible SQL.

CREATE TABLE IF NOT EXISTS sales (
    order_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    order_date TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    quantity INTEGER,
    unit_price REAL,
    total_price REAL,
    region TEXT
);

-- Import the provided CSV into the sales table before running queries.
-- SQLite CLI example:
-- .mode csv
-- .import SQL_Sales_Dataset_200_Rows.csv sales

-- 1. SELECT: preview records
SELECT * FROM sales LIMIT 10;

-- 2. WHERE: orders above 20,000
SELECT order_id, customer_name, total_price
FROM sales
WHERE total_price > 20000
ORDER BY total_price DESC;

-- 3. GROUP BY + SUM: revenue by category
SELECT category, SUM(total_price) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 4. Aggregations: average order value and order count
SELECT COUNT(*) AS total_orders,
       AVG(total_price) AS average_order_value,
       SUM(total_price) AS total_revenue
FROM sales;

-- 5. Top customers by total spend
SELECT customer_name,
       COUNT(DISTINCT order_id) AS order_count,
       SUM(total_price) AS total_spend
FROM sales
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 10;

-- 6. CASE: classify order values
SELECT order_id, customer_name, total_price,
       CASE
         WHEN total_price >= 20000 THEN 'High'
         WHEN total_price >= 10000 THEN 'Medium'
         ELSE 'Low'
       END AS order_value_band
FROM sales
ORDER BY total_price DESC;

-- 7. Subquery: orders above the average order value
SELECT order_id, customer_name, total_price
FROM sales
WHERE total_price > (SELECT AVG(total_price) FROM sales)
ORDER BY total_price DESC;

-- 8. JOIN example using a customer summary derived table
SELECT s.order_id, s.customer_name, s.total_price, c.customer_total
FROM sales AS s
JOIN (
    SELECT customer_name, SUM(total_price) AS customer_total
    FROM sales
    GROUP BY customer_name
) AS c
ON s.customer_name = c.customer_name
ORDER BY c.customer_total DESC, s.total_price DESC;
