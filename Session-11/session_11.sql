CREATE DATABASE session11_practice_db;
USE session11_practice_db;

CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Playlists (
    playlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Restaurants VALUES
(1, 'Green Garden', 4.7),
(2, 'Spice House', 4.1),
(3, 'Coastal Kitchen', 4.8),
(4, 'City Cafe', 3.9);

INSERT INTO Products VALUES
(1, 'Wireless Mouse', 750.00, 'Electronics'),
(2, 'Headphones', 1500.00, 'Electronics'),
(3, 'Notebook', 100.00, 'Stationery'),
(4, 'Desk Organizer', 500.00, 'Stationery'),
(5, 'Water Bottle', 400.00, 'Lifestyle');

INSERT INTO Users VALUES
(101, 'Asha'),
(102, 'Ravi'),
(103, 'Mina'),
(104, 'Dev');

INSERT INTO Playlists VALUES
(1, 101, 'Focus Mix'),
(2, 101, 'Weekend Songs'),
(3, 101, 'Workout Mix'),
(4, 102, 'Road Trip'),
(5, 103, 'Calm Evening'),
(6, 103, 'Classics');

INSERT INTO Orders VALUES
(1, 101, 450.00),
(2, 102, 1200.00),
(3, 103, 750.00),
(4, 101, 300.00),
(5, 104, 500.00);

-- Task 1: Restaurants with ratings higher than the average rating.
SELECT name, rating
FROM Restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM Restaurants
);

-- Task 2: Each product with the average price in its category.
SELECT p.name, p.category, p.price,
       (
           SELECT AVG(p2.price)
           FROM Products AS p2
           WHERE p2.category = p.category
       ) AS average_category_price
FROM Products AS p;

-- Task 3: Users with more playlists than the average number per user.
SELECT u.username,
       playlist_counts.user_id,
       playlist_counts.playlist_count
FROM (
    SELECT user_id, COUNT(*) AS playlist_count
    FROM Playlists
    GROUP BY user_id
) AS playlist_counts
JOIN Users AS u
    ON u.user_id = playlist_counts.user_id
WHERE playlist_counts.playlist_count > (
    SELECT AVG(counts_per_user.playlist_count)
    FROM (
        SELECT u2.user_id, COUNT(p2.playlist_id) AS playlist_count
        FROM Users AS u2
        LEFT JOIN Playlists AS p2
            ON p2.user_id = u2.user_id
        GROUP BY u2.user_id
    ) AS counts_per_user
);

-- Task 4: User IDs with at least one order above the average order amount.
SELECT DISTINCT user_id
FROM Orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM Orders
);
