-- Day 30: Product Analytics Foundations
-- Create our registered users table

CREATE TABLE IF NOT EXISTS product_users (
    user_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    acquisition_channel TEXT NOT NULL
);

-- Add our sample users

INSERT INTO product_users (
    user_id,
    name,
    acquisition_channel
)
VALUES
    (10, 'Nia', 'Organic'),
    (20, 'Omar', 'Paid Search'),
    (30, 'Priya', 'Referral'),
    (40, 'Leo', 'Organic')
ON CONFLICT (user_id) DO NOTHING;

-- Check our data
SELECT *
FROM product_users
ORDER BY user_id;


-- Create our product events table

CREATE TABLE IF NOT EXISTS product_events (
    event_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES product_users(user_id),
    event_name TEXT NOT NULL
);


-- Add sample product events

INSERT INTO product_events (
    event_id,
    user_id,
    event_name
)
VALUES
    (1001, 10, 'app_open'),
    (1002, 10, 'view_product'),
    (1003, 10, 'purchase'),
    (1004, 20, 'app_open'),
    (1005, 20, 'view_product'),
    (1006, 30, 'app_open'),
    (1007, 30, 'view_product'),
    (1008, 30, 'purchase')
ON CONFLICT (event_id) DO NOTHING;

-- Check our new events table
SELECT *
FROM product_events
ORDER BY event_id;


-- How many unique users have made a purchase?

SELECT
    COUNT(DISTINCT user_id) AS unique_purchasers
FROM product_events
WHERE event_name = 'purchase';