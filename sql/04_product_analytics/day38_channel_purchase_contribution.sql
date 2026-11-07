-- Day 38: Purchase events by acquisition channel

SELECT
    u.acquisition_channel,
    COUNT(e.event_id)
        FILTER (WHERE e.event_name = 'purchase')
        AS purchase_events
FROM product_users AS u
LEFT JOIN product_events AS e
    ON u.user_id = e.user_id
GROUP BY u.acquisition_channel
ORDER BY purchase_events DESC;


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
),
total_purchases AS (
    SELECT
        SUM(purchase_events) AS all_purchase_events
    FROM channel_purchases
)
SELECT
    cp.acquisition_channel,
    cp.purchase_events,
    tp.all_purchase_events,
    ROUND(
    cp.purchase_events * 100.0
    / NULLIF(tp.all_purchase_events, 0),
    2
) AS purchase_contribution_pct
FROM channel_purchases AS cp
CROSS JOIN total_purchases AS tp
ORDER BY cp.purchase_events DESC;