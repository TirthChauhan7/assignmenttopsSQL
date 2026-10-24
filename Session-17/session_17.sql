CREATE DATABASE IF NOT EXISTS session17_practice_db;
USE session17_practice_db;

-- Task 1: 
CREATE TABLE IF NOT EXISTS FoodOrders (
    order_id INT PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO FoodOrders VALUES
(1, 250.00),
(2, 300.00),
(3, 999.00),
(4, 1000.00),
(5, 1450.00);

-- Classify food orders by total amount.
SELECT order_id,
       total_amount,
       CASE
           WHEN total_amount < 300 THEN 'Small'
           WHEN total_amount < 1000 THEN 'Medium'
           ELSE 'Large'
       END AS order_size
FROM FoodOrders;

-- Task 2: 
CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

INSERT INTO Movies VALUES
(1, 'Example Film', 8.5),
(2, 'Sample Story', 7.2),
(3, 'Quiet Road', 4.8),
(4, 'Action Hit', 8.0),
(5, 'New Release', 5.0);

-- Display a popularity label based on each movie's rating.
SELECT movie_id, movie_name, rating,
       CASE
           WHEN rating >= 8 THEN 'Blockbuster'
           WHEN rating >= 5 THEN 'Hit'
           ELSE 'Average'
       END AS popularity
FROM Movies;

-- Task 3: 
CREATE TABLE IF NOT EXISTS FlipkartProducts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO FlipkartProducts VALUES
(1, 'Notebook', 250.00),
(2, 'Headphones', 500.00),
(3, 'Keyboard', 2000.00),
(4, 'Smart Watch', 2500.00);

-- Bin product prices into Budget, Standard, or Premium.
SELECT product_id,
       product_name,
       price,
       CASE
           WHEN price < 500 THEN 'Budget'
           WHEN price <= 2000 THEN 'Standard'
           ELSE 'Premium'
       END AS price_category
FROM FlipkartProducts;

-- Task 4:
CREATE TABLE IF NOT EXISTS SpotifyTracks (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(100) NOT NULL,
    duration_sec INT NOT NULL
);

INSERT INTO SpotifyTracks VALUES
(1, 'Short Tune', 150),
(2, 'Three Minutes', 180),
(3, 'Five Minutes', 300),
(4, 'Long Session', 360);

--  Label track durations. 180 and 300 seconds are Medium.
SELECT track_id,
       track_name,
       duration_sec,
       CASE
           WHEN duration_sec < 180 THEN 'Short'
           WHEN duration_sec <= 300 THEN 'Medium'
           ELSE 'Long'
       END AS duration_label
FROM SpotifyTracks;