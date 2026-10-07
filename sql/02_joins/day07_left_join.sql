SELECT
    c.name,
    c.country,
    o.order_id,
    o.amount
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;



SELECT c.name, c.country
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id, o.order_id;