-- Day 41: Running total foundations

WITH daily_purchases AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-11-01', 2),
            (DATE '2026-11-02', 3),
            (DATE '2026-11-03', 1),
            (DATE '2026-11-04', 4)
    ) AS d(purchase_date, purchase_events)
)
SELECT
    purchase_date,
    purchase_events,

    SUM(purchase_events) OVER (
        ORDER BY purchase_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS running_total

FROM daily_purchases
ORDER BY purchase_date ASC;