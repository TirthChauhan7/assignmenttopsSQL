USE session3_practice_db;

-- Task 1: Find restaurants >= 4.5
SELECT *
FROM restaurants
WHERE rating >= 4.5;

-- Task 2: Find Action movies released after 2020.
SELECT *
FROM movies
WHERE release_year > 2020
  AND genre = 'Action';

-- Task 3: Find products not in Electronics OR priced less than 500.
SELECT *
FROM products
WHERE category <> 'Electronics'
   OR price < 500;

-- Task 4: Find users not from Ahmedabad and have more than 1000 followers.
SELECT *
FROM users
WHERE NOT (city = 'Ahmedabad')
  AND followers > 1000;