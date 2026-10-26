-- Which customers have placed an order?
SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE EXISTS (
    SELECT 1
    FROM sales_orders AS o
    WHERE o.customer_id = c.customer_id
);


-- -- Which customers have NEVER placed an order?
SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM sales_orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;