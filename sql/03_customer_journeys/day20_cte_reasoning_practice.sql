WITH customer_spending AS (
    SELECT
    customer_id, SUM(amount) AS total_spent
    FROM sales_orders
    GROUP BY customer_id
)

SELECT ROUND(AVG(total_spent), 2) AS avg_spend_per_customer
FROM customer_spending;
--GROUP BY customer_id
--ORDER BY customer_id;