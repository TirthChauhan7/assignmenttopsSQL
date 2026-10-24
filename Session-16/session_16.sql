CREATE DATABASE IF NOT EXISTS session16_practice_db;
USE session16_practice_db;

-- Task 1:
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

INSERT INTO users VALUES
(1, 'Asha', 'Patel'),
(2, 'Ravi', 'Shah'),
(3, 'Mina', 'Joshi');

-- Combine first_name and last_name into a single full_name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM users;

-- Task 2: 
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    song_title VARCHAR(200) NOT NULL
);

INSERT INTO playlists VALUES
(1, 'morning breeze'),
(2, 'City Lights'),
(3, 'quiet road');

-- Display every song title in uppercase.
SELECT UPPER(song_title) AS song_title_uppercase
FROM playlists;

-- Task 3: 
CREATE TABLE IF NOT EXISTS food_items (
    item_id INT PRIMARY KEY,
    item_code VARCHAR(100) NOT NULL
);

INSERT INTO food_items VALUES
(1, '  FD-001 '),
(2, 'FD-002   '),
(3, '   FD-003');

-- Remove leading and trailing spaces from item codes.
SELECT item_code,
       TRIM(item_code) AS cleaned_item_code
FROM food_items;

-- Task 4:
CREATE TABLE IF NOT EXISTS movies (
    movie_id INT PRIMARY KEY,
    imdb_id VARCHAR(20) NOT NULL
);

INSERT INTO movies VALUES
(1, 'tt1234567'),
(2, 'tt7654321'),
(3, 'tt2468101');

-- Extract just the numeric part (the last 7 characters)
SELECT imdb_id,
       RIGHT(imdb_id, 7) AS movie_number
FROM movies;

-- Task 5:
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    sku_code VARCHAR(100) NOT NULL
);

INSERT INTO products VALUES
(1, 'MOB-123-XY'),
(2, 'LAP-045-ZQ'),
(3, 'ACC-008-AA');

-- Replace all dashes '-' with underscores '_' in sku_code.
SELECT sku_code,
       REPLACE(sku_code, '-', '_') AS updated_sku_code
FROM products;