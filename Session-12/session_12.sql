CREATE DATABASE IF NOT EXISTS session12_practice_db;
USE session12_practice_db;

CREATE TABLE SpotifyArtists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    followers BIGINT NOT NULL
);

CREATE TABLE  FlipkartOrders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE ZomatoRestaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

CREATE TABLE IPLMatches (
    match_id INT PRIMARY KEY,
    team VARCHAR(100) NOT NULL,
    runs INT NOT NULL,
    match_year INT NOT NULL
);

INSERT INTO SpotifyArtists VALUES
(1, 'Artist A', 85000000),
(2, 'Artist B', 120000000),
(3, 'Artist C', 45000000),
(4, 'Artist D', 99000000),
(5, 'Artist E', 67000000);

INSERT INTO FlipkartOrders VALUES
(1, 101, '2023-01-10', 1250.00),
(2, 102, '2023-01-24', 800.00),
(3, 103, '2023-02-05', 3200.00),
(4, 101, '2023-02-22', 1800.00),
(5, 104, '2023-03-12', 950.00),
(6, 102, '2023-03-28', 2150.00),
(7, 105, '2024-01-15', 5000.00);

INSERT INTO ZomatoRestaurants VALUES
(1, 'Green Garden', 'Mumbai', 4.5),
(2, 'Spice House', 'Mumbai', 4.2),
(3, 'Pune Bites', 'Pune', 3.8),
(4, 'Hill Cafe', 'Pune', 4.0),
(5, 'Delhi Diner', 'Delhi', 4.3),
(6, 'Capital Kitchen', 'Delhi', 4.5);

INSERT INTO IPLMatches VALUES
(1, 'Chennai', 220, 2023),
(2, 'Chennai', 2050, 2023),
(3, 'Mumbai', 2105, 2023),
(4, 'Gujarat', 1800, 2023),
(5, 'Mumbai', 200, 2022),
(6, 'Delhi', 2150, 2024);

-- Task 1: The top 3 most followed artists.
WITH TopArtists AS (
    SELECT artist_id, name, followers
    FROM SpotifyArtists
    ORDER BY followers DESC
    LIMIT 3
)
SELECT *
FROM TopArtists;

-- Task 2: Find the 2023 month with the highest total sales.
WITH MonthlyTotals AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
           SUM(total_amount) AS total_sales
    FROM FlipkartOrders
    WHERE order_date >= '2023-01-01'
      AND order_date < '2024-01-01'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT order_month, total_sales
FROM MonthlyTotals
ORDER BY total_sales DESC
LIMIT 1;

-- Task 3: Generate a list of dates for the next 7 days starting from today.
WITH RECURSIVE CalendarDays (day_date) AS (
    SELECT CURRENT_DATE
    UNION ALL
    SELECT DATE_ADD(day_date, INTERVAL 1 DAY)
    FROM CalendarDays
    WHERE day_date < DATE_ADD(CURRENT_DATE, INTERVAL 6 DAY)
)
SELECT day_date
FROM CalendarDays;

-- Task 4: Return restaurants in cities whose average rating is above 4.0.
WITH CityAverages AS (
    SELECT city, AVG(rating) AS average_rating
    FROM ZomatoRestaurants
    GROUP BY city
)
SELECT r.id, r.name, r.city, r.rating, c.average_rating
FROM ZomatoRestaurants AS r
JOIN CityAverages AS c
    ON r.city = c.city
WHERE c.average_rating > 4.0;

-- Task 5:
-- the WHERE filter keeps only 2023 teams whose total exceeds 2,000 runs.
WITH TeamTotals AS (
    SELECT team, SUM(runs) AS total_runs
    FROM IPLMatches
    WHERE match_year = 2023
    GROUP BY team
)
SELECT team, total_runs
FROM TeamTotals
WHERE total_runs > 2000;