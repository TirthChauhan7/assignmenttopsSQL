CREATE DATABASE IF NOT EXISTS session15_practice_db;
USE session15_practice_db;

-- Task 1: Show the current date and time.
SELECT NOW() AS CurrentDateTime;

-- Task 2: Create Orders table.
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL
);

INSERT INTO Orders VALUES
(1, '2025-01-15'),
(2, '2025-06-22'),
(3, '2026-02-08');

-- display each order's order_date.
SELECT order_id, order_date,
       YEAR(order_date) AS order_year,
       MONTH(order_date) AS order_month,
       DAY(order_date) AS order_day
FROM Orders;

-- Task 3: Create Deliveries Table.
CREATE TABLE IF NOT EXISTS Deliveries (
    delivery_id INT PRIMARY KEY,
    delivery_date DATE NOT NULL
);

INSERT INTO Deliveries VALUES
(1, '2025-03-12'),
(2, '2025-04-25'),
(3, '2025-07-01');

-- Pick up dates.
SELECT delivery_id, delivery_date,
       DATE_SUB(delivery_date, INTERVAL 2 DAY) AS expected_pickup_date
FROM Deliveries;

-- Task 4: Create Subscriptions Table.
CREATE TABLE IF NOT EXISTS Subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

INSERT INTO Subscriptions VALUES
(1, 101, '2025-01-01', '2025-12-31'),
(2, 102, '2025-03-15', '2025-09-15'),
(3, 103, '2026-01-01', '2026-06-30');

-- display user_id, start_date, end_date, and the total number of days of each subscription
SELECT user_id, start_date, end_date,
       DATEDIFF(end_date, start_date) AS subscription_days
FROM Subscriptions;

-- Task 5: Create AppLogins Table.
CREATE TABLE IF NOT EXISTS AppLogins (
    user_id INT PRIMARY KEY,
    last_login_date DATETIME NOT NULL
);

INSERT INTO AppLogins VALUES
(101, DATE_SUB(NOW(), INTERVAL 45 DAY)),
(102, DATE_SUB(NOW(), INTERVAL 60 DAY)),
(103, DATE_SUB(NOW(), INTERVAL 15 DAY)),
(104, DATE_SUB(NOW(), INTERVAL 30 DAY));

-- To find all users who haven't logged in for more than 30 days from today.
SELECT user_id, last_login_date
FROM AppLogins
WHERE DATEDIFF(NOW(), last_login_date) > 30;