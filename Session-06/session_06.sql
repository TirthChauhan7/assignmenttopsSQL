USE session3_practice_db;

CREATE TABLE IF NOT EXISTS food_orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS spotify_playlists (
    playlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS bookmyshow_reviews (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

CREATE TABLE IF NOT EXISTS paytm_transactions (
    txn_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS myntra_orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL
);

INSERT INTO food_orders (order_id, user_id, amount) VALUES
(1, 101, 400.00),
(2, 101, 250.00),
(3, 102, 600.00),
(4, 102, 350.00),
(5, 103, 200.00);

INSERT INTO spotify_playlists (playlist_id, user_id, song_id) VALUES
(1, 101, 501),
(2, 101, 502),
(3, 101, 503),
(4, 102, 504),
(5, 102, 505),
(6, 103, 506);

INSERT INTO bookmyshow_reviews (review_id, movie_id, rating) VALUES
(1, 201, 4.2),
(2, 201, 3.8),
(3, 202, 4.7),
(4, 202, 4.4),
(5, 203, 3.9);

INSERT INTO paytm_transactions (txn_id, user_id, amount) VALUES
(1, 101, 100.00),
(2, 101, 1200.00),
(3, 102, 250.00),
(4, 102, 800.00),
(5, 103, 75.00),
(6, 103, 600.00);

INSERT INTO myntra_orders (order_id, user_id, total_price) VALUES
(1, 101, 999.00),
(2, 101, 1500.00),
(3, 101, 750.00),
(4, 102, 2300.00),
(5, 102, 2000.00),
(6, 103, 499.00);

-- Task 1: total amount spent by users on food order
SELECT user_id, SUM(amount) AS total_spent
FROM food_orders
GROUP BY user_id
ORDER BY user_id;

-- Task 2: how many songs a user has added to their playlist
SELECT user_id, COUNT(song_id) AS song_count
FROM spotify_playlists
GROUP BY user_id
ORDER BY user_id;

-- Task 3: Average rating for each movie, rounded to one decimal place.
SELECT movie_id, ROUND(AVG(rating), 1) AS average_rating
FROM bookmyshow_reviews
GROUP BY movie_id
ORDER BY movie_id;

-- Task 4: Smallest and largest transaction amount for each user.
SELECT user_id,
       MIN(amount) AS minimum_amount,
       MAX(amount) AS maximum_amount
FROM paytm_transactions
GROUP BY user_id
ORDER BY user_id;

-- Task 5: Order count, average order value, and highest order value per user.
SELECT user_id,
       COUNT(*) AS order_count,
       ROUND(AVG(total_price), 2) AS average_order_value,
       MAX(total_price) AS highest_order_value
FROM myntra_orders
GROUP BY user_id
ORDER BY user_id;