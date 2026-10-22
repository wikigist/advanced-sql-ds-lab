-- Show me customers who have placed more than one order, along with their total order counts.

WITH orders_per_customer AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM sales_orders
    GROUP BY customer_id
),
repeat_customers AS (
    SELECT
        customer_id,
        total_orders
    FROM orders_per_customer
    WHERE total_orders > 1
)
SELECT
    customer_id,
    total_orders
FROM repeat_customers;



-- For every customer, show their name, total number of orders, and total number of support cases.

WITH orders_per_customer AS (
        SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM sales_orders
    GROUP BY customer_id
),
cases_per_customer AS (
    SELECT customer_id,
    COUNT(*) AS total_cases
    FROM journey_cases
    GROUP BY customer_id
)
SELECT
     c.name, COALESCE(o.total_orders, 0) AS total_orders, COALESCE(j.total_cases, 0) AS total_cases
FROM sales_customers AS c
LEFT JOIN orders_per_customer AS o
    ON c.customer_id = o.customer_id
LEFT JOIN cases_per_customer AS j
    ON c.customer_id = j.customer_id;