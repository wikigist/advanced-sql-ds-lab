-- Day 51: Month-over-month revenue growth

WITH monthly_revenue AS (
    SELECT '2026-01-01' AS month_start, 10000 AS revenue
    UNION ALL
    SELECT '2026-02-01', 12000
    UNION ALL
    SELECT '2026-03-01', 9000
    UNION ALL
    SELECT '2026-04-01', 15000
),
revenue_with_lag AS (
    SELECT
    month_start,
    revenue,
    LAG(revenue) OVER (
       ORDER BY  month_start
    ) AS previous_revenue
FROM monthly_revenue
ORDER BY month_start
)
SELECT
    month_start,
    revenue,
    previous_revenue,
    (revenue - previous_revenue) AS revenue_change,
    ROUND(
    (revenue - previous_revenue)  * 100.0
    / NULLIF(previous_revenue, 0),
    2
) AS mom_growth_pct
FROM revenue_with_lag
ORDER BY month_start;