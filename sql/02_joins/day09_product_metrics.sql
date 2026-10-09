SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count, COALESCE(SUM(o.amount), 0) AS total_spent
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC, c.customer_id;


SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count, 
SUM(
    CASE WHEN o.amount > 100 THEN 1
    ELSE 0 END
    ) AS high_value_orders

FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;


SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count, 
COUNT(o.order_id) FILTER (
    WHERE o.amount > 100
) AS high_value_orders

FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;