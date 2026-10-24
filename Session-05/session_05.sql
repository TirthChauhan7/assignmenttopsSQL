USE session3_practice_db;

ALTER TABLE products
ADD COLUMN sold_count INT NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    payment_method VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY,
    movie_name VARCHAR(100),
    booking_date DATETIME NOT NULL
);

INSERT INTO orders (order_id, payment_method) VALUES
(1, 'UPI'),
(2, 'Cash'),
(3, 'Credit Card'),
(4, 'UPI'),
(5, 'Debit Card'),
(6, 'Cash');

INSERT INTO bookings (booking_id, movie_name, booking_date) VALUES
(1, 'Example Film', '2025-02-10 18:30:00'),
(2, 'Sample Story', '2025-02-12 20:00:00'),
(3, 'Action Example', '2025-02-15 15:00:00'),
(4, 'Example Film', '2025-02-17 21:15:00'),
(5, 'New Adventure', '2025-02-18 13:00:00'),
(6, 'Sample Story', '2025-02-20 19:30:00');

UPDATE products SET sold_count = 850  WHERE id = 1;
UPDATE products SET sold_count = 2300 WHERE id = 2;
UPDATE products SET sold_count = 1500 WHERE id = 3;
UPDATE products SET sold_count = 3100 WHERE id = 4;

INSERT INTO products (id, name, price, category, sold_count) VALUES
(5, 'Water Bottle', 450.00, 'Lifestyle', 980),
(6, 'Keyboard', 1800.00, 'Electronics', 2750),
(7, 'Backpack', 2200.00, 'Lifestyle', 1900),
(8, 'Desk Organizer', 650.00, 'Home', 1200),
(9, 'Bluetooth Speaker', 2400.00, 'Electronics', 3300),
(10, 'Travel Mug', 550.00, 'Lifestyle', 1600);


-- Task 1:
SELECT DISTINCT payment_method
FROM orders;

-- Task 2: List registered cities once in A-to-Z order.
SELECT DISTINCT city
FROM users
ORDER BY city ASC;

-- Task 3: Show the five latest movie bookings.
SELECT *
FROM bookings
ORDER BY booking_date DESC
LIMIT 5;

-- Task 4: Show the ten products with the highest sold_count.
SELECT name, sold_count
FROM products
ORDER BY sold_count DESC
LIMIT 10;
