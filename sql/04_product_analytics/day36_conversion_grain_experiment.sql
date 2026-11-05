-- Day 36: Add a second qualifying purchase for Nia

INSERT INTO product_events (
    event_id,
    user_id,
    event_name,
    event_time
)
VALUES (
    1010,
    10,
    'purchase',
    '2026-11-01 09:30:00'
)
ON CONFLICT (event_id) DO NOTHING;

-- Inspect all recorded purchases

SELECT
    event_id,
    user_id,
    event_name,
    event_time
FROM product_events
WHERE event_name = 'purchase'
ORDER BY event_id;


-- Of all purchases, what percentage had at least one earlier recorded product view?

WITH purchase_views AS (
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
)
SELECT
    COUNT(*) AS total_purchases,
    COUNT(latest_view_time) AS purchases_with_prior_view,
    ROUND(
        COUNT(latest_view_time) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS prior_view_purchase_pct
FROM purchase_views;


-- Of all unique purchasing users, what percentage made at least one purchase after viewing a product?

WITH purchase_views AS (
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
)
SELECT
    COUNT(DISTINCT user_id) AS total_purchasing_users,

    COUNT(DISTINCT user_id)
        FILTER (WHERE latest_view_time IS NOT NULL)
        AS users_with_prior_view,

ROUND(
    COUNT(DISTINCT user_id)
        FILTER (WHERE latest_view_time IS NOT NULL)
        * 100.0
        / NULLIF(COUNT(DISTINCT user_id), 0),
    2
) AS purchasing_users_with_prior_view_pct
FROM purchase_views;