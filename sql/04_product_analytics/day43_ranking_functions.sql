-- Day 43: Ranking functions foundations

WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            ('Alice', 10000),
            ('Ben', 10000),
            ('Chloe', 8000),
            ('Daniel', 8000),
            ('Emma', 6000)
    ) AS s(salesperson, monthly_sales)
)
SELECT
    salesperson,
    monthly_sales,
    ROW_NUMBER() OVER (
        ORDER BY monthly_sales DESC, salesperson ASC
    ) AS row_num,
    RANK() OVER (
        ORDER BY monthly_sales DESC
    ) AS sales_rank,
    DENSE_RANK() OVER (
        ORDER BY monthly_sales DESC
    ) AS dense_sales_rank
FROM salesperson_sales
ORDER BY monthly_sales DESC, salesperson ASC;


-- If monthly sales are tied, assign row numbers using reverse alphabetical order.

WITH salesperson_sales AS (
    SELECT *
    FROM (
        VALUES
            ('Alice', 10000),
            ('Ben', 10000),
            ('Chloe', 8000),
            ('Daniel', 8000),
            ('Emma', 6000)
    ) AS s(salesperson, monthly_sales)
)
SELECT
    salesperson,
    monthly_sales,
    ROW_NUMBER() OVER (
        ORDER BY monthly_sales DESC, salesperson DESC
    ) AS row_num,
    RANK() OVER (
        ORDER BY monthly_sales DESC
    ) AS sales_rank,
    DENSE_RANK() OVER (
        ORDER BY monthly_sales DESC
    ) AS dense_sales_rank
FROM salesperson_sales
ORDER BY monthly_sales DESC, salesperson DESC;