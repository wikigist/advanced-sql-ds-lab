-- Which orders are worth more than the average order amount?

SELECT
    order_id,
    customer_id,
    amount
FROM sales_orders
WHERE amount > (
    SELECT AVG(amount)
    FROM sales_orders
);


-- Which customers have an average order amount greater than £100?

SELECT
    customer_id,
    ROUND(AVG(amount), 2) AS avg_order_amount
FROM sales_orders
GROUP BY customer_id
HAVING AVG(amount) > 100;


-- Show the individual orders placed by customers whose average order amount is greater than £100.

SELECT
    order_id,
    customer_id,
    amount
FROM sales_orders
WHERE customer_id IN (
    SELECT customer_id
    FROM sales_orders
    GROUP BY customer_id
    HAVING AVG(amount) > 100
);


-- Show all support cases opened by customers from Nigeria.

SELECT
    case_id,
    customer_id
FROM journey_cases
WHERE customer_id IN (
    SELECT customer_id
    FROM sales_customers
    WHERE country = 'Nigeria'
);


-- Show all individual orders placed by customers who have opened more than one support case.

SELECT
    order_id, customer_id, amount
FROM sales_orders
WHERE customer_id IN (
    SELECT customer_id
    FROM journey_cases
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);