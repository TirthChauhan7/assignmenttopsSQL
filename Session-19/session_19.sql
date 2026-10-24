CREATE DATABASE IF NOT EXISTS session19_practice_db;
USE session19_practice_db;

-- Task 1: create an orders table with at least 10,000 sample rows.
CREATE TABLE orders (
    order_id BIGINT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

-- Create 10,000 deterministic sample rows. The CTE is used only to generate practice data.
SET SESSION cte_max_recursion_depth = 10001;
INSERT INTO orders (order_id, user_id, order_date, amount)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10000
)
SELECT n,
       MOD(n, 100) + 1,
       DATE_ADD('2025-01-01', INTERVAL MOD(n, 365) DAY),
       MOD(n * 37, 50000) / 100.0
FROM numbers;

-- Before indexing.
SELECT order_id, user_id, order_date, amount
FROM orders
WHERE user_id = 42;

EXPLAIN
SELECT order_id, user_id, order_date, amount
FROM orders
WHERE user_id = 42;

-- Task 2: add the requested index, then rerun the same SELECT and note Workbench's time.
CREATE INDEX idx_orders_user_id ON orders(user_id);

SELECT order_id, user_id, order_date, amount
FROM orders
WHERE user_id = 42;

EXPLAIN
SELECT order_id, user_id, order_date, amount
FROM orders
WHERE user_id = 42;

-- Task 4: a products table and a category index.
CREATE TABLE products (
    product_id INT NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 799.00),
(2, 'Notebook Set', 'Stationery', 249.00),
(3, 'Bluetooth Speaker', 'Electronics', 1999.00),
(4, 'Desk Lamp', 'Home', 1299.00),
(5, 'USB-C Cable', 'Electronics', 399.00),
(6, 'Water Bottle', 'Home', 499.00),
(7, 'Pen Pack', 'Stationery', 149.00),
(8, 'Keyboard', 'Electronics', 2499.00);

CREATE INDEX idx_products_category ON products(category);

-- The WHERE condition matches the indexed category column directly.
SELECT product_id, product_name, category, price
FROM products
WHERE category = 'Electronics';

EXPLAIN
SELECT product_id, product_name, category, price
FROM products
WHERE category = 'Electronics';

-- Task 5:
SELECT order_id, amount
FROM orders
WHERE user_id = 42;

-- Assignment note for Task 5:
-- "Besides indexing, I can reduce the amount of data read and returned by selecting only the
-- columns needed instead of using SELECT *. For example, a sales report that needs order_id and
-- amount should select just those columns. This reduces unnecessary data transfer and can make
-- the query easier to optimize; I would verify the effect with EXPLAIN ANALYZE and timings."