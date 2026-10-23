-- Which customers have placed at least one order AND currently have at least one unresolved support case?
WITH customers_with_orders AS (
    SELECT DISTINCT
    customer_id
FROM sales_orders
),
customers_with_unresolved_cases AS (
    SELECT DISTINCT
    customer_id
FROM journey_cases
WHERE resolved_at IS NULL
)
SELECT c.customer_id, c.name
FROM sales_customers AS c
INNER JOIN customers_with_orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN customers_with_unresolved_cases AS u
    ON c.customer_id = u.customer_id
    ORDER BY c.customer_id;


-- Which customers have placed at least one order but have NO unresolved support cases?

WITH customers_with_orders AS (
    SELECT DISTINCT
    customer_id
FROM sales_orders
),
customers_with_unresolved_cases AS (
    SELECT DISTINCT
    customer_id
FROM journey_cases
WHERE resolved_at IS NULL
)

SELECT c.customer_id, c.name
FROM sales_customers AS c
INNER JOIN customers_with_orders AS o
    ON c.customer_id = o.customer_id
LEFT JOIN customers_with_unresolved_cases AS u
    ON o.customer_id = u.customer_id
    WHERE u.customer_id IS NULL
    ORDER BY c.customer_id;