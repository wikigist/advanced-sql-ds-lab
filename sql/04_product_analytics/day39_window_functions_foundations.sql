-- Day 39: Introduction to window functions

WITH channel_purchases AS (
    SELECT
        u.acquisition_channel,
        COUNT(e.event_id)
            FILTER (WHERE e.event_name = 'purchase')
            AS purchase_events
    FROM product_users AS u
    LEFT JOIN product_events AS e
        ON u.user_id = e.user_id
    GROUP BY u.acquisition_channel
)
SELECT
    acquisition_channel,
    purchase_events,
    SUM(purchase_events) OVER () AS all_purchase_events,
    ROUND(
    purchase_events * 100.0
    / NULLIF(SUM(purchase_events) OVER (), 0),
    2
) AS purchase_contribution_pct
FROM channel_purchases
ORDER BY purchase_events DESC;


-- Experiment 2: Purchase totals within each acquisition channel

WITH user_purchases AS (
    SELECT
        u.user_id,
        u.name,
        u.acquisition_channel,
        COUNT(e.event_id)
            FILTER (WHERE e.event_name = 'purchase')
            AS purchase_events
    FROM product_users AS u
    LEFT JOIN product_events AS e
        ON u.user_id = e.user_id
    GROUP BY
        u.user_id,
        u.name,
        u.acquisition_channel
)
SELECT
    name,
    acquisition_channel,
    purchase_events,
    SUM(purchase_events) OVER (
        PARTITION BY acquisition_channel
    ) AS channel_purchase_events,
    SUM(purchase_events) OVER () AS all_purchase_events,
    COUNT(*) OVER (
    PARTITION BY acquisition_channel
) AS registered_users_in_channel
FROM user_purchases
ORDER BY acquisition_channel, name;