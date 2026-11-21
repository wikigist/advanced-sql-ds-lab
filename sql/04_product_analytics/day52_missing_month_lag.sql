-- Day 52: Missing calendar months and LAG()

WITH monthly_revenue AS (
    SELECT DATE '2026-01-01' AS month_start, 10000 AS revenue
    UNION ALL
    SELECT DATE '2026-02-01', 12000
    UNION ALL
    SELECT DATE '2026-04-01', 15000
), 
months_with_lag AS (
SELECT
    month_start,
    revenue,
    LAG(revenue) OVER (
        ORDER BY month_start
    ) AS previous_revenue,
    LAG(month_start) OVER (
    ORDER BY month_start
) AS previous_month_start,
(month_start - INTERVAL '1 month')::date
    AS expected_previous_month
FROM monthly_revenue
ORDER BY month_start
)
SELECT 
    month_start,
    revenue,
    CASE
    WHEN previous_month_start IS NULL
        THEN 'First available month'

    WHEN previous_month_start =
         (month_start - INTERVAL '1 month')::date
        THEN 'Consecutive month'

    ELSE 'Calendar gap'
END AS comparison_status,
CASE
    WHEN previous_month_start = expected_previous_month
        THEN     ROUND(
    (revenue - previous_revenue)  * 100.0
    / NULLIF(previous_revenue, 0),
    2
    )
    ELSE NULL
END AS mom_growth_pct
FROM months_with_lag
ORDER BY month_start;