-- Return exactly two highest-performing salespeople per region. Break sales ties using the smallest employee ID.

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
WHERE rn <= 2
ORDER BY region, rn;


-- Show everyone belonging to the top TWO DISTINCT sales amounts in each region. Include everyone tied at those sales levels.

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
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY monthly_sales DESC
    ) AS sales_level_rank
    FROM salesperson_sales
)
SELECT
    region,
    employee_id,
    salesperson,
    monthly_sales
FROM ranked_salespeople
WHERE sales_level_rank <= 2
ORDER BY region;


WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'North', 10000),
            (102, 'Ben', 'North', 10000),
            (103, 'Chloe', 'North', 8000),
            (201, 'Daniel', 'South', 12000),
            (202, 'Emma', 'South', 9000),
            (203, 'Farah', 'South', 12000),
            (104, 'Grace', 'North', 7000)
    ) AS s(employee_id, salesperson, region, monthly_sales)
),
ranked_salespeople AS (
    SELECT
        employee_id,
        salesperson,
        region,
        monthly_sales,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY monthly_sales DESC
    ) AS sales_level_rank
    FROM salesperson_sales
)
SELECT
    region,
    salesperson,
    monthly_sales,
    sales_level_rank
FROM ranked_salespeople
-- WHERE sales_level_rank <= 2
ORDER BY region, sales_level_rank, employee_id;



WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            (101, 'Alice', 'North', 10000),
            (102, 'Ben', 'North', 10000),
            (103, 'Chloe', 'North', 8000),
            (201, 'Daniel', 'South', 12000),
            (202, 'Emma', 'South', 9000),
            (203, 'Farah', 'South', 12000),
            (104, 'Grace', 'North', 9000)
    ) AS s(employee_id, salesperson, region, monthly_sales)
),
ranked_salespeople AS (
    SELECT
        employee_id,
        salesperson,
        region,
        monthly_sales,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY monthly_sales DESC
    ) AS sales_level_rank
    FROM salesperson_sales
)
SELECT
    region,
    salesperson,
    monthly_sales,
    sales_level_rank
FROM ranked_salespeople
WHERE sales_level_rank <= 2
ORDER BY region, sales_level_rank, employee_id;