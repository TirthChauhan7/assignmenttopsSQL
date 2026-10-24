CREATE DATABASE IF NOT EXISTS session3_practice_db;
USE session3_practice_db;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100),
    release_year INT,
    genre VARCHAR(50)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    followers INT
);

INSERT INTO restaurants VALUES
(1, 'Green Garden', 4.7),
(2, 'Spice House', 4.4),
(3, 'Coastal Kitchen', 4.8);

INSERT INTO movies VALUES
(1, 'Action Example', 2022, 'Action'),
(2, 'Old Action', 2020, 'Action'),
(3, 'New Drama', 2023, 'Drama');

INSERT INTO products VALUES
(1, 'Headphones', 1200.00, 'Electronics'),
(2, 'Phone Case', 350.00, 'Electronics'),
(3, 'Desk Lamp', 700.00, 'Home'),
(4, 'Notebook', 100.00, 'Stationery');

INSERT INTO users VALUES
(1, 'Asha', 'Mumbai', 1500),
(2, 'Ravi', 'Ahmedabad', 2400),
(3, 'Mina', 'Pune', 800),
(4, 'Dev', 'Surat', 1200);