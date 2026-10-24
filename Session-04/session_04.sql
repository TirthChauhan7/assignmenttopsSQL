USE session3_practice_db;

CREATE TABLE IF NOT EXISTS songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist_name VARCHAR(100)
);

INSERT INTO songs VALUES
(1, 'Song One', 'Armaan Malik'),
(2, 'Evening Tune', 'Carlos Santana'),
(3, 'Quiet Road', 'Taylor Swift'),
(4, 'City Lights', 'Asha Bhosle');

-- Task 1: Names ending with 'Cafe'
SELECT *
FROM restaurants
WHERE name LIKE '%Cafe';

-- Task 2: Price BETWEEN 500 and 1500.
SELECT *
FROM products
WHERE price BETWEEN 500 AND 1500;

-- Task 3:
SELECT *
FROM users
WHERE city IN ('Ahmedabad', 'Surat', 'Vadodara');

-- Task 4: Find artist names containing letters 'ar'.
SELECT song_name, artist_name
FROM songs
WHERE artist_name LIKE '%ar%';