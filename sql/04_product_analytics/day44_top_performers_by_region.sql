-- Day 44: Top-performing salesperson per region

WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'North', 10000),
            (102, 'Ben', 'North', 10000),
            (103, 'Chloe', 'North', 8000),
            (201, 'Daniel', 'South', 12000),
            (202, 'Emma', 'South', 9000),
            (203, 'Farah', 'South', 12000)
    ) AS s(employee_id, salesperson, region, monthly_sales)
),
ranked_salespeople AS (
    SELECT
        employee_id,
        salesperson,
        region,
        monthly_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY monthly_sales DESC, employee_id ASC
        ) AS rn
    FROM salesperson_sales
)
SELECT *
FROM ranked_salespeople
ORDER BY region, rn;


WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'North', 10000),
            (102, 'Ben', 'North', 10000),
            (103, 'Chloe', 'North', 8000),
            (201, 'Daniel', 'South', 12000),
            (202, 'Emma', 'South', 9000),
            (203, 'Farah', 'South', 12000)
    ) AS s(employee_id, salesperson, region, monthly_sales)
),
ranked_salespeople AS (
    SELECT
        employee_id,
        salesperson,
        region,
        monthly_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY monthly_sales DESC, employee_id ASC
        ) AS rn
    FROM salesperson_sales
)
SELECT
    region,
    employee_id,
    salesperson,
    monthly_sales
FROM ranked_salespeople
WHERE rn = 1
ORDER BY region;