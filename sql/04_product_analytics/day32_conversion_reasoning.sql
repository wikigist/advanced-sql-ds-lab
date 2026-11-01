WITH viewers AS (
    SELECT DISTINCT user_id
    FROM product_events
    WHERE event_name = 'view_product'
),

purchasers AS (
    SELECT DISTINCT user_id
    FROM product_events
    WHERE event_name = 'purchase'
)

SELECT
    COUNT(*) AS total_viewers,
    COUNT(p.user_id) AS viewers_who_purchased,
    ROUND(COUNT(p.user_id) * 100.0 / NULLIF(COUNT(*), 0),2) AS conversion_rate_pct
FROM viewers AS v
LEFT JOIN purchasers AS p
    ON v.user_id = p.user_id;



-- Add event timestamps for sequential conversion analysis

ALTER TABLE product_events
ADD COLUMN IF NOT EXISTS event_time TIMESTAMP;

-- Inspect the new column
SELECT
    event_id,
    user_id,
    event_name,
    event_time
FROM product_events
ORDER BY event_id;


-- Add illustrative timestamps to Nia's product events

UPDATE product_events
SET event_time = '2026-11-01 09:05:00'
WHERE event_id = 1002;

UPDATE product_events
SET event_time = '2026-11-01 09:20:00'
WHERE event_id = 1003;

-- Check Nia's events
SELECT
    event_id,
    user_id,
    event_name,
    event_time
FROM product_events
WHERE user_id = 10
ORDER BY event_id;


-- Priya purchased before viewing a product

UPDATE product_events
SET event_time = '2026-11-01 11:15:00'
WHERE event_id = 1008;

UPDATE product_events
SET event_time = '2026-11-01 11:30:00'
WHERE event_id = 1007;

-- Inspect Priya's journey
SELECT
    event_id,
    user_id,
    event_name,
    event_time
FROM product_events
WHERE user_id = 30
ORDER BY event_time NULLS LAST;


-- Compare each user's product-view and purchase timestamps

SELECT
    v.user_id,
    v.event_time AS view_time,
    p.event_time AS purchase_time
FROM product_events AS v
INNER JOIN product_events AS p
    ON v.user_id = p.user_id
WHERE v.event_name = 'view_product'
  AND p.event_name = 'purchase'
ORDER BY v.user_id;


-- Compare each user's product-view before a purchase

SELECT
    v.user_id,
    v.event_time AS view_time,
    p.event_time AS purchase_time
FROM product_events AS v
INNER JOIN product_events AS p
    ON v.user_id = p.user_id
WHERE v.event_name = 'view_product'
  AND p.event_name = 'purchase'
  AND p.event_time > v.event_time
ORDER BY v.user_id;