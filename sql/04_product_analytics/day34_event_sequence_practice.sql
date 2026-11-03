-- For each purchase, find the most recent recorded product view that happened before it.

SELECT
    p.event_id AS purchase_id,
    p.user_id,
    p.event_time AS purchase_time
FROM product_events AS p
WHERE p.event_name = 'purchase'
ORDER BY p.event_id;


-- Add a second product view for Nia to test MAX()

INSERT INTO product_events (
    event_id,
    user_id,
    event_name,
    event_time
)
VALUES (
    1009,
    10,
    'view_product',
    '2026-11-01 09:10:00'
)
ON CONFLICT (event_id) DO NOTHING;



-- Show every purchase with qualifying earlier product views

SELECT
    p.event_id AS purchase_id,
    p.user_id,
    p.event_time AS purchase_time,
    v.event_time AS earlier_view_time
FROM product_events AS p
LEFT JOIN product_events AS v
    ON p.user_id = v.user_id
   AND v.event_name = 'view_product'
   AND v.event_time < p.event_time
WHERE p.event_name = 'purchase'
ORDER BY p.event_id;


-- Finding the MOST RECENT earlier view

SELECT
    p.event_id AS purchase_id,
    p.user_id,
    p.event_time AS purchase_time,
    MAX(v.event_time) AS latest_view_time
FROM product_events AS p
LEFT JOIN product_events AS v
    ON p.user_id = v.user_id
   AND v.event_name = 'view_product'
   AND v.event_time < p.event_time
WHERE p.event_name = 'purchase'
GROUP BY
    p.event_id,
    p.user_id,
    p.event_time
ORDER BY p.event_id;

