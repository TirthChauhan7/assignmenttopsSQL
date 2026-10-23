CREATE DATABASE IF NOT EXISTS session2_practice_db;
USE session2_practice_db;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

CREATE TABLE zomato_reviews (
    review_id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100),
    release_year INT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO restaurants VALUES
(1, 'Green Garden', 4.2),
(2, 'Spice House', 3.8);

INSERT INTO zomato_reviews VALUES
(1, 'Green Garden', 4.2),
(2, 'Spice House', 3.8);

INSERT INTO movies VALUES
(1, 'Example Film', 2020),
(2, 'Sample Story', 2023);

INSERT INTO products VALUES
(1, 'Notebook', 50.00),
(2, 'Pen', 10.00);

-- Task 1:
SELECT *
FROM restaurants;

-- Task 2:
SELECT name, rating
FROM zomato_reviews;

-- Task 3:
SELECT
    movie_name AS `Title`,
    release_year AS `Year Released`
FROM movies;

-- Task 4:
SELECT *
FROM products;
