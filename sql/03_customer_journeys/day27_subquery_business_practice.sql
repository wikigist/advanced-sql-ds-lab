-- Customers who have at least one unresolved support case
SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE EXISTS (
    SELECT 1
    FROM journey_cases AS j
    WHERE j.customer_id = c.customer_id
      AND j.resolved_at IS NULL
)
ORDER BY c.customer_id;


SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM journey_cases AS j
    WHERE j.customer_id = c.customer_id
      AND j.resolved_at IS NULL
)
ORDER BY c.customer_id;