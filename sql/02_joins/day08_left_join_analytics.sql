SELECT
    c.name,
    o.order_id,
    o.amount
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
    ON c.customer_id = o.customer_id
    AND o.amount > 100
ORDER BY c.customer_id;



SELECT
    c.name,
    o.order_id,
    o.amount
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.amount > 100
ORDER BY c.customer_id;



SELECT c.customer_id, c.name, COUNT(order_id) AS order_count
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;


SELECT c.customer_id, c.name, COUNT(order_id) AS order_count, COALESCE(SUM(o.amount), 0) AS total_spent,
COALESCE(SUM(o.amount), 0)/NULLIF(COUNT(o.order_id), 0) AS average_order_value
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;


SELECT c.customer_id, c.name, COUNT(order_id) AS order_count, COALESCE(SUM(o.amount), 0) AS total_spent,
AVG(o.amount) AS average_order_value
FROM sales_customers AS c
LEFT JOIN sales_orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

