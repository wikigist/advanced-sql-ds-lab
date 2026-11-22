-- Day 53: Complete monthly calendar with revenue

WITH calendar_months AS (
    SELECT generate_series(
        DATE '2026-01-01',
        DATE '2026-04-01',
        INTERVAL '1 month'
    )::date AS month_start
),
monthly_revenue AS (
    SELECT DATE '2026-01-01' AS month_start, 10000 AS revenue
    UNION ALL
    SELECT DATE '2026-02-01', 12000
    UNION ALL
    SELECT DATE '2026-03-01', 0
    UNION ALL
    SELECT DATE '2026-04-01', 15000
)
SELECT 
    c.month_start,
    m.revenue
FROM calendar_months c
LEFT JOIN monthly_revenue m
ON c.month_start = m.month_start
ORDER BY month_start;