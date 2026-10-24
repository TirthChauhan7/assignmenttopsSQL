CREATE DATABASE IF NOT EXISTS session8_practice_db;
USE session8_practice_db;

CREATE TABLE IF NOT EXISTS CustomerSegments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    segment_id INT,
    CONSTRAINT fk_users_customer_segments
        FOREIGN KEY (segment_id) REFERENCES CustomerSegments(segment_id)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO CustomerSegments (segment_id, segment_name) VALUES
(1, 'Regular'),
(2, 'Premium'),
(3, 'New');

INSERT INTO Users (user_id, username, city, segment_id) VALUES
(1, 'Asha', 'Mumbai', 2),
(2, 'Ravi', 'Ahmedabad', 1),
(3, 'Mina', 'Pune', 3),
(4, 'Dev', 'Surat', 1);

INSERT INTO Orders (order_id, user_id, product, amount) VALUES
(1, 1, 'Veg Thali', 450.00),
(2, 1, 'Masala Chai', 120.00),
(3, 2, 'Paneer Wrap', 320.00),
(4, 3, 'Veg Burger', 280.00),
(5, 2, 'Biryani', 550.00),
(6, 999, 'Guest Order', 600.00);

-- Task 2: INNER JOIN
SELECT u.username, o.product
FROM Users AS u
INNER JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY u.user_id, o.order_id;

-- Task 3: LEFT JOIN all usernames along with their ordered products; users without orders show NULL for product.
SELECT u.username, o.product
FROM Users AS u
LEFT JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY u.user_id, o.order_id;

-- Task 4: RIGHT JOIN keeps every order; unmatched user IDs show NULL for username.
SELECT o.order_id, o.user_id, u.username, o.product, o.amount
FROM Users AS u
RIGHT JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY o.order_id;

-- Task 5: show each username, their segment name, and total order amount
SELECT u.username,
       cs.segment_name,
       SUM(o.amount) AS total_order_amount
FROM Users AS u
LEFT JOIN CustomerSegments AS cs
    ON u.segment_id = cs.segment_id
LEFT JOIN Orders AS o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.username, cs.segment_name
ORDER BY u.user_id;