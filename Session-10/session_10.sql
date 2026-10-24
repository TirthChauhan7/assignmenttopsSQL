USE session3_practice_db;

CREATE TABLE AppOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

CREATE TABLE InStoreOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO AppOrders (order_id, customer_name, amount, order_date) VALUES
(1, 'Asha', 320.00, '2025-03-01'),
(2, 'Ravi', 450.00, '2025-03-02'),
(3, 'Asha', 180.00, '2025-03-03');

INSERT INTO InStoreOrders (order_id, customer_name, amount, order_date) VALUES
(101, 'Asha', 500.00, '2025-03-04'),
(102, 'Kiran', 200.00, '2025-03-05'),
(103, 'Ravi', 100.00, '2025-03-06');

-- Task 2: UNION - combine all unique customer names from both tables.
SELECT customer_name FROM AppOrders
UNION
SELECT customer_name FROM InStoreOrders;

-- Task 3: UNION ALL display every order (including duplicates if any) from both tables.
SELECT order_id, customer_name, amount, order_date FROM AppOrders
UNION ALL
SELECT order_id, customer_name, amount, order_date FROM InStoreOrders;

-- Task 4 Union: Count the unique customer names (3 rows).
SELECT COUNT(*) AS union_unique_name_count
FROM (
    SELECT customer_name FROM AppOrders
    UNION
    SELECT customer_name FROM InStoreOrders
) AS unique_customers;

-- Task 4 Union All: Count all customer-name (6 rows)
SELECT COUNT(*) AS union_all_name_count
FROM (
    SELECT customer_name FROM AppOrders
    UNION ALL
    SELECT customer_name FROM InStoreOrders
) AS all_customer_name_rows;

-- UNION removes duplicates, UNION ALL does not.