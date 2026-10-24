CREATE DATABASE IF NOT EXISTS session9_practice_db;
USE session9_practice_db;

CREATE TABLE influencers (
    influencer_id INT PRIMARY KEY,
    influencer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE playlists (
    id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL,
    parent_playlist_id INT NULL
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    offer_title VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INT NULL
);

INSERT INTO influencers VALUES
(1, 'Ava Mehta', 'Mumbai'),
(2, 'Ben Shah', 'Pune'),
(3, 'Chen Rao', 'Delhi'),
(4, 'Dia Patel', 'Jaipur');

INSERT INTO brands VALUES
(1, 'StyleCo', 'Mumbai'),
(2, 'Foodies', 'Pune'),
(3, 'TechHub', 'Bengaluru'),
(4, 'TravelX', 'Kolkata');

INSERT INTO playlists VALUES
(1, 'Main Library', NULL),
(2, 'Focus Mix', 1),
(3, 'Calm Tracks', 1),
(4, 'Deep Work', 2);

INSERT INTO users VALUES
(1, 'Asha', 'Mumbai'),
(2, 'Arjun', 'Mumbai'),
(3, 'Beena', 'Pune'),
(4, 'Dev', 'Mumbai');

INSERT INTO offers VALUES
(1, '10% off headphones'),
(2, 'Free delivery'),
(3, '₹200 off orders over ₹999');

INSERT INTO employees VALUES
(1, 'Neha CEO', NULL),
(2, 'Rohan Manager', 1),
(3, 'Sara Analyst', 2),
(4, 'Imran Director', NULL);

-- Task 1: Matching and unmatching rows from both sides.
SELECT i.influencer_name, b.brand_name
FROM influencers AS i
LEFT JOIN brands AS b
    ON i.city = b.city
UNION ALL
SELECT i.influencer_name, b.brand_name
FROM influencers AS i
RIGHT JOIN brands AS b
    ON i.city = b.city
WHERE i.influencer_id IS NULL;

-- Task 2: SELF JOIN display - each playlist alongside its parent playlist's name.
SELECT child.playlist_name AS playlist_name,
       parent.playlist_name AS parent_playlist_name
FROM playlists AS child
LEFT JOIN playlists AS parent
    ON child.parent_playlist_id = parent.id
ORDER BY child.id;

-- Task 3: CROSS JOIN creates every user/offer combination.
SELECT u.user_name, o.offer_title
FROM users AS u
CROSS JOIN offers AS o
ORDER BY u.user_id, o.offer_id;
-- If a campaign can use this candidate list, then they target the offers using customer preferences.

-- Task 4: Show each employee and their manager.
SELECT e.name AS employee_name,
       m.name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.id
ORDER BY e.id;

-- Task 4 Modified: Show only top-level employees who do not have a manager.
SELECT e.name AS employee_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.id
WHERE e.manager_id IS NULL;

-- Task 5: List same-city user pairs once, excluding a user paired with themselves.
SELECT
    u1.user_name AS user_1,
    u2.user_name AS user_2,
    u1.city
FROM users AS u1
JOIN users AS u2
    ON u1.city = u2.city
   AND u1.user_id < u2.user_id;
   
-- “I used ChatGPT to help write and review the self-join. 
-- It explained that comparing user IDs with < excludes self-pairs and duplicate reversed pairs.”


