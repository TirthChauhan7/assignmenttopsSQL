CREATE DATABASE  session13_practice_db;
USE session13_practice_db;

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    app_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Playlist (
    song_id INT NOT NULL,
    user_id INT NOT NULL,
    duration_sec INT NOT NULL,
    PRIMARY KEY (song_id, user_id)
);

CREATE TABLE IF NOT EXISTS MovieRatings (
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_name VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO Orders VALUES
(1, 101, 400.00, 'Zomato'),
(2, 102, 250.00, 'Swiggy'),
(3, 101, 600.00, 'Flipkart'),
(4, 103, 320.00, 'Zomato'),
(5, 102, 500.00, 'Swiggy'),
(6, 104, 150.00, 'Zomato'),
(7, 101, 200.00, 'Swiggy'),
(8, 103, 480.00, 'Flipkart'),
(9, 104, 350.00, 'Zomato'),
(10, 102, 300.00, 'Flipkart');

INSERT INTO Playlist (song_id, user_id, duration_sec) VALUES
(501, 101, 180),
(502, 101, 210),
(503, 101, 200),
(504, 102, 240),
(505, 102, 300),
(506, 103, 150),
(507, 103, 180),
(508, 103, 120);

INSERT INTO MovieRatings VALUES
(1, 101, 'Example Film', 5.0),
(2, 102, 'Example Film', 4.0),
(3, 103, 'Example Film', 3.0),
(4, 101, 'Sample Story', 4.0),
(5, 104, 'Sample Story', 5.0),
(6, 102, 'Quiet Road', 3.0);

-- Task 1: Each order with the total amount across all orders.
SELECT order_id,
       user_id,
       order_amount,
       app_name,
       SUM(order_amount) OVER () AS total_all_orders
FROM Orders;

-- Task 2: Each order with the average order amount for that user.
SELECT user_id,
       order_id,
       order_amount,
       AVG(order_amount) OVER (PARTITION BY user_id) AS user_average_order_amount
FROM Orders;

-- Task 3: Each song duration with the user's total playlist duration in seconds.
SELECT user_id,
       song_id,
       duration_sec,
       SUM(duration_sec) OVER (PARTITION BY user_id) AS user_total_duration_sec
FROM Playlist;

-- Task 4: Each rating, the average for that movie, and the difference from that average.
SELECT user_id,
       movie_name,
       rating,
       AVG(rating) OVER (PARTITION BY movie_name) AS movie_average_rating,
       rating - AVG(rating) OVER (PARTITION BY movie_name) AS difference_from_average
FROM MovieRatings;
