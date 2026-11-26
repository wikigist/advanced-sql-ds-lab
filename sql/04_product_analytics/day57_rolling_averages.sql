-- Day 57: Rolling revenue averages

WITH monthly_revenue AS (
    SELECT DATE '2026-01-01' AS month_start, 10000 AS revenue
    UNION ALL
    SELECT DATE '2026-02-01', 12000
    UNION ALL
    SELECT DATE '2026-03-01', 9000
    UNION ALL
    SELECT DATE '2026-04-01', 15000
    UNION ALL
    SELECT DATE '2026-05-01', 11000
    UNION ALL
    SELECT DATE '2026-06-01', 17000
)
SELECT 
    month_start,
    revenue,
    ROUND(
    AVG(revenue) OVER (
        ORDER BY month_start
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ),
    2
) AS rolling_avg_revenue
FROM monthly_revenue
ORDER BY month_start;


WITH monthly_revenue AS (
    SELECT DATE '2026-01-01' AS month_start, 10000 AS revenue
    UNION ALL
    SELECT DATE '2026-02-01', 12000
    UNION ALL
    SELECT DATE '2026-03-01', 9000
    UNION ALL
    SELECT DATE '2026-04-01', 15000
    UNION ALL
    SELECT DATE '2026-05-01', 11000
    UNION ALL
    SELECT DATE '2026-06-01', 17000
)
SELECT 
    month_start,
    revenue,
    ROUND(
    AVG(revenue) OVER (
        ORDER BY month_start
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ),
    2
) AS rolling_avg_revenue,
COUNT(revenue) OVER (
    ORDER BY month_start
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS months_available
FROM monthly_revenue
ORDER BY month_start;