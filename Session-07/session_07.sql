USE session3_practice_db;

ALTER TABLE movies
ADD COLUMN box_office_collection DECIMAL(15,2) NOT NULL DEFAULT 0;

UPDATE movies SET box_office_collection = 15000000.00 WHERE movie_id = 1;
UPDATE movies SET box_office_collection = 9000000.00  WHERE movie_id = 2;
UPDATE movies SET box_office_collection = 110000000.00 WHERE movie_id = 3;

INSERT INTO movies (movie_id, movie_name, release_year, genre, box_office_collection) VALUES
(4, 'Romantic Film', 2024, 'Romance', 85000000.00),
(5, 'Comedy Film', 2023, 'Comedy', 120000000.00),
(6, 'Action Hit', 2024, 'Action', 150000000.00),
(7, 'Drama Hit', 2024, 'Drama', 105000000.00);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS playlist (
    playlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    duration INT NOT NULL COMMENT 'Song duration in seconds'
);

INSERT INTO transactions (transaction_id, user_id, amount, payment_method) VALUES
(1, 101, 450.00, 'UPI'),
(2, 102, 1200.00, 'Credit Card'),
(3, 101, 800.00, 'UPI'),
(4, 103, 300.00, 'Cash'),
(5, 102, 500.00, 'Credit Card'),
(6, 103, 700.00, 'UPI');

INSERT INTO playlist (playlist_id, user_id, song_id, duration) VALUES
(1, 101, 601, 3600),
(2, 101, 602, 4200),
(3, 102, 603, 2400),
(4, 102, 604, 1800),
(5, 103, 605, 5000),
(6, 103, 606, 3000);

-- Task 1: total number of orders placed by each user (food_orders was created in Session 6).
SELECT user_id, COUNT(*) AS total_orders
FROM food_orders
GROUP BY user_id
ORDER BY user_id;

-- Task 2:  total amount spent by each payment_method.
SELECT payment_method, SUM(amount) AS total_amount_spent
FROM transactions
GROUP BY payment_method
ORDER BY payment_method;

-- Task 3: Total box-office collection by genre, keeping totals above 10 crore rupees.
-- 10 crore rupees = 100,000,000 rupees.
SELECT genre, SUM(box_office_collection) AS total_collection
FROM movies
GROUP BY genre
HAVING SUM(box_office_collection) > 100000000
ORDER BY total_collection DESC;

-- Task 4: Find users whose playlist song durations total more than 7,200 seconds (2 hours).
SELECT user_id, SUM(duration) AS total_duration_seconds
FROM playlist
GROUP BY user_id
HAVING SUM(duration) > 7200
ORDER BY user_id;