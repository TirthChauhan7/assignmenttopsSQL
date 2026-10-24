CREATE DATABASE session14_practice_db;
USE session14_practice_db;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    artist VARCHAR(100) NOT NULL,
    streams INT NOT NULL
);

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    platform VARCHAR(50) NOT NULL,
    followers INT NOT NULL
);
INSERT INTO Orders VALUES
(1, 101, '2025-01-10', 450.00),
(2, 101, '2025-02-14', 620.00),
(3, 101, '2025-03-03', 300.00),
(4, 102, '2025-01-22', 800.00),
(5, 102, '2025-04-19', 525.00),
(6, 103, '2025-02-01', 250.00),
(7, 103, '2025-05-11', 950.00),
(8, 103, '2025-06-05', 400.00);

INSERT INTO Songs VALUES
(1, 'Nova', 1000000),
(2, 'Nova', 800000),
(3, 'Nova', 800000),
(4, 'Nova', 500000),
(5, 'Echo', 950000),
(6, 'Echo', 700000),
(7, 'Echo', 700000),
(8, 'Echo', 300000);

INSERT INTO Movies VALUES
(1, 'Action', 9.0),
(2, 'Action', 9.0),
(3, 'Action', 8.2),
(4, 'Action', 7.5),
(5, 'Drama', 8.8),
(6, 'Drama', 8.1),
(7, 'Drama', 8.1),
(8, 'Drama', 7.9);

INSERT INTO Influencers VALUES
(1, 'Instagram', 900000),
(2, 'Instagram', 750000),
(3, 'Instagram', 750000),
(4, 'Instagram', 400000),
(5, 'TikTok', 1500000),
(6, 'TikTok', 1100000),
(7, 'TikTok', 850000),
(8, 'TikTok', 500000);

-- Task 1: each user's orders from newest to oldest.
SELECT order_id, user_id, order_date, total_amount,
       ROW_NUMBER() OVER (
           PARTITION BY user_id
           ORDER BY order_date DESC
       ) AS order_number_for_user
FROM Orders;

-- Task 2: Rank songs by streams within each artist.
SELECT song_id, artist, streams,
       RANK() OVER (
           PARTITION BY artist
           ORDER BY streams DESC
       ) AS stream_rank
FROM Songs;

-- Task 3: Rank movies within each genre,  highest rating is rank 1.
SELECT movie_id, genre, rating,
       DENSE_RANK() OVER (
           PARTITION BY genre
           ORDER BY rating DESC
       ) AS genre_rating_rank
FROM Movies;

-- Task 4: Show the top 3 influencers per platform using ROW_NUMBER and a CTE.
WITH RankedInfluencers AS (
    SELECT id,
           platform,
           followers,
           ROW_NUMBER() OVER (
               PARTITION BY platform
               ORDER BY followers DESC, id ASC
           ) AS row_num
    FROM Influencers
)
SELECT id, platform, followers, row_num
FROM RankedInfluencers
WHERE row_num <= 3;