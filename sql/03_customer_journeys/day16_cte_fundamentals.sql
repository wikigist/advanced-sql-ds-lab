WITH customer_case_counts AS (
    SELECT
        customer_id,
        COUNT(case_id) AS total_cases
    FROM journey_cases
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_cases
FROM customer_case_counts
--WHERE total_cases > 1
ORDER BY customer_id;



-- For each country, how many customers have raised more than one case?
WITH repeat_case_customers AS (
    SELECT
        customer_id,
        COUNT(case_id) AS total_cases
    FROM journey_cases
    GROUP BY customer_id
    HAVING COUNT(case_id) > 1
)

SELECT
    c.country,
    COUNT(r.customer_id) AS repeat_case_customers
FROM repeat_case_customers AS r
INNER JOIN sales_customers AS c
    ON r.customer_id = c.customer_id
GROUP BY c.country
ORDER BY c.country;



-- Which customers have spent more than £100 in total across all their orders?
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM sales_orders
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY customer_id;



-- For each country, how many customers have spent more than £100 in total?
-- Exercise 2: Customers spending over 100 by country

WITH customer_total_spent AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM sales_orders
    GROUP BY customer_id
)

SELECT
    c.country,
    COUNT(s.customer_id) AS customers_over_100
FROM customer_total_spent AS s
INNER JOIN sales_customers AS c
    ON s.customer_id = c.customer_id
WHERE s.total_spent > 100
GROUP BY c.country
ORDER BY c.country;