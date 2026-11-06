-- Day 37: Which acquisition channels bring in the most users, and which bring in the most purchasers?

-- Inspect how registered users join to product events

SELECT
    u.user_id,
    u.name,
    u.acquisition_channel,
    e.event_id,
    e.event_name
FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
ORDER BY u.user_id, e.event_id;


-- Compare joined row counts with unique registered users

SELECT
    u.acquisition_channel,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT u.user_id) AS registered_users
FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
GROUP BY u.acquisition_channel
ORDER BY u.acquisition_channel;



SELECT
    u.acquisition_channel,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT u.user_id) AS registered_users,
    COUNT(DISTINCT u.user_id)
        FILTER (WHERE e.event_name = 'purchase')
        AS unique_purchasers
FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
GROUP BY u.acquisition_channel
ORDER BY u.acquisition_channel;


-- Which acquisition channel has the highest percentage of registered users who have made a purchase?

SELECT
    u.acquisition_channel,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT u.user_id) AS registered_users,
    COUNT(DISTINCT u.user_id)
        FILTER (WHERE e.event_name = 'purchase')
        AS unique_purchasers,
        ROUND(
               COUNT(DISTINCT u.user_id)
               FILTER (WHERE e.event_name = 'purchase') * 100.0
               / NULLIF(COUNT(DISTINCT u.user_id), 0),
               2
               ) AS purchaser_rate_pct

FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
GROUP BY u.acquisition_channel
ORDER BY u.acquisition_channel;


-- Which acquisition channel has the highest purchaser rate?

SELECT
    u.acquisition_channel,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT u.user_id) AS registered_users,
    COUNT(DISTINCT u.user_id)
        FILTER (WHERE e.event_name = 'purchase')
        AS unique_purchasers,
        ROUND(
               COUNT(DISTINCT u.user_id)
               FILTER (WHERE e.event_name = 'purchase') * 100.0
               / NULLIF(COUNT(DISTINCT u.user_id), 0),
               2
               ) AS purchaser_rate_pct

FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
GROUP BY u.acquisition_channel
ORDER BY purchaser_rate_pct DESC;