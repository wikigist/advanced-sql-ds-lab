-- How many people viewed a product, and how many went on to purchase?

SELECT
    COUNT(*) AS total_product_views
FROM product_events
WHERE event_name = 'view_product';

SELECT
    COUNT(DISTINCT user_id) AS unique_product_viewers
FROM product_events
WHERE event_name = 'view_product';


-- Great! Three users viewed a product. But how many of those users also made a purchase?

WITH viewers AS (
    SELECT DISTINCT user_id
    FROM product_events
    WHERE event_name = 'view_product'
)
SELECT *
FROM viewers
ORDER BY user_id;


-- Identify product viewers and which of them purchased

-- Count viewers and how many of them purchased

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
    ROUND(
        COUNT(p.user_id) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS conversion_rate_pct
FROM viewers AS v
LEFT JOIN purchasers AS p
    ON v.user_id = p.user_id;
