CREATE DATABASE IF NOT EXISTS session18_practice_db;
USE session18_practice_db;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE RestaurantReviews (
    review_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO Restaurants VALUES
(1, 'Green Garden', 'Mumbai'),
(2, 'Spice House', 'Pune'),
(3, 'Coastal Kitchen', 'Mumbai');

INSERT INTO RestaurantReviews VALUES
(1, 1, 4.5),
(2, 1, 4.7),
(3, 2, 3.8),
(4, 2, 4.0),
(5, 3, 4.2),
(6, 3, 4.4);

-- Task 1: Create a view with restaurant name, average rating, and review count.
CREATE OR REPLACE VIEW TopRatedRestaurants AS
SELECT r.name AS restaurant_name,
       AVG(rv.rating) AS average_rating,
       COUNT(rv.review_id) AS total_reviews
FROM Restaurants AS r
INNER JOIN RestaurantReviews AS rv
    ON rv.restaurant_id = r.id
GROUP BY r.id, r.name
HAVING AVG(rv.rating) > 4.0;

SELECT * FROM TopRatedRestaurants;

-- Task 2: Replace the view definition to include city using an INNER JOIN.
CREATE OR REPLACE VIEW TopRatedRestaurants AS
SELECT r.name AS restaurant_name,
       r.city,
       AVG(rv.rating) AS average_rating,
       COUNT(rv.review_id) AS total_reviews
FROM Restaurants AS r
INNER JOIN RestaurantReviews AS rv
    ON rv.restaurant_id = r.id
GROUP BY r.id, r.name, r.city
HAVING AVG(rv.rating) > 4.0;

SELECT * FROM TopRatedRestaurants;

-- Task 3:

UPDATE TopRatedRestaurants
SET average_rating = 5.0
WHERE restaurant_name = 'Green Garden';

-- Error Code: 1288. The target table TopRatedRestaurants of the UPDATE is not updatable.
-- "The view calculates AVG() and COUNT() and uses GROUP BY and HAVING, 
-- so its rows don’t map one-to-one to individual rows in the source tables.
-- MySQL therefore won’t let me update the calculated average through the view."

-- Task 4:
CREATE TABLE IF NOT EXISTS SwiggyOrders (
    order_id INT PRIMARY KEY,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO SwiggyOrders VALUES
(1, DATE_SUB(NOW(), INTERVAL 45 DAY), 450.00),
(2, DATE_SUB(NOW(), INTERVAL 20 DAY), 320.00),
(3, DATE_SUB(NOW(), INTERVAL 5 DAY), 780.00),
(4, NOW(), 250.00);

-- Daily food-order count and revenue for the last 30 days.
CREATE OR REPLACE VIEW DailyOrderSummary AS
SELECT DATE(order_date) AS order_date,
       COUNT(*) AS total_orders,
       SUM(total_amount) AS total_revenue
FROM SwiggyOrders
WHERE order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
  AND order_date <= NOW()
GROUP BY DATE(order_date);

SELECT * FROM DailyOrderSummary;

-- Task 5 : List 3 good practices.

-- 1. Use clear names and documented measures; e.g., name a view FlipkartDailySales and define revenue as SUM(order_amount).
-- 2. Keep the view focused and expose only needed columns; e.g., include order_date, category, and revenue for a sales dashboard.
-- 3. Filter and group at the intended reporting grain; e.g., aggregate Flipkart orders by day before a daily trend chart uses the view.


