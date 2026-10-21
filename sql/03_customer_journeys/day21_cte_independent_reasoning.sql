-- What is the average number of orders placed per purchasing customer?

WITH orders_per_customer AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM sales_orders
    GROUP BY customer_id
)
SELECT
    ROUND(AVG(total_orders), 2) AS avg_orders_per_customer
FROM orders_per_customer;



-- What is the average number of support cases opened per customer who has opened a case?

WITH cases_per_customer AS (
    SELECT
    customer_id,
    COUNT(*) AS total_cases
FROM journey_cases
GROUP BY customer_id
)

SELECT ROUND(AVG(total_cases), 2) as avg_cases_per_customer
FROM cases_per_customer;



-- How many purchasing customers have placed more than one order?

WITH orders_per_customer AS (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM sales_orders
    GROUP BY customer_id
)

SELECT
    COUNT(*) AS customers_with_multiple_orders
FROM orders_per_customer
WHERE total_orders > 1;