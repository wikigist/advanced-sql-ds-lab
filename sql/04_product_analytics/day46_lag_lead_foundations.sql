-- Day 46: LAG and LEAD foundations

WITH monthly_revenue AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-01-01', 10000),
            (DATE '2026-02-01', 12000),
            (DATE '2026-03-01', 9000),
            (DATE '2026-04-01', 15000)
    ) AS m(month_start, revenue)
)
SELECT
    month_start,
    revenue
FROM monthly_revenue
ORDER BY month_start;

-- Calculating for previous_month_revenue using LAG()

WITH monthly_revenue AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-01-01', 10000),
            (DATE '2026-02-01', 12000),
            (DATE '2026-03-01', 9000),
            (DATE '2026-04-01', 15000)
    ) AS m(month_start, revenue)
)
SELECT
    month_start,
    revenue,
    LAG(revenue) OVER (
    ORDER BY month_start
    ) AS previous_month_revenue
FROM monthly_revenue
ORDER BY month_start;


-- Calculating for revenue change

WITH monthly_revenue AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-01-01', 10000),
            (DATE '2026-02-01', 12000),
            (DATE '2026-03-01', 9000),
            (DATE '2026-04-01', 15000)
    ) AS m(month_start, revenue)
)
SELECT
    month_start,
    revenue,
    LAG(revenue) OVER (
    ORDER BY month_start
    ) AS previous_month_revenue,
    revenue - LAG(revenue) OVER (
    ORDER BY month_start
    )  AS revenue_change
FROM monthly_revenue
ORDER BY month_start;


-- Calculating for next_month_revenue using LEAD()

WITH monthly_revenue AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-01-01', 10000),
            (DATE '2026-02-01', 12000),
            (DATE '2026-03-01', 9000),
            (DATE '2026-04-01', 15000)
    ) AS m(month_start, revenue)
)
SELECT
    month_start,
    revenue,
    LEAD(revenue) OVER (
    ORDER BY month_start
    ) AS next_month_revenue
FROM monthly_revenue
ORDER BY month_start;


-- Calculating for next month's revenue change

WITH monthly_revenue AS (
    SELECT *
    FROM (
        VALUES
            (DATE '2026-01-01', 10000),
            (DATE '2026-02-01', 12000),
            (DATE '2026-03-01', 9000),
            (DATE '2026-04-01', 15000)
    ) AS m(month_start, revenue)
)
SELECT
    month_start,
    revenue,
    LEAD(revenue) OVER (
    ORDER BY month_start
    ) AS next_month_revenue,
    LEAD(revenue) OVER (
    ORDER BY month_start
    ) - revenue AS next_month_rev_change
FROM monthly_revenue
ORDER BY month_start;